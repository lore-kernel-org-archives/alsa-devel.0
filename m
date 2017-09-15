From: anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 4/4] ASoC: dapm: Remove the redundant check
Date: Thu, 14 Sep 2017 22:03:22 -0700
Message-ID: <CABCoZhAjqV=B7ouWuD8J_5ZKinisCy-w4WYA2+qNK57SThMrRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f68.google.com (mail-vk0-f68.google.com
 [209.85.213.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B334267276
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 07:03:23 +0200 (CEST)
Received: by mail-vk0-f68.google.com with SMTP id w23so327883vkw.3
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 22:03:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, perex@perex.cz, tiwai@suse.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
@@ -1032,10 +1032,6 @@ static int dapm_new_dai_link(struct
snd_soc_dapm_widget *w)
        struct snd_soc_dapm_context *dapm = w->dapm;
        struct snd_card *card = dapm->card->snd_card;

-       /* create control for links with > 1 config */
-       if (w->num_params <= 1)
-               return 0;
-
        /* add kcontrol */
        for (i = 0; i < w->num_kcontrols; i++) {
                kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
--
2.5.4 (Apple Git-61)
