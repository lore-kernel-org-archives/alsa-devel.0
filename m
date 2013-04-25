From: Marek Belisko <marek.belisko@gmail.com>
Subject: [PATCH v2 2/3] ASoC: spdif_transmitter: Add DT support.
Date: Thu, 25 Apr 2013 15:13:13 +0200
Message-ID: <1366895594-19596-3-git-send-email-marek.belisko@streamunlimited.com>
References: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, zonque@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek.belisko@streamunlimited.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Add devicetree support for this dummy audio soc driver.

Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
Signed-off-by: Marek Belisko <marek.belisko@streamunlimited.com>
---
 .../bindings/sound/spdif-transmitter.txt           |   10 ++++++++++
 sound/soc/codecs/spdif_transmitter.c               |   10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitter.txt

diff --git a/Documentation/devicetree/bindings/sound/spdif-transmitter.txt b/Documentation/devicetree/bindings/sound/spdif-transmitter.txt
new file mode 100644
index 0000000..55a8584
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spdif-transmitter.txt
@@ -0,0 +1,10 @@
+Device-Tree bindings for dummy spdif transmitter
+
+Required properties:
+	- compatible: should be "linux,spdif-dit".
+
+Example node:
+
+	codec: spdif-transmitter {
+		compatible = "linux,spdif-dit";
+	};
diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index 112a49d..1828049 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -20,6 +20,7 @@
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
+#include <linux/of.h>
 
 #define DRV_NAME "spdif-dit"
 
@@ -52,12 +53,21 @@ static int spdif_dit_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id spdif_dit_dt_ids[] = {
+	{ .compatible = "linux,spdif-dit", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spdif_dit_dt_ids);
+#endif
+
 static struct platform_driver spdif_dit_driver = {
 	.probe		= spdif_dit_probe,
 	.remove		= spdif_dit_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spdif_dit_dt_ids),
 	},
 };
 
-- 
1.7.9.5
