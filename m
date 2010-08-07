From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: add AD1980 obsolete information
Date: Sat,  7 Aug 2010 12:06:07 -0400
Message-ID: <1281197167-18087-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AFC81037FF
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 18:06:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Sonic Zhang <sonic.zhang@analog.com>

This codec has been obsoleted by ADI, so add appropriate warnings to the
source tree to dissuade people from using in new designs based on driver
support.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig        |    7 ++++++-
 sound/soc/blackfin/bf5xx-ad1980.c |   10 +++++++++-
 sound/soc/codecs/ad1980.c         |   10 +++++++++-
 sound/soc/codecs/ad1980.h         |    6 ++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 75bbc90..b73ee38 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -113,13 +113,18 @@ config SND_BF5XX_RESET_GPIO_NUM
 	  Set the correct GPIO for RESET the sound chip.
 
 config SND_BF5XX_SOC_AD1980
-	tristate "SoC AD1980/1 Audio support for BF5xx"
+	tristate "SoC AD1980/1 Audio support for BF5xx (Obsolete)"
 	depends on SND_BF5XX_AC97
 	select SND_BF5XX_SOC_AC97
 	select SND_SOC_AD1980
 	help
 	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
 
+	  Warning:
+	  Because Analog Devices Inc. discontinued the ad1980 sound chip since
+	  Sep. 2009, this ad1980 driver is not maintained, tested and supported
+	  by ADI now.
+
 config SND_BF5XX_SOC_SPORT
 	tristate
 
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index d8f5912..92f7c32 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -26,6 +26,14 @@
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+/*
+ * WARNING:
+ *
+ * Because Analog Devices Inc. discontinued the ad1980 sound chip since
+ * Sep. 2009, this ad1980 driver is not maintained, tested and supported
+ * by ADI now.
+ */
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
@@ -109,5 +117,5 @@ module_exit(bf5xx_board_exit);
 
 /* Module information */
 MODULE_AUTHOR("Cliff Cai");
-MODULE_DESCRIPTION("ALSA SoC AD1980/1 BF5xx board");
+MODULE_DESCRIPTION("ALSA SoC AD1980/1 BF5xx board (Obsolete)");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 0420727..70cfaec 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -11,6 +11,14 @@
  *  option) any later version.
  */
 
+/*
+ * WARNING:
+ *
+ * Because Analog Devices Inc. discontinued the ad1980 sound chip since
+ * Sep. 2009, this ad1980 driver is not maintained, tested and supported
+ * by ADI now.
+ */
+
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -298,6 +306,6 @@ struct snd_soc_codec_device soc_codec_dev_ad1980 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ad1980);
 
-MODULE_DESCRIPTION("ASoC ad1980 driver");
+MODULE_DESCRIPTION("ASoC ad1980 driver (Obsolete)");
 MODULE_AUTHOR("Roy Huang, Cliff Cai");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad1980.h b/sound/soc/codecs/ad1980.h
index db6c850..538f37c 100644
--- a/sound/soc/codecs/ad1980.h
+++ b/sound/soc/codecs/ad1980.h
@@ -1,5 +1,11 @@
 /*
  * ad1980.h  --  ad1980 Soc Audio driver
+ *
+ * WARNING:
+ *
+ * Because Analog Devices Inc. discontinued the ad1980 sound chip since
+ * Sep. 2009, this ad1980 driver is not maintained, tested and supported
+ * by ADI now.
  */
 
 #ifndef _AD1980_H
-- 
1.7.2
