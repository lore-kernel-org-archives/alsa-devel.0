From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Change spitz_ext_control to take dapm as
	argument.
Date: Fri, 17 Feb 2012 16:15:56 +0800
Message-ID: <1329466556.21113.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AD501103B0E
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 09:16:06 +0100 (CET)
Received: by dady9 with SMTP id y9so3161467dad.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 00:16:04 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This fixes below build warning:
  CC      sound/soc/pxa/spitz.o
sound/soc/pxa/spitz.c: In function 'spitz_startup':
sound/soc/pxa/spitz.c:116: warning: passing argument 1 of 'spitz_ext_control' from incompatible pointer type
sound/soc/pxa/spitz.c:47: note: expected 'struct snd_soc_card *' but argument is of type 'struct snd_soc_codec *'

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/spitz.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 4d108dc..fc052d8 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -44,10 +44,8 @@ static int spitz_jack_func;
 static int spitz_spk_func;
 static int spitz_mic_gpio;
 
-static void spitz_ext_control(struct snd_soc_card *card)
+static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &card->dapm;
-
 	if (spitz_spk_func == SPITZ_SPK_ON)
 		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
@@ -113,7 +111,7 @@ static int spitz_startup(struct snd_pcm_substream *substream)
 	mutex_lock(&codec->mutex);
 
 	/* check the jack status at stream startup */
-	spitz_ext_control(codec);
+	spitz_ext_control(&codec->dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -179,7 +177,7 @@ static int spitz_set_jack(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	spitz_jack_func = ucontrol->value.integer.value[0];
-	spitz_ext_control(card);
+	spitz_ext_control(&card->dapm);
 	return 1;
 }
 
@@ -193,13 +191,13 @@ static int spitz_get_spk(struct snd_kcontrol *kcontrol,
 static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (spitz_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	spitz_spk_func = ucontrol->value.integer.value[0];
-	spitz_ext_control(card);
+	spitz_ext_control(&card->dapm);
 	return 1;
 }
 
-- 
1.7.5.4
