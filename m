From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: soc-core: add snd_soc_of_parse_sysclk_id() for dt
Date: Thu, 2 Jan 2014 15:34:17 +0800
Message-ID: <1388648057-28373-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_sysclk_id() and supports below
style on dt:

sysclk-id = <XXX>;

It's an optional property, If this property is absent the defualt
vaule 0 will be returned.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5a049d9..86ac72f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1170,6 +1170,7 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
+unsigned int snd_soc_of_parse_sysclk_id(struct device_node *np);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index be88df5..572d95d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4472,6 +4472,22 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
 
+unsigned int snd_soc_of_parse_sysclk_id(struct device_node *np)
+{
+	u32 id;
+
+	/*
+	 * check "sysclk-id = <XX>"
+	 * it is an optional property
+	 * 0 will be returned if absent
+	 */
+	if (of_property_read_u32(np, "sysclk-id", &id))
+		id = 0;
+
+	return id;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_sysclk_id);
+
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix)
 {
-- 
1.8.4
