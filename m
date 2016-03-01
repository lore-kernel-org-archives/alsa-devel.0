From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wl1273: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:22:37 +0900
Message-ID: <E1aaatR-000846-PM@finisterre>
References: <1456765684-5717-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A792655E3
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:03 +0100 (CET)
In-Reply-To: <1456765684-5717-6-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wl1273: Fix enum ctl accesses in a wrong type

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 154a0fddd4275aa93f4683705579a7d8ec3d177b Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:08:04 +0100
Subject: [PATCH] ASoC: wl1273: Fix enum ctl accesses in a wrong type

"Codec Mode" and "Audio Switch" ctls in wl1273 codec driver are enum,
while the current driver accesses wrongly via value.integer.value[].
They have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0
