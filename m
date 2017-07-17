From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing of_node_put" to the
	asoc tree
Date: Mon, 17 Jul 2017 17:06:10 +0100
Message-ID: <E1dX8XC-00051e-Dq@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A88C26744F
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:20 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add missing of_node_put

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

>From 53ba2aa314164f7fcd3acf9594313811256a52c4 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 15 Jul 2017 09:19:07 +0200
Subject: [PATCH] ASoC: rsnd: add missing of_node_put

for_each_child_of_node performs an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression n;
expression e,e1;
identifier l;
@@

 for_each_child_of_node(e1,n) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  goto l;
)
   ...
 }
...
l: ... when != n
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 5 ++++-
 sound/soc/sh/rcar/dvc.c | 5 ++++-
 sound/soc/sh/rcar/mix.c | 5 ++++-
 sound/soc/sh/rcar/src.c | 6 +++++-
 sound/soc/sh/rcar/ssi.c | 6 +++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 4ba8f2fe7a4c..e7f53f44165d 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -394,13 +394,16 @@ int rsnd_ctu_probe(struct rsnd_priv *priv)
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_ctu_probe_done;
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ctu), &rsnd_ctu_ops,
 				    clk, rsnd_mod_get_status, RSND_MOD_CTU, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_ctu_probe_done;
+		}
 
 		i++;
 	}
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 99d2d9459e75..1743ade3cc55 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -380,13 +380,16 @@ int rsnd_dvc_probe(struct rsnd_priv *priv)
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_dvc_probe_done;
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(dvc), &rsnd_dvc_ops,
 				    clk, rsnd_mod_get_status, RSND_MOD_DVC, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_dvc_probe_done;
+		}
 
 		i++;
 	}
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 195fc7bb22af..6c4826c189a4 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -168,13 +168,16 @@ int rsnd_mix_probe(struct rsnd_priv *priv)
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_mix_probe_done;
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(mix), &rsnd_mix_ops,
 				    clk, rsnd_mod_get_status, RSND_MOD_MIX, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_mix_probe_done;
+		}
 
 		i++;
 	}
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 7aa239e28491..8e9a1de0ec25 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -581,20 +581,24 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 		src->irq = irq_of_parse_and_map(np, 0);
 		if (!src->irq) {
 			ret = -EINVAL;
+			of_node_put(np);
 			goto rsnd_src_probe_done;
 		}
 
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_src_probe_done;
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
 				    &rsnd_src_ops, clk, rsnd_mod_get_status,
 				    RSND_MOD_SRC, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_src_probe_done;
+		}
 
 skip:
 		i++;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 46feddd78ee2..49cdc5e007b3 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1079,6 +1079,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
 		}
 
@@ -1091,6 +1092,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 		ssi->irq = irq_of_parse_and_map(np, 0);
 		if (!ssi->irq) {
 			ret = -EINVAL;
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
 		}
 
@@ -1101,8 +1103,10 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssi), ops, clk,
 				    rsnd_ssi_get_status, RSND_MOD_SSI, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
+		}
 
 		i++;
 	}
-- 
2.13.2
