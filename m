From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/10] soc - Convert Wolfson codec drivers to
	use bulk DAPM registration
Date: Tue, 13 May 2008 12:40:09 +0100
Message-ID: <1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37D6F24AE4
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |   16 ++++------------
 sound/soc/codecs/wm8750.c |   16 ++++------------
 sound/soc/codecs/wm8753.c |   17 ++++-------------
 sound/soc/codecs/wm9712.c |   17 ++++-------------
 sound/soc/codecs/wm9713.c |   15 ++++-----------
 5 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0cf9265..006923b 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -193,7 +193,7 @@ SND_SOC_DAPM_INPUT("RLINEIN"),
 SND_SOC_DAPM_INPUT("LLINEIN"),
 };
 
-static const char *intercon[][3] = {
+static const struct snd_soc_dapm_route intercon[] = {
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
@@ -214,22 +214,14 @@ static const char *intercon[][3] = {
 	{"Line Input", NULL, "LLINEIN"},
 	{"Line Input", NULL, "RLINEIN"},
 	{"Mic Bias", NULL, "MICIN"},
-
-	/* terminator */
-	{NULL, NULL, NULL},
 };
 
 static int wm8731_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8731_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
+				  ARRAY_SIZE(wm8731_dapm_widgets));
 
-	/* set up audio path interconnects */
-	for (i = 0; intercon[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, intercon[i][0],
-			intercon[i][1], intercon[i][2]);
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 16cd5d4..9c7b0e8 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -378,7 +378,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("RINPUT3"),
 };
 
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* left mixer */
 	{"Left Mixer", "Playback Switch", "Left DAC"},
 	{"Left Mixer", "Left Bypass Switch", "Left Line Mux"},
@@ -470,22 +470,14 @@ static const char *audio_map[][3] = {
 	/* ADC */
 	{"Left ADC", NULL, "Left ADC Mux"},
 	{"Right ADC", NULL, "Right ADC Mux"},
-
-	/* terminator */
-	{NULL, NULL, NULL},
 };
 
 static int wm8750_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8750_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+				  ARRAY_SIZE(wm8750_dapm_widgets));
 
-	/* set up audio path audio_mapnects */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index fb41826..2bc49ab 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -523,7 +523,7 @@ SND_SOC_DAPM_INPUT("MIC2"),
 SND_SOC_DAPM_VMID("VREF"),
 };
 
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* left mixer */
 	{"Left Mixer", "Left Playback Switch", "Left DAC"},
 	{"Left Mixer", "Voice Playback Switch", "Voice DAC"},
@@ -674,23 +674,14 @@ static const char *audio_map[][3] = {
 
 	/* ACOP */
 	{"ACOP", NULL, "ALC Mixer"},
-
-	/* terminator */
-	{NULL, NULL, NULL},
 };
 
 static int wm8753_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
+	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+				  ARRAY_SIZE(wm8753_dapm_widgets));
 
-	for (i = 0; i < ARRAY_SIZE(wm8753_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8753_dapm_widgets[i]);
-
-	/* set up the WM8753 audio map */
-	for (i = 0; audio_map[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
-	}
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d2d79e1..d205e6c 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -350,7 +350,7 @@ SND_SOC_DAPM_INPUT("MIC1"),
 SND_SOC_DAPM_INPUT("MIC2"),
 };
 
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* virtual mixer - mixes left & right channels for spk and mono */
 	{"AC97 Mixer", NULL, "Left DAC"},
 	{"AC97 Mixer", NULL, "Right DAC"},
@@ -446,23 +446,14 @@ static const char *audio_map[][3] = {
 	{"Speaker PGA", NULL, "Speaker Mux"},
 	{"LOUT2", NULL, "Speaker PGA"},
 	{"ROUT2", NULL, "Speaker PGA"},
-
-	{NULL, NULL, NULL},
 };
 
 static int wm9712_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
-
-	for(i = 0; i < ARRAY_SIZE(wm9712_dapm_widgets); i++) {
-		snd_soc_dapm_new_control(codec, &wm9712_dapm_widgets[i]);
-	}
+	snd_soc_dapm_new_controls(codec, wm9712_dapm_widgets,
+				  ARRAY_SIZE(wm9712_dapm_widgets));
 
-	/* set up audio path audio_mapnects */
-	for(i = 0; audio_map[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
-	}
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 1f24116..1d292e7 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -456,7 +456,7 @@ SND_SOC_DAPM_INPUT("MIC2B"),
 SND_SOC_DAPM_VMID("VMID"),
 };
 
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* left HP mixer */
 	{"Left HP Mixer", "PC Beep Playback Switch", "PCBEEP"},
 	{"Left HP Mixer", "Voice Playback Switch",   "Voice DAC"},
@@ -607,21 +607,14 @@ static const char *audio_map[][3] = {
 	{"Capture Mono Mux", "Stereo", "Capture Mixer"},
 	{"Capture Mono Mux", "Left", "Left Capture Source"},
 	{"Capture Mono Mux", "Right", "Right Capture Source"},
-
-	{NULL, NULL, NULL},
 };
 
 static int wm9713_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm9713_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm9713_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm9713_dapm_widgets,
+				  ARRAY_SIZE(wm9713_dapm_widgets));
 
-	/* set up audio path audio_mapnects */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
-- 
1.5.5.1
