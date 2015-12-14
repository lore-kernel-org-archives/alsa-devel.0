From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] rcar: ctu: Avoid use of ret uninitialised
Date: Mon, 14 Dec 2015 12:07:29 +0000
Message-ID: <1450094851-27525-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E39026043C
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 13:07:43 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We use ret as the return value from the rsnd_ctu_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

Perhaps this should be an error instead?  It's not like it's a sensible
configuration...

 sound/soc/sh/rcar/ctu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 7c1e190cd389..d53a225d19e9 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -111,6 +111,7 @@ int rsnd_ctu_probe(struct rsnd_priv *priv)
 	priv->ctu	= ctu;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		ctu = rsnd_ctu_get(priv, i);
 
-- 
2.6.2
