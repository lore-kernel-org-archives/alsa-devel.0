From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Add support for audio trace
	firmware" to the asoc tree
Date: Fri, 29 Jan 2016 12:40:38 +0100
Message-ID: <E1aP7Pq-0006x9-TS@finisterre>
References: <1453398782-32198-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C4026047B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 12:40:52 +0100 (CET)
In-Reply-To: <1453398782-32198-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm5110: Add support for audio trace firmware

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

>From 31889507fd84a6a1c8dce36a214a070cec1fc559 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:53:00 +0000
Subject: [PATCH] ASoC: wm5110: Add support for audio trace firmware

Mainly this adds DAI links for the audio trace, however, it is also
necessary to update the data IRQ handler to check more cores. We have
the handler check every core so it should not be necessary to update
this function if more compressed firmwares are added in the future.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h |  2 +-
 sound/soc/codecs/wm5110.c  | 43 +++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/wm_adsp.c |  1 -
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 8b6adb5..0c64a57 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -57,7 +57,7 @@
 #define ARIZONA_CLK_98MHZ  5
 #define ARIZONA_CLK_147MHZ 6
 
-#define ARIZONA_MAX_DAI  8
+#define ARIZONA_MAX_DAI  10
 #define ARIZONA_MAX_ADSP 4
 
 #define ARIZONA_DVFS_SR1_RQ	0x001
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b47bc44..92b6a6a 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1828,6 +1828,9 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "Voice Control DSP", NULL, "DSP3" },
 	{ "Voice Control DSP", NULL, "SYSCLK" },
 
+	{ "Audio Trace DSP", NULL, "DSP1" },
+	{ "Audio Trace DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -2171,6 +2174,27 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 			.formats = WM5110_FORMATS,
 		},
 	},
+	{
+		.name = "wm5110-cpu-trace",
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "wm5110-dsp-trace",
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+	},
 };
 
 static int wm5110_open(struct snd_compr_stream *stream)
@@ -2182,6 +2206,8 @@ static int wm5110_open(struct snd_compr_stream *stream)
 
 	if (strcmp(rtd->codec_dai->name, "wm5110-dsp-voicectrl") == 0) {
 		n_adsp = 2;
+	} else if (strcmp(rtd->codec_dai->name, "wm5110-dsp-trace") == 0) {
+		n_adsp = 0;
 	} else {
 		dev_err(arizona->dev,
 			"No suitable compressed stream for DAI '%s'\n",
@@ -2194,12 +2220,21 @@ static int wm5110_open(struct snd_compr_stream *stream)
 
 static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 {
-	struct wm5110_priv *florida = data;
-	int ret;
+	struct wm5110_priv *priv = data;
+	struct arizona *arizona = priv->core.arizona;
+	int serviced = 0;
+	int i, ret;
+
+	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
+		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
+		if (ret != -ENODEV)
+			serviced++;
+	}
 
-	ret = wm_adsp_compr_handle_irq(&florida->core.adsp[2]);
-	if (ret == -ENODEV)
+	if (!serviced) {
+		dev_err(arizona->dev, "Spurious compressed data IRQ\n");
 		return IRQ_NONE;
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 76ab52d..653dbff 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2823,7 +2823,6 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 	mutex_lock(&dsp->pwr_lock);
 
 	if (!buf) {
-		adsp_err(dsp, "Spurious buffer IRQ\n");
 		ret = -ENODEV;
 		goto out;
 	}
-- 
2.6.4
