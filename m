From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/3] sound/soc/soc-core.c: drop kfree of devm_kzalloc's data
Date: Sat,  8 Dec 2012 19:01:20 +0100
Message-ID: <1354989680-25794-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, matthias@kaehlcke.net
Cc: kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Using kfree to free data allocated with devm_kzalloc causes double frees.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x = devm_kzalloc(...)
...
?-kfree(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The kfrees were introduced in b761c0ca.
I sent this a few months ago, and I still think it should be applied...

 sound/soc/soc-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f81c597..86d7a36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4136,7 +4136,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"Property '%s' index %d could not be read: %d\n",
 				propname, 2 * i, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 		ret = of_property_read_string_index(np, propname,
@@ -4145,7 +4144,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"Property '%s' index %d could not be read: %d\n",
 				propname, (2 * i) + 1, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 	}
