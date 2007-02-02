From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 17/19] ASoC 0.13 spitz machine
Date: Fri, 02 Feb 2007 14:46:18 +0000
Message-ID: <1170427578.18082.148.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ytz7fW+i4nQ23DEl1e3q"
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

--=-Ytz7fW+i4nQ23DEl1e3q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the Sharp spitz machine driver to the new API in ASoC
0.13.

Changes:-

o  Manually configure DAI hardware format.

o Removed config_sysclk() function. No longer needed as clocking is now
configured manually.

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


--=-Ytz7fW+i4nQ23DEl1e3q
Content-Disposition: attachment; filename="asoc13-spitz.patch"
Content-Type: text/x-patch; name="asoc13-spitz.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/pxa/spitz.c
--- a/soc/pxa/spitz.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/spitz.c	Thu Feb 01 17:49:46 2007 +0000
@@ -37,6 +37,7 @@
 #include <asm/mach-types.h>
 #include "../codecs/wm8750.h"
 #include "pxa2xx-pcm.h"
+#include "pxa2xx-i2s.h"
 
 #define SPITZ_HP        0
 #define SPITZ_MIC       1
@@ -121,8 +122,59 @@ static int spitz_startup(struct snd_pcm_
 	return 0;
 }
 
+static int spitz_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		clk = 11289600;
+		break;
+	}
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
+	/* set the codec system clock for DAC and ADC */
+	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set the I2S system clock as input (unused) */
+	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static struct snd_soc_ops spitz_ops = {
 	.startup = spitz_startup,
+	.hw_params = spitz_hw_params,
 };
 
 static int spitz_get_jack(struct snd_kcontrol *kcontrol,
@@ -276,37 +328,6 @@ static int spitz_wm8750_init(struct snd_
 	return 0;
 }
 
-static unsigned int spitz_config_sysclk(struct snd_soc_pcm_runtime *rtd,
-	struct snd_soc_clock_info *info)
-{
-	if (info->bclk_master & SND_SOC_DAIFMT_CBS_CFS) {
-		/* pxa2xx is i2s master  */
-		switch (info->rate) {
-		case 11025:
-		case 22050:
-		case 44100:
-		case 88200:
-			/* configure codec digital filters
-			 * for 11.025, 22.05, 44.1, 88.2 */
-			rtd->codec_dai->config_sysclk(rtd->codec_dai, info,
-				11289600);
-		break;
-		default:
-			/* configure codec digital filters for all other rates */
-			rtd->codec_dai->config_sysclk(rtd->codec_dai, info,
-				SPITZ_AUDIO_CLOCK);
-		break;
-		}
-		/* configure pxa2xx i2s interface clocks as master */
-		return rtd->cpu_dai->config_sysclk(rtd->cpu_dai, info,
-			SPITZ_AUDIO_CLOCK);
-	} else {
-		/* codec is i2s master - only configure codec DAI clock */
-		return rtd->codec_dai->config_sysclk(rtd->codec_dai, info,
-			SPITZ_AUDIO_CLOCK);
-	}
-}
-
 /* spitz digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link spitz_dai = {
 	.name = "wm8750",
@@ -314,7 +335,7 @@ static struct snd_soc_dai_link spitz_dai
 	.cpu_dai = &pxa_i2s_dai,
 	.codec_dai = &wm8750_dai,
 	.init = spitz_wm8750_init,
-	.config_sysclk = spitz_config_sysclk,
+	.ops = &spitz_ops,
 };
 
 /* spitz audio machine driver */
@@ -322,7 +343,6 @@ static struct snd_soc_machine snd_soc_ma
 	.name = "Spitz",
 	.dai_link = &spitz_dai,
 	.num_links = 1,
-	.ops = &spitz_ops,
 };
 
 /* spitz audio private data */

--=-Ytz7fW+i4nQ23DEl1e3q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-Ytz7fW+i4nQ23DEl1e3q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-Ytz7fW+i4nQ23DEl1e3q--
