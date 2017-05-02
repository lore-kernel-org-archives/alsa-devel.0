From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH 2/2] ASoC: ts3a227e: add acpi table
Date: Tue,  2 May 2017 12:11:09 +0200
Message-ID: <1493719869-16100-3-git-send-email-thierry.escande@collabora.com>
References: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch adds the acpi match table for the ts3a227e audio accessory
detection device. This enables headset features like jack plug/unplug
notifications, mic presence, and button pressed events.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 sound/soc/codecs/ts3a227e.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 4356843..738e04b 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -374,11 +375,20 @@ static const struct of_device_id ts3a227e_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
 
+#ifdef CONFIG_ACPI
+static struct acpi_device_id ts3a227e_acpi_match[] = {
+	{ "104C227E", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ts3a227e_acpi_match);
+#endif
+
 static struct i2c_driver ts3a227e_driver = {
 	.driver = {
 		.name = "ts3a227e",
 		.pm = &ts3a227e_pm,
 		.of_match_table = of_match_ptr(ts3a227e_of_match),
+		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),
 	},
 	.probe = ts3a227e_i2c_probe,
 	.id_table = ts3a227e_i2c_ids,
-- 
2.7.4
