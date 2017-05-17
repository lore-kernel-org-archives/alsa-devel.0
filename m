From: Mark Brown <broonie@kernel.org>
Subject: Applied "of_graph: add of_graph_get_port_parent()" to the asoc tree
Date: Wed, 17 May 2017 10:53:16 +0100
Message-ID: <E1dAvds-000738-3H@debutante>
References: <878txvxqxn.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878txvxqxn.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Guennadi <g.liakhovetski@gmx.de>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-Kernel <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   of_graph: add of_graph_get_port_parent()

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

>From 0ef472a973ebbfc20f2f12769e77a8cfd3612778 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Apr 2017 01:32:17 +0000
Subject: [PATCH] of_graph: add of_graph_get_port_parent()

Linux kernel already has of_graph_get_remote_port_parent(),
but, sometimes we want to get own port parent.
This patch adds of_graph_get_port_parent()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/of/base.c        | 30 ++++++++++++++++++++++--------
 include/linux/of_graph.h |  7 +++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b169508a9b56..4c305599a664 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2501,6 +2501,27 @@ struct device_node *of_graph_get_remote_endpoint(const struct device_node *node)
 EXPORT_SYMBOL(of_graph_get_remote_endpoint);
 
 /**
+ * of_graph_get_port_parent() - get port's parent node
+ * @node: pointer to a local endpoint device_node
+ *
+ * Return: device node associated with endpoint node linked
+ *	   to @node. Use of_node_put() on it when done.
+ */
+struct device_node *of_graph_get_port_parent(struct device_node *node)
+{
+	unsigned int depth;
+
+	/* Walk 3 levels up only if there is 'ports' node. */
+	for (depth = 3; depth && node; depth--) {
+		node = of_get_next_parent(node);
+		if (depth == 2 && of_node_cmp(node->name, "ports"))
+			break;
+	}
+	return node;
+}
+EXPORT_SYMBOL(of_graph_get_port_parent);
+
+/**
  * of_graph_get_remote_port_parent() - get remote port's parent node
  * @node: pointer to a local endpoint device_node
  *
@@ -2511,18 +2532,11 @@ struct device_node *of_graph_get_remote_port_parent(
 			       const struct device_node *node)
 {
 	struct device_node *np;
-	unsigned int depth;
 
 	/* Get remote endpoint node. */
 	np = of_graph_get_remote_endpoint(node);
 
-	/* Walk 3 levels up only if there is 'ports' node. */
-	for (depth = 3; depth && np; depth--) {
-		np = of_get_next_parent(np);
-		if (depth == 2 && of_node_cmp(np->name, "ports"))
-			break;
-	}
-	return np;
+	return of_graph_get_port_parent(np);
 }
 EXPORT_SYMBOL(of_graph_get_remote_port_parent);
 
diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index 0c9473a169dd..9db632d16cbc 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -50,6 +50,7 @@ struct device_node *of_graph_get_endpoint_by_regs(
 		const struct device_node *parent, int port_reg, int reg);
 struct device_node *of_graph_get_remote_endpoint(
 					const struct device_node *node);
+struct device_node *of_graph_get_port_parent(struct device_node *node);
 struct device_node *of_graph_get_remote_port_parent(
 					const struct device_node *node);
 struct device_node *of_graph_get_remote_port(const struct device_node *node);
@@ -88,6 +89,12 @@ static inline struct device_node *of_graph_get_remote_endpoint(
 	return NULL;
 }
 
+static inline struct device_node *of_graph_get_port_parent(
+	struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_graph_get_remote_port_parent(
 					const struct device_node *node)
 {
-- 
2.11.0
