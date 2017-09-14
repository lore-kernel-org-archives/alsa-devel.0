From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] ASoC: topology: Fix a potential memory leak in 'soc_tplg_dapm_widget_denum_create()'
Date: Thu, 14 Sep 2017 22:44:24 +0200
Message-ID: <20170914204424.25464-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

If this sanity check fails, we must free the memory that has already been
allocated.

So we must go to 'err' as in the other error handling parth of this
function.

Fixes: 1a7dd6e2f192 ("ASoC: topology: Allow a widget to have multiple enum controls")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2499b54a57e8..01a50413c66f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1301,7 +1301,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		/* validate kcontrol */
 		if (strnlen(ec->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			return NULL;
+			goto err;
 
 		se = kzalloc(sizeof(*se), GFP_KERNEL);
 		if (se == NULL)
-- 
2.11.0
