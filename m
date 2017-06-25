From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 2/6] pcm: hw: add an arrangement
	for initialization of appl_ptr/avail_min
Date: Sun, 25 Jun 2017 13:41:20 +0900
Message-ID: <20170625044124.22234-3-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EA552266B4B
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

Regardless of success/failure mapping of control/status data for runtime of
PCM substream, appl_ptr/avail_min parameters are initialized. In current
implementation, they are initialized in case-dependent, different places.
It's possible to collect them to one place.

This commit unifies relevant code in a place after all of trials for the
mappings are finished.
---
 src/pcm/pcm_hw.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index abf4afe0..c60a521b 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -867,10 +867,8 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	return xfern.result;
 }
 
-static int map_status_data(snd_pcm_t *pcm)
+static int map_status_data(snd_pcm_hw_t *hw)
 {
-	snd_pcm_hw_t *hw = pcm->private_data;
-	struct snd_pcm_sync_ptr sync_ptr;
 	void *ptr;
 	int err;
 	ptr = MAP_FAILED;
@@ -879,15 +877,6 @@ static int map_status_data(snd_pcm_t *pcm)
 			   PROT_READ, MAP_FILE|MAP_SHARED, 
 			   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
 	if (ptr == MAP_FAILED || ptr == NULL) {
-		memset(&sync_ptr, 0, sizeof(sync_ptr));
-		sync_ptr.c.control.appl_ptr = 0;
-		sync_ptr.c.control.avail_min = 1;
-		err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, &sync_ptr);
-		if (err < 0) {
-			err = -errno;
-			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
-			return err;
-		}
 		hw->sync_ptr = calloc(1, sizeof(struct snd_pcm_sync_ptr));
 		if (hw->sync_ptr == NULL)
 			return -ENOMEM;
@@ -897,13 +886,12 @@ static int map_status_data(snd_pcm_t *pcm)
 	} else {
 		hw->mmap_status = ptr;
 	}
-	snd_pcm_set_hw_ptr(pcm, &hw->mmap_status->hw_ptr, hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS + offsetof(struct snd_pcm_mmap_status, hw_ptr));
+
 	return 0;
 }
 
-static int map_control_data(snd_pcm_t *pcm)
+static int map_control_data(snd_pcm_hw_t *hw)
 {
-	snd_pcm_hw_t *hw = pcm->private_data;
 	void *ptr;
 	int err;
 	if (hw->sync_ptr == NULL) {
@@ -916,10 +904,8 @@ static int map_control_data(snd_pcm_t *pcm)
 			return err;
 		}
 		hw->mmap_control = ptr;
-	} else {
-		hw->mmap_control->avail_min = 1;
 	}
-	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
+
 	return 0;
 }
 
@@ -930,14 +916,30 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 
 	hw->sync_ptr_ioctl = (int)force_fallback;
 
-	err = map_status_data(pcm);
+	err = map_status_data(hw);
 	if (err < 0)
 		return err;
 
-	err = map_control_data(pcm);
+	err = map_control_data(hw);
 	if (err < 0)
 		return err;
 
+	/* Initialize the data. */
+	hw->mmap_control->appl_ptr = 0;
+	hw->mmap_control->avail_min = 1;
+	snd_pcm_set_hw_ptr(pcm, &hw->mmap_status->hw_ptr, hw->fd,
+			   SNDRV_PCM_MMAP_OFFSET_STATUS +
+				offsetof(struct snd_pcm_mmap_status, hw_ptr));
+	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
+			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
+	if (hw->sync_ptr_ioctl) {
+		if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, hw->sync_ptr) < 0) {
+			err = -errno;
+			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.11.0
