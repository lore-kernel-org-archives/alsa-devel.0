From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 1/2] ASoC: core: Add API to use DMI name in
	sound card long name
Date: Tue, 10 Jan 2017 14:42:49 +0800
Message-ID: <2c6136c012b7f94dd2fb35fd5def8195abdc0113.1484030246.git.mengdong.lin@linux.intel.com>
References: <cover.1484030246.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 35D36266DB0
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 07:39:45 +0100 (CET)
In-Reply-To: <cover.1484030246.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Intel DSP platform drivers are used by many different devices but are
difficult for userspace to differentiate. This patch adds an API to allow
the DMI name to be used in the sound card long name, thereby helping
userspace load the correct UCM configuration. Usually machine drivers
uses their own name as the sound card name (short name), and leave the
long name and driver name blank. This API will use the DMI info like
vendor, product and board to make up the card long name. If the machine
driver has already explicitly set the long name, this API will do nothing.

This patch also allows for further differentiation as many devices that
share the same DMI name i.e. Minnowboards, UP boards may be configured
with different codecs or firmwares. The API supports flavoring the DMI
name into the card longname to provide the extra differentiation required
for these devices.

For Use Case Manager (UCM) in the user space, changing card long name by
this API is backward compatible, since the card name does not change. For
a given sound card, even if there is no device-specific UCM configuration
file that uses the card long name, UCM will fall back to load the default
configuration file that uses the card name.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 795e6c4..e4f1844 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -497,6 +497,8 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt);
 
+int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
+
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
@@ -1094,6 +1096,8 @@ struct snd_soc_card {
 	const char *name;
 	const char *long_name;
 	const char *driver_name;
+	char dmi_longname[80];
+
 	struct device *dev;
 	struct snd_card *snd_card;
 	struct module *owner;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aaab26a..c744266 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -34,6 +34,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -1886,6 +1887,127 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
+
+/* Only keep number and alphabet characters and a few separator characters.
+ * DMI info often has SPACE and we must trim them, since Use Case Manager in
+ * the user space expects the device-specific configuration files/directories
+ * use the same name as the card long name but Autoconf cannot support SPACE
+ * in file or directory name.
+ */
+static void trim_special_characters(char *name)
+{
+	int i, j = 0;
+
+	for (i = 0; name[i]; i++) {
+		if (isalnum(name[i]) || (name[i] == '.')
+		    || (name[i] == '-') || (name[i] == '_'))
+			name[j++] = name[i];
+	}
+
+	name[j] = '\0';
+}
+
+/**
+ * snd_soc_set_dmi_name() - Register DMI names to card
+ * @card: The card to register DMI names
+ * @flavour: The flavour "differentiator" for the card amongst its peers.
+ *
+ * An Intel machine driver may be used by many different devices but are
+ * difficult for userspace to differentiate, since machine drivers ususally
+ * use their own name as the card name (short name) and leave the card long
+ * name blank. To differentiate such devices and fix bugs due to lack of
+ * device-specific configurations, this function allows DMI info to be used
+ * as the sound card long name, in the format of
+ * "vendor.product.version.board"
+ * (Character '.' are used to separate different DMI fields here).
+ * This will help the userspace to load the correct UCM (Use Case Manager)
+ * configuration.
+ *
+ * Possible card long names may be:
+ * DellInc..XPS139343.01.0310JH
+ * ASUSTeKCOMPUTERINC..T100TA.1.0.T100TA
+ * Circuitco.MinnowboardMaxD0PLATFORM.D0.MinnowBoardMAX
+ * (Please note DMI can also include '.' like"Inc." so you may see double '.'
+ * sometimes)
+ *
+ * This function also supports flavoring the card longname to provide
+ * the extra differentiation, like "vendor.product.version.board.flavor".
+ *
+ * We only keep number and alphabet characters and a few separator characters
+ * in the card long name since UCM in the user space uses the card long names
+ * as card configuration directory names and AudoConf cannot support special
+ * charactors like SPACE.
+ *
+ * Returns 0 on success, otherwise a negative error code.
+ */
+int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
+{
+	const char *vendor, *product, *product_version, *board;
+	int len;
+
+	if (card->long_name)
+		return 0; /* long name already set by driver or from DMI */
+
+	/* make up dmi long name as: vendor.product.version.board */
+	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	if (!vendor) {
+		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
+		return 0;
+	}
+
+	snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
+			 "%s", vendor);
+
+	product = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (product) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 sizeof(card->snd_card->longname) - len,
+			 ".%s", product);
+
+		/* some vendors like Lenovo may only put a self-explanatory
+		 * name in the product version field
+		 */
+		product_version = dmi_get_system_info(DMI_PRODUCT_VERSION);
+		if (product_version) {
+			len = strlen(card->dmi_longname);
+			snprintf(card->dmi_longname + len,
+				 sizeof(card->snd_card->longname) - len,
+				 ".%s", product_version);
+			}
+	}
+
+	board = dmi_get_system_info(DMI_BOARD_NAME);
+	if (board) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 sizeof(card->snd_card->longname) - len,
+			 ".%s", board);
+	} else if (!product) {
+		/* fall back to using legacy name */
+		dev_warn(card->dev, "ASoC: no DMI board/product name!\n");
+		return 0;
+	}
+
+	/* trim special characters to save space for flavor string */
+	trim_special_characters(card->dmi_longname);
+
+	/* Add flavour to dmi long name */
+	if (flavour) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 sizeof(card->snd_card->longname) - len,
+			 ".%s", flavour);
+		trim_special_characters(card->dmi_longname + len);
+	}
+
+	/* set the card long name */
+	card->long_name = card->dmi_longname;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
+
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
-- 
2.5.0
