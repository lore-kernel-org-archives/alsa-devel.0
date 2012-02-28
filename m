From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap3beagle: Add dai link for McBSP2
	master configuration (CLKS source)
Date: Tue, 28 Feb 2012 09:55:14 +0200
Message-ID: <1330415714-5136-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242]) by alsa0.perex.cz (Postfix) with SMTP id A83DB244BB
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 08:55:41 +0100 (CET)
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so5187553lah.9
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 23:55:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Create new dai link so we can choose between two different modes of operation:
PCM0: twl4030 master, McBSP2 slave (current configuration)
PCM1: twl4030 slave, McBSP2 slave (SRG source is from CLKS pin)

This will help us tracking down, and test different setups on Beagle board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hello,

While tracking down an issue regported by Grazvydas Ignotas regarding to the
McBSP move series (Pandora setup was not working) I have noticed that we can
use the Beagle board in a similar way as Pandora uses it (McBSP master, twl4030
slave, CLKS pin is connected to twl4030 256*FS clock output).
With this patch we can switch between the two modes by playing on hw:0,0 or on
hw:0,1.

I will add the third option later where McBSP is the master, but the clock for
SRG is coming from internal source.

This patch depends on the McBSP rewrite series (OMAP/ASoC: Move and merge McBSP
driver under ASoC)
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049628.html

Regards,
Peter

 sound/soc/omap/omap3beagle.c |  110 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 2830dfd..a2f9130 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -34,6 +34,7 @@
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
+/* McBSP2 slave, TWL4030 master */
 static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -80,6 +81,14 @@ static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Set McBSP clock to PER_96M_FCLK */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
+				     96000000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu system clock\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -87,23 +96,104 @@ static struct snd_soc_ops omap3beagle_ops = {
 	.hw_params = omap3beagle_hw_params,
 };
 
+/* McBSP2 master, TWL4030 slave */
+static int omap3beagle_slave_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int fmt;
+	int ret;
+
+	switch (params_channels(params)) {
+	case 2: /* Stereo I2S mode */
+		fmt =	SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	case 4: /* Four channel TDM mode */
+		fmt =	SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	/* Set McBSP clock to external (CLKS) */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+				     256 * params_rate(params),
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu system clock\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 8);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set SRG clock divider\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap3beagle_slave_ops = {
+	.hw_params = omap3beagle_slave_hw_params,
+};
+
 /* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link omap3beagle_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.platform_name = "omap-pcm-audio",
-	.codec_dai_name = "twl4030-hifi",
-	.codec_name = "twl4030-codec",
-	.ops = &omap3beagle_ops,
+static struct snd_soc_dai_link omap3beagle_dai[] = {
+	{
+		/* McBSP2 slave, TWL4030 master configuration */
+		.name = "TWL4030 master",
+		.stream_name = "TWL4030 master",
+		.cpu_dai_name = "omap-mcbsp.2",
+		.platform_name = "omap-pcm-audio",
+		.codec_dai_name = "twl4030-hifi",
+		.codec_name = "twl4030-codec",
+		.ops = &omap3beagle_ops,
+	}, {
+		/* McBSP2 master, TWL4030 slave configuration */
+		.name = "TWL4030 slave",
+		.stream_name = "TWL4030 slave",
+		.cpu_dai_name = "omap-mcbsp.2",
+		.platform_name = "omap-pcm-audio",
+		.codec_dai_name = "twl4030-hifi",
+		.codec_name = "twl4030-codec",
+		.ops = &omap3beagle_slave_ops,
+	},
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_omap3beagle = {
 	.name = "omap3beagle",
 	.owner = THIS_MODULE,
-	.dai_link = &omap3beagle_dai,
-	.num_links = 1,
+	.dai_link = omap3beagle_dai,
+	.num_links = ARRAY_SIZE(omap3beagle_dai),
 };
 
 static struct platform_device *omap3beagle_snd_device;
-- 
1.7.8.4
