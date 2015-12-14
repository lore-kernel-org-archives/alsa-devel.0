From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] rcar: dvc: Avoid use of ret uninitialised
Date: Mon, 14 Dec 2015 12:07:30 +0000
Message-ID: <1450094851-27525-2-git-send-email-broonie@kernel.org>
References: <1450094851-27525-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F869260417
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 13:07:42 +0100 (CET)
In-Reply-To: <1450094851-27525-1-git-send-email-broonie@kernel.org>
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

We use ret as the return value from the rsnd_dvc_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 66aeea8e0069..42e6a230a3d1 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -360,6 +360,7 @@ int rsnd_dvc_probe(struct rsnd_priv *priv)
 	priv->dvc	= dvc;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		dvc = rsnd_dvc_get(priv, i);
 
-- 
2.6.2
