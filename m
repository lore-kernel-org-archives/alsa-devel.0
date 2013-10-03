From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI names
Date: Thu,  3 Oct 2013 15:33:56 +0300
Message-ID: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds alternative way to specify DAI links by using ACPI names.
ACPI name here is considered to be used as an alias for device name during
DAI link binding time.

Rationale behind this is that device name especially with bus connected
codecs may not be constant enough to be used in machines with dynamic and
variable amount of bus controllers due changing bus/adapter number.

One way to solve this problem on ACPI 5 based systems is to use ACPI names
of those devices that are enumerated by the ACPI subsystem.

For instance, matchine drivers could specify codec in DAI link by using:
	.codec_name = "INT33CA:00",
instead of
	.codec_name = "rt5640.0-001c",

Note that ACPI name is used just an alias during bind time and core
continues to use device name. In fact, machine drivers could use either
names.

Thanks to Mika Westerberg for initial idea to use ACPI handles for binding.
Author extended and simplified the idea so that struct snd_soc_dai_link
doesn't need a new field, machine drivers don't need any additional code
and soc-core.c can handle matching when executing soc_bind_dai_link().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
linux-acpi@vger.kernel.org cc'd if ACPI folks would like to check API usage
here.
---
 sound/soc/soc-core.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4280c70..5cb440e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/acpi.h>
 #include <sound/ac97_codec.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -836,6 +837,27 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
+static bool soc_match_name(struct device *dev,
+			   const char *comp_name, const char *bind_name)
+{
+	if (!strcmp(comp_name, bind_name))
+		return true;
+
+#if IS_ENABLED(CONFIG_ACPI)
+	if (ACPI_HANDLE(dev)) {
+		struct acpi_device *adev;
+		if (!acpi_bus_get_device(ACPI_HANDLE(dev), &adev) &&
+		    !strcmp(dev_name(&adev->dev), bind_name)) {
+			dev_dbg(dev, "Matching with ACPI name %s\n",
+				dev_name(&adev->dev));
+			return true;
+		}
+	}
+#endif
+
+	return false;
+}
+
 static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -853,10 +875,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		    (cpu_dai->dev->of_node != dai_link->cpu_of_node))
 			continue;
 		if (dai_link->cpu_name &&
-		    strcmp(dev_name(cpu_dai->dev), dai_link->cpu_name))
+		    !soc_match_name(cpu_dai->dev, dev_name(cpu_dai->dev),
+				    dai_link->cpu_name))
 			continue;
 		if (dai_link->cpu_dai_name &&
-		    strcmp(cpu_dai->name, dai_link->cpu_dai_name))
+		    !soc_match_name(cpu_dai->dev, cpu_dai->name,
+				    dai_link->cpu_dai_name))
 			continue;
 
 		rtd->cpu_dai = cpu_dai;
@@ -874,7 +898,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 			if (codec->dev->of_node != dai_link->codec_of_node)
 				continue;
 		} else {
-			if (strcmp(codec->name, dai_link->codec_name))
+			if (!soc_match_name(codec->dev, codec->name,
+					    dai_link->codec_name))
 				continue;
 		}
 
@@ -886,8 +911,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		 */
 		list_for_each_entry(codec_dai, &dai_list, list) {
 			if (codec->dev == codec_dai->dev &&
-				!strcmp(codec_dai->name,
-					dai_link->codec_dai_name)) {
+			    soc_match_name(codec->dev, codec_dai->name,
+					   dai_link->codec_dai_name)) {
 
 				rtd->codec_dai = codec_dai;
 			}
@@ -918,7 +943,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 			    dai_link->platform_of_node)
 				continue;
 		} else {
-			if (strcmp(platform->name, platform_name))
+			if (!soc_match_name(platform->dev, platform->name,
+					    platform_name))
 				continue;
 		}
 
-- 
1.8.4.rc3

