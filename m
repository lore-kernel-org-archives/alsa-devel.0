From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: spitz - Fix kcontrols to use card
	instead of codec.
Date: Thu, 16 Feb 2012 12:00:23 +0000
Message-ID: <1329393623-28816-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A98624518
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 13:00:30 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hq7so1580979wib.34
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 04:00:28 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Machine kcontrols now use card instead of codec for thier "chip".

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/pxa/spitz.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 90c5245..4d108dc 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -44,9 +44,9 @@ static int spitz_jack_func;
 static int spitz_spk_func;
 static int spitz_mic_gpio;
 
-static void spitz_ext_control(struct snd_soc_codec *codec)
+static void spitz_ext_control(struct snd_soc_card *card)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 
 	if (spitz_spk_func == SPITZ_SPK_ON)
 		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
@@ -173,13 +173,13 @@ static int spitz_get_jack(struct snd_kcontrol *kcontrol,
 static int spitz_set_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
 	if (spitz_jack_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	spitz_jack_func = ucontrol->value.integer.value[0];
-	spitz_ext_control(codec);
+	spitz_ext_control(card);
 	return 1;
 }
 
@@ -193,13 +193,13 @@ static int spitz_get_spk(struct snd_kcontrol *kcontrol,
 static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
 	if (spitz_spk_func == ucontrol->value.integer.value[0])
 		return 0;
 
 	spitz_spk_func = ucontrol->value.integer.value[0];
-	spitz_ext_control(codec);
+	spitz_ext_control(card);
 	return 1;
 }
 
-- 
1.7.5.4
