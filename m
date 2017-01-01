From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: dpcm: Avoid putting stream state to STOP
	when FE stream is paused
Date: Sat, 31 Dec 2016 22:44:39 -0800
Message-ID: <1483253079-7978-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1D7266639
 for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2017 07:44:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

When multiple front-ends are using the same back-end, putting state of a
front-end to STOP state upon receiving pause command will result in backend
stream getting released by DPCM framework unintentionally. In order to
avoid backend to be released when another active front-end stream is
present, put the stream state to PAUSED state instead of STOP state.

Signed-off-by: Patrick Lai <plai@codeaurora.org>
---
 sound/soc/soc-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7a1eaa..6aba140 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2184,9 +2184,11 @@ static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
+		break;
 	}
 
 out:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
