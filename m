From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: da732x: Fix enum ctl accesses in a wrong
	type
Date: Mon, 29 Feb 2016 18:04:42 +0100
Message-ID: <1456765482-5599-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 37BA8266520
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:04:45 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

"DAC1 High Pass Filter Mode" & co in da732x codec driver are enum,
while the current driver accesses wrongly via value.integer.value[].
They have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

like other patchsets, I didn't put Cc to stable.  If this driver is
used for 64bit archs, feel free to put Cc to stable.

 sound/soc/codecs/da732x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 1d5a89c5164b..461506a4ca6a 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -334,7 +334,7 @@ static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
-	unsigned int sel = ucontrol->value.integer.value[0];
+	unsigned int sel = ucontrol->value.enumerated.item[0];
 	unsigned int bits;
 
 	switch (sel) {
@@ -368,13 +368,13 @@ static int da732x_hpf_get(struct snd_kcontrol *kcontrol,
 
 	switch (val) {
 	case DA732X_HPF_VOICE_EN:
-		ucontrol->value.integer.value[0] = DA732X_HPF_VOICE;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_VOICE;
 		break;
 	case DA732X_HPF_MUSIC_EN:
-		ucontrol->value.integer.value[0] = DA732X_HPF_MUSIC;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_MUSIC;
 		break;
 	default:
-		ucontrol->value.integer.value[0] = DA732X_HPF_DISABLED;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_DISABLED;
 		break;
 	}
 
-- 
2.7.2
