From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use
	snd_soc_dai_link_component for CPU" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:18 +0100 (BST)
Message-ID: <20190606212718.88625440049@finisterre.sirena.org.uk>
References: <87ftonmkuo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60F2CF8976E
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:19 +0200 (CEST)
In-Reply-To: <87ftonmkuo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: use snd_soc_dai_link_component for CPU

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 08a5841e3a109f9ea7bfa9c64109aefa95a318c7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:07:22 +0900
Subject: [PATCH] ASoC: soc-core: use snd_soc_dai_link_component for CPU

current ALSA SoC is starting to support modern style dai_linke
(= struct snd_soc_dai_link_component) which is mainly used for
multipul DAI/component connection.
Now Codec has full multi-codec support, Platform is using modern
style but still for single Platform.
Only CPU is not yet supporting modern style yet.
If we could support it for CPU, we can switch to modern style
dai_link on all CPU/Codec/Platform, and remove legacy style
from ALSA SoC.

Multi-CPU will be supported in the future.
This patch is initial support for modern style for CPU

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 +++
 sound/soc/soc-core.c | 83 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f20785aa7b4a..ae7ca828e167 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -927,6 +927,9 @@ struct snd_soc_dai_link {
 	 */
 	const char *cpu_dai_name;
 
+	struct snd_soc_dai_link_component *cpus;
+	unsigned int num_cpus;
+
 	/*
 	 *	codec_name
 	 *	codec_of_node
@@ -1035,6 +1038,7 @@ struct snd_soc_dai_link {
 	 * drivers should not modify this value.
 	 */
 	unsigned int legacy_platform:1;
+	unsigned int legacy_cpu:1;
 
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ace5fb01d9a0..f86ee4f48f06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -887,7 +887,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs;
-	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_component *component;
 	int i;
 
@@ -906,13 +905,11 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	if (!rtd)
 		return -ENOMEM;
 
-	cpu_dai_component.name = dai_link->cpu_name;
-	cpu_dai_component.of_node = dai_link->cpu_of_node;
-	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
+	/* FIXME: we need multi CPU support in the future */
+	rtd->cpu_dai = snd_soc_find_dai(dai_link->cpus);
 	if (!rtd->cpu_dai) {
 		dev_info(card->dev, "ASoC: CPU DAI %s not registered\n",
-			 dai_link->cpu_dai_name);
+			 dai_link->cpus->dai_name);
 		goto _err_defer;
 	}
 	snd_soc_rtdcom_add(rtd, rtd->cpu_dai->component);
@@ -1049,6 +1046,46 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	}
 }
 
+static int snd_soc_init_cpu(struct snd_soc_card *card,
+			    struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_dai_link_component *cpu = dai_link->cpus;
+
+	/*
+	 * REMOVE ME
+	 *
+	 * This is glue code for Legacy vs Modern dai_link.
+	 * This function will be removed if all derivers are switched to
+	 * modern style dai_link.
+	 * Driver shouldn't use both legacy and modern style in the same time.
+	 * see
+	 *	soc.h :: struct snd_soc_dai_link
+	 */
+	/* convert Legacy platform link */
+	if (!cpu) {
+		cpu = devm_kzalloc(card->dev,
+				   sizeof(struct snd_soc_dai_link_component),
+				   GFP_KERNEL);
+		if (!cpu)
+			return -ENOMEM;
+
+		dai_link->cpus		= cpu;
+		dai_link->num_cpus	= 1;
+		dai_link->legacy_cpu	= 1;
+
+		cpu->name	= dai_link->cpu_name;
+		cpu->of_node	= dai_link->cpu_of_node;
+		cpu->dai_name	= dai_link->cpu_dai_name;
+	}
+
+	if (!dai_link->cpus) {
+		dev_err(card->dev, "ASoC: DAI link has no CPUs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
@@ -1088,7 +1125,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	return 0;
 }
 
-static void soc_cleanup_platform(struct snd_soc_card *card)
+static void soc_cleanup_legacy(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
 	int i;
@@ -1103,6 +1140,10 @@ static void soc_cleanup_platform(struct snd_soc_card *card)
 			link->legacy_platform = 0;
 			link->platforms       = NULL;
 		}
+		if (link->legacy_cpu) {
+			link->legacy_cpu = 0;
+			link->cpus = NULL;
+		}
 	}
 }
 
@@ -1150,6 +1191,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	int i, ret;
 	struct snd_soc_dai_link_component *codec;
 
+	ret = snd_soc_init_cpu(card, link);
+	if (ret) {
+		dev_err(card->dev, "ASoC: failed to init cpu\n");
+		return ret;
+	}
+
 	ret = snd_soc_init_platform(card, link);
 	if (ret) {
 		dev_err(card->dev, "ASoC: failed to init multiplatform\n");
@@ -1208,12 +1255,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	    !soc_find_component(link->platforms->of_node, link->platforms->name))
 		return -EPROBE_DEFER;
 
+	/* FIXME */
+	if (link->num_cpus > 1) {
+		dev_err(card->dev,
+			"ASoC: multi cpu is not yet supported %s\n",
+			link->name);
+		return -EINVAL;
+	}
+
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
 	 * name alone..
 	 */
-	if (link->cpu_name && link->cpu_of_node) {
+	if (link->cpus->name && link->cpus->of_node) {
 		dev_err(card->dev,
 			"ASoC: Neither/both cpu name/of_node are set for %s\n",
 			link->name);
@@ -1224,16 +1279,16 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if cpu dai component is not added to
 	 * component list.
 	 */
-	if ((link->cpu_of_node || link->cpu_name) &&
-	    !soc_find_component(link->cpu_of_node, link->cpu_name))
+	if ((link->cpus->of_node || link->cpus->name) &&
+	    !soc_find_component(link->cpus->of_node, link->cpus->name))
 		return -EPROBE_DEFER;
 
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
 	 * specified
 	 */
-	if (!link->cpu_dai_name &&
-	    !(link->cpu_name || link->cpu_of_node)) {
+	if (!link->cpus->dai_name &&
+	    !(link->cpus->name || link->cpus->of_node)) {
 		dev_err(card->dev,
 			"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
 			link->name);
@@ -2049,7 +2104,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
-	soc_cleanup_platform(card);
+	soc_cleanup_legacy(card);
 
 	/* remove auxiliary devices */
 	soc_remove_aux_devices(card);
@@ -2806,7 +2861,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
-			soc_cleanup_platform(card);
+			soc_cleanup_legacy(card);
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
 			mutex_unlock(&client_mutex);
-- 
2.20.1
