From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/14] ASoC: wm2000: Fix wrong value references
	for boolean kctl
Date: Tue, 10 Mar 2015 12:39:09 +0100
Message-ID: <1425987556-569-8-git-send-email-tiwai@suse.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0383A261569
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
 sound/soc/codecs/wm2000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 8d9de49a5052..21d5402e343f 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -610,7 +610,7 @@ static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
-	ucontrol->value.enumerated.item[0] = wm2000->anc_active;
+	ucontrol->value.integer.value[0] = wm2000->anc_active;
 
 	return 0;
 }
@@ -620,7 +620,7 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int anc_active = ucontrol->value.enumerated.item[0];
+	int anc_active = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (anc_active > 1)
@@ -643,7 +643,7 @@ static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
-	ucontrol->value.enumerated.item[0] = wm2000->spk_ena;
+	ucontrol->value.integer.value[0] = wm2000->spk_ena;
 
 	return 0;
 }
@@ -653,7 +653,7 @@ static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int val = ucontrol->value.enumerated.item[0];
+	int val = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (val > 1)
-- 
2.3.2
