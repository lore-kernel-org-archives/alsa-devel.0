From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: support
	snd_soc_dai_link_component for aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:57 +0100 (BST)
Message-ID: <20190812130957.867A62740CED@ypsilon.sirena.org.uk>
References: <87y3046wcf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51ADBF805FE
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:10:03 +0200 (CEST)
In-Reply-To: <87y3046wcf.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <"r fontana"@redhat.com>, Shunli Wang <shunli.wang@mediatek.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Danny Milosavljevic <dannym@scratchpost.org>, Georgii Staroselskii <georgii.staroselskii@emlid.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthi>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: support snd_soc_dai_link_component for aux_dev

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 3dc29b8b2062075602c7aff1514a120b4ed0187f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:52:33 +0900
Subject: [PATCH] ASoC: soc-core: support snd_soc_dai_link_component for
 aux_dev

To find aux_dev, ASoC is using .name, codec_name, codec_of_node.
Here, .name is used to fallback in case of no codec.

But, we already have this kind of component finding method by
snd_soc_dai_link_component and soc_find_component().
We shouldn't have duplicated implementation to do same things.
This patch adds snd_soc_dai_link_component support to finding aux_dev.

Now, no driver is using only .name.
All drivers are using codec_name and/or codec_of_node.
This means no driver is finding component from .name so far.
(Actually almost all drivers are using .name as just "device name",
 not for finding component...)

This patch
1) add snd_soc_dai_link_component support for aux_dev. legacy style will
   be removed if all drivers are switched to new style.
2) try to find component via snd_soc_dai_link_component.
   Then, it doesn't try to find via .name, because no driver is using
   it so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87y3046wcf.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 +++++++
 sound/soc/soc-core.c | 36 ++++++++++--------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 85ad971e9432..fd6ecea48fc0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -941,6 +941,7 @@ struct snd_soc_dai_link {
 #define COMP_CPU(_dai)			{ .dai_name = _dai, }
 #define COMP_CODEC(_name, _dai)		{ .name = _name, .dai_name = _dai, }
 #define COMP_PLATFORM(_name)		{ .name = _name }
+#define COMP_AUX(_name)			{ .name = _name }
 #define COMP_DUMMY()			{ .name = "snd-soc-dummy", .dai_name = "snd-soc-dummy-dai", }
 
 extern struct snd_soc_dai_link_component null_dailink_component[0];
@@ -971,6 +972,12 @@ struct snd_soc_aux_dev {
 	const char *codec_name;
 	struct device_node *codec_of_node;
 
+	/*
+	 * name, codec_name, codec_of_node will be replaced
+	 * into dlc. don't use both in the same time
+	 */
+	struct snd_soc_dai_link_component dlc;
+
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_component *component);
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bf45e60eb34f..56b99e340dda 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1537,38 +1537,22 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link_component dlc;
 
-	if (aux_dev->codec_of_node || aux_dev->codec_name) {
-		/* codecs, usually analog devices */
-		dlc.name = aux_dev->codec_name;
-		dlc.of_node = aux_dev->codec_of_node;
-		component = soc_find_component(&dlc);
-		if (!component) {
-			if (dlc.of_node)
-				dlc.name = of_node_full_name(dlc.of_node);
-			goto err_defer;
-		}
-	} else if (aux_dev->name) {
-		/* generic components */
-		dlc.name = aux_dev->name;
-		dlc.of_node = NULL;
-		component = soc_find_component(&dlc);
-		if (!component)
-			goto err_defer;
-	} else {
-		dev_err(card->dev, "ASoC: Invalid auxiliary device\n");
-		return -EINVAL;
-	}
+	/* remove me */
+	if (aux_dev->codec_name)
+		aux_dev->dlc.name = aux_dev->codec_name;
+	if (aux_dev->codec_of_node)
+		aux_dev->dlc.of_node = aux_dev->codec_of_node;
+
+	/* codecs, usually analog devices */
+	component = soc_find_component(&aux_dev->dlc);
+	if (!component)
+		return -EPROBE_DEFER;
 
 	component->init = aux_dev->init;
 	list_add(&component->card_aux_list, &card->aux_comp_list);
 
 	return 0;
-
-err_defer:
-	dev_err(card->dev, "ASoC: %s not registered\n", dlc.name);
-	return -EPROBE_DEFER;
 }
 
 static int soc_probe_aux_devices(struct snd_soc_card *card)
-- 
2.20.1
