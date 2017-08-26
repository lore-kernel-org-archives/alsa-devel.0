From: anish kumar <yesanishhere@gmail.com>
Subject: [patch 1/4] ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm
Date: Sat, 26 Aug 2017 01:29:25 -0700
Message-ID: <20170826082925.35472-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4578D267439
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 10:29:30 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id t3so2401385pgt.5
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 01:29:29 -0700 (PDT)
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

Before freeing the memory, check if it was allcoated.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..6e10a9a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3907,9 +3907,10 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
 	devm_kfree(card->dev, link_name);
-outfree_w_param:
 	for (count = 0 ; count < num_params; count++)
-		devm_kfree(card->dev, (void *)w_param_text[count]);
+            if (w_param_text[count])
+	        devm_kfree(card->dev, (void *)w_param_text[count]);
+outfree_w_param:
 	devm_kfree(card->dev, w_param_text);
 
 	return ret;
-- 
2.10.1 (Apple Git-78)
