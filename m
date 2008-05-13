From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/10] soc - Zaurus - Convert to bulk DAPM
	registration APIs
Date: Tue, 13 May 2008 12:40:11 +0100
Message-ID: <1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD56424AED
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 sound/soc/pxa/corgi.c  |   12 ++++--------
 sound/soc/pxa/poodle.c |   14 +++++---------
 sound/soc/pxa/spitz.c  |   14 +++++---------
 sound/soc/pxa/tosa.c   |   14 ++++----------
 4 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 7f32a11..852f16d 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -247,7 +247,7 @@ SND_SOC_DAPM_HP("Headset Jack", NULL),
 };
 
 /* Corgi machine audio map (connections to the codec pins) */
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* headset Jack  - in = micin, out = LHPOUT*/
 	{"Headset Jack", NULL, "LHPOUT"},
@@ -265,8 +265,6 @@ static const char *audio_map[][3] = {
 
 	/* Same as the above but no mic bias for line signals */
 	{"MICIN", NULL, "Line Jack"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
@@ -303,13 +301,11 @@ static int corgi_wm8731_init(struct snd_soc_codec *codec)
 	}
 
 	/* Add corgi specific widgets */
-	for (i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8731_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
+				  ARRAY_SIZE(wm8731_dapm_widgets));
 
 	/* Set up corgi specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 7e830b2..810f1fe 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -215,8 +215,8 @@ SND_SOC_DAPM_HP("Headphone Jack", NULL),
 SND_SOC_DAPM_SPK("Ext Spk", poodle_amp_event),
 };
 
-/* Corgi machine audio_mapnections to the codec pins */
-static const char *audio_map[][3] = {
+/* Corgi machine connections to the codec pins */
+static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* headphone connected to LHPOUT1, RHPOUT1 */
 	{"Headphone Jack", NULL, "LHPOUT"},
@@ -225,8 +225,6 @@ static const char *audio_map[][3] = {
 	/* speaker connected to LOUT, ROUT */
 	{"Ext Spk", NULL, "ROUT"},
 	{"Ext Spk", NULL, "LOUT"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *jack_function[] = {"Off", "Headphone"};
@@ -263,13 +261,11 @@ static int poodle_wm8731_init(struct snd_soc_codec *codec)
 	}
 
 	/* Add poodle specific widgets */
-	for (i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8731_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
+				  ARRAY_SIZE(wm8731_dapm_widgets));
 
 	/* Set up poodle specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d8b8372..73a6df8 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -250,7 +250,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 };
 
 /* Spitz machine audio_map */
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* headphone connected to LOUT1, ROUT1 */
 	{"Headphone Jack", NULL, "LOUT1"},
@@ -269,8 +269,6 @@ static const char *audio_map[][3] = {
 
 	/* line is connected to input 1 - no bias */
 	{"LINPUT1", NULL, "Line Jack"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
@@ -313,13 +311,11 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	}
 
 	/* Add spitz specific widgets */
-	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8750_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+				  ARRAY_SIZE(wm8750_dapm_widgets));
 
-	/* Set up spitz specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	/* Set up spitz specific audio paths */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 7346d7e..fda2aa0 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -154,7 +154,7 @@ SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
 /* tosa audio map */
-static const char *audio_map[][3] = {
+static const snd_soc_dapm_route audio_map[] = {
 
 	/* headphone connected to HPOUTL, HPOUTR */
 	{"Headphone Jack", NULL, "HPOUTL"},
@@ -173,8 +173,6 @@ static const char *audio_map[][3] = {
 	{"Headset Jack", NULL, "HPOUTR"},
 	{"LINEINR", NULL, "Mic Bias"},
 	{"Mic Bias", NULL, "Headset Jack"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
@@ -208,15 +206,11 @@ static int tosa_ac97_init(struct snd_soc_codec *codec)
 	}
 
 	/* add tosa specific widgets */
-	for (i = 0; i < ARRAY_SIZE(tosa_dapm_widgets); i++) {
-		snd_soc_dapm_new_control(codec, &tosa_dapm_widgets[i]);
-	}
+	snd_soc_dapm_new_controls(codec, &tosa_dapm_widgets,
+				  ARRAY_SIZE(tosa_dapm_widgets));
 
 	/* set up tosa specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
-	}
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
-- 
1.5.5.1
