From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-card: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:27 +0100 (BST)
Message-ID: <20190606212627.C0753440046@finisterre.sirena.org.uk>
References: <87tvd3gy5n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 900E7F89785
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:28 +0200 (CEST)
In-Reply-To: <87tvd3gy5n.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: meson: axg-card: use modern dai_link style

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

>From c84836d7f6509141d5be31cc7a1028228fe0545a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:32 +0900
Subject: [PATCH] ASoC: meson: axg-card: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 57 ++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index db0a7fc18928..fb03258d00ae 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -115,7 +115,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 
 	if (card->dai_link) {
 		for_each_card_prelinks(card, i, link) {
-			of_node_put(link->cpu_of_node);
+			of_node_put(link->cpus->of_node);
 			for_each_link_codecs(link, j, codec)
 				of_node_put(codec->of_node);
 		}
@@ -254,6 +254,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	struct axg_card *priv = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai_link *pad = &card->dai_link[*index];
 	struct snd_soc_dai_link *lb;
+	struct snd_soc_dai_link_component *dlc;
 	int ret;
 
 	/* extend links */
@@ -267,11 +268,20 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	if (!lb->name)
 		return -ENOMEM;
 
+	dlc = devm_kzalloc(card->dev, 2 * sizeof(*dlc), GFP_KERNEL);
+	if (!dlc)
+		return -ENOMEM;
+
+	lb->cpus = &dlc[0];
+	lb->codecs = &dlc[1];
+	lb->num_cpus = 1;
+	lb->num_codecs = 1;
+
 	lb->stream_name = lb->name;
-	lb->cpu_of_node = pad->cpu_of_node;
-	lb->cpu_dai_name = "TDM Loopback";
-	lb->codec_name = "snd-soc-dummy";
-	lb->codec_dai_name = "snd-soc-dummy-dai";
+	lb->cpus->of_node = pad->cpus->of_node;
+	lb->cpus->dai_name = "TDM Loopback";
+	lb->codecs->name = "snd-soc-dummy";
+	lb->codecs->dai_name = "snd-soc-dummy-dai";
 	lb->dpcm_capture = 1;
 	lb->no_pcm = 1;
 	lb->ops = &axg_card_tdm_be_ops;
@@ -284,7 +294,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	 * axg_card_clean_references() will iterate over this link,
 	 * make sure the node count is balanced
 	 */
-	of_node_get(lb->cpu_of_node);
+	of_node_get(lb->cpus->of_node);
 
 	/* Let add_links continue where it should */
 	*index += 1;
@@ -426,7 +436,7 @@ static int axg_card_parse_tdm(struct snd_soc_card *card,
 	/* Setup tdm link */
 	link->ops = &axg_card_tdm_be_ops;
 	link->init = axg_card_tdm_dai_init;
-	link->dai_fmt = axg_card_parse_daifmt(node, link->cpu_of_node);
+	link->dai_fmt = axg_card_parse_daifmt(node, link->cpus->of_node);
 
 	of_property_read_u32(node, "mclk-fs", &be->mclk_fs);
 
@@ -499,12 +509,21 @@ static int axg_card_set_fe_link(struct snd_soc_card *card,
 				struct device_node *node,
 				bool is_playback)
 {
+	struct snd_soc_dai_link_component *codec;
+
+	codec = devm_kzalloc(card->dev, sizeof(*codec), GFP_KERNEL);
+	if (!codec)
+		return -ENOMEM;
+
+	link->codecs = codec;
+	link->num_codecs = 1;
+
 	link->dynamic = 1;
 	link->dpcm_merged_format = 1;
 	link->dpcm_merged_chan = 1;
 	link->dpcm_merged_rate = 1;
-	link->codec_dai_name = "snd-soc-dummy-dai";
-	link->codec_name = "snd-soc-dummy";
+	link->codecs->dai_name = "snd-soc-dummy-dai";
+	link->codecs->name = "snd-soc-dummy";
 
 	if (is_playback)
 		link->dpcm_playback = 1;
@@ -538,16 +557,24 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 			     int *index)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[*index];
+	struct snd_soc_dai_link_component *cpu;
 	int ret;
 
-	ret = axg_card_parse_dai(card, np, &dai_link->cpu_of_node,
-				 &dai_link->cpu_dai_name);
+	cpu = devm_kzalloc(card->dev, sizeof(*cpu), GFP_KERNEL);
+	if (!cpu)
+		return -ENOMEM;
+
+	dai_link->cpus = cpu;
+	dai_link->num_cpus = 1;
+
+	ret = axg_card_parse_dai(card, np, &dai_link->cpus->of_node,
+				 &dai_link->cpus->dai_name);
 	if (ret)
 		return ret;
 
-	if (axg_card_cpu_is_playback_fe(dai_link->cpu_of_node))
+	if (axg_card_cpu_is_playback_fe(dai_link->cpus->of_node))
 		ret = axg_card_set_fe_link(card, dai_link, np, true);
-	else if (axg_card_cpu_is_capture_fe(dai_link->cpu_of_node))
+	else if (axg_card_cpu_is_capture_fe(dai_link->cpus->of_node))
 		ret = axg_card_set_fe_link(card, dai_link, np, false);
 	else
 		ret = axg_card_set_be_link(card, dai_link, np);
@@ -555,9 +582,9 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 	if (ret)
 		return ret;
 
-	if (axg_card_cpu_is_tdm_iface(dai_link->cpu_of_node))
+	if (axg_card_cpu_is_tdm_iface(dai_link->cpus->of_node))
 		ret = axg_card_parse_tdm(card, np, index);
-	else if (axg_card_cpu_is_codec(dai_link->cpu_of_node))
+	else if (axg_card_cpu_is_codec(dai_link->cpus->of_node))
 		dai_link->params = &codec_params;
 
 	return ret;
-- 
2.20.1
