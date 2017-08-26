From: anish kumar <yesanishhere@gmail.com>
Subject: [patch 2/4] ASoC: dapm: Refactor the code in
	snd_soc_dapm_new_pcm
Date: Sat, 26 Aug 2017 01:29:38 -0700
Message-ID: <20170826082938.35516-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id D221B26741F
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 10:29:45 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 63so2432264pgc.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 01:29:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: anish kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

refactor snd_soc_dapm_new_pcm to reduce the size of
this function to facilitate further refactoring.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6e10a9a..1687c8a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3821,19 +3821,15 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 				devm_kasprintf(card->dev, GFP_KERNEL,
 					       "Anonymous Configuration %d",
 					       count);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
 		} else {
 			w_param_text[count] = devm_kmemdup(card->dev,
 						config->stream_name,
 						strlen(config->stream_name) + 1,
 						GFP_KERNEL);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
+		}
+		if (!w_param_text[count]) {
+			ret = -ENOMEM;
+			goto outfree_link_name;
 		}
 		config++;
 	}
-- 
2.10.1 (Apple Git-78)
