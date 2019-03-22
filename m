From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol
Date: Fri, 22 Mar 2019 18:00:09 +0530
Message-ID: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, pankaj.laxminarayan.bharadiya@intel.com
List-Id: alsa-devel@alsa-project.org

w_text_param can be NULL and it is being dereferenced without checking.
Add the missing sanity check to prevent  NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 sound/soc/soc-dapm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef..67b032c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3957,6 +3957,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 	int count;
 
 	devm_kfree(card->dev, (void *)*private_value);
+
+	if (!w_param_text)
+		return;
+
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
 	devm_kfree(card->dev, w_param_text);
-- 
2.7.4
