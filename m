From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 1/5] ASoC: simple-card-utils: fixup
 asoc_simple_card_get_dai_id() counting
Date: Fri, 30 Nov 2018 02:04:13 +0000
Message-ID: <87y39bz5wb.wl-kuninori.morimoto.gx@renesas.com>
References: <87zhtrz5yt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410135.outbound.protection.outlook.com [40.107.141.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 72E0D267B85
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2018 03:04:15 +0100 (CET)
In-Reply-To: <87zhtrz5yt.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <C865E3B68CDB464F980C043F6DC00946@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

asoc_simple_card_get_dai_id() returns DAI ID, but it is based on
DT node's "endpoint" position.
Almost all cases 1 port has 1 endpoint, thus, it was no problem.
But in reality, port : endpoint = 1 : N, thus, counting endpoint
is BUG, it should based on "port" ID.
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/generic/simple-card-utils.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c69ce1e..6a31d07 100644
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
2.7.4
