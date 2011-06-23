From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] Blackfin: bf537: Stamp: Register adav801
	codec and ASoC machine driver
Date: Thu, 23 Jun 2011 08:00:18 +0200
Message-ID: <1308808818-26775-3-git-send-email-lars@metafoo.de>
References: <1308808818-26775-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-003.synserver.de
	[212.40.185.3]) by alsa0.perex.cz (Postfix) with SMTP id 96D09103AB0
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 09:09:57 +0200 (CEST)
In-Reply-To: <1308808818-26775-1-git-send-email-lars@metafoo.de>
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
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

There is already an entry in the spi device table for the codec, but the
modalias was wrong. Also the config symbol name for the codec is wrong, so this
is fixed as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/blackfin/mach-bf537/boards/stamp.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 5d30566..198018e 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -1000,9 +1000,9 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 	},
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_ADAV80X) || defined(CONFIG_SND_BF5XX_SOC_ADAV80X_MODULE)
+#if defined(CONFIG_SND_SOC_ADAV80X) || defined(CONFIG_SND_SOC_ADV80X_MODULE)
 	{
-		.modalias = "adav80x",
+		.modalias = "adav801",
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 1,
@@ -2118,7 +2118,7 @@ static struct i2c_board_info __initdata bfin_i2c_board_info[] = {
 	},
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_ADAV80X) || defined(CONFIG_SND_BF5XX_SOC_ADAV80X_MODULE)
+#if defined(CONFIG_SND_SOC_ADAV80X) || defined(CONFIG_SND_SOC_ADAV80X_MODULE)
 	{
 		I2C_BOARD_INFO("adav803", 0x10),
 	},
@@ -2553,6 +2553,14 @@ static struct platform_device bfin_ad73311_codec_device = {
 };
 #endif
 
+#if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAV80X) || \
+	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAV80X_MODULE)
+static struct platform_device bfin_eval_adav801_device = {
+	.name = "bfin-eval-adav801",
+	.id = -1,
+};
+#endif
+
 #if defined(CONFIG_SND_BF5XX_SOC_I2S) || defined(CONFIG_SND_BF5XX_SOC_I2S_MODULE)
 static struct platform_device bfin_i2s = {
 	.name = "bfin-i2s",
@@ -2833,6 +2841,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701_MODULE)
 	&bf5xx_adau1701_device,
 #endif
+
+#if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAV80X) || \
+	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAV80X_MODULE)
+	&bfin_eval_adav801_device,
+#endif
 };
 
 static int __init net2272_init(void)
-- 
1.7.2.5
