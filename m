From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/14] ASoC: wm9713: Fix wrong value references
	for boolean kctl
Date: Tue, 10 Mar 2015 12:39:16 +0100
Message-ID: <1425987556-569-15-git-send-email-tiwai@suse.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 124CC26170F
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 12:39:24 +0100 (CET)
In-Reply-To: <1425987556-569-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The correct values referred by a boolean control are
value.integer.value[], not value.enumerated.item[].
The former is long while the latter is int, so it's even incompatible
on 64bit architectures.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm9713.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 68222917b396..79552953e1bd 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -255,7 +255,7 @@ static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val = ucontrol->value.enumerated.item[0];
+	unsigned int val = ucontrol->value.integer.value[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, mask, shift, old;
@@ -268,7 +268,7 @@ static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&wm9713->lock);
 	old = wm9713->hp_mixer[mixer];
-	if (ucontrol->value.enumerated.item[0])
+	if (ucontrol->value.integer.value[0])
 		wm9713->hp_mixer[mixer] |= mask;
 	else
 		wm9713->hp_mixer[mixer] &= ~mask;
@@ -306,7 +306,7 @@ static int wm9713_hp_mixer_get(struct snd_kcontrol *kcontrol,
 	mixer = mc->shift >> 8;
 	shift = mc->shift & 0xff;
 
-	ucontrol->value.enumerated.item[0] =
+	ucontrol->value.integer.value[0] =
 		(wm9713->hp_mixer[mixer] >> shift) & 1;
 
 	return 0;
-- 
2.3.2
