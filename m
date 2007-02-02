From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/19] ASoC 0.13 WM8750 codec driver
Date: Fri, 02 Feb 2007 15:46:40 +0000
Message-ID: <1170431200.18082.158.camel@localhost.localdomain>
References: <1170427418.18082.134.camel@localhost.localdomain>
	<s5htzy4k27a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zwXYxYBtBjTUvB4WVzw9"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5htzy4k27a.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-zwXYxYBtBjTUvB4WVzw9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-02-02 at 16:29 +0100, Takashi Iwai wrote:
> At Fri, 02 Feb 2007 14:43:38 +0000,
> Liam Girdwood wrote:
> > 
> > diff -r fc216dd0eb92 soc/codecs/wm8750.c
> > --- a/soc/codecs/wm8750.c	Thu Feb 01 16:52:06 2007 +0100
> > +++ b/soc/codecs/wm8750.c	Wed Jan 31 16:43:17 2007 +0000
> (snip)
> > +static struct workqueue_struct *wm8750_workq = NULL;
> 
> I guess the normal schedule_delayed_work() is enough instead of own
> workq?  Unless really frequent and heavy jobs, the global queue is
> more friendly to the system.
> 

Fixed. 

Thanks

Liam

--=-zwXYxYBtBjTUvB4WVzw9
Content-Disposition: attachment; filename=asoc13-codec-wm8750.patch
Content-Type: text/x-patch; name=asoc13-codec-wm8750.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/codecs/wm8750.c
--- a/soc/codecs/wm8750.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/wm8750.c	Fri Feb 02 15:44:05 2007 +0000
@@ -30,7 +30,7 @@
 #include "wm8750.h"
 
 #define AUDIO_NAME "WM8750"
-#define WM8750_VERSION "0.11"
+#define WM8750_VERSION "0.12"
 
 /*
  * Debug
@@ -50,6 +50,11 @@
 	printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
 #define warn(format, arg...) \
 	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
+
+/* codec private data */
+struct wm8750_priv {
+	unsigned int sysclk;
+};
 
 /*
  * wm8750 register cache
@@ -68,280 +73,6 @@ static const u16 wm8750_reg[] = {
 	0x0000, 0x0000, 0x0050, 0x0050,  /* 32 */
 	0x0050, 0x0050, 0x0050, 0x0050,  /* 36 */
 	0x0079, 0x0079, 0x0079,          /* 40 */
-};
-
-#define WM8750_HIFI_DAIFMT \
-	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_RIGHT_J | \
-	SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_NB_IF | SND_SOC_DAIFMT_IB_NF | \
-	SND_SOC_DAIFMT_IB_IF)
-
-#define WM8750_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-#define WM8750_HIFI_FSB \
-	(SND_SOC_FSBD(1) | SND_SOC_FSBD(2) | SND_SOC_FSBD(4) | \
-	SND_SOC_FSBD(8) | SND_SOC_FSBD(16))
-
-#define WM8750_HIFI_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define WM8750_HIFI_BITS \
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-
-static struct snd_soc_dai_mode wm8750_modes[] = {
-	/* common codec frame and clock master modes */
-	/* 8k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1536,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1408,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 2304,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 2112,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1500,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 11.025k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_11025,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1024,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_11025,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1536,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_11025,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1088,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 16k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_16000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 768,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_16000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1152,
-		.bfs = WM8750_HIFI_FSB
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_16000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 750,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 22.05k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_22050,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 512,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_22050,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 768,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_22050,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 544,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 32k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 384,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 576,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 375,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 44.1k & 48k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 384,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_44100,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 272,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_48000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 250,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* 88.2k & 96k */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 128,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 192,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_88200,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 136,
-		.bfs = WM8750_HIFI_FSB,
-	},
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = SNDRV_PCM_RATE_96000,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 125,
-		.bfs = WM8750_HIFI_FSB,
-	},
-
-	/* codec frame and clock slave modes */
-	{
-		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = WM8750_HIFI_BITS,
-		.pcmrate = WM8750_HIFI_RATES,
-		.pcmdir = WM8750_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = SND_SOC_FS_ALL,
-		.bfs = SND_SOC_FSB_ALL,
-	},
 };
 
 /*
@@ -834,113 +565,122 @@ static inline int get_coeff(int mclk, in
 	return -EINVAL;
 }
 
-/* WM8750 supports numerous input clocks per sample rate */
-static unsigned int wm8750_config_sysclk(struct snd_soc_codec_dai *dai,
-	struct snd_soc_clock_info *info, unsigned int clk)
-{
-	dai->mclk = clk;
-	return dai->mclk;
-}
-
-static int wm8750_pcm_prepare(struct snd_pcm_substream *substream)
+static int wm8750_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8750_priv *wm8750 = codec->private_data;
+
+	switch (freq) {
+	case 11289600:
+	case 12000000:
+	case 12288000:
+	case 16934400:
+	case 18432000:
+		wm8750->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int wm8750_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface = 0;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		iface = 0x0040;
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
+	wm8750_write(codec, WM8750_IFACE, iface);
+	return 0;
+}
+
+static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
-	u16 iface = 0, bfs, srate = 0;
-	int i = get_coeff(rtd->codec_dai->mclk,
-		snd_soc_get_rate(rtd->codec_dai->dai_runtime.pcmrate));
-
-	/* is coefficient valid ? */
-	if (i < 0)
-		return i;
-
-	bfs = SND_SOC_FSBD_REAL(rtd->codec_dai->dai_runtime.bfs);
-
-	/* set master/slave audio interface */
-	switch (rtd->codec_dai->dai_runtime.fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		iface = 0x0040;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		break;
-	}
-
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
+	struct wm8750_priv *wm8750 = codec->private_data;
+	u16 iface = wm8750_read_reg_cache(codec, WM8750_IFACE) & 0x1f3;
+	u16 srate = wm8750_read_reg_cache(codec, WM8750_SRATE) & 0x1c0;
+	int coeff = get_coeff(wm8750->sysclk, params_rate(params));
 
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
+	case SNDRV_PCM_FORMAT_S32_LE:
 		iface |= 0x000c;
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
-	/* set bclk divisor rate */
-	switch (bfs) {
-	case 1:
-		break;
-	case 4:
-		srate |= (0x1 << 7);
-		break;
-	case 8:
-		srate |= (0x2 << 7);
-		break;
-	case 16:
-		srate |= (0x3 << 7);
 		break;
 	}
 
 	/* set iface & srate */
 	wm8750_write(codec, WM8750_IFACE, iface);
-	wm8750_write(codec, WM8750_SRATE, srate |
-		(coeff_div[i].sr << 1) | coeff_div[i].usb);
+	if (coeff >= 0)
+		wm8750_write(codec, WM8750_SRATE, srate |
+			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
 }
 
-static int wm8750_mute(struct snd_soc_codec *codec,
-	struct snd_soc_codec_dai *dai, int mute)
-{
+static int wm8750_mute(struct snd_soc_codec_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8750_read_reg_cache(codec, WM8750_ADCDAC) & 0xfff7;
+
 	if (mute)
 		wm8750_write(codec, WM8750_ADCDAC, mute_reg | 0x8);
 	else
@@ -973,6 +713,13 @@ static int wm8750_dapm_event(struct snd_
 	codec->dapm_state = event;
 	return 0;
 }
+
+#define WM8750_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define WM8750_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
 
 struct snd_soc_codec_dai wm8750_dai = {
 	.name = "WM8750",
@@ -980,20 +727,21 @@ struct snd_soc_codec_dai wm8750_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-	},
+		.rates = WM8750_RATES,
+		.formats = WM8750_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
+		.rates = WM8750_RATES,
+		.formats = WM8750_FORMATS,},
+	.ops = {
+		.hw_params = wm8750_pcm_hw_params,
 	},
-	.config_sysclk = wm8750_config_sysclk,
-	.digital_mute = wm8750_mute,
-	.ops = {
-		.prepare = wm8750_pcm_prepare,
-	},
-	.caps = {
-		.num_modes = ARRAY_SIZE(wm8750_modes),
-		.mode = wm8750_modes,
+	.dai_ops = {
+		.digital_mute = wm8750_mute,
+		.set_fmt = wm8750_set_dai_fmt,
+		.set_sysclk = wm8750_set_dai_sysclk,
 	},
 };
 EXPORT_SYMBOL_GPL(wm8750_dai);
@@ -1037,8 +785,7 @@ static int wm8750_resume(struct platform
 	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 		codec->dapm_state = SNDRV_CTL_POWER_D0;
-		schedule_delayed_work(&codec->delayed_work,
-			 msecs_to_jiffies(1000));
+		schedule_delayed_work(&codec->delayed_work, msecs_to_jiffies(1000));
 	}
 
 	return 0;
@@ -1218,6 +965,7 @@ static int wm8750_probe(struct platform_
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct wm8750_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec;
+	struct wm8750_priv *wm8750;
 	int ret = 0;
 
 	info("WM8750 Audio Codec %s", WM8750_VERSION);
@@ -1225,12 +973,20 @@ static int wm8750_probe(struct platform_
 	if (codec == NULL)
 		return -ENOMEM;
 
+	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	if (wm8750 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = wm8750;
 	socdev->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 	wm8750_socdev = socdev;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
+	
 #if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
@@ -1246,6 +1002,25 @@ static int wm8750_probe(struct platform_
 	return ret;
 }
 
+/*
+ * This function forces any delayed work to be queued and run.
+ */
+static int run_delayed_work(struct delayed_work *dwork)
+{
+	int ret;
+
+	/* cancel any work waiting to be queued. */
+	ret = cancel_delayed_work(dwork);
+
+	/* if there was any work waiting then we run it now and
+	 * wait for it's completion */
+	if (ret) {
+		schedule_delayed_work(dwork, 0);
+		flush_scheduled_work();
+	}
+	return ret;
+}
+
 /* power down chip */
 static int wm8750_remove(struct platform_device *pdev)
 {
@@ -1254,12 +1029,13 @@ static int wm8750_remove(struct platform
 
 	if (codec->control_data)
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
-	flush_scheduled_work();
+	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8750_i2c_driver);
 #endif
+	kfree(codec->private_data);
 	kfree(codec);
 
 	return 0;
diff -r fc216dd0eb92 soc/codecs/wm8750.h
--- a/soc/codecs/wm8750.h	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/wm8750.h	Thu Feb 01 17:54:23 2007 +0000
@@ -55,9 +55,10 @@
 
 #define WM8750_CACHE_REGNUM 0x2a
 
+#define WM8750_SYSCLK	0
+
 struct wm8750_setup_data {
 	unsigned short i2c_address;
-	unsigned int mclk;
 };
 
 extern struct snd_soc_codec_dai wm8750_dai;

--=-zwXYxYBtBjTUvB4WVzw9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-zwXYxYBtBjTUvB4WVzw9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-zwXYxYBtBjTUvB4WVzw9--
