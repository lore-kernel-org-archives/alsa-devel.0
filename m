From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: adg :: AUDIO-CLKOUTn asynchronizes support" to the asoc tree
Date: Thu, 09 Jun 2016 18:42:33 +0100
Message-ID: <E1bB3yT-0003Nq-Ak@debutante>
References: <87mvmvkq8b.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87mvmvkq8b.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: adg :: AUDIO-CLKOUTn asynchronizes support

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

>From 7dc20319660d12d2ef642e572e8802c228b6c1cd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Jun 2016 03:21:37 +0000
Subject: [PATCH] ASoC: rsnd: adg :: AUDIO-CLKOUTn asynchronizes support

AUDIO-CLKOUTn can asynchronizes with L/R clock.
AUDIO-CLKOUTn synchronizes with L/R clock is now default behavior.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt         |  2 ++
 sound/soc/sh/rcar/adg.c                                | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index c7b29df4a963..15a7316e4c91 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -373,6 +373,8 @@ Optional properties:
 - #clock-cells			: it must be 0 if your system has audio_clkout
 				  it must be 1 if your system has audio_clkout0/1/2/3
 - clock-frequency		: for all audio_clkout0/1/2/3
+- clkout-lr-asynchronous	: boolean property. it indicates that audio_clkoutn
+				  is asynchronizes with lr-clock.
 
 SSI subnode properties:
 - interrupts			: Should contain SSI interrupt for PIO transfer
diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 49354d17ea55..7d3e0e46d64a 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -33,11 +33,15 @@ struct rsnd_adg {
 	struct clk *clkout[CLKOUTMAX];
 	struct clk_onecell_data onecell;
 	struct rsnd_mod mod;
+	u32 flags;
 
 	int rbga_rate_for_441khz; /* RBGA */
 	int rbgb_rate_for_48khz;  /* RBGB */
 };
 
+#define LRCLK_ASYNC	(1 << 0)
+#define adg_mode_flags(adg)	(adg->flags)
+
 #define for_each_rsnd_clk(pos, adg, i)		\
 	for (i = 0;				\
 	     (i < CLKMAX) &&			\
@@ -355,6 +359,16 @@ found_clock:
 
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
+	if (!(adg_mode_flags(adg) & LRCLK_ASYNC)) {
+		struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
+		u32 ckr = 0;
+
+		if (0 == (rate % 8000))
+			ckr = 0x80000000;
+
+		rsnd_mod_bset(adg_mod, SSICKR, 0x80000000, ckr);
+	}
+
 	dev_dbg(dev, "ADG: %s[%d] selects 0x%x for %d\n",
 		rsnd_mod_name(ssi_mod), rsnd_mod_id(ssi_mod),
 		data, rate);
@@ -532,6 +546,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg;
 	struct device *dev = rsnd_priv_to_dev(priv);
+	struct device_node *np = dev->of_node;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
 	if (!adg) {
@@ -545,6 +560,9 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
 
+	if (of_get_property(np, "clkout-lr-asynchronous", NULL))
+		adg->flags = LRCLK_ASYNC;
+
 	priv->adg = adg;
 
 	return 0;
-- 
2.8.1
