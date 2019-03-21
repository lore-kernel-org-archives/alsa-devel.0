From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_new_dai
Date: Thu, 21 Mar 2019 15:41:25 +0530
Message-ID: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, pankaj.laxminarayan.bharadiya@intel.com
List-Id: alsa-devel@alsa-project.org

In case of single config, w_param_text is NULL.
In snd_soc_dapm_new_control_unlocked() call failure case, it will end
up calling snd_soc_dapm_free_kcontrol() unconditionally and result in
NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 sound/soc/soc-dapm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef..ba6cb37 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4094,8 +4094,9 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
-	snd_soc_dapm_free_kcontrol(card, &private_value,
-				   rtd->dai_link->num_params, w_param_text);
+	if (w_param_text)
+		snd_soc_dapm_free_kcontrol(card, &private_value,
+				rtd->dai_link->num_params, w_param_text);
 param_fail:
 	devm_kfree(card->dev, link_name);
 	return ERR_PTR(ret);
-- 
2.7.4
