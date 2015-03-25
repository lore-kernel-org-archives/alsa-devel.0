From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: DAPM: Fix build warning
Date: Wed, 25 Mar 2015 10:13:28 +0000
Message-ID: <1427278408-27134-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, nikesh@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

commit c66150824b8a ("ASoC: dapm: add code to configure dai link
parameters") introduced the following build warning:

sound/soc/soc-dapm.c: In function 'snd_soc_dapm_new_pcm':
sound/soc/soc-dapm.c:3389:4: warning: passing argument 1 of 'snprintf'
discards 'const' qualifier from pointer target type
    snprintf(w_param_text[count], len,

This patch fixes this by adding a non-const temporary variable to hold
the value as it is created before assigning to the entry in
w_param_text.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 049b300..7640370 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3376,18 +3376,20 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 
 	for (count = 0 ; count < num_params; count++) {
 		if (!config->stream_name) {
+			char *anon_name;
+
 			dev_warn(card->dapm.dev,
 				"ASoC: anonymous config %d for dai link %s\n",
 				count, link_name);
 			len = strlen("Anonymous Configuration ") + 3;
-			w_param_text[count] =
-				devm_kzalloc(card->dev, len, GFP_KERNEL);
-			if (!w_param_text[count]) {
+			anon_name = devm_kzalloc(card->dev, len, GFP_KERNEL);
+			if (!anon_name) {
 				ret = -ENOMEM;
 				goto outfree_link_name;
 			}
-			snprintf(w_param_text[count], len,
+			snprintf(anon_name, len,
 				"Anonymous Configuration %d", count);
+			w_param_text[count] = anon_name;
 		} else {
 			w_param_text[count] = devm_kmemdup(card->dev,
 						config->stream_name,
-- 
1.7.2.5
