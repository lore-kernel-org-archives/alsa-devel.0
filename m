From: sean.mcneil@ti.com
Subject: [PATCH - BT and FM audio for zoom2 2/2] Change pcm to
	bluetooth for McBSP3. Add FM transmit for McBSP4
Date: Mon,  3 Aug 2009 11:29:15 +0700
Message-ID: <1249273755-32620-2-git-send-email-sean.mcneil@ti.com>
References: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Sean McNeil <sean.mcneil@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Sean McNeil <sean.mcneil@ti.com>


Signed-off-by: Sean McNeil <sean.mcneil@ti.com>

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index f90b45f..2fdefd5 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -35,10 +35,13 @@
 #include "omap-pcm.h"
 #include "../codecs/twl4030.h"
 
+#define OMAP_MCBSP_MASTER_MODE	0
+
+#define ZOOM2_BT_MCBSP_GPIO		164
 #define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
 #define ZOOM2_HEADSET_EXTMUTE_GPIO	153
 
-static int zoom2_hw_params(struct snd_pcm_substream *substream,
+static int zoom2_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -77,33 +80,41 @@ static int zoom2_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops zoom2_ops = {
-	.hw_params = zoom2_hw_params,
+static struct snd_soc_ops zoom2_i2s_ops = {
+	.hw_params = zoom2_i2s_hw_params,
 };
 
-static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int zoom2_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;
 
+	if (gpio_request(ZOOM2_BT_MCBSP_GPIO, "bt_mux") == 0) {
+		gpio_direction_output(ZOOM2_BT_MCBSP_GPIO, 1);
+		gpio_free(ZOOM2_BT_MCBSP_GPIO);
+	}
+
+#if OMAP_MCBSP_MASTER_MODE
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int divisor;
+
 	/* Set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
 		return ret;
 	}
 
 	/* Set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai,
-				SND_SOC_DAIFMT_DSP_A |
-				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBM_CFM);
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0) {
 		printk(KERN_ERR "can't set cpu DAI configuration\n");
 		return ret;
@@ -117,11 +128,121 @@ static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret = twl4030_set_rate(codec_dai->codec, params);
+
+	/* Use external (CLK256FS) clock for mcBSP3 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+			0, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set mcBSP3 to external clock\n");
+		return ret;
+	}
+
+	divisor = twl4030_get_clock_divisor(codec_dai->codec, params);
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, divisor);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec clock divisor\n");
+		return ret;
+	}
+#else
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+int zoom2_pcm_hw_free(struct snd_pcm_substream *substream)
+{
 	return 0;
 }
 
-static struct snd_soc_ops zoom2_voice_ops = {
-	.hw_params = zoom2_hw_voice_params,
+static struct snd_soc_ops zoom2_pcm_ops = {
+	.hw_params = zoom2_pcm_hw_params,
+	.hw_free = zoom2_pcm_hw_free,
+};
+
+static int zoom2_fm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+#if OMAP_MCBSP_MASTER_MODE
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int divisor;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+			SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	ret = twl4030_set_rate(codec_dai->codec, params);
+
+	/* Use external (CLK256FS) clock for mcBSP4 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+			0, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set mcBSP4 to external clock\n");
+		return ret;
+	}
+
+	divisor = twl4030_get_clock_divisor(codec_dai->codec, params);
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, divisor);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec clock divisor\n");
+		return ret;
+	}
+#else
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static struct snd_soc_ops zoom2_fm_ops = {
+	.hw_params = zoom2_fm_hw_params,
 };
 
 /* Zoom2 machine DAPM */
@@ -207,24 +328,57 @@ static int zoom2_twl4030_voice_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#if !OMAP_MCBSP_MASTER_MODE
+struct snd_soc_dai null_dai = {
+	.name = "null",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE,},
+};
+#endif
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link zoom2_dai[] = {
-	{
-		.name = "TWL4030 I2S",
-		.stream_name = "TWL4030 Audio",
-		.cpu_dai = &omap_mcbsp_dai[0],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
-		.init = zoom2_twl4030_init,
-		.ops = &zoom2_ops,
-	},
-	{
-		.name = "TWL4030 PCM",
-		.stream_name = "TWL4030 Voice",
-		.cpu_dai = &omap_mcbsp_dai[1],
-		.codec_dai = &twl4030_dai[TWL4030_DAI_VOICE],
-		.init = zoom2_twl4030_voice_init,
-		.ops = &zoom2_voice_ops,
-	},
+{
+	.name = "TWL4030_I2S",
+	.stream_name = "TWL4030_I2S",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.init = zoom2_twl4030_init,
+	.ops = &zoom2_i2s_ops,
+},
+{
+	.name = "TWL4030_PCM",
+	.stream_name = "TWL4030_PCM",
+	.cpu_dai = &omap_mcbsp_dai[1],
+#if OMAP_MCBSP_MASTER_MODE
+	.codec_dai = &twl4030_dai[TWL4030_DAI_CLOCK],
+#else
+	.codec_dai = &null_dai,
+#endif
+	.init = zoom2_twl4030_voice_init,
+	.ops = &zoom2_pcm_ops,
+},
+{
+	.name = "TWL4030_FM",
+	.stream_name = "TWL4030_FM",
+	.cpu_dai = &omap_mcbsp_dai[2],
+#if OMAP_MCBSP_MASTER_MODE
+	.codec_dai = &twl4030_dai[TWL4030_DAI_CLOCK],
+#else
+	.codec_dai = &null_dai,
+#endif
+	.ops = &zoom2_fm_ops,
+},
 };
 
 /* Audio machine driver */
@@ -268,6 +422,10 @@ static int __init zoom2_soc_init(void)
 	}
 	printk(KERN_INFO "Zoom2 SoC init\n");
 
+#if !OMAP_MCBSP_MASTER_MODE
+	snd_soc_register_dais(&null_dai, 1);
+#endif
+
 	zoom2_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!zoom2_snd_device) {
 		printk(KERN_ERR "Platform device allocation failed\n");
@@ -278,6 +436,7 @@ static int __init zoom2_soc_init(void)
 	zoom2_snd_devdata.dev = &zoom2_snd_device->dev;
 	*(unsigned int *)zoom2_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
 	*(unsigned int *)zoom2_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
+	*(unsigned int *)zoom2_dai[2].cpu_dai->private_data = 3; /* McBSP4 */
 
 	ret = platform_device_add(zoom2_snd_device);
 	if (ret)
-- 
1.6.0.4
