From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove OF adjusting for
	snd_soc_of_parse_audio_prefix" to the asoc tree
Date: Tue, 31 Jan 2017 20:02:26 +0000
Message-ID: <E1cYedG-0005Zp-Ff@debutante>
References: <87bmutqad6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BDFA2673B0
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:36 +0100 (CET)
In-Reply-To: <87bmutqad6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_prefix

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

>From 440a3006f154a3aca4badf72841c61ac93a72110 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Jan 2017 06:37:16 +0000
Subject: [PATCH] ASoC: soc-core: remove OF adjusting for
 snd_soc_of_parse_audio_prefix

Because prototype of OF-graph sound card support didn't have Sound Card
node, commit b6defcca0a604129155ae472b116a2e1688d8995
("ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_prefix")
adjusted to it on each functions.

But final discussion result of ALSA SoC / OF-graph ML, OF-graph sound
card has node. Thus, this commit became no longer needed.

This reverts commit b6defcca0a604129155ae472b116a2e1688d8995.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 6 +-----
 sound/soc/soc-core.c | 9 +++------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4dccc4f63f5e..34bd033443dc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1656,11 +1656,7 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *rx_mask,
 			      unsigned int *slots,
 			      unsigned int *slot_width);
-#define snd_soc_of_parse_audio_prefix(card, codec_conf, of_node, propname) \
-	snd_soc_of_parse_audio_prefix_from_node(card, NULL, codec_conf, \
-						of_node, propname)
-void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
-				   struct device_node *np,
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 656a981f6eb1..4ff2448f6023 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3664,18 +3664,15 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_tdm_slot);
 
-void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
-				   struct device_node *np,
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname)
 {
+	struct device_node *np = card->dev->of_node;
 	const char *str;
 	int ret;
 
-	if (!np)
-		np = card->dev->of_node;
-
 	ret = of_property_read_string(np, propname, &str);
 	if (ret < 0) {
 		/* no prefix is not error */
@@ -3685,7 +3682,7 @@ void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
 	codec_conf->of_node	= of_node;
 	codec_conf->name_prefix	= str;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix_from_node);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
 
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
-- 
2.11.0
