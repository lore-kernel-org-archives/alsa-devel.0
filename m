From: Mark Brown <broonie@kernel.org>
Subject: Applied "of_graph: add of_graph_get_remote_endpoint()" to the asoc tree
Date: Wed, 17 May 2017 10:53:21 +0100
Message-ID: <E1dAvdx-00074D-At@debutante>
References: <87d1n7xqzd.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d1n7xqzd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Guennadi <g.liakhovetski@gmx.de>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-Kernel <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   of_graph: add of_graph_get_remote_endpoint()

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

>From 4c9c3d595f1bad021cc126d20879df4016801736 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Apr 2017 01:31:42 +0000
Subject: [PATCH] of_graph: add of_graph_get_remote_endpoint()

It should use same method to get same result.
To getting remote-endpoint node,
let's use of_graph_get_remote_endpoint()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/of/base.c        | 18 ++++++++++++++++--
 include/linux/of_graph.h |  8 ++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5db6aa1688e9..b169508a9b56 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2487,6 +2487,20 @@ struct device_node *of_graph_get_endpoint_by_regs(
 EXPORT_SYMBOL(of_graph_get_endpoint_by_regs);
 
 /**
+ * of_graph_get_remote_endpoint() - get remote endpoint node
+ * @node: pointer to a local endpoint device_node
+ *
+ * Return: Remote endpoint node associated with remote endpoint node linked
+ *	   to @node. Use of_node_put() on it when done.
+ */
+struct device_node *of_graph_get_remote_endpoint(const struct device_node *node)
+{
+	/* Get remote endpoint node. */
+	return of_parse_phandle(node, "remote-endpoint", 0);
+}
+EXPORT_SYMBOL(of_graph_get_remote_endpoint);
+
+/**
  * of_graph_get_remote_port_parent() - get remote port's parent node
  * @node: pointer to a local endpoint device_node
  *
@@ -2500,7 +2514,7 @@ struct device_node *of_graph_get_remote_port_parent(
 	unsigned int depth;
 
 	/* Get remote endpoint node. */
-	np = of_parse_phandle(node, "remote-endpoint", 0);
+	np = of_graph_get_remote_endpoint(node);
 
 	/* Walk 3 levels up only if there is 'ports' node. */
 	for (depth = 3; depth && np; depth--) {
@@ -2524,7 +2538,7 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
 	struct device_node *np;
 
 	/* Get remote endpoint node. */
-	np = of_parse_phandle(node, "remote-endpoint", 0);
+	np = of_graph_get_remote_endpoint(node);
 	if (!np)
 		return NULL;
 	return of_get_next_parent(np);
diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index abdb02eaef06..0c9473a169dd 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -48,6 +48,8 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 					struct device_node *previous);
 struct device_node *of_graph_get_endpoint_by_regs(
 		const struct device_node *parent, int port_reg, int reg);
+struct device_node *of_graph_get_remote_endpoint(
+					const struct device_node *node);
 struct device_node *of_graph_get_remote_port_parent(
 					const struct device_node *node);
 struct device_node *of_graph_get_remote_port(const struct device_node *node);
@@ -80,6 +82,12 @@ static inline struct device_node *of_graph_get_endpoint_by_regs(
 	return NULL;
 }
 
+static inline struct device_node *of_graph_get_remote_endpoint(
+					const struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_graph_get_remote_port_parent(
 					const struct device_node *node)
 {
-- 
2.11.0
