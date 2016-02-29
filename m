From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ASoC: wl1273: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:08:04 +0100
Message-ID: <1456765684-5717-6-git-send-email-tiwai@suse.de>
References: <1456765684-5717-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A99C726149E
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:08:06 +0100 (CET)
In-Reply-To: <1456765684-5717-1-git-send-email-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"Codec Mode" and "Audio Switch" ctls in wl1273 codec driver are enum,
while the current driver accesses wrongly via value.integer.value[].
They have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wl1273.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 7693c1129bab..1b79778098d2 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -175,7 +175,7 @@ static int snd_wl1273_get_audio_route(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = wl1273->mode;
+	ucontrol->value.enumerated.item[0] = wl1273->mode;
 
 	return 0;
 }
@@ -193,18 +193,17 @@ static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
-	if (wl1273->mode == ucontrol->value.integer.value[0])
+	if (wl1273->mode == ucontrol->value.enumerated.item[0])
 		return 0;
 
 	/* Do not allow changes while stream is running */
 	if (snd_soc_codec_is_active(codec))
 		return -EPERM;
 
-	if (ucontrol->value.integer.value[0] < 0 ||
-	    ucontrol->value.integer.value[0] >=  ARRAY_SIZE(wl1273_audio_route))
+	if (ucontrol->value.enumerated.item[0] >=  ARRAY_SIZE(wl1273_audio_route))
 		return -EINVAL;
 
-	wl1273->mode = ucontrol->value.integer.value[0];
+	wl1273->mode = ucontrol->value.enumerated.item[0];
 
 	return 1;
 }
@@ -219,7 +218,7 @@ static int snd_wl1273_fm_audio_get(struct snd_kcontrol *kcontrol,
 
 	dev_dbg(codec->dev, "%s: enter.\n", __func__);
 
-	ucontrol->value.integer.value[0] = wl1273->core->audio_mode;
+	ucontrol->value.enumerated.item[0] = wl1273->core->audio_mode;
 
 	return 0;
 }
@@ -233,7 +232,7 @@ static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,
 
 	dev_dbg(codec->dev, "%s: enter.\n", __func__);
 
-	val = ucontrol->value.integer.value[0];
+	val = ucontrol->value.enumerated.item[0];
 	if (wl1273->core->audio_mode == val)
 		return 0;
 
-- 
2.7.2
