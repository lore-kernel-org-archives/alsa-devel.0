From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove OF adjusting for
	snd_soc_of_parse_audio_simple_widgets" to the asoc tree
Date: Tue, 31 Jan 2017 20:02:29 +0000
Message-ID: <E1cYedJ-0005ai-GD@debutante>
References: <87a8adqacm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C339D2673BD
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:39 +0100 (CET)
In-Reply-To: <87a8adqacm.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux-DT <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_simple_widgets

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 21efde50ca9cba9230d1b1ea54aadbf6d96c4157 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Jan 2017 06:37:34 +0000
Subject: [PATCH] ASoC: soc-core: remove OF adjusting for
 snd_soc_of_parse_audio_simple_widgets

Because prototype of OF-graph sound card support didn't have Sound Card
node, commit 1ef5bcd57be5c8b31286b7b47828064be25f266b
("ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_simple_widgets")
adjusted to it on each functions.

But final discussion result of ALSA SoC / OF-graph ML, OF-graph sound
card has node. Thus, this commit became no longer needed.

This reverts commit 1ef5bcd57be5c8b31286b7b47828064be25f266b.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 8 ++------
 sound/soc/soc-core.c | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 838e03778b58..4dccc4f63f5e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1649,12 +1649,8 @@ void snd_soc_util_exit(void);
 int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
 					 struct device_node *np,
 					 const char *propname);
-#define snd_soc_of_parse_audio_simple_widgets(card, propname)\
-	snd_soc_of_parse_audio_simple_widgets_from_node(card, NULL, propname)
-int snd_soc_of_parse_audio_simple_widgets_from_node(struct snd_soc_card *card,
-						    struct device_node *np,
-						    const char *propname);
-
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e30984fd649b..656a981f6eb1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3530,17 +3530,14 @@ static const struct snd_soc_dapm_widget simple_widgets[] = {
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
-int snd_soc_of_parse_audio_simple_widgets_from_node(struct snd_soc_card *card,
-					  struct device_node *np,
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname)
 {
+	struct device_node *np = card->dev->of_node;
 	struct snd_soc_dapm_widget *widgets;
 	const char *template, *wname;
 	int i, j, num_widgets, ret;
 
-	if (!np)
-		np = card->dev->of_node;
-
 	num_widgets = of_property_count_strings(np, propname);
 	if (num_widgets < 0) {
 		dev_err(card->dev,
@@ -3611,7 +3608,7 @@ int snd_soc_of_parse_audio_simple_widgets_from_node(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets_from_node);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
 static int snd_soc_of_get_slot_mask(struct device_node *np,
 				    const char *prop_name,
-- 
2.11.0
