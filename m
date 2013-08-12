From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c: Avoid using ARRAY_AND_SIZE(e) as a function argument
Date: Mon, 12 Aug 2013 22:49:24 +0200
Message-ID: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, robert.jarzmik@free.fr
Cc: kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
arity of the called function.

At the suggestion of Robert Jarzmik, this additionally removes the
definition of ARRAY_AND_SIZE, which is not used elsewhere in the file.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,f;
@@

f(...,
- ARRAY_AND_SIZE(e)
+ e,ARRAY_SIZE(e)
  ,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.
v2 removes the definition of ARRAY_AND_SIZE.

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 97b711e..bbea778 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -56,8 +56,6 @@
 #include "pxa2xx-ac97.h"
 #include "../codecs/wm9713.h"
 
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
 #define AC97_GPIO_PULL		0x58
 
 /* Use GPIO8 for rear speaker amplifier */
@@ -133,10 +131,11 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	unsigned short reg;
 
 	/* Add mioa701 specific widgets */
-	snd_soc_dapm_new_controls(dapm, ARRAY_AND_SIZE(mioa701_dapm_widgets));
+	snd_soc_dapm_new_controls(dapm, mioa701_dapm_widgets,
+				  ARRAY_SIZE(mioa701_dapm_widgets));
 
 	/* Set up mioa701 specific audio path audio_mapnects */
-	snd_soc_dapm_add_routes(dapm, ARRAY_AND_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* Prepare GPIO8 for rear speaker amplifier */
 	reg = codec->driver->read(codec, AC97_GPIO_CFG);
