From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v2 1/3] ASoC: core: export snd_soc_get_dai_name
Date: Tue, 20 Jan 2015 19:47:34 +0100
Message-ID: <f87a92d15c95d48b6709f7a99f8fc3e79ec01d28.1421868426.git.moinejf@free.fr>
References: <cover.1421868426.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1421868426.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

snd_soc_get_dai_name() may be used to define a sound card with
a different syntax from the one of the simple-card.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 include/sound/soc.h  | 2 ++
 sound/soc/soc-core.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index edd4a0a..7e783d6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1502,6 +1502,8 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
+int snd_soc_get_dai_name(struct of_phandle_args *args,
+			 const char **dai_name);
 
 #include <sound/soc-dai.h>
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ededb97..6a782ca 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3418,8 +3418,8 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
-static int snd_soc_get_dai_name(struct of_phandle_args *args,
-				const char **dai_name)
+int snd_soc_get_dai_name(struct of_phandle_args *args,
+			 const char **dai_name)
 {
 	struct snd_soc_component *pos;
 	int ret = -EPROBE_DEFER;
@@ -3465,6 +3465,7 @@ static int snd_soc_get_dai_name(struct of_phandle_args *args,
 	mutex_unlock(&client_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_get_dai_name);
 
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
