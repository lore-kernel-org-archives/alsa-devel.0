From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Add tdm slot mask support
	to simple-card" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:49 +0100
Message-ID: <E1ZcItp-0007tn-Db@finisterre>
References: <667e3576d8ec96a556ad3aa5b29a45745f766642.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0693265090
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:02:00 +0200 (CEST)
In-Reply-To: <667e3576d8ec96a556ad3aa5b29a45745f766642.1441806963.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Add tdm slot mask support to simple-card

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

>From 6131084a0bc966107021d8c89489f9cd1663b902 Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 9 Sep 2015 21:27:43 +0300
Subject: [PATCH] ASoC: simple-card: Add tdm slot mask support to simple-card

Adds DT binding for explicitly choosing a tdm mask for DAI and uses it
in simple-card. The API for snd_soc_of_parse_tdm_slot() has also been
changed.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tdm-slot.txt         | 11 +++++++++-
 include/sound/simple_card.h                        |  2 ++
 include/sound/soc.h                                |  2 ++
 sound/soc/generic/simple-card.c                    |  8 +++++--
 sound/soc/soc-core.c                               | 25 ++++++++++++++++++++++
 5 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tdm-slot.txt b/Documentation/devicetree/bindings/sound/tdm-slot.txt
index 6a2c842..34cf70e 100644
--- a/Documentation/devicetree/bindings/sound/tdm-slot.txt
+++ b/Documentation/devicetree/bindings/sound/tdm-slot.txt
@@ -4,11 +4,15 @@ This specifies audio DAI's TDM slot.
 
 TDM slot properties:
 dai-tdm-slot-num : Number of slots in use.
-dai-tdm-slot-width :  Width in bits for each slot.
+dai-tdm-slot-width : Width in bits for each slot.
+dai-tdm-slot-tx-mask : Transmit direction slot mask, optional
+dai-tdm-slot-rx-mask : Receive direction slot mask, optional
 
 For instance:
 	dai-tdm-slot-num = <2>;
 	dai-tdm-slot-width = <8>;
+	dai-tdm-slot-tx-mask = <0 1>;
+	dai-tdm-slot-rx-mask = <1 0>;
 
 And for each spcified driver, there could be one .of_xlate_tdm_slot_mask()
 to specify a explicit mapping of the channels and the slots. If it's absent
@@ -18,3 +22,8 @@ tx and rx masks.
 For snd_soc_of_xlate_tdm_slot_mask(), the tx and rx masks will use a 1 bit
 for an active slot as default, and the default active bits are at the LSB of
 the masks.
+
+The explicit masks are given as array of integers, where the first
+number presents bit-0 (LSB), second presents bit-1, etc. Any non zero
+number is considered 1 and 0 is 0. snd_soc_of_xlate_tdm_slot_mask()
+does not do anything, if either mask is set non zero value.
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index b9b4f28..0399352 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -19,6 +19,8 @@ struct asoc_simple_dai {
 	unsigned int sysclk;
 	int slots;
 	int slot_width;
+	unsigned int tx_slot_mask;
+	unsigned int rx_slot_mask;
 	struct clk *clk;
 };
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..a76622d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1601,6 +1601,8 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
+			      unsigned int *tx_mask,
+			      unsigned int *rx_mask,
 			      unsigned int *slots,
 			      unsigned int *slot_width);
 void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3ff76d4..54c3320 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -151,7 +151,9 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	}
 
 	if (set->slots) {
-		ret = snd_soc_dai_set_tdm_slot(dai, 0, 0,
+		ret = snd_soc_dai_set_tdm_slot(dai,
+					       set->tx_slot_mask,
+					       set->rx_slot_mask,
 						set->slots,
 						set->slot_width);
 		if (ret && ret != -ENOTSUPP) {
@@ -243,7 +245,9 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		return ret;
 
 	/* Parse TDM slot */
-	ret = snd_soc_of_parse_tdm_slot(np, &dai->slots, &dai->slot_width);
+	ret = snd_soc_of_parse_tdm_slot(np, &dai->tx_slot_mask,
+					&dai->rx_slot_mask,
+					&dai->slots, &dai->slot_width);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6173d15..c5e21ca 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3291,13 +3291,38 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
+static int snd_soc_of_get_slot_mask(struct device_node *np,
+				    const char *prop_name,
+				    unsigned int *mask)
+{
+	u32 val;
+	const u32 *of_slot_mask = of_get_property(np, prop_name, &val);
+	int i;
+
+	if (!of_slot_mask)
+		return 0;
+	val /= sizeof(u32);
+	for (i = 0; i < val; i++)
+		if (be32_to_cpup(&of_slot_mask[i]))
+			*mask |= (1 << i);
+
+	return val;
+}
+
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
+			      unsigned int *tx_mask,
+			      unsigned int *rx_mask,
 			      unsigned int *slots,
 			      unsigned int *slot_width)
 {
 	u32 val;
 	int ret;
 
+	if (tx_mask)
+		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-tx-mask", tx_mask);
+	if (rx_mask)
+		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
+
 	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
 		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
 		if (ret)
-- 
2.5.0
