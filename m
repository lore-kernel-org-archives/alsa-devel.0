From: anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 2/4] ASoC: dapm: Refactor the code in
	snd_soc_dapm_new_pcm
Date: Thu, 14 Sep 2017 22:02:40 -0700
Message-ID: <CABCoZhB7MJ=nvq_CAskJMfk6R9nt1uQ7EZ+szRz2bpbb6vGUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C90C26727C
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 07:02:41 +0200 (CEST)
Received: by mail-ua0-f194.google.com with SMTP id s15so383744uag.0
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 22:02:41 -0700 (PDT)
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

refactor snd_soc_dapm_new_pcm to reduce the size of
this function to facilitate further refactoring.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f51f613..d55cac6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3821,19 +3821,15 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
                                devm_kasprintf(card->dev, GFP_KERNEL,
                                               "Anonymous Configuration %d",
                                               count);
-                       if (!w_param_text[count]) {
-                               ret = -ENOMEM;
-                               goto outfree_link_name;
-                       }
                } else {
                        w_param_text[count] = devm_kmemdup(card->dev,
                                                config->stream_name,
                                                strlen(config->stream_name) + 1,
                                                GFP_KERNEL);
-                       if (!w_param_text[count]) {
-                               ret = -ENOMEM;
-                               goto outfree_link_name;
-                       }
+               }
+               if (!w_param_text[count]) {
+                       ret = -ENOMEM;
+                       goto outfree_link_name;
                }
                config++;
        }
--
2.5.4 (Apple Git-61)
