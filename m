From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: export snd_soc_of_get_slot_mask" to the asoc tree
Date: Fri, 20 Jul 2018 17:43:16 +0100
Message-ID: <E1fgYUu-0000kP-EJ@debutante>
References: <20180717153643.8806-17-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-17-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: export snd_soc_of_get_slot_mask

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cbdfab3b675f4c34258b0ec9e4707de44e1f6989 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:43:02 +0200
Subject: [PATCH] ASoC: export snd_soc_of_get_slot_mask

Amlogic's axg card driver can't use snd_soc_of_parse_tdm_slot()
directly because it needs to handle 4 mask for each direction.
Yet the parsing of each mask is the same, so export
snd_soc_of_get_slot_mask() to reuse the the existing code.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a23ecdf3eff1..ace474e8649e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1433,6 +1433,9 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 08e189485009..ad5b0ef16d82 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3428,9 +3428,9 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
-static int snd_soc_of_get_slot_mask(struct device_node *np,
-				    const char *prop_name,
-				    unsigned int *mask)
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask)
 {
 	u32 val;
 	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
@@ -3445,6 +3445,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(snd_soc_of_get_slot_mask);
 
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
-- 
2.18.0
