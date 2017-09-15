From: anish kumar <yesanishhere@gmail.com>
Subject: Resend: [PATCH 1/4] ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm
Date: Thu, 14 Sep 2017 22:02:17 -0700
Message-ID: <CABCoZhCST2kbTNT4BpwniipkaD=dGB5Jb0WFw6QckUaJYxMKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F105C267239
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 07:02:19 +0200 (CEST)
Received: by mail-ua0-f194.google.com with SMTP id k23so378473uaf.3
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 22:02:19 -0700 (PDT)
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

Before freeing the memory, check if it was allcoated.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..f51f613 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3907,9 +3907,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
        devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
        devm_kfree(card->dev, link_name);
-outfree_w_param:
        for (count = 0 ; count < num_params; count++)
                devm_kfree(card->dev, (void *)w_param_text[count]);
+outfree_w_param:
        devm_kfree(card->dev, w_param_text);

        return ret;
--
2.5.4 (Apple Git-61)
