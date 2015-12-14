From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] rcar: mux: Avoid use of ret uninitialised
Date: Mon, 14 Dec 2015 12:07:31 +0000
Message-ID: <1450094851-27525-3-git-send-email-broonie@kernel.org>
References: <1450094851-27525-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38344260423
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 13:07:43 +0100 (CET)
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

We use ret as the return value from the rsnd_mix_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/mix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index b34957ab75b9..65542b6a89e9 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -158,6 +158,7 @@ int rsnd_mix_probe(struct rsnd_priv *priv)
 	priv->mix	= mix;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		mix = rsnd_mix_get(priv, i);
 
-- 
2.6.2
