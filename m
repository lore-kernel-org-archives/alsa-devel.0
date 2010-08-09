From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: n810: Remove tlv320aic3x i2c
	registration from n810 machine driver
Date: Mon,  9 Aug 2010 14:35:34 +0300
Message-ID: <1281353734-16387-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 19F84245FC
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 13:34:22 +0200 (CEST)
Received: by eye27 with SMTP id 27so3224117eye.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2010 04:34:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

tlv320aic3x board info registration here is not working for couple of
reasons:

- TLV320AIC33 i2c address is 0x18 instead of 0x1b
- i2c bus indexing in omap starts from 1 so bus number should be 2
- arch/arm/mach-omap2/board-n8x0.c doesn't register the second bus so
  devices are not probed anyway

As this is not currently working and there are patches adding tlv320aic3x
registration into board-n8x0.c, this patch finally removes this temporary
registration.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Liam, I'm thinking the N810 multi-component conversion. I think it would be
easiest for you if there is no board-n8x0.c changes. It avoids possible
merge conflicts with those upcoming registration changes and adding
n810_aic33_setup can be done afterwards. I.e. it's ok if m-c removes
the n810_aic33_setup from n810.c but doesn't add it to board-n8x0.c.
---
 sound/soc/omap/n810.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 08e09d7..58dcaac 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -336,13 +336,6 @@ static struct snd_soc_device n810_snd_devdata = {
 
 static struct platform_device *n810_snd_device;
 
-/* temporary i2c device creation until this can be moved into the machine
- * support file.
-*/
-static struct i2c_board_info i2c_device[] = {
-	{ I2C_BOARD_INFO("tlv320aic3x", 0x1b), }
-};
-
 static int __init n810_soc_init(void)
 {
 	int err;
@@ -351,8 +344,6 @@ static int __init n810_soc_init(void)
 	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 		return -ENODEV;
 
-	i2c_register_board_info(1, i2c_device, ARRAY_SIZE(i2c_device));
-
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!n810_snd_device)
 		return -ENOMEM;
-- 
1.7.1
