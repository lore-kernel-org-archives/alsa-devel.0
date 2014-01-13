From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv2 2/6] ASoC: core: add snd_soc_get_widgets
Date: Mon, 13 Jan 2014 13:53:54 +0800
Message-ID: <1389592438-13761-3-git-send-email-Li.Xiubo@freescale.com>
References: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389592438-13761-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add widgets list getting.

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 23f9572..f352333 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -388,6 +388,7 @@ int devm_snd_soc_register_component(struct device *dev,
 void snd_soc_unregister_component(struct device *dev);
 int snd_soc_register_widgets(struct snd_soc_widgets *wdg);
 void snd_soc_unregister_widgets(struct snd_soc_widgets *wdg);
+struct snd_soc_widgets *snd_soc_get_widgets(struct device_node *np);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
 				    unsigned int reg);
 int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9adcada..e1d26e6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3860,6 +3860,37 @@ void snd_soc_unregister_widgets(struct snd_soc_widgets *wdg)
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_widgets);
 
+struct snd_soc_widgets *snd_soc_get_widgets(struct device_node *np)
+{
+	struct snd_soc_widgets *wdg;
+	const char *string;
+	int ret;
+
+	if (!np)
+		return ERR_PTR(-EINVAL);
+
+	if (!of_property_read_bool(np, "sound-widgets"))
+		return NULL;
+
+	ret = of_property_read_string(np, "sound-widgets",
+				      &string);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	mutex_lock(&widgets_mutex);
+	list_for_each_entry(wdg, &widgets_list, list) {
+		if (!strcmp(string, wdg->name)) {
+			mutex_unlock(&widgets_mutex);
+			return wdg;
+		}
+
+	}
+	mutex_unlock(&widgets_mutex);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_widgets);
+
 /*
  * Simplify DAI link configuration by removing ".-1" from device names
  * and sanitizing names.
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
