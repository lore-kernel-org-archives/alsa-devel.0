From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: fixup
	asoc_simple_card_get_dai_id() ID method" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:44 +0000 (GMT)
Message-ID: <20181214123744.CCFD311258A1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E435267C06
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:45 +0100 (CET)
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() ID method

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

>From b8b89f5ee0b2555fa5a9d778685d2d6fb5122bb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:29:42 +0900
Subject: [PATCH] ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id()
 ID method

commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup
asoc_simple_card_get_dai_id() counting") fixuped getting DAI ID method.
It will get DAI ID from OF graph "port", but, we want to consider about
"endpoint", too.
And, we also want to keep compatibility.

This patch fixup it as

	if (driver has specified DAI ID)
		use it as DAI ID
	else if (OF graph endpoint has reg)
		use it as DAI ID
	else if (OF graph port has reg)
		use it as DAI ID
	else
		use endpoint count as DAI ID

Fixes: commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 32 +++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 17d8aee43835..b807a47515eb 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -269,22 +269,46 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
 static int asoc_simple_card_get_dai_id(struct device_node *ep)
 {
+	struct device_node *node;
+	struct device_node *endpoint;
 	struct of_endpoint info;
+	int i, id;
 	int ret;
 
+	/* use driver specified DAI ID if exist */
 	ret = snd_soc_get_dai_id(ep);
 	if (ret != -ENOTSUPP)
 		return ret;
 
+	/* use endpoint/port reg if exist */
+	ret = of_graph_parse_endpoint(ep, &info);
+	if (ret == 0) {
+		if (info.id)
+			return info.id;
+		if (info.port)
+			return info.port;
+	}
+
+	node = of_graph_get_port_parent(ep);
+
 	/*
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	ret = of_graph_parse_endpoint(ep, &info);
-	if (ret)
-		return -ENXIO;
+	i = 0;
+	id = -1;
+	for_each_endpoint_of_node(node, endpoint) {
+		if (endpoint == ep)
+			id = i;
+		i++;
+	}
+
+	of_node_put(node);
+
+	if (id < 0)
+		return -ENODEV;
 
-	return info.port;
+	return id;
 }
 
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-- 
2.19.0.rc2
