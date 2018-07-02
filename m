From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: core: Allow topology to override
	machine driver FE DAI link config.
Date: Mon,  2 Jul 2018 16:59:54 +0100
Message-ID: <20180702155954.6722-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 598F22676AB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 00:12:11 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Machine drivers statically define a number of DAI links that currently
cannot be changed or removed by topology. This means PCMs and platform
components cannot be changed by topology at runtime AND machine drivers
are tightly coupled to topology.

This patch allows topology to override the machine driver DAI link config
in order to reuse machine drivers with different topologies and platform
components. The patch supports :-

1) create new FE PCMs with a topology defined PCM ID.
2) destroy existing static FE PCMs
3) change the platform component driver.
4) assign any new HW params fixups.
5) assign a new card name prefix to differentiate this topology to userspace.

The patch requires no changes to the machine drivers, but does add some
platform component flags that the platform component driver can assign
before loading topologies.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---

Changes since V1. 
  o Now iterate over component_list to fix crash with DT enumerated cards.
  o Make sure name prefix is only added once with deferred probiing.

 include/sound/soc.h  |  13 ++++++
 sound/soc/soc-core.c | 101 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/soc-pcm.c  |  12 +++++
 3 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f7579f82cc00..b1d65fcb8756 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -806,6 +806,14 @@ struct snd_soc_component_driver {
 	unsigned int use_pmdown_time:1; /* care pmdown_time at stop */
 	unsigned int endianness:1;
 	unsigned int non_legacy_dai_naming:1;
+
+	/* this component uses topology and ignore machine driver FEs */
+	const char *ignore_machine;
+	const char *topology_name_prefix;
+	int (*be_hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
+				  struct snd_pcm_hw_params *params);
+	bool use_dai_pcm_id;	/* use the DAI link PCM ID as PCM device number */
+	int be_pcm_base;	/* base device ID for all BE PCMs */
 };
 
 struct snd_soc_component {
@@ -963,6 +971,9 @@ struct snd_soc_dai_link {
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
 
+	/* Do not create a PCM for this DAI link (Backend link) */
+	unsigned int ignore:1;
+
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
@@ -1002,6 +1013,7 @@ struct snd_soc_card {
 	const char *long_name;
 	const char *driver_name;
 	char dmi_longname[80];
+	char topology_shortname[32];
 
 	struct device *dev;
 	struct snd_card *snd_card;
@@ -1011,6 +1023,7 @@ struct snd_soc_card {
 	struct mutex dapm_mutex;
 
 	bool instantiated;
+	bool topology_shortname_created;
 
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4663de3cf495..38bf7d01894b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -852,6 +852,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	const char *platform_name;
 	int i;
 
+	if (dai_link->ignore)
+		return 0;
+
 	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
 	if (soc_is_dai_link_bound(card, dai_link)) {
@@ -1461,7 +1464,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int i, ret;
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component;
+	int i, ret, num;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
 			card->name, rtd->num, order);
@@ -1507,9 +1512,28 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		soc_dpcm_debugfs_add(rtd);
 #endif
 
+	num = rtd->num;
+
+	/*
+	 * most drivers will register their PCMs using DAI link ordering but
+	 * topology based drivers can use the DAI link id field to set PCM
+	 * device number and then use rtd + a base offset of the BEs.
+	 */
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		if (!component->driver->use_dai_pcm_id)
+			continue;
+
+		if (rtd->dai_link->no_pcm)
+			num += component->driver->be_pcm_base;
+		else
+			num = rtd->dai_link->id;
+	}
+
 	if (cpu_dai->driver->compress_new) {
 		/*create compress_device"*/
-		ret = cpu_dai->driver->compress_new(rtd, rtd->num);
+		ret = cpu_dai->driver->compress_new(rtd, num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1519,7 +1543,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 
 		if (!dai_link->params) {
 			/* create the pcm */
-			ret = soc_new_pcm(rtd, rtd->num);
+			ret = soc_new_pcm(rtd, num);
 			if (ret < 0) {
 				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 				       dai_link->stream_name, ret);
@@ -1846,6 +1870,74 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
 #endif /* CONFIG_DMI */
 
+static void soc_check_tplg_fes(struct snd_soc_card *card)
+{
+	struct snd_soc_component *component;
+	const struct snd_soc_component_driver *comp_drv;
+	struct snd_soc_dai_link *dai_link;
+	int i;
+
+	list_for_each_entry(component, &component_list, list) {
+
+		/* does this component override FEs ? */
+		if (!component->driver->ignore_machine)
+			continue;
+
+		/* for this machine ? */
+		if (strcmp(component->driver->ignore_machine,
+			   card->dev->driver->name))
+			continue;
+
+		/* machine matches, so override the rtd data */
+		for (i = 0; i < card->num_links; i++) {
+
+			dai_link = &card->dai_link[i];
+
+			/* ignore this FE */
+			if (dai_link->dynamic) {
+				dai_link->ignore = true;
+				continue;
+			}
+
+			dev_info(card->dev, "info: override FE DAI link %s\n",
+				 card->dai_link[i].name);
+
+			/* override platform component */
+			dai_link->platform_name = component->name;
+
+			/* convert non BE into BE */
+			dai_link->no_pcm = 1;
+
+			/* override any BE fixups */
+			dai_link->be_hw_params_fixup =
+				component->driver->be_hw_params_fixup;
+
+			/* most BE links don't set stream name, so set it to
+			 * dai link name if it's NULL to help bind widgets.
+			 */
+			if (!dai_link->stream_name)
+				dai_link->stream_name = dai_link->name;
+		}
+
+		/* Inform userspace we are using alternate topology */
+		if (component->driver->topology_name_prefix) {
+
+			/* topology shortname created ? */
+			if (!card->topology_shortname_created) {
+				comp_drv = component->driver;
+
+				snprintf(card->topology_shortname, 32, "%s-%s",
+					 comp_drv->topology_name_prefix,
+					 card->name);
+				card->topology_shortname_created = true;
+			}
+
+			/* use topology shortname */
+			card->name = card->topology_shortname;
+		}
+	}
+}
+
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
@@ -1855,6 +1947,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
+	/* check whether any platform is ignore machine FE and using topology */
+	soc_check_tplg_fes(card);
+
 	/* bind DAIs */
 	for (i = 0; i < card->num_links; i++) {
 		ret = soc_bind_dai_link(card, &card->dai_link[i]);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 153218aa4909..db51849ae9bd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -865,8 +865,20 @@ int soc_dai_hw_params(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params,
 		      struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	int ret;
 
+	/* perform any topology hw_params fixups before DAI  */
+	if (rtd->dai_link->be_hw_params_fixup) {
+		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
+		if (ret < 0) {
+			dev_err(rtd->dev,
+				"ASoC: hw_params topology fixup failed %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	if (dai->driver->ops->hw_params) {
 		ret = dai->driver->ops->hw_params(substream, params, dai);
 		if (ret < 0) {
-- 
2.17.1
