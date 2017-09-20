From: yesanishhere@gmail.com
Subject: [Resend] [PATCH 1/4] ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm
Date: Wed, 20 Sep 2017 01:28:33 -0700
Message-ID: <1505896116-43310-2-git-send-email-yesanishhere@gmail.com>
References: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CA847267276
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 10:28:49 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id u18so1275487pgo.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 01:28:49 -0700 (PDT)
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

w_param_text[count] is freed in the wrong error path.
Fix it by shifting the outfree_w_param label.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..f51f613 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3907,9 +3907,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
 	devm_kfree(card->dev, link_name);
-outfree_w_param:
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
+outfree_w_param:
 	devm_kfree(card->dev, w_param_text);
 
 	return ret;
-- 
2.5.4 (Apple Git-61)
