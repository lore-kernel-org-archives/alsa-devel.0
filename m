From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 4/6] pcm: hw: allocate fallback
	buffer in advance of trials of mapping
Date: Sun, 25 Jun 2017 13:41:22 +0900
Message-ID: <20170625044124.22234-5-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EC975266B53
 for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2017 06:41:34 +0200 (CEST)
In-Reply-To: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When allowing failure of map operation for both of status/control data
for runtime of PCM substream, applications need to use fallback buffer
for an alternative ioctl. However, in current implementation, status
mapping is dominant to the allocation.

This commit moves code for the allocation outside of the mapping
operation for status data.
---
 src/pcm/pcm_hw.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 1d34956c..a3d1f137 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -867,21 +867,18 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	return xfern.result;
 }
 
-static int map_status_data(snd_pcm_hw_t *hw)
+static int map_status_data(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *sync_ptr)
 {
 	void *ptr;
-	int err;
+
 	ptr = MAP_FAILED;
 	if (hw->sync_ptr_ioctl == 0)
 		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_status)),
 			   PROT_READ, MAP_FILE|MAP_SHARED, 
 			   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
 	if (ptr == MAP_FAILED || ptr == NULL) {
-		hw->sync_ptr = calloc(1, sizeof(struct snd_pcm_sync_ptr));
-		if (hw->sync_ptr == NULL)
-			return -ENOMEM;
-		hw->mmap_status = &hw->sync_ptr->s.status;
-		hw->mmap_control = &hw->sync_ptr->c.control;
+		hw->mmap_status = &sync_ptr->s.status;
+		hw->mmap_control = &sync_ptr->c.control;
 		hw->sync_ptr_ioctl = 1;
 	} else {
 		hw->mmap_status = ptr;
@@ -894,7 +891,7 @@ static int map_control_data(snd_pcm_hw_t *hw)
 {
 	void *ptr;
 	int err;
-	if (hw->sync_ptr == NULL) {
+	if (hw->sync_ptr_ioctl == 0) {
 		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_control)),
 			   PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED, 
 			   hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
@@ -912,11 +909,18 @@ static int map_control_data(snd_pcm_hw_t *hw)
 static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
+	struct snd_pcm_sync_ptr *sync_ptr;
 	int err;
 
+	/* Preparation for fallback to failure of mmap(2). */
+	sync_ptr = malloc(sizeof(*sync_ptr));
+	if (sync_ptr == NULL)
+		return -ENOMEM;
+	memset(sync_ptr, 0, sizeof(*sync_ptr));
+
 	hw->sync_ptr_ioctl = (int)force_fallback;
 
-	err = map_status_data(hw);
+	err = map_status_data(hw, sync_ptr);
 	if (err < 0)
 		return err;
 
@@ -924,6 +928,14 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 	if (err < 0)
 		return err;
 
+	/* Any fallback mode needs to keep the buffer. */
+	if (hw->sync_ptr_ioctl == 0) {
+		hw->sync_ptr = sync_ptr;
+	} else {
+		free(sync_ptr);
+		hw->sync_ptr = NULL;
+	}
+
 	/* Initialize the data. */
 	hw->mmap_control->appl_ptr = 0;
 	hw->mmap_control->avail_min = 1;
-- 
2.11.0
