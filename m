From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 08/10] ASoC: blackfin: Switch
	bf5xx-ad1836 from bf5xx-tdm to bf5xx-i2s
Date: Tue, 28 May 2013 19:22:16 +0200
Message-ID: <1369761738-29503-8-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The bf5xx-i2s driver now has support for TDM mode and the bf5xx-tdm driver is
going to be removed soon, so switch the driver over to bf5xx-i2s.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/ezkit.c |  2 +-
 arch/blackfin/mach-bf533/boards/stamp.c |  2 +-
 arch/blackfin/mach-bf537/boards/stamp.c |  2 +-
 arch/blackfin/mach-bf561/boards/ezkit.c |  2 +-
 arch/blackfin/mach-bf609/boards/ezkit.c |  2 +-
 sound/soc/blackfin/Kconfig              | 16 ++++++++--------
 sound/soc/blackfin/bf5xx-ad1836.c       | 18 +++++++-----------
 7 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 29f16e5..8224895 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -590,7 +590,7 @@ static struct platform_device bfin_tdm = {
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
-	"bfin-tdm.0",
+	"bfin-i2s.0",
 	"spi0.4",
 };
 static struct platform_device bfin_ad1836_machine = {
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index 6fca869..a644a8b 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -620,7 +620,7 @@ static struct platform_device bfin_ac97_pcm = {
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
-	"bfin-tdm.0",
+	"bfin-i2s.0",
 	"spi0.4",
 };
 static struct platform_device bfin_ad1836_machine = {
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 6a3a14b..d978ca9 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2645,7 +2645,7 @@ static struct platform_device bfin_ac97_pcm = {
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
-	"bfin-tdm.0",
+	"bfin-i2s.0",
 	"spi0.4",
 };
 static struct platform_device bfin_ad1836_machine = {
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 551f866..9512c36 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -542,7 +542,7 @@ static struct platform_device bfin_ac97 = {
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
-	"bfin-tdm.0",
+	"bfin-i2s.0",
 	"spi0.4",
 };
 static struct platform_device bfin_ad1836_machine = {
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index 97d7016..bba40ae 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -821,7 +821,7 @@ static struct platform_device bfin_i2s = {
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
-	"bfin-tdm.0",
+	"bfin-i2s.0",
 	"spi0.76",
 };
 static struct platform_device bfin_ad1836_machine = {
diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 906c349..4a67865 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -56,6 +56,14 @@ config SND_SOC_BFIN_EVAL_ADAV80X
 	  Note: This driver assumes that the ADAV80X digital record and playback
 	  interfaces are connected to the first SPORT port on the BF5XX board.
 
+config SND_BF5XX_SOC_AD1836
+	tristate "SoC AD1836 Audio support for BF5xx"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_AD1836
+	help
+	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
+
 config SND_BF5XX_SOC_AD193X
 	tristate "SoC AD193X Audio support for Blackfin"
 	depends on SND_BF5XX_I2S
@@ -91,14 +99,6 @@ config SND_BF5XX_TDM
 	  mode.
 	  You will also need to select the audio interfaces to support below.
 
-config SND_BF5XX_SOC_AD1836
-	tristate "SoC AD1836 Audio support for BF5xx"
-	depends on SND_BF5XX_TDM
-	select SND_BF5XX_SOC_TDM
-	select SND_SOC_AD1836
-	help
-	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
-
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 1528176..8fcfc4e 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -30,14 +30,10 @@
 
 #include "../codecs/ad1836.h"
 
-#include "bf5xx-tdm.h"
-
 static struct snd_soc_card bf5xx_ad1836;
 
-static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int bf5xx_ad1836_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int channel_map[] = {0, 4, 1, 5, 2, 6, 3, 7};
 	int ret = 0;
@@ -48,13 +44,13 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xFF, 0xFF, 8, 32);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-static struct snd_soc_ops bf5xx_ad1836_ops = {
-	.hw_params = bf5xx_ad1836_hw_params,
-};
-
 #define BF5XX_AD1836_DAIFMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_IF | \
 				SND_SOC_DAIFMT_CBM_CFM)
 
@@ -62,9 +58,9 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai = {
 	.name = "ad1836",
 	.stream_name = "AD1836",
 	.codec_dai_name = "ad1836-hifi",
-	.platform_name = "bfin-tdm-pcm-audio",
-	.ops = &bf5xx_ad1836_ops,
+	.platform_name = "bfin-i2s-pcm-audio",
 	.dai_fmt = BF5XX_AD1836_DAIFMT,
+	.init = bf5xx_ad1836_init,
 };
 
 static struct snd_soc_card bf5xx_ad1836 = {
-- 
1.8.0
