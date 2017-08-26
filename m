From: anish kumar <yesanishhere@gmail.com>
Subject: [patch 4/4] ASoC: dapm: Remove the redundant check
Date: Sat, 26 Aug 2017 01:30:04 -0700
Message-ID: <20170826083004.35610-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 855CB2678E8
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 10:30:08 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id t3so2402277pgt.5
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 01:30:08 -0700 (PDT)
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

Remove this redundant check, the check for
creating the control in the case of codec to codec
dai link is moved to snd_soc_dapm_new_pcm function.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5d792dc..3ecaad0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1032,10 +1032,6 @@ static int dapm_new_dai_link(struct snd_soc_dapm_widget *w)
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_card *card = dapm->card->snd_card;
 
-	/* create control for links with > 1 config */
-	if (w->num_params <= 1)
-		return 0;
-
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
-- 
2.10.1 (Apple Git-78)
