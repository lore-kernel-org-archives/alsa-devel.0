From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH 2/2 v2] blackfin: add platform device for
	ad1836 machine driver
Date: Fri, 10 Aug 2012 18:06:09 -0400
Message-ID: <1344636369-12367-2-git-send-email-scott.jiang.linux@gmail.com>
References: <1344636369-12367-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 707622664BE
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 11:03:38 +0200 (CEST)
In-Reply-To: <1344636369-12367-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

---
 arch/blackfin/mach-bf527/boards/ezkit.c |   20 ++++++++++++++++++++
 arch/blackfin/mach-bf533/boards/stamp.c |   20 ++++++++++++++++++++
 arch/blackfin/mach-bf537/boards/stamp.c |   20 ++++++++++++++++++++
 arch/blackfin/mach-bf561/boards/ezkit.c |   20 ++++++++++++++++++++
 arch/blackfin/mach-bf609/boards/ezkit.c |   19 +++++++++++++++++++
 5 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index fc179ca..29f16e5 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -587,6 +587,21 @@ static struct platform_device bfin_tdm = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
+	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+static const char * const ad1836_link[] = {
+	"bfin-tdm.0",
+	"spi0.4",
+};
+static struct platform_device bfin_ad1836_machine = {
+	.name = "bfin-snd-ad1836",
+	.id = -1,
+	.dev = {
+		.platform_data = (void *)ad1836_link,
+	},
+};
+#endif
+
 static struct spi_board_info bfin_spi_board_info[] __initdata = {
 #if defined(CONFIG_MTD_M25P80) \
 	|| defined(CONFIG_MTD_M25P80_MODULE)
@@ -1269,6 +1284,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 #if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
 	&bfin_tdm,
 #endif
+
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
+	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+	&bfin_ad1836_machine,
+#endif
 };
 
 static int __init ezkit_init(void)
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index ce88a71..6fca869 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -617,6 +617,21 @@ static struct platform_device bfin_ac97_pcm = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
+	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+static const char * const ad1836_link[] = {
+	"bfin-tdm.0",
+	"spi0.4",
+};
+static struct platform_device bfin_ad1836_machine = {
+	.name = "bfin-snd-ad1836",
+	.id = -1,
+	.dev = {
+		.platform_data = (void *)ad1836_link,
+	},
+};
+#endif
+
 #if defined(CONFIG_SND_BF5XX_SOC_AD73311) || \
 	defined(CONFIG_SND_BF5XX_SOC_AD73311_MODULE)
 static const unsigned ad73311_gpio[] = {
@@ -754,6 +769,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_ac97_pcm,
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
+	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+	&bfin_ad1836_machine,
+#endif
+
 #if defined(CONFIG_SND_BF5XX_SOC_AD73311) || \
 	defined(CONFIG_SND_BF5XX_SOC_AD73311_MODULE)
 	&bfin_ad73311_machine,
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 5ed654a..307bd7e 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2641,6 +2641,21 @@ static struct platform_device bfin_ac97_pcm = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
+	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+static const char * const ad1836_link[] = {
+	"bfin-tdm.0",
+	"spi0.4",
+};
+static struct platform_device bfin_ad1836_machine = {
+	.name = "bfin-snd-ad1836",
+	.id = -1,
+	.dev = {
+		.platform_data = (void *)ad1836_link,
+	},
+};
+#endif
+
 #if defined(CONFIG_SND_BF5XX_SOC_AD73311) || \
 				defined(CONFIG_SND_BF5XX_SOC_AD73311_MODULE)
 static const unsigned ad73311_gpio[] = {
@@ -2927,6 +2942,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_ac97_pcm,
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
+	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+	&bfin_ad1836_machine,
+#endif
+
 #if defined(CONFIG_SND_BF5XX_SOC_AD73311) || \
 		defined(CONFIG_SND_BF5XX_SOC_AD73311_MODULE)
 	&bfin_ad73311_machine,
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 7c36777..551f866 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -539,6 +539,21 @@ static struct platform_device bfin_ac97 = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
+	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+static const char * const ad1836_link[] = {
+	"bfin-tdm.0",
+	"spi0.4",
+};
+static struct platform_device bfin_ad1836_machine = {
+	.name = "bfin-snd-ad1836",
+	.id = -1,
+	.dev = {
+		.platform_data = (void *)ad1836_link,
+	},
+};
+#endif
+
 static struct platform_device *ezkit_devices[] __initdata = {
 
 	&bfin_dpmc,
@@ -603,6 +618,11 @@ static struct platform_device *ezkit_devices[] __initdata = {
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97,
 #endif
+
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
+	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+	&bfin_ad1836_machine,
+#endif
 };
 
 static int __init net2272_init(void)
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index c2cf1ae..61c1f47 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -818,6 +818,21 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
+	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+static const char * const ad1836_link[] = {
+	"bfin-tdm.0",
+	"spi0.76",
+};
+static struct platform_device bfin_ad1836_machine = {
+	.name = "bfin-snd-ad1836",
+	.id = -1,
+	.dev = {
+		.platform_data = (void *)ad1836_link,
+	},
+};
+#endif
+
 #if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X61) || \
 	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X61_MODULE)
 static struct platform_device adau1761_device = {
@@ -1557,6 +1572,10 @@ static struct platform_device *ezkit_devices[] __initdata = {
 	defined(CONFIG_SND_BF6XX_SOC_I2S_MODULE)
 	&bfin_i2s,
 #endif
+#if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
+	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
+	&bfin_ad1836_machine,
+#endif
 #if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X61) || \
 	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X61_MODULE)
 	&adau1761_device,
-- 
1.7.0.4
