From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: fixup
	asoc_simple_card_get_dai_id() counting" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:08 +0000 (GMT)
Message-ID: <20181204172708.53D5611251E3@debutante.sirena.org.uk>
References: <87y39bz5wb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D44B3267B74
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:08 +0100 (CET)
In-Reply-To: <87y39bz5wb.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting

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

>From b6f3fc005a2c8b425d7a0973b43bef05890bf479 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Nov 2018 02:04:13 +0000
Subject: [PATCH] ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id()
 counting

asoc_simple_card_get_dai_id() returns DAI ID, but it is based on
DT node's "endpoint" position.
Almost all cases 1 port has 1 endpoint, thus, it was no problem.
But in reality, port : endpoint = 1 : N, thus, counting endpoint
is BUG, it should based on "port" ID.
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c69ce1e563cd..6a31d07976b9 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -269,35 +269,19 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
 static int asoc_simple_card_get_dai_id(struct device_node *ep)
 {
-	struct device_node *node;
-	struct device_node *endpoint;
-	int i, id;
+	struct of_endpoint info;
 	int ret;
 
 	ret = snd_soc_get_dai_id(ep);
 	if (ret != -ENOTSUPP)
 		return ret;
 
-	node = of_graph_get_port_parent(ep);
-
 	/*
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	i = 0;
-	id = -1;
-	for_each_endpoint_of_node(node, endpoint) {
-		if (endpoint == ep)
-			id = i;
-		i++;
-	}
-
-	of_node_put(node);
-
-	if (id < 0)
-		return -ENODEV;
-
-	return id;
+	of_graph_parse_endpoint(ep, &info);
+	return info.port;
 }
 
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-- 
2.19.0.rc2
