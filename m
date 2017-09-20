From: yesanishhere@gmail.com
Subject: [Resend] [PATCH 4/4] ASoC: dapm: Remove the redundant
	check
Date: Wed, 20 Sep 2017 01:28:36 -0700
Message-ID: <1505896116-43310-5-git-send-email-yesanishhere@gmail.com>
References: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9160C267227
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 10:28:54 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id j16so1272788pga.2
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 01:28:54 -0700 (PDT)
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

Remove this redundant check, the check for
creating the control in the case of codec to codec
dai link is moved to snd_soc_dapm_new_pcm function.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3c493b3..fcad345 100644
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
2.5.4 (Apple Git-61)
