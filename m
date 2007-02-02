From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 1/19] 0.13 ASoC headers.
Date: Fri, 02 Feb 2007 14:42:20 +0000
Message-ID: <1170427340.18082.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-22oWzX5To/mtgqyHb5p+"
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


--=-22oWzX5To/mtgqyHb5p+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch updates the API's to include the new DAI configuration and
clocking architecture.

Changes:-

 o Removed DAI automatic matching and capabilities structure (struct
snd_soc_dai_mode) and macros.

 o Added DAI operations for codec and CPU interfaces.

 o Removed config_sysclk() function and struct snd_soc_clock_info. No
longer needed as clocking is now configured manually in the machine
drivers. Also removed other clocking data from structures.

 o Updated version to 0.13

 o Added shift to SOC_SINGLE_EXT kcontrol macro.

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>




--=-22oWzX5To/mtgqyHb5p+
Content-Disposition: attachment; filename=asoc13-header.patch
Content-Type: text/x-patch; name=asoc13-header.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 include/soc.h
--- a/include/soc.h	Thu Feb 01 16:52:06 2007 +0100
+++ b/include/soc.h	Wed Jan 31 17:50:32 2007 +0000
@@ -22,7 +22,7 @@
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
 
-#define SND_SOC_VERSION "0.12"
+#define SND_SOC_VERSION "0.13.0"
 
 /*
  * Convenience kcontrol builders
@@ -60,12 +60,12 @@
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
 	.private_value = (unsigned long)&xenum }
-#define SOC_SINGLE_EXT(xname, xreg, xmask, xinvert,\
+#define SOC_SINGLE_EXT(xname, xreg, xshift, xmask, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw_ext, \
+	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value =  SOC_SINGLE_VALUE_EXT(xreg, xmask, xinvert) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
@@ -87,20 +87,29 @@
 /*
  * DAI hardware audio formats
  */
-#define SND_SOC_DAIFMT_I2S		(1 << 0)	/* I2S mode */
-#define SND_SOC_DAIFMT_RIGHT_J	(1 << 1)	/* Right justified mode */
-#define SND_SOC_DAIFMT_LEFT_J	(1 << 2)	/* Left Justified mode */
-#define SND_SOC_DAIFMT_DSP_A	(1 << 3)	/* L data msb after FRM or LRC */
-#define SND_SOC_DAIFMT_DSP_B	(1 << 4)	/* L data msb during FRM or LRC */
-#define SND_SOC_DAIFMT_AC97		(1 << 5)	/* AC97 */
+#define SND_SOC_DAIFMT_I2S		0	/* I2S mode */
+#define SND_SOC_DAIFMT_RIGHT_J	1	/* Right justified mode */
+#define SND_SOC_DAIFMT_LEFT_J	2	/* Left Justified mode */
+#define SND_SOC_DAIFMT_DSP_A	3	/* L data msb after FRM or LRC */
+#define SND_SOC_DAIFMT_DSP_B	4	/* L data msb during FRM or LRC */
+#define SND_SOC_DAIFMT_AC97		5	/* AC97 */
+
+#define SND_SOC_DAIFMT_MSB 	SND_SOC_DAIFMT_LEFT_J
+#define SND_SOC_DAIFMT_LSB	SND_SOC_DAIFMT_RIGHT_J
+
+/*
+ * DAI Gating
+ */
+#define SND_SOC_DAIFMT_CONT			(0 << 4)	/* continuous clock */
+#define SND_SOC_DAIFMT_GATED		(1 << 4)	/* clock is gated when not Tx/Rx */
 
 /*
  * DAI hardware signal inversions
  */
-#define SND_SOC_DAIFMT_NB_NF		(1 << 8)	/* normal bit clock + frame */
-#define SND_SOC_DAIFMT_NB_IF		(1 << 9)	/* normal bclk + inv frm */
-#define SND_SOC_DAIFMT_IB_NF		(1 << 10)	/* invert bclk + nor frm */
-#define SND_SOC_DAIFMT_IB_IF		(1 << 11)	/* invert bclk + frm */
+#define SND_SOC_DAIFMT_NB_NF		(0 << 8)	/* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_IF		(1 << 8)	/* normal bclk + inv frm */
+#define SND_SOC_DAIFMT_IB_NF		(2 << 8)	/* invert bclk + nor frm */
+#define SND_SOC_DAIFMT_IB_IF		(3 << 8)	/* invert bclk + frm */
 
 /*
  * DAI hardware clock masters
@@ -108,58 +117,22 @@
  * i.e. if the codec is clk and frm master then the interface is
  * clk and frame slave.
  */
-#define SND_SOC_DAIFMT_CBM_CFM	(1 << 12) /* codec clk & frm master */
-#define SND_SOC_DAIFMT_CBS_CFM	(1 << 13) /* codec clk slave & frm master */
-#define SND_SOC_DAIFMT_CBM_CFS	(1 << 14) /* codec clk master & frame slave */
-#define SND_SOC_DAIFMT_CBS_CFS	(1 << 15) /* codec clk & frm slave */
-
-#define SND_SOC_DAIFMT_FORMAT_MASK		0x00ff
+#define SND_SOC_DAIFMT_CBM_CFM	(0 << 12) /* codec clk & frm master */
+#define SND_SOC_DAIFMT_CBS_CFM	(1 << 12) /* codec clk slave & frm master */
+#define SND_SOC_DAIFMT_CBM_CFS	(2 << 12) /* codec clk master & frame slave */
+#define SND_SOC_DAIFMT_CBS_CFS	(3 << 12) /* codec clk & frm slave */
+
+#define SND_SOC_DAIFMT_FORMAT_MASK		0x000f
+#define SND_SOC_DAIFMT_CLOCK_MASK		0x00f0
 #define SND_SOC_DAIFMT_INV_MASK			0x0f00
-#define SND_SOC_DAIFMT_CLOCK_MASK		0xf000
-
-/*
- * DAI hardware audio direction
- */
-#define SND_SOC_DAIDIR_PLAYBACK		0x1
-#define SND_SOC_DAIDIR_CAPTURE		0x2
-
-/*
- * DAI hardware Time Division Multiplexing (TDM) Slots
- * Left and Right data word positions
- * This is measured in words (sample size) and not bits.
- */
-#define SND_SOC_DAITDM_LRDW(l,r)	((l << 8) | r)
-
-/*
- * DAI hardware clock ratios
- * bit clock can either be a generated by dividing mclk or
- * by multiplying sample rate, hence there are 2 definitions below
- * depending on codec type.
- */
-/* ratio of sample rate to mclk/sysclk */
-#define SND_SOC_FS_ALL			0xffff	/* all mclk supported */
-
-/* bit clock dividers */
-#define SND_SOC_FSBD(x)			(1 << (x - 1))	/* ratio mclk:bclk */
-#define SND_SOC_FSBD_REAL(x)	(ffs(x))
-
-/* bit clock ratio to (sample rate * channels * word size) */
-#define SND_SOC_FSBW(x)			(1 << (x - 1))
-#define SND_SOC_FSBW_REAL(x)		(ffs(x))
-/* all bclk ratios supported */
-#define SND_SOC_FSB_ALL			~0ULL
-
-/*
- * DAI hardware flags
- */
-/* use bfs mclk divider mode (BCLK = MCLK / x) */
-#define SND_SOC_DAI_BFS_DIV		0x1
-/* use bfs rate mulitplier  (BCLK = RATE * x)*/
-#define SND_SOC_DAI_BFS_RATE	0x2
-/* use bfs rcw multiplier (BCLK = RATE * CHN * WORD SIZE) */
-#define SND_SOC_DAI_BFS_RCW		0x4
-/* capture and playback can use different clocks */
-#define SND_SOC_DAI_ASYNC		0x8
+#define SND_SOC_DAIFMT_MASTER_MASK		0xf000
+
+
+/*
+ * Master Clock Directions
+ */
+#define SND_SOC_CLOCK_IN	0
+#define SND_SOC_CLOCK_OUT	1
 
 /*
  * AC97 codec ID's bitmask
@@ -195,7 +168,6 @@ int snd_soc_register_card(struct snd_soc
 /* set runtime hw params */
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
-int snd_soc_get_rate(int rate);
 
 /* codec IO */
 #define snd_soc_read(codec, reg) codec->read(codec, reg)
@@ -244,6 +216,8 @@ int snd_soc_put_volsw_2r(struct snd_kcon
 /* SoC PCM stream information */
 struct snd_soc_pcm_stream {
 	char *stream_name;
+	u64 formats;			/* SNDRV_PCM_FMTBIT_* */
+	unsigned int rates;		/* SNDRV_PCM_RATE_* */
 	unsigned int rate_min;		/* min rate */
 	unsigned int rate_max;		/* max rate */
 	unsigned int channels_min;	/* min channels */
@@ -261,23 +235,43 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
-/* SoC DAI hardware mode */
-struct snd_soc_dai_mode {
-	u16 fmt;		/* SND_SOC_DAIFMT_* */
-	u16 tdm;		/* SND_SOC_HWTDM_* */
-	u64 pcmfmt; 	/* SNDRV_PCM_FMTBIT_* */
-	u16 pcmrate;	/* SND_SOC_HWRATE_* */
-	u16 pcmdir:2;	/* SND_SOC_HWDIR_* */
-	u16 flags:8;	/* hw flags */
-	u16 fs;			/* mclk to rate divider */
-	u64 bfs;		/* mclk to bclk dividers */
-	unsigned long priv;		/* private mode data */
-};
-
-/* DAI capabilities */
-struct snd_soc_dai_cap {
-	int num_modes;				/* number of DAI modes */
-	struct snd_soc_dai_mode *mode;	/* array of supported DAI modes */
+/* ASoC codec DAI ops */
+struct snd_soc_codec_ops {
+	/* codec DAI clocking configuration */
+	int (*set_sysclk)(struct snd_soc_codec_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_codec_dai *codec_dai,
+		int pll_id, unsigned int freq_in, unsigned int freq_out);
+	int (*set_clkdiv)(struct snd_soc_codec_dai *codec_dai,
+		int div_id, int div);
+
+	/* CPU DAI format configuration */
+	int (*set_fmt)(struct snd_soc_codec_dai *codec_dai,
+		unsigned int fmt);
+	int (*set_tdm_slot)(struct snd_soc_codec_dai *codec_dai,
+		unsigned int mask, int slots);
+	int (*set_tristate)(struct snd_soc_codec_dai *, int tristate);
+
+	/* digital mute */
+	int (*digital_mute)(struct snd_soc_codec_dai *, int mute);
+};
+
+/* ASoC cpu DAI ops */
+struct snd_soc_cpu_ops {
+	/* CPU DAI clocking configuration */
+	int (*set_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir);
+	int (*set_clkdiv)(struct snd_soc_cpu_dai *cpu_dai,
+		int div_id, int div);
+	int (*set_pll)(struct snd_soc_cpu_dai *cpu_dai,
+		int pll_id, unsigned int freq_in, unsigned int freq_out);
+
+	/* CPU DAI format configuration */
+	int (*set_fmt)(struct snd_soc_cpu_dai *cpu_dai,
+		unsigned int fmt);
+	int (*set_tdm_slot)(struct snd_soc_cpu_dai *cpu_dai,
+		unsigned int mask, int slots);
+	int (*set_tristate)(struct snd_soc_cpu_dai *, int tristate);
 };
 
 /* SoC Codec DAI */
@@ -288,21 +282,15 @@ struct snd_soc_codec_dai {
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream playback;
 	struct snd_soc_pcm_stream capture;
-	struct snd_soc_dai_cap caps;
 
 	/* DAI runtime info */
-	struct snd_soc_dai_mode dai_runtime;
-	struct snd_soc_ops ops;
-	unsigned int (*config_sysclk)(struct snd_soc_codec_dai*,
-		struct snd_soc_clock_info *info, unsigned int clk);
-	int (*digital_mute)(struct snd_soc_codec *,
-		struct snd_soc_codec_dai*, int);
-	unsigned int mclk;		/* the audio master clock */
-	unsigned int pll_in;	/* the PLL input clock */
-	unsigned int pll_out;	/* the PLL output clock */
-	unsigned int clk_div;	/* internal clock divider << 1 (for fractions) */
+	struct snd_soc_codec *codec;
 	unsigned int active;
 	unsigned char pop_wait:1;
+
+	/* ops */
+	struct snd_soc_ops ops;
+	struct snd_soc_codec_ops dai_ops;
 
 	/* DAI private data */
 	void *private_data;
@@ -323,20 +311,18 @@ struct snd_soc_cpu_dai {
 		struct snd_soc_cpu_dai *cpu_dai);
 	int (*resume)(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai);
-	unsigned int (*config_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
-		struct snd_soc_clock_info *info, unsigned int clk);
+
+	/* ops */
+	struct snd_soc_ops ops;
+	struct snd_soc_cpu_ops dai_ops;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
-	struct snd_soc_dai_cap caps;
 
 	/* DAI runtime info */
-	struct snd_soc_dai_mode dai_runtime;
-	struct snd_soc_ops ops;
 	struct snd_pcm_runtime *runtime;
 	unsigned char active:1;
-	unsigned int mclk;
 	void *dma_data;
 
 	/* DAI private data */
@@ -417,14 +403,12 @@ struct snd_soc_dai_link  {
 	/* DAI */
 	struct snd_soc_codec_dai *codec_dai;
 	struct snd_soc_cpu_dai *cpu_dai;
-	u32 flags;			/* DAI config preference flags */
+
+	/* machine stream operations */
+	struct snd_soc_ops *ops;
 
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_codec *codec);
-
-	/* audio sysclock configuration */
-	unsigned int (*config_sysclk)(struct snd_soc_pcm_runtime *rtd,
-		struct snd_soc_clock_info *info);
 };
 
 /* SoC machine */
@@ -440,9 +424,6 @@ struct snd_soc_machine {
 	int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
 	int (*resume_pre)(struct platform_device *pdev);
 	int (*resume_post)(struct platform_device *pdev);
-
-	/* machine stream operations */
-	struct snd_soc_ops *ops;
 
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
@@ -462,8 +443,7 @@ struct snd_soc_device {
 
 /* runtime channel data */
 struct snd_soc_pcm_runtime {
-	struct snd_soc_codec_dai *codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai;
+	struct snd_soc_dai_link *dai;
 	struct snd_soc_device *socdev;
 };
 
@@ -478,11 +458,4 @@ struct soc_enum {
 	void *dapm;
 };
 
-/* clocking configuration data */
-struct snd_soc_clock_info {
-	unsigned int rate;
-	unsigned int fs;
-	unsigned int bclk_master;
-};
-
 #endif

--=-22oWzX5To/mtgqyHb5p+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-22oWzX5To/mtgqyHb5p+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-22oWzX5To/mtgqyHb5p+--
