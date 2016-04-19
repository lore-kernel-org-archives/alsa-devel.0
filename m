From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] ASoC: tlv320aix31xx: Add ACPI match for Lenovo
	100S
Date: Tue, 19 Apr 2016 18:00:20 +0200
Message-ID: <1461081620-23378-1-git-send-email-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E229264EBF
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 18:00:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bastien Nocera <hadess@hadess.net>
List-Id: alsa-devel@alsa-project.org

The Lenovo 100S netbook has a codec controller for which there is a
driver, but doesn't know how to access the device. This adds the
necessary ACPI table for the driver to find the device.

Device (TTLV)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "10TI3100")  // _HID: Hardware ID
    Name (_CID, "10TI3100")  // _CID: Compatible ID
    Name (_DDN, "TI TLV320AIC3100 Codec Controller ")  // _DDN: DOS Device Name
    Name (_UID, One)  // _UID: Unique ID

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Jan Schmidt <jan@centricular.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index ee4def4..3c5e1df 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
@@ -1280,10 +1281,19 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aic31xx_acpi_match[] = {
+	{ "10TI3100", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
+#endif
+
 static struct i2c_driver aic31xx_i2c_driver = {
 	.driver = {
 		.name	= "tlv320aic31xx-codec",
 		.of_match_table = of_match_ptr(tlv320aic31xx_of_match),
+		.acpi_match_table = ACPI_PTR(aic31xx_acpi_match),
 	},
 	.probe		= aic31xx_i2c_probe,
 	.remove		= aic31xx_i2c_remove,
-- 
2.7.3
