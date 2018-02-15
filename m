From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: sgtl5000: Fix suspend/resume
Date: Thu, 15 Feb 2018 15:20:28 -0200
Message-ID: <1518715228-4470-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0067.outbound.protection.outlook.com [104.47.33.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E826267CD7
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:55:46 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, eric@nelint.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 8419caa72702 ("ASoC: sgtl5000: Do not disable regulators in
SND_SOC_BIAS_OFF") causes the sgtl5000 to fail after a suspend/resume
sequence:

# aplay /media/a2002011001-e02.wav
Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:2051: write error: Input/output error

Clearing the SGTL5000_REFTOP_POWERUP bit causes the issue after
suspend/resume, so do not clear this bit in the same way we used
to do previously to the aforementioned commit.

As sgtl5000_set_bias_level() only deals with SGTL5000_REFTOP_POWERUP,
we can simply remove it as this bit is already set inside 
sgtl5000_set_power_regs().

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/sgtl5000.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c26ac22..7bae303 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -858,36 +858,6 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/*
- * set dac bias
- * common state changes:
- * startup:
- * off --> standby --> prepare --> on
- * standby --> prepare --> on
- *
- * stop:
- * on --> prepare --> standby
- */
-static int sgtl5000_set_bias_level(struct snd_soc_component *component,
-				   enum snd_soc_bias_level level)
-{
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-	case SND_SOC_BIAS_PREPARE:
-	case SND_SOC_BIAS_STANDBY:
-		snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-				    SGTL5000_REFTOP_POWERUP,
-				    SGTL5000_REFTOP_POWERUP);
-		break;
-	case SND_SOC_BIAS_OFF:
-		snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-				    SGTL5000_REFTOP_POWERUP, 0);
-		break;
-	}
-
-	return 0;
-}
-
 #define SGTL5000_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE |\
@@ -1245,7 +1215,6 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver sgtl5000_driver = {
 	.probe			= sgtl5000_probe,
-	.set_bias_level		= sgtl5000_set_bias_level,
 	.controls		= sgtl5000_snd_controls,
 	.num_controls		= ARRAY_SIZE(sgtl5000_snd_controls),
 	.dapm_widgets		= sgtl5000_dapm_widgets,
-- 
2.7.4
