From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: pcm: allow backend hardware to be freed
	in pause state
Date: Wed, 19 Dec 2012 19:36:02 -0800
Message-ID: <1355974562-21537-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id D96D3265162
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 04:36:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
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
@@ -1240,6 +1240,7 @@ static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
 			continue;
 
-- 
1.7.8.3
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
