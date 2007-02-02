From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 4/19] ASoC 0.13 WM8731 codec
Date: Fri, 02 Feb 2007 14:43:27 +0000
Message-ID: <1170427407.18082.133.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vLFtNqm4xsEO/ZnE+A3R"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-vLFtNqm4xsEO/ZnE+A3R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the WM8731 codec driver to the new API in ASoC 0.13.

Changes:-

o Removed DAI capabilities matching code in favour of manual matching in
the machine drivers.

o Added DAI operations for codec and CPU interfaces.

o Removed config_sysclk() function and struct snd_soc_clock_info. No
longer needed as clocking is now configured manually in the machine
drivers. Also removed other clocking data from structures.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>



Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-vLFtNqm4xsEO/ZnE+A3R
Content-Disposition: attachment; filename="asoc13-codec-wm8731.patch"
Content-Type: text/x-patch; name="asoc13-codec-wm8731.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/codecs/wm8731.c
--- a/soc/codecs/wm8731.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/wm8731.c	Wed Jan 31 16:43:17 2007 +0000
@@ -30,7 +30,7 @@
 #include "wm8731.h"
 
 #define AUDIO_NAME "wm8731"
-#define WM8731_VERSION "0.12"
+#define WM8731_VERSION "0.13"
 
 /*
  * Debug
@@ -53,6 +53,11 @@
 
 struct snd_soc_codec_device soc_codec_dev_wm8731;
 
+/* codec private data */
+struct wm8731_priv {
+	unsigned int sysclk;
+};
+
 /*
  * wm8731 register cache
  * We can't read the WM8731 register space when we are
@@ -63,191 +68,6 @@ static const u16 wm8731_reg[WM8731_CACHE
     0x0097, 0x0097, 0x0079, 0x0079,
     0x000a, 0x0008, 0x009f, 0x000a,
     0x0000, 0x0000
-};
-
-#define WM8731_DAIFMT \
-	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_RIGHT_J | \
-	SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_NB_IF | SND_SOC_DAIFMT_IB_NF | \
-	SND_SOC_DAIFMT_IB_IF)
-
-#define WM8731_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-#define WM8731_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define WM8731_HIFI_BITS \
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-
-static struct snd_soc_dai_mode wm8731_modes[] = {
-	/* codec frame and clock master modes */
-	/* 8k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 1536,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 2304,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 1408,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 2112,
-		.bfs = 64,
-	},
-
-	/* 32k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 384,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 576,
-		.bfs = 64,
-	},
-
-	/* 44.1k & 48k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 256,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 384,
-		.bfs = 64,
-	},
-
-	/* 88.2 & 96k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 128,
-		.bfs = 64,
-	},
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.fs = 192,
-		.bfs = 64,
-	},
-
-	/* USB codec frame and clock master modes */
-	/* 8k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1500,
-		.bfs = SND_SOC_FSBD(1),
-	},
-
-	/* 44.1k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 272,
-		.bfs = SND_SOC_FSBD(1),
-	},
-
-	/* 48k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 250,
-		.bfs = SND_SOC_FSBD(1),
-	},
-
-	/* 88.2k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 136,
-		.bfs = SND_SOC_FSBD(1),
-	},
-
-	/* 96k */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 125,
-		.bfs = SND_SOC_FSBD(1),
-	},
-
-	/* codec frame and clock slave modes */
-	{
-		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = WM8731_HIFI_BITS,
-		.pcmrate = WM8731_RATES,
-		.pcmdir = WM8731_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = SND_SOC_FS_ALL,
-		.bfs = SND_SOC_FSB_ALL,
-	},
 };
 
 /*
@@ -471,94 +291,45 @@ static inline int get_coeff(int mclk, in
 	return 0;
 }
 
-/* WM8731 supports numerous clocks per sample rate */
-static unsigned int wm8731_config_sysclk(struct snd_soc_codec_dai *dai,
-	struct snd_soc_clock_info *info, unsigned int clk)
-{
-	dai->mclk = 0;
-
-	/* check that the calculated FS and rate actually match a clock from
-	 * the machine driver */
-	if (info->fs * info->rate == clk)
-		dai->mclk = clk;
-
-	return dai->mclk;
-}
-
-static int wm8731_pcm_prepare(struct snd_pcm_substream *substream)
+static int wm8731_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	u16 iface = 0, srate;
-	int i = get_coeff(rtd->codec_dai->mclk,
-		snd_soc_get_rate(rtd->codec_dai->dai_runtime.pcmrate));
-
-	/* set master/slave audio interface */
-	switch (rtd->codec_dai->dai_runtime.fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		iface |= 0x0040;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		break;
-	}
-	srate = (coeff_div[i].sr << 2) |
+	struct wm8731_priv *wm8731 = codec->private_data;
+	u16 iface = wm8731_read_reg_cache(codec, WM8731_IFACE) & 0xfff3;
+	int i = get_coeff(wm8731->sysclk, params_rate(params));
+	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
+
 	wm8731_write(codec, WM8731_SRATE, srate);
 
-	/* interface format */
-	switch (rtd->codec_dai->dai_runtime.fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		iface |= 0x0002;
-		break;
-	case SND_SOC_DAIFMT_RIGHT_J:
-		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		iface |= 0x0001;
-		break;
-	case SND_SOC_DAIFMT_DSP_A:
-		iface |= 0x0003;
-		break;
-	case SND_SOC_DAIFMT_DSP_B:
-		iface |= 0x0013;
-		break;
-	}
-
 	/* bit size */
-	switch (rtd->codec_dai->dai_runtime.pcmfmt) {
-	case SNDRV_PCM_FMTBIT_S16_LE:
-		break;
-	case SNDRV_PCM_FMTBIT_S20_3LE:
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
 		iface |= 0x0004;
 		break;
-	case SNDRV_PCM_FMTBIT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
 		iface |= 0x0008;
 		break;
-	case SNDRV_PCM_FMTBIT_S32_LE:
-		iface |= 0x000c;
-		break;
-	}
-
-	/* clock inversion */
-	switch (rtd->codec_dai->dai_runtime.fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		iface |= 0x0090;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		iface |= 0x0080;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		iface |= 0x0010;
-		break;
-	}
-
-	/* set iface */
+	}
+
 	wm8731_write(codec, WM8731_IFACE, iface);
+	return 0;
+}
+
+static int wm8731_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
 
 	/* set active */
 	wm8731_write(codec, WM8731_ACTIVE, 0x0001);
+
 	return 0;
 }
 
@@ -575,10 +346,11 @@ static void wm8731_shutdown(struct snd_p
 	}
 }
 
-static int wm8731_mute(struct snd_soc_codec *codec,
-	struct snd_soc_codec_dai *dai, int mute)
-{
+static int wm8731_mute(struct snd_soc_codec_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8731_read_reg_cache(codec, WM8731_APDIGI) & 0xfff7;
+
 	if (mute)
 		wm8731_write(codec, WM8731_APDIGI, mute_reg | 0x8);
 	else
@@ -586,6 +358,84 @@ static int wm8731_mute(struct snd_soc_co
 	return 0;
 }
 
+static int wm8731_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8731_priv *wm8731 = codec->private_data;
+
+	switch (freq) {
+	case 11289600:
+	case 12000000:
+	case 12288000:
+	case 16934400:
+	case 18432000:
+		wm8731->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+
+static int wm8731_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface = 0;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		iface |= 0x0040;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= 0x0002;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface |= 0x0001;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface |= 0x0003;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		iface |= 0x0013;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface |= 0x0090;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface |= 0x0080;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface |= 0x0010;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set iface */
+	wm8731_write(codec, WM8731_IFACE, iface);
+	return 0;
+}
+
 static int wm8731_dapm_event(struct snd_soc_codec *codec, int event)
 {
 	u16 reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
@@ -611,6 +461,15 @@ static int wm8731_dapm_event(struct snd_
 	codec->dapm_state = event;
 	return 0;
 }
+
+#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+		SNDRV_PCM_RATE_96000)
+
+#define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
 
 struct snd_soc_codec_dai wm8731_dai = {
 	.name = "WM8731",
@@ -618,22 +477,24 @@ struct snd_soc_codec_dai wm8731_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-	},
+		.rates = WM8731_RATES,
+		.formats = WM8731_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-	},
-	.config_sysclk = wm8731_config_sysclk,
-	.digital_mute = wm8731_mute,
+		.rates = WM8731_RATES,
+		.formats = WM8731_FORMATS,},
 	.ops = {
 		.prepare = wm8731_pcm_prepare,
+		.hw_params = wm8731_hw_params,
 		.shutdown = wm8731_shutdown,
 	},
-	.caps = {
-		.num_modes = ARRAY_SIZE(wm8731_modes),
-		.mode = wm8731_modes,
-	},
+	.dai_ops = {
+		.digital_mute = wm8731_mute,
+		.set_sysclk = wm8731_set_dai_sysclk,
+		.set_fmt = wm8731_set_dai_fmt,
+	}
 };
 EXPORT_SYMBOL_GPL(wm8731_dai);
 
@@ -683,7 +544,6 @@ static int wm8731_init(struct snd_soc_de
 	codec->dai = &wm8731_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = ARRAY_SIZE(wm8731_reg);
-
 	codec->reg_cache =
 			kzalloc(sizeof(u16) * ARRAY_SIZE(wm8731_reg), GFP_KERNEL);
 	if (codec->reg_cache == NULL)
@@ -832,6 +692,7 @@ static int wm8731_probe(struct platform_
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct wm8731_setup_data *setup;
 	struct snd_soc_codec *codec;
+	struct wm8731_priv *wm8731;
 	int ret = 0;
 
 	info("WM8731 Audio Codec %s", WM8731_VERSION);
@@ -841,6 +702,13 @@ static int wm8731_probe(struct platform_
 	if (codec == NULL)
 		return -ENOMEM;
 
+	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
+	if (wm8731 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = wm8731;
 	socdev->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -875,6 +743,7 @@ static int wm8731_remove(struct platform
 #if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8731_i2c_driver);
 #endif
+	kfree(codec->private_data);
 	kfree(codec);
 
 	return 0;
diff -r fc216dd0eb92 soc/codecs/wm8731.h
--- a/soc/codecs/wm8731.h	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/wm8731.h	Wed Jan 31 16:43:17 2007 +0000
@@ -31,6 +31,9 @@
 
 #define WM8731_CACHEREGNUM 	10
 
+#define WM8731_SYSCLK	0
+#define WM8731_DAI		0
+
 struct wm8731_setup_data {
 	unsigned short i2c_address;
 };

--=-vLFtNqm4xsEO/ZnE+A3R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-vLFtNqm4xsEO/ZnE+A3R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-vLFtNqm4xsEO/ZnE+A3R--
