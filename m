From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 9/9] pcm: code refactoring to
	use helper functions
Date: Thu, 22 Jun 2017 23:43:34 +0900
Message-ID: <20170622144334.1306-10-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 471BD266DA6
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:46 +0200 (CEST)
In-Reply-To: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
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

In former commits, some helper functions were added. This commit applies
refactoring to use them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 64 +++++++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 2d68fe12..4759b5bb 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -132,13 +132,11 @@ struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pcm)
 }
 #endif /* DOC_HIDDEN */
 
-static int sync_ptr1(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *ptr,
-		     unsigned int flags)
+static int do_sync_ptr(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *sync_ptr)
 {
 	int err;
 
-	ptr->flags = flags;
-	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, ptr) < 0) {
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, sync_ptr) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
 		return err;
@@ -147,26 +145,23 @@ static int sync_ptr1(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *ptr,
 	return 0;
 }
 
-static inline int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
+static int issue_applptr(snd_pcm_hw_t *hw)
 {
-	return hw->sync_ptr ? sync_ptr1(hw, hw->sync_ptr, flags) : 0;
-}
+	struct snd_pcm_sync_ptr *sync_ptr, buf = {0};
 
-/* explicit notification of appl_ptr update to kernel */
-static int sync_applptr(snd_pcm_hw_t *hw)
-{
-	struct snd_pcm_sync_ptr ptr;
-	ptr.c.control = *hw->mmap_control;
-	return sync_ptr1(hw, &ptr, 0);
-}
+	if (!hw->mmap_control_fallbacked) {
+		if (!hw->sync_applptr)
+			return 0;
 
-static int issue_applptr(snd_pcm_hw_t *hw)
-{
-	if (!hw->mmap_control_fallbacked)
-		return 0;
 
-	return sync_ptr1(hw, hw->sync_ptr,
-			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+		buf.c.control = *hw->mmap_control;
+		sync_ptr = &buf;
+	} else {
+		sync_ptr = hw->sync_ptr;
+	}
+
+	sync_ptr->flags = SNDRV_PCM_SYNC_PTR_AVAIL_MIN;
+	return do_sync_ptr(hw, sync_ptr);
 }
 
 static int issue_availmin(snd_pcm_hw_t *hw)
@@ -174,8 +169,8 @@ static int issue_availmin(snd_pcm_hw_t *hw)
 	if (!hw->mmap_control_fallbacked)
 		return 0;
 
-	return sync_ptr1(hw, hw->sync_ptr,
-			 SNDRV_PCM_SYNC_PTR_APPL);
+	hw->sync_ptr->flags = SNDRV_PCM_SYNC_PTR_APPL;
+	return do_sync_ptr(hw, hw->sync_ptr);
 }
 
 static int query_applptr(snd_pcm_hw_t *hw)
@@ -183,9 +178,9 @@ static int query_applptr(snd_pcm_hw_t *hw)
 	if (!hw->mmap_control_fallbacked)
 		return 0;
 
-	return sync_ptr1(hw, hw->sync_ptr,
-			 SNDRV_PCM_SYNC_PTR_APPL |
-			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+	hw->sync_ptr->flags = SNDRV_PCM_SYNC_PTR_APPL |
+			      SNDRV_PCM_SYNC_PTR_AVAIL_MIN;
+	return do_sync_ptr(hw, hw->sync_ptr);
 }
 
 static int query_hwptr(snd_pcm_hw_t *hw)
@@ -193,10 +188,10 @@ static int query_hwptr(snd_pcm_hw_t *hw)
 	if (!hw->mmap_status_fallbacked)
 		return 0;
 
-	return sync_ptr1(hw, hw->sync_ptr,
-			 SNDRV_PCM_SYNC_PTR_HWSYNC |
-			 SNDRV_PCM_SYNC_PTR_APPL |
-			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+	hw->sync_ptr->flags = SNDRV_PCM_SYNC_PTR_HWSYNC |
+			      SNDRV_PCM_SYNC_PTR_APPL |
+			      SNDRV_PCM_SYNC_PTR_AVAIL_MIN;
+	return do_sync_ptr(hw, hw->sync_ptr);
 }
 
 static int query_status(snd_pcm_hw_t *hw)
@@ -204,9 +199,9 @@ static int query_status(snd_pcm_hw_t *hw)
 	if (!hw->mmap_status_fallbacked)
 		return 0;
 
-	return sync_ptr1(hw, hw->sync_ptr,
-			 SNDRV_PCM_SYNC_PTR_APPL |
-			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+	hw->sync_ptr->flags = SNDRV_PCM_SYNC_PTR_APPL |
+			      SNDRV_PCM_SYNC_PTR_AVAIL_MIN;
+	return do_sync_ptr(hw, hw->sync_ptr);
 }
 
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
@@ -1113,10 +1108,7 @@ static snd_pcm_sframes_t snd_pcm_hw_mmap_commit(snd_pcm_t *pcm,
 	snd_pcm_hw_t *hw = pcm->private_data;
 
 	snd_pcm_mmap_appl_forward(pcm, size);
-	if (hw->sync_ptr)
-		sync_ptr(hw, 0);
-	else if (hw->sync_applptr)
-		sync_applptr(hw);
+	issue_applptr(hw);
 #ifdef DEBUG_MMAP
 	fprintf(stderr, "appl_forward: hw_ptr = %li, appl_ptr = %li, size = %li\n", *pcm->hw.ptr, *pcm->appl.ptr, size);
 #endif
-- 
2.11.0
