From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] Blackfin: bf537: Stamp: Register adau1701
	codec and ASoC machine driver
Date: Fri, 10 Jun 2011 19:18:51 +0200
Message-ID: <1307726331-28618-3-git-send-email-lars@metafoo.de>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-056.synserver.de (smtp-out-056.synserver.de
	[212.40.185.56]) by alsa0.perex.cz (Postfix) with SMTP id 6C029103C7D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:19:57 +0200 (CEST)
In-Reply-To: <1307726331-28618-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier@gentoo.org>
---
 arch/blackfin/mach-bf537/boards/stamp.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 76db1d4..1365cbd 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2390,6 +2390,11 @@ static struct i2c_board_info __initdata bfin_i2c_board_info[] = {
 		I2C_BOARD_INFO("adau1361", 0x38),
 	},
 #endif
+#if defined(CONFIG_SND_SOC_ADAU1701) || defined(CONFIG_SND_SOC_ADAU1701_MODULE)
+	{
+		I2C_BOARD_INFO("adau1701", 0x34),
+	},
+#endif
 #if defined(CONFIG_AD525X_DPOT) || defined(CONFIG_AD525X_DPOT_MODULE)
 	{
 		I2C_BOARD_INFO("ad5258", 0x18),
@@ -2760,6 +2765,13 @@ static struct platform_device iio_gpio_trigger = {
 };
 #endif
 
+#if defined(CONFIG_SND_BF5XX_SOC_ADAU1701) || \
+	defined(CONFIG_SND_BF5XX_SOC_ADAU1701_MODULE)
+static struct platform_device bf5xx_adau1701_device = {
+	.name = "bf5xx-adau1701",
+};
+#endif
+
 static struct platform_device *stamp_devices[] __initdata = {
 
 	&bfin_dpmc,
@@ -2914,6 +2926,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 	defined(CONFIG_IIO_GPIO_TRIGGER_MODULE)
 	&iio_gpio_trigger,
 #endif
+
+#if defined(CONFIG_SND_BF5XX_SOC_ADAU1701) || \
+	defined(CONFIG_SND_BF5XX_SOC_ADAU1701_MODULE)
+	&bf5xx_adau1701_device,
+#endif
 };
 
 static int __init stamp_init(void)
-- 
1.7.2.5
