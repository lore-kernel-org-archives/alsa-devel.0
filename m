From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 6/6] pcm: hw: maintain fallback
	mode for control data mapping independently
Date: Sun, 25 Jun 2017 13:41:24 +0900
Message-ID: <20170625044124.22234-7-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 37B37266B50
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

Currently, failures of status/control data mapping are handled dependently.
However, it's not sure that one of the operations is failed when another
is failed.

This commit adds a member into private data structure to maintain fallback
mode for control data mapping, independently of status data mapping. As a
result, we have four cases to handle status/control data:

1. both of status/control data are mapped.
Nothing changed. A structure with alias of 'snd_pcm_hw_t' already has two
members to point the mapped area and in application runtime they're used
to refer/set status/control data. No need to call ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR to issue/query the data.

2. both of status/control data are unmapped.
The two members point to allocated memory for fallback buffer. In
application runtime, the buffer is given as an argument for ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR to issue/query the data.

3. status data is mapped only.
One of the two members is used to point the mapped area. Another points to
allocated memory for fallback buffer. In application runtime, the buffer
is used as an argument to execute ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR
for the latter data, but the former data is already synchronized.

4. control data is mapped only.
The same as the above.

In design of ALSA PCM interface, userspace applications are not expected
to map the status data as writable. On the other hand, expected to map
the control data as writable. In a focus on the differences, we could
achieve to reduce calls of the ioctl(2) in a case that one of the
status/control data is successfully mapped and another is failed (case 3
and 4). Especially, in current alsa-lib implementation, application
runtime queries state of runtime of PCM substream so often.
---
 src/pcm/pcm_hw.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 78857941..5573fce2 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -95,6 +95,7 @@ typedef struct {
 	volatile struct snd_pcm_mmap_status * mmap_status;
 	struct snd_pcm_mmap_control *mmap_control;
 	bool mmap_status_fallbacked;
+	bool mmap_control_fallbacked;
 	struct snd_pcm_sync_ptr *sync_ptr;
 
 	int period_event;
@@ -143,9 +144,11 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
-static inline int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
+static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 {
-	return hw->sync_ptr ? sync_ptr1(hw, flags) : 0;
+	if (hw->mmap_status_fallbacked || hw->mmap_control_fallbacked)
+		return sync_ptr1(hw, flags);
+	return 0;
 }
 
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
@@ -899,24 +902,24 @@ static bool map_control_data(snd_pcm_hw_t *hw,
 			     bool force_fallback)
 {
 	struct snd_pcm_mmap_control *mmap_control;
-	int err;
+	bool fallbacked;
 
 	if (!force_fallback) {
 		mmap_control = mmap(NULL, page_align(sizeof(*mmap_control)),
 				    PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED,
 				    hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
-		if (mmap_control == MAP_FAILED || mmap_control == NULL) {
-			err = -errno;
-			SYSMSG("control mmap failed (%i)", err);
-			return err;
-		}
-	} else {
+	}
+
+	if (mmap_control == MAP_FAILED || mmap_control == NULL) {
 		mmap_control = &sync_ptr->c.control;
+		fallbacked = true;
+	} else {
+		fallbacked = false;
 	}
 
 	hw->mmap_control = mmap_control;
 
-	return 0;
+	return fallbacked;
 }
 
 static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
@@ -933,12 +936,11 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 
 	hw->mmap_status_fallbacked =
 			map_status_data(hw, sync_ptr, force_fallback);
-	err = map_control_data(hw, sync_ptr, hw->mmap_status_fallbacked);
-	if (err < 0)
-		return err;
+	hw->mmap_control_fallbacked =
+			map_control_data(hw, sync_ptr, force_fallback);
 
 	/* Any fallback mode needs to keep the buffer. */
-	if (hw->mmap_status_fallbacked == 0) {
+	if (hw->mmap_status_fallbacked || hw->mmap_control_fallbacked) {
 		hw->sync_ptr = sync_ptr;
 	} else {
 		free(sync_ptr);
@@ -953,7 +955,7 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 				offsetof(struct snd_pcm_mmap_status, hw_ptr));
 	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
 			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
-	if (hw->mmap_status_fallbacked) {
+	if (hw->mmap_control_fallbacked) {
 		if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, hw->sync_ptr) < 0) {
 			err = -errno;
 			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
@@ -975,7 +977,7 @@ static void unmap_status_data(snd_pcm_hw_t *hw)
 
 static void unmap_control_data(snd_pcm_hw_t *hw)
 {
-	if (!hw->mmap_status_fallbacked) {
+	if (!hw->mmap_control_fallbacked) {
 		if (munmap((void *)hw->mmap_control,
 			   page_align(sizeof(*hw->mmap_control))) < 0)
 			SYSMSG("control munmap failed (%u)", errno);
@@ -987,12 +989,13 @@ static void unmap_status_and_control_data(snd_pcm_hw_t *hw)
 	unmap_status_data(hw);
 	unmap_control_data(hw);
 
-	if (hw->mmap_status_fallbacked)
+	if (hw->mmap_status_fallbacked || hw->mmap_control_fallbacked)
 		free(hw->sync_ptr);
 
 	hw->mmap_status = NULL;
 	hw->mmap_control = NULL;
 	hw->mmap_status_fallbacked = false;
+	hw->mmap_control_fallbacked = false;
 	hw->sync_ptr = NULL;
 }
 
-- 
2.11.0
