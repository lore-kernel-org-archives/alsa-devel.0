From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH_V3 3/4] sound: soc: jz4740: Add DT support to jz4740-i2s driver
Date: Mon, 26 Jan 2015 14:53:12 +0000
Message-ID: <1422283993-53642-4-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422283993-53642-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422283993-53642-1-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds device tree support for the jz4740 driver.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
