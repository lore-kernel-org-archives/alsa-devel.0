From: yesanishhere@gmail.com
Subject: [Resend] [PATCH 2/4] ASoC: dapm: Refactor the code in
	snd_soc_dapm_new_pcm
Date: Wed, 20 Sep 2017 01:28:34 -0700
Message-ID: <1505896116-43310-3-git-send-email-yesanishhere@gmail.com>
References: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A0EA0267277
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 10:28:51 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id j16so1272676pga.2
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 01:28:51 -0700 (PDT)
In-Reply-To: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ckeepax@opensource.cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: anish kumar <yesanishhere@gmail.com>

refactor snd_soc_dapm_new_pcm to reduce the size of
this function to facilitate further refactoring.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f51f613..d55cac6 100644
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
2.5.4 (Apple Git-61)
