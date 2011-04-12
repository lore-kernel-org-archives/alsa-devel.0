From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ARM: s3c2440: gta02; Register dfbmcs320 device
Date: Tue, 12 Apr 2011 22:51:04 +0200
Message-ID: <1302641464-27494-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
	[212.40.185.51]) by alsa0.perex.cz (Postfix) with SMTP id 198C224496
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 22:51:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Register the dfbmcs320 device which provides the PCM DAI for the bluetooth
module.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 0db2411..7166620 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -409,6 +409,10 @@ struct platform_device s3c24xx_pwm_device = {
 	.num_resources	= 0,
 };
 
+static struct platform_device gta02_dfbmcs320_device = {
+	.name = "dfbmcs320",
+};
+
 static struct i2c_board_info gta02_i2c_devs[] __initdata = {
 	{
 		I2C_BOARD_INFO("pcf50633", 0x73),
@@ -523,6 +527,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_iis,
 	&samsung_asoc_dma,
 	&s3c_device_i2c0,
+	&gta02_dfbmcs320_device,
 	&gta02_buttons_device,
 	&s3c_device_adc,
 	&s3c_device_ts,
-- 
1.7.2.5
