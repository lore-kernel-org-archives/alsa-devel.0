From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/4] ASoC: uda1380: split set_dai_fmt into
	_both, _playback and _capture variants
Date: Tue,  3 Feb 2009 17:19:40 +0100
Message-ID: <1233677983-23710-2-git-send-email-philipp.zabel@gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id C4EA3103857
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:19:50 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so971049fge.44
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:19:50 -0800 (PST)
In-Reply-To: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch splits set_dai_fmt into three variants (single interface,
dual interface playback only, dual interface capture only) so that
data input and output formats can be configured separately for dual
interface setups.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |   68 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a957b43..6de37b2 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -356,7 +356,7 @@ static int uda1380_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int uda1380_set_dai_fmt(struct snd_soc_dai *codec_dai,
+static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -366,16 +366,70 @@ static int uda1380_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	iface = uda1380_read_reg_cache(codec, UDA1380_IFACE);
 	iface &= ~(R01_SFORI_MASK | R01_SIM | R01_SFORO_MASK);
 
-	/* FIXME: how to select I2S for DATAO and MSB for DATAI correctly? */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		iface |= R01_SFORI_I2S | R01_SFORO_I2S;
 		break;
 	case SND_SOC_DAIFMT_LSB:
-		iface |= R01_SFORI_LSB16 | R01_SFORO_I2S;
+		iface |= R01_SFORI_LSB16 | R01_SFORO_LSB16;
 		break;
 	case SND_SOC_DAIFMT_MSB:
-		iface |= R01_SFORI_MSB | R01_SFORO_I2S;
+		iface |= R01_SFORI_MSB | R01_SFORO_MSB;
+	}
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
+		iface |= R01_SIM;
+
+	uda1380_write(codec, UDA1380_IFACE, iface);
+
+	return 0;
+}
+
+static int uda1380_set_dai_fmt_playback(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int iface;
+
+	/* set up DAI based upon fmt */
+	iface = uda1380_read_reg_cache(codec, UDA1380_IFACE);
+	iface &= ~R01_SFORI_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= R01_SFORI_I2S;
+		break;
+	case SND_SOC_DAIFMT_LSB:
+		iface |= R01_SFORI_LSB16;
+		break;
+	case SND_SOC_DAIFMT_MSB:
+		iface |= R01_SFORI_MSB;
+	}
+
+	uda1380_write(codec, UDA1380_IFACE, iface);
+
+	return 0;
+}
+
+static int uda1380_set_dai_fmt_capture(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int iface;
+
+	/* set up DAI based upon fmt */
+	iface = uda1380_read_reg_cache(codec, UDA1380_IFACE);
+	iface &= ~(R01_SIM | R01_SFORO_MASK);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= R01_SFORO_I2S;
+		break;
+	case SND_SOC_DAIFMT_LSB:
+		iface |= R01_SFORO_LSB16;
+		break;
+	case SND_SOC_DAIFMT_MSB:
+		iface |= R01_SFORO_MSB;
 	}
 
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
@@ -549,7 +603,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
 		.digital_mute = uda1380_mute,
-		.set_fmt = uda1380_set_dai_fmt,
+		.set_fmt = uda1380_set_dai_fmt_both,
 	},
 },
 { /* playback only - dual interface */
@@ -566,7 +620,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
 		.digital_mute = uda1380_mute,
-		.set_fmt = uda1380_set_dai_fmt,
+		.set_fmt = uda1380_set_dai_fmt_playback,
 	},
 },
 { /* capture only - dual interface*/
@@ -582,7 +636,7 @@ struct snd_soc_dai uda1380_dai[] = {
 		.hw_params = uda1380_pcm_hw_params,
 		.shutdown = uda1380_pcm_shutdown,
 		.prepare = uda1380_pcm_prepare,
-		.set_fmt = uda1380_set_dai_fmt,
+		.set_fmt = uda1380_set_dai_fmt_capture,
 	},
 },
 };
-- 
1.5.6.5
