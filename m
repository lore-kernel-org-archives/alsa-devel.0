From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 04/12] ASoC: alc5632: Rename capture
	switches to common scheme XXX2REC
Date: Sat, 11 Feb 2012 23:26:30 +0200
Message-ID: <1328995598-8788-5-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D4E61039F1
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:26:56 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1256798eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:26:56 -0800 (PST)
In-Reply-To: <1328995598-8788-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Rename capture switches to common scheme XXX2REC.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   56 ++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 6bb6075..d56218f 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -246,24 +246,24 @@ SOC_DAPM_SINGLE("VOICE2SPK Playback Switch", ALC5632_VOICE_DAC_VOL, 14, 1, 1),
 
 /* Left Record Mixer */
 static const struct snd_kcontrol_new alc5632_captureL_mixer_controls[] = {
-SOC_DAPM_SINGLE("Mic1 Capture Switch", ALC5632_ADC_REC_MIXER, 14, 1, 1),
-SOC_DAPM_SINGLE("Mic2 Capture Switch", ALC5632_ADC_REC_MIXER, 13, 1, 1),
-SOC_DAPM_SINGLE("LineInL Capture Switch", ALC5632_ADC_REC_MIXER, 12, 1, 1),
-SOC_DAPM_SINGLE("Left Phone Capture Switch", ALC5632_ADC_REC_MIXER, 11, 1, 1),
-SOC_DAPM_SINGLE("HPMixerL Capture Switch", ALC5632_ADC_REC_MIXER, 10, 1, 1),
-SOC_DAPM_SINGLE("SPKMixer Capture Switch", ALC5632_ADC_REC_MIXER, 9, 1, 1),
-SOC_DAPM_SINGLE("MonoMixer Capture Switch", ALC5632_ADC_REC_MIXER, 8, 1, 1),
+SOC_DAPM_SINGLE("MIC12REC_L Capture Switch", ALC5632_ADC_REC_MIXER, 14, 1, 1),
+SOC_DAPM_SINGLE("MIC22REC_L Capture Switch", ALC5632_ADC_REC_MIXER, 13, 1, 1),
+SOC_DAPM_SINGLE("LIL2REC Capture Switch", ALC5632_ADC_REC_MIXER, 12, 1, 1),
+SOC_DAPM_SINGLE("PH2REC_L Capture Switch", ALC5632_ADC_REC_MIXER, 11, 1, 1),
+SOC_DAPM_SINGLE("HPL2REC Capture Switch", ALC5632_ADC_REC_MIXER, 10, 1, 1),
+SOC_DAPM_SINGLE("SPK2REC_L Capture Switch", ALC5632_ADC_REC_MIXER, 9, 1, 1),
+SOC_DAPM_SINGLE("MONO2REC_L Capture Switch", ALC5632_ADC_REC_MIXER, 8, 1, 1),
 };
 
 /* Right Record Mixer */
 static const struct snd_kcontrol_new alc5632_captureR_mixer_controls[] = {
-SOC_DAPM_SINGLE("Mic1 Capture Switch", ALC5632_ADC_REC_MIXER, 6, 1, 1),
-SOC_DAPM_SINGLE("Mic2 Capture Switch", ALC5632_ADC_REC_MIXER, 5, 1, 1),
-SOC_DAPM_SINGLE("LineInR Capture Switch", ALC5632_ADC_REC_MIXER, 4, 1, 1),
-SOC_DAPM_SINGLE("Right Phone Capture Switch", ALC5632_ADC_REC_MIXER, 3, 1, 1),
-SOC_DAPM_SINGLE("HPMixerR Capture Switch", ALC5632_ADC_REC_MIXER, 2, 1, 1),
-SOC_DAPM_SINGLE("SPKMixer Capture Switch", ALC5632_ADC_REC_MIXER, 1, 1, 1),
-SOC_DAPM_SINGLE("MonoMixer Capture Switch", ALC5632_ADC_REC_MIXER, 0, 1, 1),
+SOC_DAPM_SINGLE("MIC12REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 6, 1, 1),
+SOC_DAPM_SINGLE("MIC22REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 5, 1, 1),
+SOC_DAPM_SINGLE("LIR2REC Capture Switch", ALC5632_ADC_REC_MIXER, 4, 1, 1),
+SOC_DAPM_SINGLE("PH2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 3, 1, 1),
+SOC_DAPM_SINGLE("HPR2REC Capture Switch", ALC5632_ADC_REC_MIXER, 2, 1, 1),
+SOC_DAPM_SINGLE("SPK2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 1, 1, 1),
+SOC_DAPM_SINGLE("MONO2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 0, 1, 1),
 };
 
 static const char *alc5632_spk_n_sour_sel[] = {
@@ -449,22 +449,22 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Mono Mix", "DAC2MONO Playback Switch",	"DAC Left Channel"},
 
 	/* Left record mixer */
-	{"Left Capture Mix", "LineInL Capture Switch",	"LINEINL"},
-	{"Left Capture Mix", "Left Phone Capture Switch", "PHONEN"},
-	{"Left Capture Mix", "Mic1 Capture Switch",	"MIC1 Pre Amp"},
-	{"Left Capture Mix", "Mic2 Capture Switch",	"MIC2 Pre Amp"},
-	{"Left Capture Mix", "HPMixerL Capture Switch", "HPL Mix"},
-	{"Left Capture Mix", "SPKMixer Capture Switch", "Speaker Mix"},
-	{"Left Capture Mix", "MonoMixer Capture Switch", "Mono Mix"},
+	{"Left Capture Mix", "LIL2REC Capture Switch", "LINEINL"},
+	{"Left Capture Mix", "PH2REC_L Capture Switch", "PHONEN"},
+	{"Left Capture Mix", "MIC12REC_L Capture Switch", "MIC1 Pre Amp"},
+	{"Left Capture Mix", "MIC22REC_L Capture Switch", "MIC2 Pre Amp"},
+	{"Left Capture Mix", "HPL2REC Capture Switch", "HPL Mix"},
+	{"Left Capture Mix", "SPK2REC_L Capture Switch", "Speaker Mix"},
+	{"Left Capture Mix", "MONO2REC_L Capture Switch", "Mono Mix"},
 
 	/*Right record mixer */
-	{"Right Capture Mix", "LineInR Capture Switch",	"LINEINR"},
-	{"Right Capture Mix", "Right Phone Capture Switch",	"PHONEP"},
-	{"Right Capture Mix", "Mic1 Capture Switch",	"MIC1 Pre Amp"},
-	{"Right Capture Mix", "Mic2 Capture Switch",	"MIC2 Pre Amp"},
-	{"Right Capture Mix", "HPMixerR Capture Switch", "HPR Mix"},
-	{"Right Capture Mix", "SPKMixer Capture Switch", "Speaker Mix"},
-	{"Right Capture Mix", "MonoMixer Capture Switch", "Mono Mix"},
+	{"Right Capture Mix", "LIR2REC Capture Switch", "LINEINR"},
+	{"Right Capture Mix", "PH2REC_R Capture Switch", "PHONEP"},
+	{"Right Capture Mix", "MIC12REC_R Capture Switch", "MIC1 Pre Amp"},
+	{"Right Capture Mix", "MIC22REC_R Capture Switch", "MIC2 Pre Amp"},
+	{"Right Capture Mix", "HPR2REC Capture Switch", "HPR Mix"},
+	{"Right Capture Mix", "SPK2REC_R Capture Switch", "Speaker Mix"},
+	{"Right Capture Mix", "MONO2REC_R Capture Switch", "Mono Mix"},
 
 	/* headphone left mux */
 	{"Left Headphone Mux", "HP Left Mix",		"HPL Mix"},
-- 
1.7.3.4
