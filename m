From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove OF adjusting for
	snd_soc_of_parse_card_name" to the asoc tree
Date: Tue, 31 Jan 2017 20:02:23 +0000
Message-ID: <E1cYedD-0005Yv-FZ@debutante>
References: <878tpxqac4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C01B92673B0
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:35 +0100 (CET)
In-Reply-To: <878tpxqac4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_card_name

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

>From b07609cecaac6681a2fca3eebc1bae7b00282620 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Jan 2017 06:37:51 +0000
Subject: [PATCH] ASoC: soc-core: remove OF adjusting for
 snd_soc_of_parse_card_name

Because prototype of OF-graph sound card support didn't have Sound Card
node, commit 8f5ebb1bee15b5720741a98414767bb86f6c2b23
("ASoC: soc-core: adjust for graph on snd_soc_of_parse_card_name")
adjusted to it on each functions.

But final discussion result of ALSA SoC / OF-graph ML, OF-graph sound
card has node. Thus, this commit became no longer needed.

This reverts commit 8f5ebb1bee15b5720741a98414767bb86f6c2b23.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 ++-----
 sound/soc/soc-core.c | 11 +++++------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 34bd033443dc..6ecabeb8d31d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1644,11 +1644,8 @@ static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
-#define snd_soc_of_parse_card_name(card, propname) \
-	snd_soc_of_parse_card_name_from_node(card, NULL, propname)
-int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
-					 struct device_node *np,
-					 const char *propname);
+int snd_soc_of_parse_card_name(struct snd_soc_card *card,
+			       const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4ff2448f6023..ebaebc7c9699 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3492,10 +3492,10 @@ void snd_soc_unregister_codec(struct device *dev)
 EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
 
 /* Retrieve a card's name from device tree */
-int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
-					 struct device_node *np,
-					 const char *propname)
+int snd_soc_of_parse_card_name(struct snd_soc_card *card,
+			       const char *propname)
 {
+	struct device_node *np;
 	int ret;
 
 	if (!card->dev) {
@@ -3503,8 +3503,7 @@ int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
-	if (!np)
-		np = card->dev->of_node;
+	np = card->dev->of_node;
 
 	ret = of_property_read_string_index(np, propname, 0, &card->name);
 	/*
@@ -3521,7 +3520,7 @@ int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name_from_node);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name);
 
 static const struct snd_soc_dapm_widget simple_widgets[] = {
 	SND_SOC_DAPM_MIC("Microphone", NULL),
-- 
2.11.0
