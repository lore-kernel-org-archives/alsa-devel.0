From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 8/9] pcm: add a helper function
	to issue applptr
Date: Thu, 22 Jun 2017 23:43:33 +0900
Message-ID: <20170622144334.1306-9-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 45142266D9B
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

When handling PCM frames by mmap operation for PCM buffer, in usual
cases, applications have no need to issue application-side position
into stuffs of kernel land. In the cases, specific page frame is
mapped for the position. However, in a case to fail the mapping,
applications can use a fallback method. This is done by ioctl(2)
with SNDRV_PCM_IOCTL_SYNC_PTR.

This commit adds a helper function to unify the relevant code.
Additionally, this commit adds a flag to purge side effect of the
call.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 045e7890..2d68fe12 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -160,6 +160,15 @@ static int sync_applptr(snd_pcm_hw_t *hw)
 	return sync_ptr1(hw, &ptr, 0);
 }
 
+static int issue_applptr(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	return sync_ptr1(hw, hw->sync_ptr,
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int issue_availmin(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_control_fallbacked)
@@ -592,7 +601,7 @@ static int snd_pcm_hw_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_hw_state(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	int err = sync_ptr(hw, 0);
+	int err = issue_applptr(hw);
 	if (err < 0)
 		return err;
 	return (snd_pcm_state_t) hw->mmap_status->state;
@@ -1016,7 +1025,7 @@ static int map_status_and_control_data(snd_pcm_t *pcm, int force_fallback)
 
 	/* Initialize when control mapping is fallbacked. */
 	if (hw->mmap_control_fallbacked > 0) {
-		int err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, &hw->sync_ptr);
+		int err = issue_applptr(hw);
 		if (err < 0) {
 			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", -errno);
 			return -errno;
@@ -1119,7 +1128,7 @@ static snd_pcm_sframes_t snd_pcm_hw_avail_update(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	snd_pcm_uframes_t avail;
 
-	sync_ptr(hw, 0);
+	issue_applptr(hw);
 	avail = snd_pcm_mmap_avail(pcm);
 	switch (FAST_PCM_STATE(hw)) {
 	case SNDRV_PCM_STATE_RUNNING:
-- 
2.11.0
