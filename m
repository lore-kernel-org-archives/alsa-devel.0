From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ARM: s3c2440: gta02; Register dfbmcs320 device
Date: Mon,  7 Mar 2011 08:05:00 +0100
Message-ID: <1299481500-5481-7-git-send-email-lars@metafoo.de>
References: <1299481500-5481-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299481500-5481-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Register the dfbmcs320 device which provides the PCM DAI for the bluetooth
module.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
I've verified that this patch does not cause any merge conflicts with the other
gta02 changes in Kukjin's tree, so I think it would be best to merge this patch
together with the reset of the series through the ASoC tree.
---
 arch/arm/mach-s3c2440/mach-gta02.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 9f2c14e..3415517 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -416,6 +416,10 @@ struct platform_device s3c24xx_pwm_device = {
 	.num_resources	= 0,
 };
 
+static struct platform_device gta02_dfbmcs320_device = {
+	.name = "dfbmcs320",
+};
+
 static struct i2c_board_info gta02_i2c_devs[] __initdata = {
 	{
 		I2C_BOARD_INFO("pcf50633", 0x73),
@@ -508,6 +512,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_nand,
 	&gta02_nor_flash,
 	&s3c24xx_pwm_device,
+	&gta02_dfbmcs320_device,
 	&s3c_device_iis,
 	&s3c_device_i2c0,
 };
-- 
1.7.2.3
