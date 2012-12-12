From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: pcm: allow backend hardware to be freed
	in pause state
Date: Wed, 12 Dec 2012 08:49:40 -0800
Message-ID: <1355330980-25189-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A34260202
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 17:49:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>
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
