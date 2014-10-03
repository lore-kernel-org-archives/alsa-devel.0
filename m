From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 2/3] ASoC: rt5677: Add ACPI device probing
Date: Fri,  3 Oct 2014 14:37:25 -0700
Message-ID: <1412372246-10489-2-git-send-email-benzh@chromium.org>
References: <1412372246-10489-1-git-send-email-benzh@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412372246-10489-1-git-send-email-benzh@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

The rt5677 codec driver looks for ACPI device ID "RT5677CE",
which is specified in coreboot.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Reviewed-on: https://chromium-review.googlesource.com/207622
Reviewed-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: AndyX C Huang <andyx.c.huang@intel.com>
---
 sound/soc/codecs/rt5677.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index cecbdb1..19dbb8a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -3680,10 +3681,21 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5677_acpi_id[] = {
+	{ "RT5677CE", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_acpi_id);
+#endif
+
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
 		.owner = THIS_MODULE,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(rt5677_acpi_id),
+#endif
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.1.0.rc2.206.gedb03e5
