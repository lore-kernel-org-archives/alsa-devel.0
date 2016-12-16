From: mengdong.lin@linux.intel.com
Subject: [RFC PATCH 1/2] ASoC: core: Add API to use DMI name in
	sound card long name
Date: Fri, 16 Dec 2016 10:51:04 +0800
Message-ID: <895e6e34fdf601cea514f6a205711cba85bfcdce.1481856472.git.mengdong.lin@linux.intel.com>
References: <cover.1481856472.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A1FB9267474
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 03:48:35 +0100 (CET)
In-Reply-To: <cover.1481856472.git.mengdong.lin@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Intel DSP platform drivers are used by many different devices but are
difficult for userspace to differentiate. This patch adds an API to allow
the DMI name to be used in the sound card long name, thereby helping
userspace load the correct UCM configuration. Usually machine drivers
uses their own name as the sound card name (short name), and leave the
long name and driver name blank. This API will generate DMI name from the
DMI vendor, product and board info, and then make up a unique card long
name from the short name and DMI name. If the machine driver has already
explicitly set the long name, although not observed, this API will do
nothing.

This patch also allows for further differentiation as many devices that
share the same DMI name i.e. Minnowboards, UP boards may be configured
with different codecs or firmwares. The API supports flavoring the DMI
name into the card longname to provide the extra differentiation required
for these devices.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 795e6c4..b84648f 100644
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
@@ -1094,6 +1096,9 @@ struct snd_soc_card {
 	const char *name;
 	const char *long_name;
 	const char *driver_name;
+	char dmi_longname[80];
+	char board_name[80];
+
 	struct device *dev;
 	struct snd_card *snd_card;
 	struct module *owner;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aaab26a..bb6a23a 100644
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
 
+/* Move the DMI stuff below to a new file soc-dmi.c? */
+struct snd_soc_dmi_name  {
+	const char *vendor;
+	const char *product;
+	const char *board;
+	const char *name;
+};
+
+#define SOC_DMI_ENTRY(_vendor, _product, _board, _name) \
+	{ .vendor = (_vendor), .board = (_board), \
+	  .product = (_product), .name = (_name) }
+
+/* DMI names. The matched DMI name will be appended to the card short name
+ * to make up the card long name. Machine drivers ususally use their own name
+ * as the card short name, and leave the long name empty. Machine driver may
+ * call API snd_soc_set_dmi_name() to get a unique long name. In user space,
+ * Use Case Manager (UCM) will try to find the best configuration file by
+ * matching the card long name at first, and if unavailable, match the short
+ * name as a fallback.
+ * For example, for a Boradwell-based Dell XPS 13-2015(9343), the card short
+ * name is "broadwell-rt286" and the DMI name is "DELL-XPS", so the long name
+ * will be "broadwell-rt286-Dell-XPS". For a new Skylake-based Dell XPS 13/15,
+ * if the short name is "skl-xyz" and DMI name is "Dell-XPS", the long name
+ * will be "skl-xyz-Dell-XPS".In user space, Use Case Manager (UCM) will try
+ * to find the best configuration file by matching the card long name (e.g.
+ * broadwell-rt286-Dell-XPS), and if unavailable, fallback to the default
+ * configuration file by matching the short name (e.g. broadwell-rt286).
+ */
+static struct snd_soc_dmi_name dmi_names[]  = {
+	SOC_DMI_ENTRY("Intel Corp.", "Broadwell Client platform",
+		      "Wilson Beach SDS", "Intel-Wilson-Beach"),
+	SOC_DMI_ENTRY("Dell Inc.", "XPS 13 9343", "0310JH", "Dell-XPS"),
+	SOC_DMI_ENTRY("ASUSTeK COMPUTER INC.", "T100TA", "T100TA",
+		      "ASUS-T100"),
+	{}	/* terminator */
+};
+
+/* retrieve the last word of shortname or longname */
+static const char *retrieve_id_from_card_name(const char *name)
+{
+	const char *spos = name;
+
+	while (*name) {
+		if (isspace(*name) && isalnum(name[1]))
+			spos = name + 1;
+		name++;
+	}
+	return spos;
+}
+
+static const char *find_dmi_name(const char *vendor, const char *product,
+			const char *board)
+{
+	struct snd_soc_dmi_name *name_entry;
+
+	/* vendor must be valid, either product or board must to be valid */
+	if (!vendor || (!product && !board))
+		return NULL;
+
+	name_entry = dmi_names;
+	while (name_entry->vendor) {
+		if (!strncmp(vendor, name_entry->vendor, 32)
+		    && (!product
+			|| !strncmp(product, name_entry->product, 32))
+		    && (!board || !strncmp(board, name_entry->board, 32)))
+			return name_entry->name;
+
+		name_entry++;
+	}
+
+	return NULL;
+}
+
+/**
+ * snd_soc_set_dmi_name() - Register DMI names to card
+ * @card: The card to register DMI names
+ * @flavour: The flavour "differentiator" for the card amongst its peers.
+ *
+ * Returns 0 on success, otherwise a negative error code.
+ */
+int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
+{
+	const char *vendor, *product, *board, *name;
+	char *spos;
+
+	if (card->long_name)
+		return 0; /* already set long name by driver or from DMI */
+
+	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	if (!vendor) {
+		dev_warn(card->dev, "ASoC: the DMI vendor name is empty!\n");
+		return 0;
+	}
+
+	product = dmi_get_system_info(DMI_PRODUCT_NAME);
+	board = dmi_get_system_info(DMI_BOARD_NAME);
+	if (!board && !product) {
+		/* fall back to using legacy name */
+		dev_warn(card->dev, "ASoC: both board/product name are empty!\n");
+		return 0;
+	}
+
+	name = find_dmi_name(vendor, product, board);
+	if (name)
+		snprintf(card->board_name, sizeof(card->board_name),
+			"%s-%s", card->name, name);
+	else
+		snprintf(card->board_name, sizeof(card->snd_card->longname),
+			"%s-%s-%s-%s", card->name, vendor, product, board);
+
+	/* replace SPACE with '-' */
+	spos = card->board_name;
+	while (*spos) {
+		if (isspace(*spos))
+			*spos = '-';
+		spos++;
+	}
+
+	/* long name */
+	card->long_name = card->board_name;
+
+	/* Add flavour to long name */
+	if (flavour) {
+		snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
+			"%s-%s", retrieve_id_from_card_name(card->long_name),
+			flavour);
+		card->long_name = card->dmi_longname;
+	}
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
