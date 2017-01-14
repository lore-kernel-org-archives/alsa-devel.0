From: mengdong.lin@linux.intel.com
Subject: [PATCH v4 1/2] ASoC: core: Add API to use DMI name in
	sound card long name
Date: Sat, 14 Jan 2017 16:13:02 +0800
Message-ID: <a2c968808a0dff3f5c611b469d04770e0f0d9e48.1484381178.git.mengdong.lin@linux.intel.com>
References: <cover.1484381178.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B062666FB
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 09:09:49 +0100 (CET)
In-Reply-To: <cover.1484381178.git.mengdong.lin@linux.intel.com>
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
index aaab26a..e558e19 100644
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
@@ -1886,6 +1887,139 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
+
+/* Trim special characters, and replace '-' with '_' since '-' is used to
+ * separate different DMI fields in the card long name. Only number and
+ * alphabet characters and a few separator characters are kept.
+ */
+static void cleanup_dmi_name(char *name)
+{
+	int i, j = 0;
+
+	for (i = 0; name[i]; i++) {
+		if (isalnum(name[i]) || (name[i] == '.')
+		    || (name[i] == '_'))
+			name[j++] = name[i];
+		else if (name[i] == '-')
+			name[j++] = '_';
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
+ * use their own name as the card short name and leave the card long name
+ * blank. To differentiate such devices and fix bugs due to lack of
+ * device-specific configurations, this function allows DMI info to be used
+ * as the sound card long name, in the format of
+ * "vendor-product-version-board"
+ * (Character '-' is used to separate different DMI fields here).
+ * This will help the user space to load the device-specific Use Case Manager
+ * (UCM) configurations for the card.
+ *
+ * Possible card long names may be:
+ * DellInc.-XPS139343-01-0310JH
+ * ASUSTeKCOMPUTERINC.-T100TA-1.0-T100TA
+ * Circuitco-MinnowboardMaxD0PLATFORM-D0-MinnowBoardMAX
+ *
+ * This function also supports flavoring the card longname to provide
+ * the extra differentiation, like "vendor-product-version-board-flavor".
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
+	size_t longname_buf_size = sizeof(card->snd_card->longname);
+	size_t len;
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
+	cleanup_dmi_name(card->dmi_longname);
+
+	product = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (product) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 longname_buf_size - len,
+			 "-%s", product);
+
+		len++;	/* skip the separator "-" */
+		if (len < longname_buf_size)
+			cleanup_dmi_name(card->dmi_longname + len);
+
+		/* some vendors like Lenovo may only put a self-explanatory
+		 * name in the product version field
+		 */
+		product_version = dmi_get_system_info(DMI_PRODUCT_VERSION);
+		if (product_version) {
+			len = strlen(card->dmi_longname);
+			snprintf(card->dmi_longname + len,
+				 longname_buf_size - len,
+				 "-%s", product_version);
+
+			len++;
+			if (len < longname_buf_size)
+				cleanup_dmi_name(card->dmi_longname + len);
+		}
+	}
+
+	board = dmi_get_system_info(DMI_BOARD_NAME);
+	if (board) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 longname_buf_size - len,
+			 "-%s", board);
+
+		len++;
+		if (len < longname_buf_size)
+			cleanup_dmi_name(card->dmi_longname + len);
+	} else if (!product) {
+		/* fall back to using legacy name */
+		dev_warn(card->dev, "ASoC: no DMI board/product name!\n");
+		return 0;
+	}
+
+	/* Add flavour to dmi long name */
+	if (flavour) {
+		len = strlen(card->dmi_longname);
+		snprintf(card->dmi_longname + len,
+			 longname_buf_size - len,
+			 "-%s", flavour);
+
+		len++;
+		if (len < longname_buf_size)
+			cleanup_dmi_name(card->dmi_longname + len);
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
