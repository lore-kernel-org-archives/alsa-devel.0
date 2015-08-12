From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ssm4567: Add sense support
Date: Wed, 12 Aug 2015 13:58:38 +0200
Message-ID: <1439380718-12503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B095226044E
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 13:58:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Omair M Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

The ssm4567 has sensing circuitry that can be used to monitor the current
and voltage on the speaker amplifier output has well as the VBAT input.
This data can be output over the I2S interface so it can be processed by a
DSP or similar.

This patch adds the sense capture output stream to the CODEC DAI as well as
DAPM widgets that ensure that the sensing circuitry is powered up when the
capture stream is active.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm4567.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index ac242b2..e619d56 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -174,6 +174,12 @@ static const struct snd_soc_dapm_widget ssm4567_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Amplifier Boost", SSM4567_REG_POWER_CTRL, 3, 1,
 		&ssm4567_amplifier_boost_control),
 
+	SND_SOC_DAPM_SIGGEN("Sense"),
+
+	SND_SOC_DAPM_PGA("Current Sense", SSM4567_REG_POWER_CTRL, 4, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Voltage Sense", SSM4567_REG_POWER_CTRL, 5, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("VBAT Sense", SSM4567_REG_POWER_CTRL, 6, 1, NULL, 0),
+
 	SND_SOC_DAPM_OUTPUT("OUT"),
 };
 
@@ -181,6 +187,13 @@ static const struct snd_soc_dapm_route ssm4567_routes[] = {
 	{ "OUT", NULL, "Amplifier Boost" },
 	{ "Amplifier Boost", "Switch", "DAC" },
 	{ "OUT", NULL, "DAC" },
+
+	{ "Current Sense", NULL, "Sense" },
+	{ "Voltage Sense", NULL, "Sense" },
+	{ "VBAT Sense", NULL, "Sense" },
+	{ "Capture Sense", NULL, "Current Sense" },
+	{ "Capture Sense", NULL, "Voltage Sense" },
+	{ "Capture Sense", NULL, "VBAT Sense" },
 };
 
 static int ssm4567_hw_params(struct snd_pcm_substream *substream,
@@ -388,6 +401,14 @@ static struct snd_soc_dai_driver ssm4567_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 			SNDRV_PCM_FMTBIT_S32,
 	},
+	.capture = {
+		.stream_name = "Capture Sense",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32,
+	},
 	.ops = &ssm4567_dai_ops,
 };
 
-- 
2.1.4
