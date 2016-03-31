From: han.lu@intel.com
Subject: [PATCH V3 1/2] ASoC: core: add API for registering DMI
	card names
Date: Thu, 31 Mar 2016 16:58:03 +0800
Message-ID: <79fd64c59dd44d44e018245ad411d48f5ba01b24.1459414492.git.han.lu@intel.com>
References: <cover.1459414492.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C76FD2612AF
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 10:56:52 +0200 (CEST)
In-Reply-To: <cover.1459414492.git.han.lu@intel.com>
In-Reply-To: <cover.1459414492.git.han.lu@intel.com>
References: <cover.1459414492.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add core API for registering DMI card names, so user space utils such
as PA and UCM can distinguish various products.
Previously on ASoC, the card short name, driver name and long name are
all the same as the machine driver name.
The patch adds more board information:
  card driver name --->  machine driver name
  card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
  card long name and
  card component   --->  short name:driver name:(DMI_SYS_VENDOR if
                         available):(the firmware name if available)

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..4e80444 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -486,6 +486,9 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt);
 
+int snd_soc_set_card_names(struct snd_soc_card *card, const char *board,
+		const char *vendor, const char *firmware);
+
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b15..8f9c13f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1828,6 +1828,59 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
+/**
+ * snd_soc_set_card_names() - Set the shortname/drivername/longname/component
+ * of a ASoC card.
+ * @card: The card to set names
+ * @board: DMI_BOARD_NAME or DMI_PRODUCT_NAME
+ * @vendor: DMI_SYS_VENDOR
+ * @firmware: The firmware name
+ *
+ * This function registers DMI names to card for the userspace to distinguish
+ * different boards/products:
+ *   card driver name --->  machine driver name
+ *   card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
+ *   card long name and
+ *   card component   --->  short name:driver name:(DMI_SYS_VENDOR)
+ *                          :(firmware name)
+ *
+ * Returns 0 on success, otherwise a negative error code.
+ */
+int snd_soc_set_card_names(struct snd_soc_card *card, const char *board,
+		const char *vendor, const char *firmware)
+{
+	int ret = 0;
+	size_t buf_size, name_size;
+	char *name;
+
+	if (!board) {
+		dev_err(card->dev, "ASoC: the board/product name is empty!\n");
+		return -EINVAL;
+	}
+
+	/* card driver name */
+	card->driver_name = card->name;
+	/* card short name */
+	card->name = board;
+	/* card long name / card component */
+	buf_size = sizeof(card->snd_card->longname);
+	name_size = strlen(card->name) + strlen(card->driver_name)
+			+ strlen(vendor) + strlen(firmware) + 4;
+	if (buf_size < name_size + strlen(card->snd_card->components))
+		return -ENOMEM;
+	name = kmalloc(buf_size, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	snprintf(name, buf_size, "%s:%s:%s:%s", card->name,
+			card->driver_name, vendor, firmware);
+	ret = snd_component_add(card->snd_card, name);
+	card->long_name = card->snd_card->components;
+
+	kfree(name);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_set_card_names);
+
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
-- 
2.5.0
