From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib v2 2/6] pcm: hw: add a helper function
	just to query status data
Date: Fri, 30 Jun 2017 20:37:25 +0900
Message-ID: <20170630113729.13656-3-o-takashi@sakamocchi.jp>
References: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F28822674A1
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:37:33 +0200 (CEST)
In-Reply-To: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
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

When mapping status data successfully, mapped page includes status data
for applications. In this case, applications have no need to call ioctl(2)
with SNDRV_PCM_IOCTL_SYNC_PTR. However, in current implementation, when
map of control data is unavailable, applications execute the ioctl(2).
This is inconvenient for some cases that applications require to query
status only.

This commit adds a helper function to query status data without issuing
the control in fallback mode from failure of status mmap.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 9963523c..38d975af 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -165,6 +165,20 @@ static int query_status_and_control_data(snd_pcm_hw_t *hw)
 			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
 }
 
+static int query_status_data(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_status_fallbacked)
+		return 0;
+
+	/*
+	 * Query both of control/status data to avoid unexpected change of
+	 * control data in kernel space.
+	 */
+	return sync_ptr1(hw,
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
 {
 	if (hw->period_timer_need_poll) {
@@ -349,7 +363,7 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	params->info &= ~0xf0000000;
 	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
 		params->info |= SND_PCM_INFO_MONOTONIC;
-	return sync_ptr(hw, 0);
+	return query_status_data(hw);
 }
 
 static void snd_pcm_hw_close_timer(snd_pcm_hw_t *hw)
@@ -556,7 +570,7 @@ static int snd_pcm_hw_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_hw_state(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	int err = sync_ptr(hw, 0);
+	int err = query_status_data(hw);
 	if (err < 0)
 		return err;
 	return (snd_pcm_state_t) hw->mmap_status->state;
@@ -1064,7 +1078,7 @@ static snd_pcm_sframes_t snd_pcm_hw_avail_update(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	snd_pcm_uframes_t avail;
 
-	sync_ptr(hw, 0);
+	query_status_data(hw);
 	avail = snd_pcm_mmap_avail(pcm);
 	switch (FAST_PCM_STATE(hw)) {
 	case SNDRV_PCM_STATE_RUNNING:
-- 
2.11.0
