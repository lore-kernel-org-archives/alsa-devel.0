From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 001/146] ASoC: soc-core:
	use	snd_soc_dai_link_component for CPU
Date: Thu, 6 Jun 2019 18:15:45 +0000
Message-ID: <3BD9CEE4EBD5E74B98FE2D277EB60E0B3900FE44@IRSMSX104.ger.corp.intel.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87ftonmkuo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62B61F896CE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 20:15:49 +0200 (CEST)
In-Reply-To: <87ftonmkuo.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>current ALSA SoC is starting to support modern style dai_linke
>(= struct snd_soc_dai_link_component) which is mainly used for
>multipul DAI/component connection.
>Now Codec has full multi-codec support, Platform is using modern
>style but still for single Platform.
>Only CPU is not yet supporting modern style yet.
>If we could support it for CPU, we can switch to modern style
>dai_link on all CPU/Codec/Platform, and remove legacy style
>from ALSA SoC.
>
>Multi-CPU will be supported in the future.
>This patch is initial support for modern style for CPU
>
>Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>---
> include/sound/soc.h  |  4 +++
> sound/soc/soc-core.c | 83
>+++++++++++++++++++++++++++++++++++++++++++---------
> 2 files changed, 73 insertions(+), 14 deletions(-)
>
>diff --git a/include/sound/soc.h b/include/sound/soc.h
>index f20785a..ae7ca82 100644
>--- a/include/sound/soc.h
>+++ b/include/sound/soc.h
>@@ -927,6 +927,9 @@ struct snd_soc_dai_link {
> 	 */
> 	const char *cpu_dai_name;
>
>+	struct snd_soc_dai_link_component *cpus;
>+	unsigned int num_cpus;
>+
> 	/*
> 	 *	codec_name
> 	 *	codec_of_node
>@@ -1035,6 +1038,7 @@ struct snd_soc_dai_link {
> 	 * drivers should not modify this value.
> 	 */
> 	unsigned int legacy_platform:1;
>+	unsigned int legacy_cpu:1;
>
> 	struct list_head list; /* DAI link list of the soc card */
> 	struct snd_soc_dobj dobj; /* For topology */
>diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>index 7abb017a8..af080a9 100644
>--- a/sound/soc/soc-core.c
>+++ b/sound/soc/soc-core.c
>@@ -887,7 +887,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
> {
> 	struct snd_soc_pcm_runtime *rtd;
> 	struct snd_soc_dai_link_component *codecs;
>-	struct snd_soc_dai_link_component cpu_dai_component;
> 	struct snd_soc_component *component;
> 	int i;
>
>@@ -906,13 +905,11 @@ static int soc_bind_dai_link(struct snd_soc_card
>*card,
> 	if (!rtd)
> 		return -ENOMEM;
>
>-	cpu_dai_component.name = dai_link->cpu_name;
>-	cpu_dai_component.of_node = dai_link->cpu_of_node;
>-	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
>-	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
>+	/* FIXME: we need multi CPU support in the future */
>+	rtd->cpu_dai = snd_soc_find_dai(dai_link->cpus);
> 	if (!rtd->cpu_dai) {
> 		dev_info(card->dev, "ASoC: CPU DAI %s not registered\n",
>-			 dai_link->cpu_dai_name);
>+			 dai_link->cpus->dai_name);
> 		goto _err_defer;
> 	}
> 	snd_soc_rtdcom_add(rtd, rtd->cpu_dai->component);
>@@ -1048,6 +1045,46 @@ static void soc_remove_dai_links(struct
>snd_soc_card *card)
> 	}
> }
>
>+static int snd_soc_init_cpu(struct snd_soc_card *card,
>+			    struct snd_soc_dai_link *dai_link)
>+{
>+	struct snd_soc_dai_link_component *cpu = dai_link->cpus;
>+
>+	/*
>+	 * REMOVE ME
>+	 *
>+	 * This is glue code for Legacy vs Modern dai_link.
>+	 * This function will be removed if all derivers are switched to
>+	 * modern style dai_link.
>+	 * Driver shouldn't use both legacy and modern style in the same time.
>+	 * see
>+	 *	soc.h :: struct snd_soc_dai_link
>+	 */
>+	/* convert Legacy platform link */
>+	if (!cpu) {
>+		cpu = devm_kzalloc(card->dev,
>+				   sizeof(struct snd_soc_dai_link_component),

sizeof(*cpu)

>+				   GFP_KERNEL);
>+		if (!cpu)
>+			return -ENOMEM;
>+
>+		dai_link->cpus		= cpu;
>+		dai_link->num_cpus	= 1;
>+		dai_link->legacy_cpu	= 1;
>+
>+		cpu->name	= dai_link->cpu_name;
>+		cpu->of_node	= dai_link->cpu_of_node;

Indentation seems off.

>+		cpu->dai_name	= dai_link->cpu_dai_name;
>+	}
>+
>+	if (!dai_link->cpus) {
>+		dev_err(card->dev, "ASoC: DAI link has no CPUs\n");
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> static int snd_soc_init_platform(struct snd_soc_card *card,
> 				 struct snd_soc_dai_link *dai_link)
> {
>@@ -1087,7 +1124,7 @@ static int snd_soc_init_platform(struct snd_soc_card
>*card,
> 	return 0;
> }
>
>-static void soc_cleanup_platform(struct snd_soc_card *card)
>+static void soc_cleanup_legacy(struct snd_soc_card *card)
> {
> 	struct snd_soc_dai_link *link;
> 	int i;
>@@ -1102,6 +1139,10 @@ static void soc_cleanup_platform(struct
>snd_soc_card *card)
> 			link->legacy_platform = 0;
> 			link->platforms       = NULL;
> 		}
>+		if (link->legacy_cpu) {
>+			link->legacy_cpu = 0;
>+			link->cpus = NULL;
>+		}
> 	}
> }
>
>@@ -1149,6 +1190,12 @@ static int soc_init_dai_link(struct snd_soc_card
>*card,
> 	int i, ret;
> 	struct snd_soc_dai_link_component *codec;
>
>+	ret = snd_soc_init_cpu(card, link);
>+	if (ret) {
>+		dev_err(card->dev, "ASoC: failed to init cpu\n");
>+		return ret;
>+	}
>+
> 	ret = snd_soc_init_platform(card, link);
> 	if (ret) {
> 		dev_err(card->dev, "ASoC: failed to init multiplatform\n");
>@@ -1207,12 +1254,20 @@ static int soc_init_dai_link(struct snd_soc_card
>*card,
> 	    !soc_find_component(link->platforms->of_node, link->platforms-
>>name))
> 		return -EPROBE_DEFER;
>
>+	/* FIXME */
>+	if (link->num_cpus > 1) {
>+		dev_err(card->dev,
>+			"ASoC: multi cpu is not yet supported %s\n",
>+			link->name);
>+		return -EINVAL;
>+	}
>+
> 	/*
> 	 * CPU device may be specified by either name or OF node, but
> 	 * can be left unspecified, and will be matched based on DAI
> 	 * name alone..
> 	 */
>-	if (link->cpu_name && link->cpu_of_node) {
>+	if (link->cpus->name && link->cpus->of_node) {
> 		dev_err(card->dev,
> 			"ASoC: Neither/both cpu name/of_node are set for
>%s\n",
> 			link->name);
>@@ -1223,16 +1278,16 @@ static int soc_init_dai_link(struct snd_soc_card
>*card,
> 	 * Defer card registartion if cpu dai component is not added to
> 	 * component list.
> 	 */
>-	if ((link->cpu_of_node || link->cpu_name) &&
>-	    !soc_find_component(link->cpu_of_node, link->cpu_name))
>+	if ((link->cpus->of_node || link->cpus->name) &&
>+	    !soc_find_component(link->cpus->of_node, link->cpus->name))
> 		return -EPROBE_DEFER;
>
> 	/*
> 	 * At least one of CPU DAI name or CPU device name/node must be
> 	 * specified
> 	 */
>-	if (!link->cpu_dai_name &&
>-	    !(link->cpu_name || link->cpu_of_node)) {
>+	if (!link->cpus->dai_name &&
>+	    !(link->cpus->name || link->cpus->of_node)) {
> 		dev_err(card->dev,
> 			"ASoC: Neither cpu_dai_name nor
>cpu_name/of_node are set for %s\n",
> 			link->name);
>@@ -2048,7 +2103,7 @@ static int soc_cleanup_card_resources(struct
>snd_soc_card *card)
> 	/* remove and free each DAI */
> 	soc_remove_dai_links(card);
> 	soc_remove_pcm_runtimes(card);
>-	soc_cleanup_platform(card);
>+	soc_cleanup_legacy(card);
>
> 	/* remove auxiliary devices */
> 	soc_remove_aux_devices(card);
>@@ -2805,7 +2860,7 @@ int snd_soc_register_card(struct snd_soc_card
>*card)
>
> 		ret = soc_init_dai_link(card, link);
> 		if (ret) {
>-			soc_cleanup_platform(card);
>+			soc_cleanup_legacy(card);
> 			dev_err(card->dev, "ASoC: failed to init link %s\n",
> 				link->name);
> 			mutex_unlock(&client_mutex);

While I understand the reasoning and need for this, this single patch contains rename, struct definition update and new func implementations all at once.
Your patchset is high in numbers already, though only a few are introducing actual changes. I'd consider splitting this into separate logical blocks.

Czarek
