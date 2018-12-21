From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: check "reg" property
	on asoc_simple_card_get_dai_id()" to the asoc tree
Date: Fri, 21 Dec 2018 18:15:37 +0000 (GMT)
Message-ID: <20181221181537.A4A141121B93@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 361C4267B4F
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:38 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()

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

>From a4ad6c42a7368b6e9ff5732c390b319a1b259134 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:45:42 +0900
Subject: [PATCH] ASoC: simple-card-utils: check "reg" property on
 asoc_simple_card_get_dai_id()

We will get DAI ID from "reg" property if it has on DT, otherwise get
it by counting port/endpoint.

But in below case, we need to get DAI ID = 0 via port reg = <0>, but
current implementation returns ID = 1, because it can't judge ID = 0 was
from "non reg" or "reg = <0>".
Thus, it will count port/endpoint number as "non reg" case.

of_graph_parse_endpoint() implementation itself is not a problem,
but because asoc_simple_card_get_dai_id() need to count port/endpoint
number when "non reg" case, it need to know ID = 0 was from
"non reg" or "reg = <0>".
This patch fix this issue.

	port {
		reg = <0>;
		xxxx: endpoint@0 {
		};
=>		xxxx: endpoint@1 {
		};
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index b807a47515eb..336895f7fd1e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -283,12 +283,20 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	/* use endpoint/port reg if exist */
 	ret = of_graph_parse_endpoint(ep, &info);
 	if (ret == 0) {
-		if (info.id)
+		/*
+		 * Because it will count port/endpoint if it doesn't have "reg".
+		 * But, we can't judge whether it has "no reg", or "reg = <0>"
+		 * only of_graph_parse_endpoint().
+		 * We need to check "reg" property
+		 */
+		if (of_get_property(ep,   "reg", NULL))
 			return info.id;
-		if (info.port)
+
+		node = of_get_parent(ep);
+		of_node_put(node);
+		if (of_get_property(node, "reg", NULL))
 			return info.port;
 	}
-
 	node = of_graph_get_port_parent(ep);
 
 	/*
-- 
2.20.1
