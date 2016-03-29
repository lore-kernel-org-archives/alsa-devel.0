From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs47l24: Add support for audio trace
	firmware" to the asoc tree
Date: Tue, 29 Mar 2016 10:13:55 -0700
Message-ID: <E1akxDH-0001Uq-Jy@finisterre>
References: <1459171764-29921-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D68D26695B
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:14:03 +0200 (CEST)
In-Reply-To: <1459171764-29921-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs47l24: Add support for audio trace firmware

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

>From c13202f7d7101a6f5542f3a31b9a6787ae7b746c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 28 Mar 2016 14:29:24 +0100
Subject: [PATCH] ASoC: cs47l24: Add support for audio trace firmware

cs47l24 supports the audio trace firmware, this streams of audio to be
captured from the CODEC over a compressed audio channel for
analysis/debugging of audio processing firmwares.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 383700a178c7..6b8b5571d3cc 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -807,6 +807,9 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "IN2L PGA", NULL, "IN2L" },
 	{ "IN2R PGA", NULL, "IN2R" },
 
+	{ "Audio Trace DSP", NULL, "DSP2" },
+	{ "Audio Trace DSP", NULL, "SYSCLK" },
+
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
 
@@ -1016,6 +1019,27 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 			.formats = CS47L24_FORMATS,
 		},
 	},
+	{
+		.name = "cs47l24-cpu-trace",
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "cs47l24-dsp-trace",
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+	},
 };
 
 static int cs47l24_open(struct snd_compr_stream *stream)
@@ -1027,6 +1051,8 @@ static int cs47l24_open(struct snd_compr_stream *stream)
 
 	if (strcmp(rtd->codec_dai->name, "cs47l24-dsp-voicectrl") == 0) {
 		n_adsp = 2;
+	} else if (strcmp(rtd->codec_dai->name, "cs47l24-dsp-trace") == 0) {
+		n_adsp = 1;
 	} else {
 		dev_err(arizona->dev,
 			"No suitable compressed stream for DAI '%s'\n",
@@ -1041,10 +1067,16 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 {
 	struct cs47l24_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
-	int ret;
+	int serviced = 0;
+	int i, ret;
+
+	for (i = 1; i <= 2; ++i) {
+		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
+		if (ret != -ENODEV)
+			serviced++;
+	}
 
-	ret = wm_adsp_compr_handle_irq(&priv->core.adsp[2]);
-	if (ret == -ENODEV) {
+	if (!serviced) {
 		dev_err(arizona->dev, "Spurious compressed data IRQ\n");
 		return IRQ_NONE;
 	}
-- 
2.8.0.rc3
