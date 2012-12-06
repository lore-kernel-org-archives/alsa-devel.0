From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: pcm: allow backend hardware to be freed in pause state
Date: Thu,  6 Dec 2012 10:39:59 -0800
Message-ID: <1354819199-28795-1-git-send-email-plai@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

When front-end PCM session is in paused state, back-end
PCM session will be put in paused state as well if given
front-end PCM session is the only client of given back-end.
Then, application closes front-end PCM session, DPCM
framework will not allow back-end enters HW_FREE state
so back-end will never get shutdown completely.

Signed-off-by: Patrick Lai <plai@codeaurora.org>
---
 sound/soc/soc-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ef22d0b..d340644 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1240,7 +1240,7 @@ static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
1.7.8.3
