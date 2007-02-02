From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 13/19] ASoC 0.13 pxa2xx i2s driver.
Date: Fri, 02 Feb 2007 14:45:39 +0000
Message-ID: <1170427539.18082.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BNDl18br7FV/OyQ7YkGf"
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

--=-BNDl18br7FV/OyQ7YkGf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the pxa2xx I2S driver to the new API in ASoC 0.13.

Changes:-

o Removed DAI capabilities matching code in favour of manual matching in
the machine drivers.

o Added DAI operations for codec and CPU interfaces.

o Removed config_sysclk() function and struct snd_soc_clock_info. No
longer needed as clocking is now configured manually in the machine
drivers. Also removed other clocking data from structures.

o Added pxa2xx-i2s.h header 

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
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


--=-BNDl18br7FV/OyQ7YkGf
Content-Disposition: attachment; filename="asoc13-pxa2xx-i2s.patch"
Content-Type: text/x-patch; name="asoc13-pxa2xx-i2s.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/pxa/pxa2xx-i2s.c
--- a/soc/pxa/pxa2xx-i2s.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/pxa2xx-i2s.c	Thu Feb 01 17:51:31 2007 +0000
@@ -29,11 +29,7 @@
 #include <asm/arch/audio.h>
 
 #include "pxa2xx-pcm.h"
-
-/* used to disable sysclk if external crystal is used */
-static int extclk;
-module_param(extclk, int, 0);
-MODULE_PARM_DESC(extclk, "set to 1 to disable pxa2xx i2s sysclk");
+#include "pxa2xx-i2s.h"
 
 struct pxa_i2s_port {
 	u32 sadiv;
@@ -41,96 +37,9 @@ struct pxa_i2s_port {
 	u32 sacr1;
 	u32 saimr;
 	int master;
+	u32 fmt;
 };
 static struct pxa_i2s_port pxa_i2s;
-
-#define PXA_I2S_DAIFMT \
-	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF)
-
-#define PXA_I2S_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-#define PXA_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-/* priv is divider */
-static struct snd_soc_dai_mode pxa2xx_i2s_modes[] = {
-	/* pxa2xx I2S frame and clock master modes */
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0x48,
-	},
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_11025,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0x34,
-	},
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_16000,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0x24,
-	},
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_22050,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0x1a,
-	},
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_44100,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0xd,
-	},
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_48000,
-		.pcmdir = PXA_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 256,
-		.bfs = SND_SOC_FSBD(4),
-		.priv = 0xc,
-	},
-
-	/* pxa2xx I2S frame master and clock slave mode */
-	{
-		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBM_CFS,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = PXA_I2S_RATES,
-		.pcmdir = PXA_I2S_DIR,
-		.fs = SND_SOC_FS_ALL,
-		.flags = SND_SOC_DAI_BFS_RATE,
-		.bfs = 64,
-		.priv = 0x48,
-	},
-};
 
 static struct pxa2xx_pcm_dma_params pxa2xx_i2s_pcm_stereo_out = {
 	.name			= "I2S PCM Stereo out",
@@ -171,8 +80,9 @@ static int pxa2xx_i2s_startup(struct snd
 static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	if (!rtd->cpu_dai->active) {
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	if (!cpu_dai->active) {
 		SACR0 |= SACR0_RST;
 		SACR0 = 0;
 	}
@@ -191,17 +101,49 @@ static int pxa_i2s_wait(void)
 	return 0;
 }
 
+static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+		unsigned int fmt)
+{
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		pxa_i2s.fmt = 0;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		pxa_i2s.fmt = SACR1_AMSL;
+		break;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		pxa_i2s.master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		pxa_i2s.master = 0;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int pxa2xx_i2s_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	if (clk_id != PXA2XX_I2S_SYSCLK)
+		return -ENODEV;
+
+	if (pxa_i2s.master && dir == SND_SOC_CLOCK_OUT)
+		pxa_gpio_mode(gpio_bus[pxa_i2s.master].sys);
+
+	return 0;
+}
+
 static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	pxa_i2s.master = 0;
-	if (rtd->cpu_dai->dai_runtime.fmt & SND_SOC_DAIFMT_CBS_CFS)
-		pxa_i2s.master = 1;
-
-	if (pxa_i2s.master && !extclk)
-		pxa_gpio_mode(gpio_bus[pxa_i2s.master].sys);
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].rx);
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].tx);
@@ -211,9 +153,9 @@ static int pxa2xx_i2s_hw_params(struct s
 	pxa_i2s_wait();
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_out;
+		cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_out;
 	else
-		rtd->cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_in;
+		cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_in;
 
 	/* is port used by another stream */
 	if (!(SACR0 & SACR0_ENB)) {
@@ -224,16 +166,37 @@ static int pxa2xx_i2s_hw_params(struct s
 			SACR0 |= SACR0_BCKD;
 
 		SACR0 |= SACR0_RFTH(14) | SACR0_TFTH(1);
-
-		if (rtd->cpu_dai->dai_runtime.fmt & SND_SOC_DAIFMT_LEFT_J)
-			SACR1 |= SACR1_AMSL;
+		SACR1 |= pxa_i2s.fmt;
 	}
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		SAIMR |= SAIMR_TFS;
 	else
 		SAIMR |= SAIMR_RFS;
 
-	SADIV = rtd->cpu_dai->dai_runtime.priv;
+	switch (params_rate(params)) {
+	case 8000:
+		SADIV = 0x48;
+		break;
+	case 11025:
+		SADIV = 0x34;
+		break;
+	case 16000:
+		SADIV = 0x24;
+		break;
+	case 22050:
+		SADIV = 0x1a;
+		break;
+	case 44100:
+		SADIV = 0xd;
+		break;
+	case 48000:
+		SADIV = 0xc;
+		break;
+	case 96000: /* not in manual and possibly slightly inaccurate */
+		SADIV = 0x6;
+		break;
+	}
+
 	return 0;
 }
 
@@ -316,12 +279,9 @@ static int pxa2xx_i2s_resume(struct plat
 #define pxa2xx_i2s_resume	NULL
 #endif
 
-/* pxa2xx I2S sysclock is always 256 FS */
-static unsigned int pxa_i2s_config_sysclk(struct snd_soc_cpu_dai *iface,
-	struct snd_soc_clock_info *info, unsigned int clk)
-{
-	return info->rate << 8;
-}
+#define PXA2XX_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
 
 struct snd_soc_cpu_dai pxa_i2s_dai = {
 	.name = "pxa2xx-i2s",
@@ -329,21 +289,25 @@ struct snd_soc_cpu_dai pxa_i2s_dai = {
 	.type = SND_SOC_DAI_I2S,
 	.suspend = pxa2xx_i2s_suspend,
 	.resume = pxa2xx_i2s_resume,
-	.config_sysclk = pxa_i2s_config_sysclk,
 	.playback = {
 		.channels_min = 2,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = PXA2XX_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
 		.channels_min = 2,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = PXA2XX_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.startup = pxa2xx_i2s_startup,
 		.shutdown = pxa2xx_i2s_shutdown,
 		.trigger = pxa2xx_i2s_trigger,
 		.hw_params = pxa2xx_i2s_hw_params,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(pxa2xx_i2s_modes),
-		.mode = pxa2xx_i2s_modes,},
+	.dai_ops = {
+		.set_fmt = pxa2xx_i2s_set_dai_fmt,
+		.set_sysclk = pxa2xx_i2s_set_dai_sysclk,
+	},
 };
 
 EXPORT_SYMBOL_GPL(pxa_i2s_dai);
diff -r fc216dd0eb92 soc/pxa/pxa2xx-i2s.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/pxa/pxa2xx-i2s.h	Wed Jan 31 16:43:17 2007 +0000
@@ -0,0 +1,20 @@
+/*
+ * linux/sound/arm/pxa2xx-i2s.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PXA2XX_I2S_H
+#define _PXA2XX_I2S_H
+
+/* pxa2xx DAI ID's */
+#define PXA2XX_DAI_I2S			0
+
+/* I2S clock */
+#define PXA2XX_I2S_SYSCLK		0
+
+extern struct snd_soc_cpu_dai pxa_i2s_dai;
+
+#endif

--=-BNDl18br7FV/OyQ7YkGf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-BNDl18br7FV/OyQ7YkGf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-BNDl18br7FV/OyQ7YkGf--
