From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] ASoC: soc-core: add snd_soc_of_lookup_component()
Date: Mon, 24 Dec 2018 14:32:12 +0530
Message-ID: <1545642133-16120-2-git-send-email-rohitkr@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Ajit Pandey <ajitp@codeaurora.org>, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Ajit Pandey <ajitp@codeaurora.org>

Soundcard should be registered after all components are registered.
Add snd_soc_of_lookup_component() to get component info from
device_node. This can be used by machine driver to make sure that
card components are registered before calling snd_soc_register_card().

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de8..dc251fc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1502,6 +1502,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
+struct snd_soc_component *snd_soc_of_lookup_component(struct device_node *np);
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3e..ab27bc5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3797,6 +3797,34 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
 
 /*
+ * snd_soc_of_lookup_component - Lookup component with device node
+ * @np: device node pointer
+ *
+ * This function looks up component based on given of_node
+ *
+ * Returns valid component pointer on success and NULL on failure to find one.
+ */
+struct snd_soc_component *snd_soc_of_lookup_component(struct device_node *np)
+{
+	struct snd_soc_component *component = NULL;
+	bool found = false;
+
+	if (!np)
+		return NULL;
+
+	mutex_lock(&client_mutex);
+	for_each_component(component)
+		if (component->dev->of_node == np) {
+			found = true;
+			break;
+		}
+	mutex_unlock(&client_mutex);
+
+	return found ? component : NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_lookup_component);
+
+/*
  * snd_soc_of_put_dai_link_codecs - Dereference device nodes in the codecs array
  * @dai_link: DAI link
  *
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
