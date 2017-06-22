From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 7/9] pcm: add a helper function
	to issue avail_min
Date: Thu, 22 Jun 2017 23:43:32 +0900
Message-ID: <20170622144334.1306-8-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 423D7266D94
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

Runtime of PCM substream has a parameter, avail_min, as a threshold to
the amount of available PCM frames in PCM buffer. Usually, this value
is shared with user space via mapped page frame. However, when failing
the mapping, applications perform fallback operation with
SNDRV_PCM_IOCTL_SYNC_PTR.

This commit add a helper function so that the above design is explicit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index a5cc5e46..045e7890 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -160,6 +160,15 @@ static int sync_applptr(snd_pcm_hw_t *hw)
 	return sync_ptr1(hw, &ptr, 0);
 }
 
+static int issue_availmin(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	return sync_ptr1(hw, hw->sync_ptr,
+			 SNDRV_PCM_SYNC_PTR_APPL);
+}
+
 static int query_applptr(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_control_fallbacked)
@@ -495,7 +504,7 @@ static int snd_pcm_hw_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
 	    params->silence_size == pcm->silence_size &&
 	    old_period_event == hw->period_event) {
 		hw->mmap_control->avail_min = params->avail_min;
-		return sync_ptr(hw, 0);
+		return issue_availmin(hw);
 	}
 	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW &&
 	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
-- 
2.11.0
