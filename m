From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RFC PATCH 1/2] ASoC: core: Print one-time messages if missing resources when binding DAIs
Date: Wed, 19 Oct 2016 14:21:05 -0300
Message-ID: <1476897666-13974-2-git-send-email-javier@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

If snd_soc_find_dai() doesn't find a DAI in soc_bind_dai_link(), a
error message is printed and an -EPROBE_DEFER errno code returned to
the caller.

But since many probe retries can happen before a resource is available,
the printed messages can spam the kernel log buffer and slow the boot.

The information is useful to know that a dependency was not meet and a
defer happened, but isn't necessary to print it on each probe deferral.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 sound/soc/soc-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd903261..4679c07e0ff6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1013,8 +1013,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
 	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
 	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
-			dai_link->cpu_dai_name);
+		dev_err_once(card->dev, "ASoC: CPU DAI %s not registered\n",
+			     dai_link->cpu_dai_name);
 		goto _err_defer;
 	}
 
@@ -1025,8 +1025,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				codecs[i].dai_name);
+			dev_err_once(card->dev,
+				     "ASoC: CODEC DAI %s not registered\n",
+				     codecs[i].dai_name);
 			goto _err_defer;
 		}
 	}
@@ -1054,8 +1055,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		rtd->platform = platform;
 	}
 	if (!rtd->platform) {
-		dev_err(card->dev, "ASoC: platform %s not registered\n",
-			dai_link->platform_name);
+		dev_err_once(card->dev, "ASoC: platform %s not registered\n",
+			     dai_link->platform_name);
 		goto _err_defer;
 	}
 
-- 
2.7.4
