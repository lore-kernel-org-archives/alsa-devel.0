From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm4567: Add sense support" to the asoc
	tree
Date: Fri, 14 Aug 2015 19:15:01 -0700
Message-ID: <E1ZQQzt-0004Qp-Da@finisterre>
References: <1439380718-12503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC05B2664F4
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:15:09 +0200 (CEST)
In-Reply-To: <1439380718-12503-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm4567: Add sense support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From dbe71b9d86ee77cf58a92657c43b0e48954dc62b Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 12 Aug 2015 13:58:38 +0200
Subject: [PATCH] ASoC: ssm4567: Add sense support

The ssm4567 has sensing circuitry that can be used to monitor the current
and voltage on the speaker amplifier output has well as the VBAT input.
This data can be output over the I2S interface so it can be processed by a
DSP or similar.

This patch adds the sense capture output stream to the CODEC DAI as well as
DAPM widgets that ensure that the sensing circuitry is powered up when the
capture stream is active.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.5.0
