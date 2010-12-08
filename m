From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: [PATCH] ASoC: fix deemphasis control in wm8904/55/60
	codecs
Date: Wed,  8 Dec 2010 23:36:17 +0300
Message-ID: <1291840577-23908-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.mail.ru (smtp3.mail.ru [94.100.176.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C6A024433
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 21:36:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Deemphasis control's .get callback should update control's value instead
of returning it - return value of callback function is used for indicating
error or success of operation.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
I discovered this while trying to adapt this deemphasis code to ak4641 codec.

 sound/soc/codecs/wm8904.c |    3 ++-
 sound/soc/codecs/wm8955.c |    3 ++-
 sound/soc/codecs/wm8960.c |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index fca60a0..9001cc4 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -818,7 +818,8 @@ static int wm8904_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
-	return wm8904->deemph;
+	ucontrol->value.enumerated.item[0] = wm8904->deemph;
+	return 0;
 }
 
 static int wm8904_put_deemph(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index f89ad6c..9cbab8e 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -380,7 +380,8 @@ static int wm8955_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
 
-	return wm8955->deemph;
+	ucontrol->value.enumerated.item[0] = wm8955->deemph;
+	return 0;
 }
 
 static int wm8955_put_deemph(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8d5efb3..21986c4 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -138,7 +138,8 @@ static int wm8960_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 
-	return wm8960->deemph;
+	ucontrol->value.enumerated.item[0] = wm8960->deemph;
+	return 0;
 }
 
 static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
-- 
1.7.0.4
