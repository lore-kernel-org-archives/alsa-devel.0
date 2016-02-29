From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: dapm: Fix ctl value accesses in a wrong
	type
Date: Mon, 29 Feb 2016 17:20:48 +0100
Message-ID: <1456762848-2837-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F52265467
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:20:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_dai_link_get() and _put() access the associated ctl
values as value.integer.value[].  However, this is an enum ctl, and it
has to be accessed via value.enumerated.item[].  The former is long
while the latter is unsigned int, so they don't align.

Fixes: c66150824b8a ('ASoC: dapm: add code to configure dai link parameters')
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0d3707987900..581175a51ecf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3573,7 +3573,7 @@ static int snd_soc_dapm_dai_link_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = w->params_select;
+	ucontrol->value.enumerated.item[0] = w->params_select;
 
 	return 0;
 }
@@ -3587,13 +3587,13 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	if (w->power)
 		return -EBUSY;
 
-	if (ucontrol->value.integer.value[0] == w->params_select)
+	if (ucontrol->value.enumerated.item[0] == w->params_select)
 		return 0;
 
-	if (ucontrol->value.integer.value[0] >= w->num_params)
+	if (ucontrol->value.enumerated.item[0] >= w->num_params)
 		return -EINVAL;
 
-	w->params_select = ucontrol->value.integer.value[0];
+	w->params_select = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
-- 
2.7.2
