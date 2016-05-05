From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/3] ASoC: da7219: Add ACPI parsing support
Date: Thu, 5 May 2016 11:53:05 +0100
Message-ID: <bb23ba754ed1f51c9b20ccd4a2b87520ce7c1893.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

This update allows for parsing of ACPI, in addition to existing DT
support.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/codecs/da7219-aad.c | 32 ++++++++++++++++++++++++++++----
 sound/soc/codecs/da7219.c     |  7 ++++---
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index c4853a8..e04ee4f 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
+#include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
@@ -27,7 +28,6 @@
 #include "da7219.h"
 #include "da7219-aad.h"

-
 /*
  * Detection control
  */
@@ -383,7 +383,7 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 }

 /*
- * DT to pdata conversion
+ * DT/ACPI to pdata conversion
  */

 static enum da7219_aad_micbias_pulse_lvl
@@ -539,6 +539,26 @@ static enum da7219_aad_adc_1bit_rpt
 	}
 }

+#ifdef CONFIG_ACPI
+static inline bool da7219_aad_of_acpi_node_matched(struct fwnode_handle *child,
+						   const char *name)
+{
+	struct acpi_data_node *acpi_node = to_acpi_data_node(child);
+
+	if (strcmp(acpi_node->name, name) == 0)
+		return true;
+	else
+		return false;
+}
+#else
+static inline bool da7219_aad_of_acpi_node_matched(struct fwnode_handle *child,
+						   const char *name)
+{
+	return false;
+}
+
+#endif /* CONFIG_ACPI */
+
 static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device *dev,
 							  const char *name)
 {
@@ -551,6 +571,9 @@ static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device *dev,
 			of_node = to_of_node(child);
 			if (of_node_cmp(of_node->name, name) == 0)
 				return child;
+		} else if (is_acpi_data_node(child)) {
+			if (da7219_aad_of_acpi_node_matched(child, name))
+				return child;
 		}
 	}

@@ -787,8 +810,9 @@ int da7219_aad_init(struct snd_soc_codec *codec)
 	da7219->aad = da7219_aad;
 	da7219_aad->codec = codec;

-	/* Handle any DT/platform data */
-	if ((codec->dev->of_node) && (da7219->pdata))
+	/* Handle any DT/ACPI/platform data */
+	if (((codec->dev->of_node) || is_acpi_node(codec->dev->fwnode)) &&
+	    (da7219->pdata))
 		da7219->pdata->aad_pdata = da7219_aad_of_to_pdata(codec);

 	da7219_aad_handle_pdata(codec);
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 6c6c8db..bc32322 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
+#include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1418,7 +1419,7 @@ static struct snd_soc_dai_driver da7219_dai = {


 /*
- * DT
+ * DT/ACPI
  */

 static const struct of_device_id da7219_of_match[] = {
@@ -1656,8 +1657,8 @@ static int da7219_probe(struct snd_soc_codec *codec)
 		break;
 	}

-	/* Handle DT/Platform data */
-	if (codec->dev->of_node)
+	/* Handle DT/ACPI/Platform data */
+	if (codec->dev->of_node || is_acpi_node(codec->dev->fwnode))
 		da7219->pdata = da7219_of_to_pdata(codec);
 	else
 		da7219->pdata = dev_get_platdata(codec->dev);
