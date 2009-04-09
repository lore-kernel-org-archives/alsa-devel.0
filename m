From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Thu, 09 Apr 2009 22:54:37 +0900
Message-ID: <49DDFE1D.3090009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F17B24455
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 15:54:50 +0200 (CEST)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout5.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KHU00CXP6N1MC@mailout5.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 09 Apr 2009 22:54:37 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KHU00JDD6N140@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 09 Apr 2009 22:54:37 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

Add Voice DAI to support the PCM voice interface of the twl4030 codec.

The PCM voice interface can be used with 8-kHz(voice narrowband) or 16-kHz
(voice wideband) sampling rates, and 16bits, and mono RX and mono TX or
stereo TX.

If the system master clock is not 26MHz, the voice PCM interface is not
available.

The PCM voice interface has two modes
- PCM mode1 : This uses the rising edge of the clock signal
- PCM mode2 : This uses the falling edge of the clock signal

PCM mode1 and mode2 have a look of DSP_A and DSP_B, so we used DSP_A and
DSP_B.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c    |  135 +++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/twl4030.h    |   16 +++++-
 sound/soc/omap/omap2evm.c     |    2 +-
 sound/soc/omap/omap3beagle.c  |    2 +-
 sound/soc/omap/omap3pandora.c |    4 +-
 sound/soc/omap/overo.c        |    2 +-
 sound/soc/omap/sdp3430.c      |    2 +-
 7 files changed, 150 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index db7fecf..13461d1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1437,6 +1437,107 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int twl4030_voice_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	u8 infreq;
+
+	/* If the system master clock is not 26MHz, the voice PCM interface is
+	 * not avilable.
+	 */
+	infreq = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL)
+		& TWL4030_APLL_INFREQ;
+
+	if (infreq != TWL4030_APLL_INFREQ_26000KHZ)
+		return -EPERM;
+
+	return 0;
+}
+
+static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	u8 old_mode, mode;
+
+	/* bit rate */
+	old_mode = twl4030_read_reg_cache(codec,
+			TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
+	mode = old_mode;
+
+	switch (params_rate(params)) {
+	case 8000:
+		mode &= ~(TWL4030_SEL_16K);
+		break;
+	case 16000:
+		mode |= TWL4030_SEL_16K;
+		break;
+	default:
+		printk(KERN_ERR "TWL4030 voice hw params: unknown rate %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	if (mode != old_mode) {
+		/* change rate and set CODECPDZ */
+		twl4030_codec_enable(codec, 0);
+		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+		twl4030_codec_enable(codec, 1);
+	}
+
+	return 0;
+}
+
+static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 old_format, format;
+
+	/* get format */
+	old_format = twl4030_read_reg_cache(codec, TWL4030_REG_VOICE_IF);
+	format = old_format;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFM:
+		format &= ~(TWL4030_VIF_SLAVE_EN);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		format |= TWL4030_VIF_SLAVE_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		format &= ~(TWL4030_VIF_FORMAT);
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format |= TWL4030_VIF_FORMAT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (format != old_format) {
+		/* change format and set CODECPDZ */
+		twl4030_codec_enable(codec, 0);
+		twl4030_write(codec, TWL4030_REG_VOICE_IF, format);
+		twl4030_codec_enable(codec, 1);
+	}
+
+	return 0;
+}
+
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
@@ -1448,8 +1549,14 @@ static struct snd_soc_dai_ops twl4030_dai_ops = {
 	.set_fmt	= twl4030_set_dai_fmt,
 };
 
-struct snd_soc_dai twl4030_dai = {
-	.name = "twl4030",
+static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
+	.startup	= twl4030_voice_startup,
+	.hw_params	= twl4030_voice_hw_params,
+	.set_fmt	= twl4030_voice_set_dai_fmt,
+};
+
+struct snd_soc_dai twl4030_dai[] = {
+{	.name = "twl4030",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -1463,6 +1570,22 @@ struct snd_soc_dai twl4030_dai = {
 		.rates = TWL4030_RATES,
 		.formats = TWL4030_FORMATS,},
 	.ops = &twl4030_dai_ops,
+},
+{	.name = "twl4030 Voice",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = &twl4030_dai_voice_ops,
+},
 };
 EXPORT_SYMBOL_GPL(twl4030_dai);
 
@@ -1503,8 +1626,8 @@ static int twl4030_init(struct snd_soc_device *socdev)
 	codec->read = twl4030_read_reg_cache;
 	codec->write = twl4030_write;
 	codec->set_bias_level = twl4030_set_bias_level;
-	codec->dai = &twl4030_dai;
-	codec->num_dai = 1;
+	codec->dai = twl4030_dai;
+	codec->num_dai = ARRAY_SIZE(twl4030_dai),
 	codec->reg_cache_size = sizeof(twl4030_reg);
 	codec->reg_cache = kmemdup(twl4030_reg, sizeof(twl4030_reg),
 					GFP_KERNEL);
@@ -1598,13 +1721,13 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_twl4030);
 
 static int __init twl4030_modinit(void)
 {
-	return snd_soc_register_dai(&twl4030_dai);
+	return snd_soc_register_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
 }
 module_init(twl4030_modinit);
 
 static void __exit twl4030_exit(void)
 {
-	snd_soc_unregister_dai(&twl4030_dai);
+	snd_soc_unregister_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
 }
 module_exit(twl4030_exit);
 
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index cb63765..305b8ba 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -171,6 +171,17 @@
 #define TWL4030_CLK256FS_EN		0x02
 #define TWL4030_AIF_EN			0x01
 
+/* VOICE_IF (0x0F) Fields */
+
+#define TWL4030_VIF_SLAVE_EN		0x80
+#define TWL4030_VIF_DIN_EN		0x40
+#define TWL4030_VIF_DOUT_EN		0x20
+#define TWL4030_VIF_SWAP		0x10
+#define TWL4030_VIF_FORMAT		0x08
+#define TWL4030_VIF_TRI_EN		0x04
+#define TWL4030_VIF_SUB_EN		0x02
+#define TWL4030_VIF_EN			0x01
+
 /* EAR_CTL (0x21) */
 #define TWL4030_EAR_GAIN		0x30
 
@@ -236,7 +247,10 @@
 #define TWL4030_SMOOTH_ANAVOL_EN	0x02
 #define TWL4030_DIGMIC_LR_SWAP_EN	0x01
 
-extern struct snd_soc_dai twl4030_dai;
+#define TWL4030_DAI_HIFI		0
+#define TWL4030_DAI_VOICE		1
+
+extern struct snd_soc_dai twl4030_dai[2];
 extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 
 #endif	/* End of __TWL4030_AUDIO_H__ */
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index 0c2322d..027e1a4 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -86,7 +86,7 @@ static struct snd_soc_dai_link omap2evm_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai,
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.ops = &omap2evm_ops,
 };
 
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index fd24a4a..6aa428e 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -83,7 +83,7 @@ static struct snd_soc_dai_link omap3beagle_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai,
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.ops = &omap3beagle_ops,
 };
 
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index fe282d4..ad219aa 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -228,14 +228,14 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.name = "PCM1773",
 		.stream_name = "HiFi Out",
 		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &twl4030_dai,
+		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 		.ops = &omap3pandora_out_ops,
 		.init = omap3pandora_out_init,
 	}, {
 		.name = "TWL4030",
 		.stream_name = "Line/Mic In",
 		.cpu_dai = &omap_mcbsp_dai[1],
-		.codec_dai = &twl4030_dai,
+		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 		.ops = &omap3pandora_in_ops,
 		.init = omap3pandora_in_init,
 	}
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index a72dc4e..ec4f8fd 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -83,7 +83,7 @@ static struct snd_soc_dai_link overo_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai,
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.ops = &overo_ops,
 };
 
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 10f1c86..1c79741 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -197,7 +197,7 @@ static struct snd_soc_dai_link sdp3430_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai,
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.init = sdp3430_twl4030_init,
 	.ops = &sdp3430_ops,
 };
-- 
1.5.6.3
