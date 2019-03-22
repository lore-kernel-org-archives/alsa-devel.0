From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Subject: [PATCH] ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai
Date: Fri, 22 Mar 2019 21:53:39 +0530
Message-ID: <1553271819-24576-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, pankaj.laxminarayan.bharadiya@intel.com
List-Id: alsa-devel@alsa-project.org

In case of single config, private_value is left uninitialized.

The private_value does need to be initialized or in
snd_soc_dapm_new_control_unlocked() call failure case, it leads to a
bogus free in snd_soc_dapm_free_kcontrol()

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 67b032c..665a6b1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4042,7 +4042,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
 	const char **w_param_text;
-	unsigned long private_value;
+	unsigned long private_value = 0;
 	char *link_name;
 	int ret;
 
-- 
2.7.4
