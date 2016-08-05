From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use of_property_read_bool" to the asoc tree
Date: Fri, 05 Aug 2016 13:09:13 +0100
Message-ID: <E1bVdw9-0002h9-KD@debutante>
References: <1470387411-15879-12-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470387411-15879-12-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use of_property_read_bool

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

>From 7ac2a2432bbba0c3a5cf9848c768ff3c6c8a976c Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 5 Aug 2016 10:56:51 +0200
Subject: [PATCH] ASoC: use of_property_read_bool

Use of_property_read_bool to check for the existence of a property.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S2,S1;
@@
-       if (of_get_property(e1,e2,NULL))
+       if (of_property_read_bool(e1,e2))
        S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 10 +++++-----
 sound/soc/sh/rcar/ssi.c         |  2 +-
 sound/soc/soc-core.c            |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 8b1d0c1a7839..f2dd86ede075 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2408,28 +2408,28 @@ static void ab8500_codec_of_probe(struct device *dev, struct device_node *np,
 {
 	u32 value;
 
-	if (of_get_property(np, "stericsson,amic1-type-single-ended", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1-type-single-ended"))
 		codec->amics.mic1_type = AMIC_TYPE_SINGLE_ENDED;
 	else
 		codec->amics.mic1_type = AMIC_TYPE_DIFFERENTIAL;
 
-	if (of_get_property(np, "stericsson,amic2-type-single-ended", NULL))
+	if (of_property_read_bool(np, "stericsson,amic2-type-single-ended"))
 		codec->amics.mic2_type = AMIC_TYPE_SINGLE_ENDED;
 	else
 		codec->amics.mic2_type = AMIC_TYPE_DIFFERENTIAL;
 
 	/* Has a non-standard Vamic been requested? */
-	if (of_get_property(np, "stericsson,amic1a-bias-vamic2", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1a-bias-vamic2"))
 		codec->amics.mic1a_micbias = AMIC_MICBIAS_VAMIC2;
 	else
 		codec->amics.mic1a_micbias = AMIC_MICBIAS_VAMIC1;
 
-	if (of_get_property(np, "stericsson,amic1b-bias-vamic2", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1b-bias-vamic2"))
 		codec->amics.mic1b_micbias = AMIC_MICBIAS_VAMIC2;
 	else
 		codec->amics.mic1b_micbias = AMIC_MICBIAS_VAMIC1;
 
-	if (of_get_property(np, "stericsson,amic2-bias-vamic1", NULL))
+	if (of_property_read_bool(np, "stericsson,amic2-bias-vamic1"))
 		codec->amics.mic2_micbias = AMIC_MICBIAS_VAMIC1;
 	else
 		codec->amics.mic2_micbias = AMIC_MICBIAS_VAMIC2;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5f848f054745..6cb6db005fc4 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -928,7 +928,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 		}
 
 		ops = &rsnd_ssi_non_ops;
-		if (of_get_property(np, "pio-transfer", NULL))
+		if (of_property_read_bool(np, "pio-transfer"))
 			ops = &rsnd_ssi_pio_ops;
 		else
 			ops = &rsnd_ssi_dma_ops;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16369cad4803..ead49d032e4c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3733,7 +3733,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 	 * SND_SOC_DAIFMT_CLOCK_MASK area
 	 */
 	snprintf(prop, sizeof(prop), "%scontinuous-clock", prefix);
-	if (of_get_property(np, prop, NULL))
+	if (of_property_read_bool(np, prop))
 		format |= SND_SOC_DAIFMT_CONT;
 	else
 		format |= SND_SOC_DAIFMT_GATED;
-- 
2.8.1
