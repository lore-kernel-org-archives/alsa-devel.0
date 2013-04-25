From: Marek Belisko <marek.belisko@gmail.com>
Subject: [PATCH v2 3/3] ASoC: spdif_receiver: Add DT support.
Date: Thu, 25 Apr 2013 15:13:14 +0200
Message-ID: <1366895594-19596-4-git-send-email-marek.belisko@streamunlimited.com>
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
 .../devicetree/bindings/sound/spdif-receiver.txt   |   10 ++++++++++
 sound/soc/codecs/spdif_receiver.c                  |   10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt

diff --git a/Documentation/devicetree/bindings/sound/spdif-receiver.txt b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
new file mode 100644
index 0000000..80f807b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
@@ -0,0 +1,10 @@
+Device-Tree bindings for dummy spdif receiver
+
+Required properties:
+	- compatible: should be "linux,spdif-dir".
+
+Example node:
+
+	codec: spdif-receiver {
+		compatible = "linux,spdif-dir";
+	};
diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index dd8d856..e9d7881 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
+#include <linux/of.h>
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
@@ -51,12 +52,21 @@ static int spdif_dir_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id spdif_dir_dt_ids[] = {
+	{ .compatible = "linux,spdif-dir", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spdif_dir_dt_ids);
+#endif
+
 static struct platform_driver spdif_dir_driver = {
 	.probe		= spdif_dir_probe,
 	.remove		= spdif_dir_remove,
 	.driver		= {
 		.name	= "spdif-dir",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spdif_dir_dt_ids),
 	},
 };
 
-- 
1.7.9.5
