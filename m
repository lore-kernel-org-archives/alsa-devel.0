From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 12/19] ASoC 0.13 AT91xxxx Eti_B1 board support
Date: Fri, 02 Feb 2007 14:45:27 +0000
Message-ID: <1170427527.18082.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VVBsv9pqry3qiKAIFE8M"
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

--=-VVBsv9pqry3qiKAIFE8M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the EtI B1 machine driver to the new API in ASoC
0.13.

Changes:-

o  Manually configure DAI hardware format.

o Removed config_sysclk() function. No longer needed as clocking is now
configured manually.

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


--=-VVBsv9pqry3qiKAIFE8M
Content-Disposition: attachment; filename="asoc13-at91-eti-b1.patch"
Content-Type: text/x-patch; name="asoc13-at91-eti-b1.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/at91/eti_b1_wm8731.c
--- a/soc/at91/eti_b1_wm8731.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/at91/eti_b1_wm8731.c	Wed Jan 31 16:43:17 2007 +0000
@@ -17,9 +17,6 @@
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
- *
- *  Revision history
- *    30th Nov 2005   Initial version.
  *
  */
 
@@ -43,9 +40,10 @@
 
 #include "../codecs/wm8731.h"
 #include "at91-pcm.h"
+#include "at91-i2s.h"
 
 #if 0
-#define	DBG(x...)	printk(KERN_INFO "eti_b1_wm8731:" x)
+#define	DBG(x...)	printk(KERN_INFO "eti_b1_wm8731: " x)
 #else
 #define	DBG(x...)
 #endif
@@ -57,12 +55,29 @@
 #define AT91_PIO_RK1	(1 << (AT91_PIN_PB10 - PIN_BASE) % 32)
 #define AT91_PIO_RF1	(1 << (AT91_PIN_PB11 - PIN_BASE) % 32)
 
-
 static struct clk *pck1_clk;
 static struct clk *pllb_clk;
 
+
 static int eti_b1_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* cpu clock is the AT91 master clock sent to the SSC */
+	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, AT91_SYSCLK_MCK,
+		60000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* codec system clock is supplied by PCK1, set to 12MHz */
+	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
 	/* Start PCK1 clock. */
 	clk_enable(pck1_clk);
 	DBG("pck1 started\n");
@@ -77,8 +92,105 @@ static void eti_b1_shutdown(struct snd_p
 	DBG("pck1 stopped\n");
 }
 
+static int eti_b1_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
+	unsigned int rate;
+	int cmr_div, period;
+
+	/* set codec DAI configuration */
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 25;	/* BCLK = 60MHz/(2*25) = 1.2MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) = 8000Hz */
+		break;
+	case 32000:
+		cmr_div = 7;	/* BCLK = 60MHz/(2*7) ~= 4.28571428MHz */
+		period = 66;	/* LRC = BCLK/(2*(66+1)) = 31982.942Hz */
+		break;
+	case 48000:
+		cmr_div = 13;	/* BCLK = 60MHz/(2*13) ~= 2.3076923MHz */
+		period = 23;	/* LRC = BCLK/(2*(23+1)) = 48076.923Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d on ETI-B1 board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
+						AT91SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
+						AT91SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+#else /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
+	/*
+	 * Codec in Master Mode.
+	 */
+
+	/* set codec DAI configuration */
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+#endif /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
+
+	return 0;
+}
+
 static struct snd_soc_ops eti_b1_ops = {
 	.startup = eti_b1_startup,
+	.hw_params = eti_b1_hw_params,
 	.shutdown = eti_b1_shutdown,
 };
 
@@ -131,15 +243,6 @@ static int eti_b1_wm8731_init(struct snd
 
 	snd_soc_dapm_sync_endpoints(codec);
 
-	return 0;
-}
-
-unsigned int eti_b1_config_sysclk(struct snd_soc_pcm_runtime *rtd,
-	struct snd_soc_clock_info *info)
-{
-	if(info->bclk_master & SND_SOC_DAIFMT_CBS_CFS) {
-		return rtd->codec_dai->config_sysclk(rtd->codec_dai, info, 12000000);
-	}
 	return 0;
 }
 
@@ -149,14 +252,13 @@ static struct snd_soc_dai_link eti_b1_da
 	.cpu_dai = &at91_i2s_dai[1],
 	.codec_dai = &wm8731_dai,
 	.init = eti_b1_wm8731_init,
-	.config_sysclk = eti_b1_config_sysclk,
+	.ops = &eti_b1_ops,
 };
 
 static struct snd_soc_machine snd_soc_machine_eti_b1 = {
 	.name = "ETI_B1",
 	.dai_link = &eti_b1_dai,
 	.num_links = 1,
-	.ops = &eti_b1_ops,
 };
 
 static struct wm8731_setup_data eti_b1_wm8731_setup = {
@@ -210,7 +312,7 @@ static int __init eti_b1_init(void)
 	}
 
  	ssc_pio_lines = AT91_PIO_TF1 | AT91_PIO_TK1 | AT91_PIO_TD1
-			| AT91_PIO_RD1 /* | AT91_PIO_RK1 | AT91_PIO_RF1 */;
+			| AT91_PIO_RD1 /* | AT91_PIO_RK1 */ | AT91_PIO_RF1;
 
 	/* Reset all PIO registers and assign lines to peripheral A */
  	at91_sys_write(AT91_PIOB + PIO_PDR,  ssc_pio_lines);
@@ -237,6 +339,11 @@ static int __init eti_b1_init(void)
 	/* assign the GPIO pin to PCK1 */
 	at91_set_B_periph(AT91_PIN_PA24, 0);
 
+#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
+	printk(KERN_INFO "eti_b1_wm8731: Codec in Slave Mode\n");
+#else
+	printk(KERN_INFO "eti_b1_wm8731: Codec in Master Mode\n");
+#endif
 	return ret;
 
 fail_io_unmap:

--=-VVBsv9pqry3qiKAIFE8M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-VVBsv9pqry3qiKAIFE8M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-VVBsv9pqry3qiKAIFE8M--
