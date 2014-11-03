From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v3 1/2] ASoC: core: add multi-codec support in DT
Date: Mon, 3 Nov 2014 18:42:22 +0100
Message-ID: <6b04d690576a0036b401d00784299ee576051c0d.1415096705.git.moinejf@free.fr>
References: <cover.1415096705.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1415096705.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

SoC audio cards may have many CODECs per audio link.
This patch exports a core function to handle such links
when they are described in the DT.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 75 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ba7130..a255f8b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1451,6 +1451,9 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     struct device_node **framemaster);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
+int snd_soc_of_get_dai_link_codecs(struct device_node *of_node,
+				   const char *list_name,
+				   struct snd_soc_dai_link *dai_link);
 
 #include <sound/soc-dai.h>
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3818cf3..e585d6d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3724,36 +3724,30 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
-int snd_soc_of_get_dai_name(struct device_node *of_node,
-			    const char **dai_name)
+static int snd_soc_get_dai_name(struct of_phandle_args *args,
+				const char **dai_name)
 {
 	struct snd_soc_component *pos;
-	struct of_phandle_args args;
-	int ret;
-
-	ret = of_parse_phandle_with_args(of_node, "sound-dai",
-					 "#sound-dai-cells", 0, &args);
-	if (ret)
-		return ret;
-
-	ret = -EPROBE_DEFER;
+	int ret = -EPROBE_DEFER;
 
 	mutex_lock(&client_mutex);
 	list_for_each_entry(pos, &component_list, list) {
-		if (pos->dev->of_node != args.np)
+		if (pos->dev->of_node != args->np)
 			continue;
 
 		if (pos->driver->of_xlate_dai_name) {
-			ret = pos->driver->of_xlate_dai_name(pos, &args, dai_name);
+			ret = pos->driver->of_xlate_dai_name(pos,
+							     args,
+							     dai_name);
 		} else {
 			int id = -1;
 
-			switch (args.args_count) {
+			switch (args->args_count) {
 			case 0:
 				id = 0; /* same as dai_drv[0] */
 				break;
 			case 1:
-				id = args.args[0];
+				id = args->args[0];
 				break;
 			default:
 				/* not supported */
@@ -3775,6 +3769,21 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 		break;
 	}
 	mutex_unlock(&client_mutex);
+	return ret;
+}
+
+int snd_soc_of_get_dai_name(struct device_node *of_node,
+			    const char **dai_name)
+{
+	struct of_phandle_args args;
+	int ret;
+
+	ret = of_parse_phandle_with_args(of_node, "sound-dai",
+					 "#sound-dai-cells", 0, &args);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_get_dai_name(&args, dai_name);
 
 	of_node_put(args.np);
 
@@ -3782,6 +3791,42 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
 
+int snd_soc_of_get_dai_link_codecs(struct device_node *of_node,
+				   const char *list_name,
+				   struct snd_soc_dai_link *dai_link)
+{
+	struct of_phandle_args args;
+	struct snd_soc_dai_link_component *component;
+	int index, ret;
+
+	for (index = 0, component = dai_link->codecs;
+	     index < dai_link->num_codecs;
+	     index++, component++) {
+		ret = of_parse_phandle_with_args(of_node, list_name,
+						 "#sound-dai-cells",
+						  index, &args);
+		if (ret)
+			goto err;
+		component->of_node = args.np;
+		ret = snd_soc_get_dai_name(&args, &component->dai_name);
+		if (ret < 0)
+			goto err;
+	}
+	return 0;
+
+err:
+	for (index = 0, component = dai_link->codecs;
+	     index < dai_link->num_codecs;
+	     index++, component++) {
+		if (!component->of_node)
+			break;
+		of_node_put((struct device_node *) component->of_node);
+		component->of_node = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_link_codecs);
+
 static int __init snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
