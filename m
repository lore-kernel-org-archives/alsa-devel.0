From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3] ASoC: dapm: Fix build warning
Date: Wed, 25 Mar 2015 11:22:35 +0000
Message-ID: <1427282555-19050-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, nikesh@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

commit c66150824b8a ("ASoC: dapm: add code to configure dai link
parameters") introduced the following build warning:

sound/soc/soc-dapm.c: In function 'snd_soc_dapm_new_pcm':
sound/soc/soc-dapm.c:3389:4: warning: passing argument 1 of 'snprintf'
discards 'const' qualifier from pointer target type
snprintf(w_param_text[count], len,

This patch fixes this by switching to using devm_kasprintf. This also
saves a couple of lines of code.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v2:
 - Use devm_kasprintf

 sound/soc/soc-dapm.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 049b300..4bd2a6f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3346,7 +3346,6 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 {
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
-	size_t len;
 	char *link_name;
 	int ret, count;
 	unsigned long private_value;
@@ -3366,28 +3365,26 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	if (!w_param_text)
 		return -ENOMEM;
 
-	len = strlen(source->name) + strlen(sink->name) + 2;
-	link_name = devm_kzalloc(card->dev, len, GFP_KERNEL);
+	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
+				   source->name, sink->name);
 	if (!link_name) {
 		ret = -ENOMEM;
 		goto outfree_w_param;
 	}
-	snprintf(link_name, len, "%s-%s", source->name, sink->name);
 
 	for (count = 0 ; count < num_params; count++) {
 		if (!config->stream_name) {
 			dev_warn(card->dapm.dev,
 				"ASoC: anonymous config %d for dai link %s\n",
 				count, link_name);
-			len = strlen("Anonymous Configuration ") + 3;
 			w_param_text[count] =
-				devm_kzalloc(card->dev, len, GFP_KERNEL);
+				devm_kasprintf(card->dev, GFP_KERNEL,
+					       "Anonymous Configuration %d",
+					       count);
 			if (!w_param_text[count]) {
 				ret = -ENOMEM;
 				goto outfree_link_name;
 			}
-			snprintf(w_param_text[count], len,
-				"Anonymous Configuration %d", count);
 		} else {
 			w_param_text[count] = devm_kmemdup(card->dev,
 						config->stream_name,
-- 
1.7.2.5
