From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ASoC Blackfin: add asoc ad73311 driver
	supporting in Blackfin boards
Date: Sat, 27 Sep 2008 16:59:03 +0800
Message-ID: <1222505943-22457-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 824E710383D
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 10:58:40 +0200 (CEST)
Received: by po-out-1718.google.com with SMTP id b23so1824393poe.2
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 01:58:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/Kconfig         |   16 +++
 sound/soc/blackfin/Makefile        |    3 +-
 sound/soc/blackfin/bf5xx-ad73311.c |  240 ++++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-i2s.c     |   52 ++++++--
 4 files changed, 296 insertions(+), 15 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad73311.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index f98331d..dc00620 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -17,6 +17,22 @@ config SND_BF5XX_SOC_SSM2602
 	help
 	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
 
+config SND_BF5XX_SOC_AD73311
+	tristate "SoC AD73311 Audio support for Blackfin"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_AD73311
+	help
+	  Say Y if you want to add support for AD73311 codec on Blackfin.
+
+config SND_BFIN_AD73311_SE
+	int "PF pin for AD73311L Chip Select"
+	depends on SND_BF5XX_SOC_AD73311
+	default 4
+	help
+	  Enter the GPIO used to control AD73311's SE pin. Acceptable
+	  values are 0 to 7
+
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN && SND_SOC
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 9ea8bd9..97bb37a 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
 # Blackfin Machine Support
 snd-ad1980-objs := bf5xx-ad1980.o
 snd-ssm2602-objs := bf5xx-ssm2602.o
-
+snd-ad73311-objs := bf5xx-ad73311.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1980) += snd-ad1980.o
 obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
+obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
new file mode 100644
index 0000000..622c9b9
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -0,0 +1,240 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-ad73311.c
+ * Author:       Cliff Cai <Cliff.Cai@analog.com>
+ *
+ * Created:      Thur Sep 25 2008
+ * Description:  Board driver for ad73311 sound chip
+ *
+ * Modified:
+ *               Copyright 2008 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm_params.h>
+
+#include <asm/blackfin.h>
+#include <asm/cacheflush.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+#include <asm/portmux.h>
+
+#include "../codecs/ad73311.h"
+#include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
+#include "bf5xx-i2s.h"
+
+#if CONFIG_SND_BF5XX_SPORT_NUM == 0
+#define bfin_write_SPORT_TCR1	bfin_write_SPORT0_TCR1
+#define bfin_read_SPORT_TCR1	bfin_read_SPORT0_TCR1
+#define bfin_write_SPORT_TCR2	bfin_write_SPORT0_TCR2
+#define bfin_write_SPORT_TX16	bfin_write_SPORT0_TX16
+#define bfin_read_SPORT_STAT	bfin_read_SPORT0_STAT
+#else
+#define bfin_write_SPORT_TCR1	bfin_write_SPORT1_TCR1
+#define bfin_read_SPORT_TCR1	bfin_read_SPORT1_TCR1
+#define bfin_write_SPORT_TCR2	bfin_write_SPORT1_TCR2
+#define bfin_write_SPORT_TX16	bfin_write_SPORT1_TX16
+#define bfin_read_SPORT_STAT	bfin_read_SPORT1_STAT
+#endif
+
+#define GPIO_SE CONFIG_SND_BFIN_AD73311_SE
+
+static struct snd_soc_machine bf5xx_ad73311;
+
+static int snd_ad73311_startup(void)
+{
+	pr_debug("%s enter\n", __func__);
+
+	/* Pull up SE pin on AD73311L */
+	gpio_set_value(GPIO_SE, 1);
+	return 0;
+}
+
+static int snd_ad73311_configure(void)
+{
+	unsigned short ctrl_regs[6];
+	unsigned short status = 0;
+	int count = 0;
+
+	/* DMCLK = MCLK = 16.384 MHz
+	 * SCLK = DMCLK/8 = 2.048 MHz
+	 * Sample Rate = DMCLK/2048  = 8 KHz
+	 */
+	ctrl_regs[0] = AD_CONTROL | AD_WRITE | CTRL_REG_B | REGB_MCDIV(0) | \
+			REGB_SCDIV(0) | REGB_DIRATE(0);
+	ctrl_regs[1] = AD_CONTROL | AD_WRITE | CTRL_REG_C | REGC_PUDEV | \
+			REGC_PUADC | REGC_PUDAC | REGC_PUREF | REGC_REFUSE ;
+	ctrl_regs[2] = AD_CONTROL | AD_WRITE | CTRL_REG_D | REGD_OGS(2) | \
+			REGD_IGS(2);
+	ctrl_regs[3] = AD_CONTROL | AD_WRITE | CTRL_REG_E | REGE_DA(0x1f);
+	ctrl_regs[4] = AD_CONTROL | AD_WRITE | CTRL_REG_F | REGF_SEEN ;
+	ctrl_regs[5] = AD_CONTROL | AD_WRITE | CTRL_REG_A | REGA_MODE_DATA;
+
+	local_irq_disable();
+	snd_ad73311_startup();
+	udelay(1);
+
+	bfin_write_SPORT_TCR1(TFSR);
+	bfin_write_SPORT_TCR2(0xF);
+	SSYNC();
+
+	/* SPORT Tx Register is a 8 x 16 FIFO, all the data can be put to
+	 * FIFO before enable SPORT to transfer the data
+	 */
+	for (count = 0; count < 6; count++)
+		bfin_write_SPORT_TX16(ctrl_regs[count]);
+	SSYNC();
+	bfin_write_SPORT_TCR1(bfin_read_SPORT_TCR1() | TSPEN);
+	SSYNC();
+
+	/* When TUVF is set, the data is already send out */
+	while (!(status & TUVF) && count++ < 10000) {
+		udelay(1);
+		status = bfin_read_SPORT_STAT();
+		SSYNC();
+	}
+	bfin_write_SPORT_TCR1(bfin_read_SPORT_TCR1() & ~TSPEN);
+	SSYNC();
+	local_irq_enable();
+
+	if (count == 10000) {
+		printk(KERN_ERR "ad73311: failed to configure codec\n");
+		return -1;
+	}
+	return 0;
+}
+
+static int bf5xx_probe(struct platform_device *pdev)
+{
+	int err;
+	if (gpio_request(GPIO_SE, "AD73311_SE")) {
+		printk(KERN_ERR "%s: Failed ro request GPIO_%d\n", __func__, GPIO_SE);
+		return -EBUSY;
+	}
+
+	gpio_direction_output(GPIO_SE, 0);
+
+	err = snd_ad73311_configure();
+	if (err < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int bf5xx_ad73311_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	pr_debug("%s enter\n", __func__);
+	cpu_dai->private_data = sport_handle;
+	return 0;
+}
+
+static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret = 0;
+
+	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
+		params_format(params));
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+
+static struct snd_soc_ops bf5xx_ad73311_ops = {
+	.startup = bf5xx_ad73311_startup,
+	.hw_params = bf5xx_ad73311_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_ad73311_dai = {
+	.name = "ad73311",
+	.stream_name = "AD73311",
+	.cpu_dai = &bf5xx_i2s_dai,
+	.codec_dai = &ad73311_dai,
+	.ops = &bf5xx_ad73311_ops,
+};
+
+static struct snd_soc_machine bf5xx_ad73311 = {
+	.name = "bf5xx_ad73311",
+	.probe = bf5xx_probe,
+	.dai_link = &bf5xx_ad73311_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_ad73311_snd_devdata = {
+	.machine = &bf5xx_ad73311,
+	.platform = &bf5xx_i2s_soc_platform,
+	.codec_dev = &soc_codec_dev_ad73311,
+};
+
+static struct platform_device *bf52x_ad73311_snd_device;
+
+static int __init bf5xx_ad73311_init(void)
+{
+	int ret;
+
+	pr_debug("%s enter\n", __func__);
+	bf52x_ad73311_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf52x_ad73311_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bf52x_ad73311_snd_device, &bf5xx_ad73311_snd_devdata);
+	bf5xx_ad73311_snd_devdata.dev = &bf52x_ad73311_snd_device->dev;
+	ret = platform_device_add(bf52x_ad73311_snd_device);
+
+	if (ret)
+		platform_device_put(bf52x_ad73311_snd_device);
+
+	return ret;
+}
+
+static void __exit bf5xx_ad73311_exit(void)
+{
+	pr_debug("%s enter\n", __func__);
+	platform_device_unregister(bf52x_ad73311_snd_device);
+}
+
+module_init(bf5xx_ad73311_init);
+module_exit(bf5xx_ad73311_exit);
+
+/* Module information */
+MODULE_AUTHOR("Cliff Cai");
+MODULE_DESCRIPTION("ALSA SoC AD73311 Blackfin");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 43a4092..8ccc778 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -24,6 +24,11 @@
  * along with this program; if not, see the file COPYING, or write
  * to the Free Software Foundation, Inc.,
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ *
+ * Revision history
+ *	6th June 2008 Initial version 
+ *	25th Sep 2008 add DAI support for AD73311
  */
 
 #include <linux/init.h>
@@ -70,6 +75,13 @@ static struct sport_param sport_params[2] = {
 	}
 };
 
+static u16 sport_req[][7] = {
+		{ P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
+		  P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0},
+		{ P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS,
+		  P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0},
+};
+
 static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -78,6 +90,14 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* interface format:support I2S,slave mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+		bf5xx_i2s.tcr1 |= TFSR | TCKFE;
+		bf5xx_i2s.rcr1 |= RFSR | RCKFE;
+		bf5xx_i2s.tcr2 |= TSFSE;
+		bf5xx_i2s.rcr2 |= RSFSE;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		bf5xx_i2s.tcr1 |= TFSR;
+		bf5xx_i2s.rcr1 |= RFSR;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		ret = -EINVAL;
@@ -127,14 +147,17 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bf5xx_i2s.tcr2 |= 15;
 		bf5xx_i2s.rcr2 |= 15;
+		sport_handle->wdsize = 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		bf5xx_i2s.tcr2 |= 23;
 		bf5xx_i2s.rcr2 |= 23;
+		sport_handle->wdsize = 3;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		bf5xx_i2s.tcr2 |= 31;
 		bf5xx_i2s.rcr2 |= 31;
+		sport_handle->wdsize = 4;
 		break;
 	}
 
@@ -145,17 +168,17 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		 * need to configure both of them at the time when the first
 		 * stream is opened.
 		 *
-		 * CPU DAI format:I2S, slave mode.
+		 * CPU DAI:slave mode.
 		 */
-		ret = sport_config_rx(sport_handle, RFSR | RCKFE,
-				      RSFSE|bf5xx_i2s.rcr2, 0, 0);
+		ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
+				      bf5xx_i2s.rcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
 
-		ret = sport_config_tx(sport_handle, TFSR | TCKFE,
-				      TSFSE|bf5xx_i2s.tcr2, 0, 0);
+		ret = sport_config_tx(sport_handle, bf5xx_i2s.tcr1,
+				      bf5xx_i2s.tcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
@@ -174,13 +197,6 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream)
 static int bf5xx_i2s_probe(struct platform_device *pdev,
 			   struct snd_soc_dai *dai)
 {
-	u16 sport_req[][7] = {
-		{ P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-		  P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0},
-		{ P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS,
-		  P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0},
-	};
-
 	pr_debug("%s enter\n", __func__);
 	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
 		pr_err("Requesting Peripherals failed\n");
@@ -198,6 +214,13 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static void bf5xx_i2s_remove(struct platform_device *pdev,
+			   struct snd_soc_dai *dai)
+{
+	pr_debug("%s enter\n", __func__);
+	peripheral_free_list(&sport_req[sport_num][0]);
+}
+
 #ifdef CONFIG_PM
 static int bf5xx_i2s_suspend(struct platform_device *dev,
 			     struct snd_soc_dai *dai)
@@ -263,15 +286,16 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
 	.probe = bf5xx_i2s_probe,
+	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
 	.resume = bf5xx_i2s_resume,
 	.playback = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
-- 
1.5.6
