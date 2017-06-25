From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 5/6] pcm: hw: maintain fallback
	mode for status data mapping
Date: Sun, 25 Jun 2017 13:41:23 +0900
Message-ID: <20170625044124.22234-6-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 59766266D81
 for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2017 06:41:37 +0200 (CEST)
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

In current implementation, results to map status/control data are not
maintained separately. It's handled as a fatal error that mapping of status
data is successful and mapping of control data is failed. However, it's
possible to handle this case by utilizing fallback buffer.

This commit adds a member into a local structure to maintain fallback mode
just for the mapping of status data as a preparation of later commit, in
which mapping results are maintained separately for each of status/control
data.
---
 src/pcm/pcm_hw.c | 78 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index a3d1f137..78857941 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -91,10 +91,12 @@ typedef struct {
 	int version;
 	int fd;
 	int card, device, subdevice;
-	int sync_ptr_ioctl;
+
 	volatile struct snd_pcm_mmap_status * mmap_status;
 	struct snd_pcm_mmap_control *mmap_control;
+	bool mmap_status_fallbacked;
 	struct snd_pcm_sync_ptr *sync_ptr;
+
 	int period_event;
 	snd_timer_t *period_timer;
 	struct pollfd period_timer_pfd;
@@ -867,42 +869,53 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	return xfern.result;
 }
 
-static int map_status_data(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *sync_ptr)
+static bool map_status_data(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *sync_ptr,
+			    bool force_fallback)
 {
-	void *ptr;
+	struct snd_pcm_mmap_status *mmap_status;
+	bool fallbacked;
+
+	mmap_status = MAP_FAILED;
+	if (!force_fallback) {
+		mmap_status = mmap(NULL, page_align(sizeof(*mmap_status)),
+				   PROT_READ, MAP_FILE|MAP_SHARED,
+				   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
+	}
 
-	ptr = MAP_FAILED;
-	if (hw->sync_ptr_ioctl == 0)
-		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_status)),
-			   PROT_READ, MAP_FILE|MAP_SHARED, 
-			   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
-	if (ptr == MAP_FAILED || ptr == NULL) {
-		hw->mmap_status = &sync_ptr->s.status;
-		hw->mmap_control = &sync_ptr->c.control;
-		hw->sync_ptr_ioctl = 1;
+	if (mmap_status == MAP_FAILED || mmap_status == NULL) {
+		mmap_status = &sync_ptr->s.status;
+		fallbacked = true;
 	} else {
-		hw->mmap_status = ptr;
+		fallbacked = false;
 	}
 
-	return 0;
+	hw->mmap_status = mmap_status;
+
+	return fallbacked;
 }
 
-static int map_control_data(snd_pcm_hw_t *hw)
+static bool map_control_data(snd_pcm_hw_t *hw,
+			     struct snd_pcm_sync_ptr *sync_ptr,
+			     bool force_fallback)
 {
-	void *ptr;
+	struct snd_pcm_mmap_control *mmap_control;
 	int err;
-	if (hw->sync_ptr_ioctl == 0) {
-		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_control)),
-			   PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED, 
-			   hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
-		if (ptr == MAP_FAILED || ptr == NULL) {
+
+	if (!force_fallback) {
+		mmap_control = mmap(NULL, page_align(sizeof(*mmap_control)),
+				    PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED,
+				    hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
+		if (mmap_control == MAP_FAILED || mmap_control == NULL) {
 			err = -errno;
 			SYSMSG("control mmap failed (%i)", err);
 			return err;
 		}
-		hw->mmap_control = ptr;
+	} else {
+		mmap_control = &sync_ptr->c.control;
 	}
 
+	hw->mmap_control = mmap_control;
+
 	return 0;
 }
 
@@ -918,18 +931,14 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 		return -ENOMEM;
 	memset(sync_ptr, 0, sizeof(*sync_ptr));
 
-	hw->sync_ptr_ioctl = (int)force_fallback;
-
-	err = map_status_data(hw, sync_ptr);
-	if (err < 0)
-		return err;
-
-	err = map_control_data(hw);
+	hw->mmap_status_fallbacked =
+			map_status_data(hw, sync_ptr, force_fallback);
+	err = map_control_data(hw, sync_ptr, hw->mmap_status_fallbacked);
 	if (err < 0)
 		return err;
 
 	/* Any fallback mode needs to keep the buffer. */
-	if (hw->sync_ptr_ioctl == 0) {
+	if (hw->mmap_status_fallbacked == 0) {
 		hw->sync_ptr = sync_ptr;
 	} else {
 		free(sync_ptr);
@@ -944,7 +953,7 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 				offsetof(struct snd_pcm_mmap_status, hw_ptr));
 	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
 			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
-	if (hw->sync_ptr_ioctl) {
+	if (hw->mmap_status_fallbacked) {
 		if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, hw->sync_ptr) < 0) {
 			err = -errno;
 			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
@@ -957,7 +966,7 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 
 static void unmap_status_data(snd_pcm_hw_t *hw)
 {
-	if (!hw->sync_ptr) {
+	if (!hw->mmap_status_fallbacked) {
 		if (munmap((void *)hw->mmap_status,
 			   page_align(sizeof(*hw->mmap_status))) < 0)
 			SYSMSG("status munmap failed (%u)", errno);
@@ -966,7 +975,7 @@ static void unmap_status_data(snd_pcm_hw_t *hw)
 
 static void unmap_control_data(snd_pcm_hw_t *hw)
 {
-	if (!hw->sync_ptr) {
+	if (!hw->mmap_status_fallbacked) {
 		if (munmap((void *)hw->mmap_control,
 			   page_align(sizeof(*hw->mmap_control))) < 0)
 			SYSMSG("control munmap failed (%u)", errno);
@@ -978,11 +987,12 @@ static void unmap_status_and_control_data(snd_pcm_hw_t *hw)
 	unmap_status_data(hw);
 	unmap_control_data(hw);
 
-	if (hw->sync_ptr)
+	if (hw->mmap_status_fallbacked)
 		free(hw->sync_ptr);
 
 	hw->mmap_status = NULL;
 	hw->mmap_control = NULL;
+	hw->mmap_status_fallbacked = false;
 	hw->sync_ptr = NULL;
 }
 
-- 
2.11.0
