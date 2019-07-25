Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from sonic308-47.consmr.mail.sg3.yahoo.com
 (sonic308-47.consmr.mail.sg3.yahoo.com [106.10.241.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEDC7F800E8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 18:17:26 +0200 (CEST)
From: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
Date: Thu, 25 Jul 2019 21:43:35 +0530
Message-Id: <20190725161335.4162-1-thakursatendra2003@yahoo.co.in>
Subject: [alsa-devel] [PATCH] [ASoC][soc-dapm] : memory leak in the func
	snd_soc_dapm_new_dai
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
List-ID: <alsa-devel@alsa-project.org>

In the func snd_soc_dapm_new_dai, if the inner func
snd_soc_dapm_alloc_kcontrol fails, there will be memory leak.
The label param_fail wont free memory which is allocated by
the func devm_kcalloc. Hence new label is created for this purpose.

Signed-off-by: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f013b24c050a..f62d41ee6d68 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4095,7 +4095,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 						w_param_text, &private_value);
 		if (!template.kcontrol_news) {
 			ret = -ENOMEM;
-			goto param_fail;
+			goto outfree_w_param;
 		}
 	} else {
 		w_param_text = NULL;
@@ -4114,6 +4114,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
+outfree_w_param:
 	snd_soc_dapm_free_kcontrol(card, &private_value,
 				   rtd->dai_link->num_params, w_param_text);
 param_fail:
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
