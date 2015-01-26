From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 3/4] sound: soc: jz4740: Add DT support to jz4740-i2s driver
Date: Mon, 26 Jan 2015 13:15:37 +0000
Message-ID: <1422278138-51097-4-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Zubair.Kakakhel@imgtec.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

This patch adds device tree support for the jz4740 driver.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V2 changes: Added ifdef config_of
---
 sound/soc/jz4740/jz4740-i2s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b7a7e82..07f7781 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -14,6 +14,8 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -424,6 +426,13 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name		= "jz4740-i2s",
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_of_matches[] = {
+	{ .compatible = "ingenic,jz4740-i2s" },
+	{ /* sentinel */ }
+};
+#endif
+
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
@@ -464,6 +473,7 @@ static struct platform_driver jz4740_i2s_driver = {
 	.probe = jz4740_i2s_dev_probe,
 	.driver = {
 		.name = "jz4740-i2s",
+		.of_match_table = of_match_ptr(jz4740_of_matches)
 	},
 };
 
-- 
1.9.1
