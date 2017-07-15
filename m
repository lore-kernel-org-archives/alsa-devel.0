From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ASoC: rsnd: add missing of_node_put
Date: Sat, 15 Jul 2017 09:19:07 +0200
Message-ID: <1500103147-17297-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id DB50526648D
 for <alsa-devel@alsa-project.org>; Sat, 15 Jul 2017 09:44:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

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

---
 sound/soc/sh/rcar/ctu.c |    5 ++++-
 sound/soc/sh/rcar/dvc.c |    5 ++++-
 sound/soc/sh/rcar/mix.c |    5 ++++-
 sound/soc/sh/rcar/src.c |    6 +++++-
 sound/soc/sh/rcar/ssi.c |    6 +++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff -u -p a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -168,13 +168,16 @@ int rsnd_mix_probe(struct rsnd_priv *pri
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
diff -u -p a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -394,13 +394,16 @@ int rsnd_ctu_probe(struct rsnd_priv *pri
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
diff -u -p a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1079,6 +1079,7 @@ int rsnd_ssi_probe(struct rsnd_priv *pri
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
 		}
 
@@ -1091,6 +1092,7 @@ int rsnd_ssi_probe(struct rsnd_priv *pri
 		ssi->irq = irq_of_parse_and_map(np, 0);
 		if (!ssi->irq) {
 			ret = -EINVAL;
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
 		}
 
@@ -1101,8 +1103,10 @@ int rsnd_ssi_probe(struct rsnd_priv *pri
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssi), ops, clk,
 				    rsnd_ssi_get_status, RSND_MOD_SSI, i);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			goto rsnd_ssi_probe_done;
+		}
 
 		i++;
 	}
diff -u -p a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -581,20 +581,24 @@ int rsnd_src_probe(struct rsnd_priv *pri
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
diff -u -p a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -380,13 +380,16 @@ int rsnd_dvc_probe(struct rsnd_priv *pri
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
