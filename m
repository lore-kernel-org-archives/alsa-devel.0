From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: [RFC 4/4] ASoC: Change soc-card codec_conf array to a
	list
Date: Mon, 15 Feb 2016 17:49:32 +0530
Message-ID: <1455538772-24926-5-git-send-email-vaibhav.agarwal@linaro.org>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CE7E26063A
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:19:54 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id yy13so85276219pab.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 04:19:54 -0800 (PST)
In-Reply-To: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Currently, number & type of codec(s) available on a platform is
fixed. Thus, machine driver knows in advance the corresponding
device name and can easily define codec_configuration
(name_prefix, compress_type) statically.

However, with the scope of adding codec devices dynamically there
is a need to add codec configuration dynamically as well.
Now we can add/remove codec configuration dynamically in response
to any codec device added/removed.

For backward compatibility, there is a provision to create list
for predefined codec configuration as well.

ToDo:
For snd_soc_remove_codec_config(), possible argument should be
of_node as well to identify codec_conf

Signed-off-by: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
---
 include/sound/soc.h  | 10 +++++++++-
 sound/soc/soc-core.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 44d8568..4074ec3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -396,6 +396,7 @@ struct snd_soc_dai_link;
 struct snd_soc_platform_driver;
 struct snd_soc_codec;
 struct snd_soc_codec_driver;
+struct snd_soc_codec_conf;
 struct snd_soc_component;
 struct snd_soc_component_driver;
 struct soc_enum;
@@ -1074,6 +1075,7 @@ struct snd_soc_codec_conf {
 	 * associated per device
 	 */
 	const char *name_prefix;
+	struct list_head list; /* codec_conf list of the soc card */
 };
 
 struct snd_soc_aux_dev {
@@ -1140,8 +1142,9 @@ struct snd_soc_card {
 	int num_rtd;
 
 	/* optional codec specific configuration */
-	struct snd_soc_codec_conf *codec_conf;
+	struct snd_soc_codec_conf *codec_conf; /* predefined configs only */
 	int num_configs;
+	struct list_head codec_conf_list; /* all configs */
 
 	/*
 	 * optional auxiliary devices such as amplifiers or codecs with DAI
@@ -1688,6 +1691,11 @@ int snd_soc_add_dailink(struct snd_soc_card *card,
 			struct snd_soc_dai_link *dai_link);
 void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name);
 
+void snd_soc_add_codec_config(struct snd_soc_card *card,
+			      struct snd_soc_codec_conf *codec_conf);
+void snd_soc_remove_codec_config(struct snd_soc_card *card,
+				 const char *dev_name);
+
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7049f9b..57ce151 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1584,16 +1584,51 @@ void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name)
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dailink);
 
+/**
+ * snd_soc_add_codec_config - add codec configuration to a sound card.
+ *
+ * @card: Sound card identifier to add codec configuration to
+ * @codec_conf: codec configuration to add
+ */
+void snd_soc_add_codec_config(struct snd_soc_card *card,
+			      struct snd_soc_codec_conf *codec_conf)
+{
+	mutex_lock(&client_mutex);
+	list_add_tail(&codec_conf->list, &card->codec_conf_list);
+	mutex_unlock(&client_mutex);
+}
+EXPORT_SYMBOL(snd_soc_add_codec_config);
+
+/**
+ * snd_soc_remove_codec_config - remove codec configuration from a sound card.
+ *
+ * @card: Sound card identifier to remove codec configuration from
+ * @dev_name: codec configuration identifier
+ */
+void snd_soc_remove_codec_config(struct snd_soc_card *card,
+				 const char *dev_name)
+{
+	struct snd_soc_codec_conf *codec_conf;
+
+	mutex_lock(&client_mutex);
+	list_for_each_entry(codec_conf, &card->codec_conf_list, list)
+		if (!strcmp(codec_conf->dev_name, dev_name)) {
+			list_del(&codec_conf->list);
+			break;
+		}
+	mutex_unlock(&client_mutex);
+}
+EXPORT_SYMBOL(snd_soc_remove_codec_config);
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
-	int i;
+	struct snd_soc_codec_conf *map, *_map;
 
-	if (card->codec_conf == NULL)
+	if (list_empty(&card->codec_conf_list))
 		return;
 
-	for (i = 0; i < card->num_configs; i++) {
-		struct snd_soc_codec_conf *map = &card->codec_conf[i];
+	list_for_each_entry_safe(map, _map, &card->codec_conf_list, list) {
 		if (map->of_node && component->dev->of_node != map->of_node)
 			continue;
 		if (map->dev_name && strcmp(component->name, map->dev_name))
@@ -2119,6 +2154,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_links; i++)
 		snd_soc_add_dai_link(card, card->dai_link+i);
 
+	/* add predefined codec_configs to the list */
+	for (i = 0; i < card->num_configs; i++)
+		snd_soc_add_codec_config(card, card->codec_conf+i);
+
 	/* initialize the register cache for each available codec */
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
@@ -2899,6 +2938,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
 
+	INIT_LIST_HEAD(&card->codec_conf_list);
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	INIT_LIST_HEAD(&card->dobj_list);
 	card->instantiated = 0;
-- 
2.1.4
