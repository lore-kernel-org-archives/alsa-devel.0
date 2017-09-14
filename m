From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] ASoC: topology: Fix a potential NULL pointer dereference in 'soc_tplg_dapm_widget_denum_create()'
Date: Thu, 14 Sep 2017 22:44:12 +0200
Message-ID: <20170914204412.25413-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

if 'se = kzalloc()' fails in the 'for' loop, we will branch to 'err'.
But in this case, 'kc[i].private_value' will still be NULL. A NULL pointer
dereference will then occur is the error handling path.

In such a case, it is safe to just 'continue' in order to skip this entry
and free the other ones.

Fixes: 1a7dd6e2f192 ("ASoC: topology: Allow a widget to have multiple enum controls")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/soc-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index dd471d2c0266..2499b54a57e8 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1378,6 +1378,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 	for (; i >= 0; i--) {
 		/* free values and texts */
 		se = (struct soc_enum *)kc[i].private_value;
+		if (!se)
+			continue;
+
 		kfree(se->dobj.control.dvalues);
 		for (j = 0; j < ec->items; j++)
 			kfree(se->dobj.control.dtexts[j]);
-- 
2.11.0
