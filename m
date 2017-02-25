From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] ASoC: es8328: Remove extra blank lines
Date: Sat, 25 Feb 2017 12:42:08 +0200
Message-ID: <1488019328-9481-1-git-send-email-narcisaanamaria12@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, john@metanate.com, romain.perier@collabora.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 sound/soc/codecs/es8328.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 3f84fbd..1967157 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -177,8 +177,6 @@ static int es8328_put_deemph(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-
-
 static const struct snd_kcontrol_new es8328_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Capture Digital Volume",
 		ES8328_ADCCONTROL8, ES8328_ADCCONTROL9,
-- 
1.9.1
