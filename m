From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] ASoC: rsnd: check return value of init function
Date: Mon, 20 Feb 2017 22:05:07 +0100
Message-ID: <20170220210514.12090-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently, this function cannot fail for the ADG case. Still, let's
apply defensive programming techniques to make sure we fail gracefully
whenever rsnd_mod_init() gets extended with another failure case.
Reported by Coverity (CID 1397893).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/sh/rcar/adg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 85a33ac0a5c443..54146f66538c18 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -564,6 +564,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	struct rsnd_adg *adg;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
+	int ret;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
 	if (!adg) {
@@ -571,8 +572,10 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 		return -ENOMEM;
 	}
 
-	rsnd_mod_init(priv, &adg->mod, &adg_ops,
+	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
 		      NULL, NULL, 0, 0);
+	if (ret)
+		return ret;
 
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
-- 
2.11.0
