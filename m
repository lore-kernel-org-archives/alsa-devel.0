From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()" to the asoc tree
Date: Wed, 17 May 2017 10:52:55 +0100
Message-ID: <E1dAvdX-0006yO-Eh@debutante>
References: <87efwqxwrm.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87efwqxwrm.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()

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

>From 1689333f8311f5952ee69d64adf242028dc7e6c6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 20 Apr 2017 01:35:18 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_parse_graph_dai()

simple-card already has asoc_simple_card_parse_dai(),
but graph base parsing needs graph specific version of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/simple_card_utils.h     | 10 ++++++
 sound/soc/generic/simple-card-utils.c | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index af58d2362975..efab584af11b 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -60,6 +60,16 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 				  const char *cells_name,
 				  int *is_single_links);
 
+#define asoc_simple_card_parse_graph_cpu(ep, dai_link)			\
+	asoc_simple_card_parse_graph_dai(ep, &dai_link->cpu_of_node,	\
+					 &dai_link->cpu_dai_name)
+#define asoc_simple_card_parse_graph_codec(ep, dai_link)		\
+	asoc_simple_card_parse_graph_dai(ep, &dai_link->codec_of_node,	\
+					 &dai_link->codec_dai_name)
+int asoc_simple_card_parse_graph_dai(struct device_node *ep,
+				     struct device_node **endpoint_np,
+				     const char **dai_name);
+
 int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c5ab8ad2a5ce..5a3d51e45938 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <sound/simple_card_utils.h>
 
 int asoc_simple_card_parse_daifmt(struct device *dev,
@@ -171,6 +172,62 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
+static int asoc_simple_card_get_dai_id(struct device_node *ep)
+{
+	struct device_node *node;
+	struct device_node *endpoint;
+	int i, id;
+
+	node = of_graph_get_port_parent(ep);
+
+	i = 0;
+	id = -1;
+	for_each_endpoint_of_node(node, endpoint) {
+		if (endpoint == ep)
+			id = i;
+		i++;
+	}
+	if (id < 0)
+		return -ENODEV;
+
+	return id;
+}
+
+int asoc_simple_card_parse_graph_dai(struct device_node *ep,
+				     struct device_node **dai_of_node,
+				     const char **dai_name)
+{
+	struct device_node *node;
+	struct of_phandle_args args;
+	int ret;
+
+	if (!ep)
+		return 0;
+	if (!dai_name)
+		return 0;
+
+	/*
+	 * of_graph_get_port_parent() will call
+	 * of_node_put(). So, call of_node_get() here
+	 */
+	of_node_get(ep);
+	node = of_graph_get_port_parent(ep);
+
+	/* Get dai->name */
+	args.np		= node;
+	args.args[0]	= asoc_simple_card_get_dai_id(ep);
+	args.args_count	= (of_graph_get_endpoint_count(node) > 1);
+
+	ret = snd_soc_get_dai_name(&args, dai_name);
+	if (ret < 0)
+		return ret;
+
+	*dai_of_node = node;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_parse_graph_dai);
+
 int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai)
 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
