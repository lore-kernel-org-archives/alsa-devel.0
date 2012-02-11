From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 07/12] ASoC: alc5632: Add DMIC switches and
	controls
Date: Sat, 11 Feb 2012 23:26:33 +0200
Message-ID: <1328995598-8788-8-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00EB0103A99
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:27:02 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1256798eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:27:02 -0800 (PST)
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

Add DMIC switches and controls to ALC5632 codec.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index b1e9af4..b6b95c8 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -196,8 +196,12 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 			ALC5632_MIC_CTRL, 10, 2, 0, boost_tlv),
 	SOC_SINGLE_TLV("Mic 2 Boost Volume",
 			ALC5632_MIC_CTRL, 8, 2, 0, boost_tlv),
-	SOC_SINGLE_TLV("Digital Boost Volume",
+	SOC_SINGLE_TLV("DMIC Boost Volume",
 			ALC5632_DIGI_BOOST_CTRL, 0, 7, 0, dig_tlv),
+	SOC_SINGLE("DMIC En Capture Switch",
+			ALC5632_DIGI_BOOST_CTRL, 15, 1, 0),
+	SOC_SINGLE("DMIC PreFilter Capture Switch",
+			ALC5632_DIGI_BOOST_CTRL, 12, 1, 0),
 };
 
 /*
@@ -266,6 +270,14 @@ SOC_DAPM_SINGLE("SPK2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 1, 1, 1),
 SOC_DAPM_SINGLE("MONO2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 0, 1, 1),
 };
 
+/* Dmic Mixer */
+static const struct snd_kcontrol_new alc5632_dmicl_mixer_controls[] = {
+SOC_DAPM_SINGLE("DMICL2ADC Capture Switch", ALC5632_DIGI_BOOST_CTRL, 7, 1, 1),
+};
+static const struct snd_kcontrol_new alc5632_dmicr_mixer_controls[] = {
+SOC_DAPM_SINGLE("DMICR2ADC Capture Switch", ALC5632_DIGI_BOOST_CTRL, 6, 1, 1),
+};
+
 static const char * const alc5632_spk_n_sour_sel[] = {
 		"RN/-R", "RP/+R", "LN/-R", "Mute"};
 static const char * const alc5632_hpl_out_input_sel[] = {
@@ -364,6 +376,12 @@ SND_SOC_DAPM_MIXER("Mono Mix", ALC5632_PWR_MANAG_ADD2, 2, 0,
 SND_SOC_DAPM_MIXER("Speaker Mix", ALC5632_PWR_MANAG_ADD2, 3, 0,
 	&alc5632_speaker_mixer_controls[0],
 	ARRAY_SIZE(alc5632_speaker_mixer_controls)),
+SND_SOC_DAPM_MIXER("DMICL Mix", SND_SOC_NOPM, 0, 0,
+	&alc5632_dmicl_mixer_controls[0],
+	ARRAY_SIZE(alc5632_dmicl_mixer_controls)),
+SND_SOC_DAPM_MIXER("DMICR Mix", SND_SOC_NOPM, 0, 0,
+	&alc5632_dmicr_mixer_controls[0],
+	ARRAY_SIZE(alc5632_dmicr_mixer_controls)),
 
 /* input mixers */
 SND_SOC_DAPM_MIXER("Left Capture Mix", ALC5632_PWR_MANAG_ADD2, 1, 0,
@@ -538,12 +556,14 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 
 	/* left ADC */
 	{"Left ADC", NULL,				"Left Capture Mix"},
-	{"Left ADC", NULL,				"DMICDAT"},
+	{"DMICL Mix", "DMICL2ADC Capture Switch", "DMICDAT"},
+	{"Left ADC", NULL,				"DMICL Mix"},
 	{"ADCLR", NULL,					"Left ADC"},
 
 	/* right ADC */
 	{"Right ADC", NULL, "Right Capture Mix"},
-	{"Right ADC", NULL, "DMICDAT"},
+	{"DMICR Mix", "DMICR2ADC Capture Switch", "DMICDAT"},
+	{"Right ADC", NULL, "DMICR Mix"},
 	{"ADCR Mux", "Stereo ADC", "Right ADC"},
 	{"ADCR Mux", "Voice ADC", "Right ADC"},
 	{"ADCLR", NULL, "ADCR Mux"},
-- 
1.7.3.4
