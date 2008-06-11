From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/10] ASoC: Add TLV information to remaining
	WM8753 controls
Date: Wed, 11 Jun 2008 13:47:12 +0100
Message-ID: <1213188435-1986-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D8D72481C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:18 +0200 (CEST)
In-Reply-To: <1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Montour <mail@mmontour.net>
List-Id: alsa-devel@alsa-project.org

From: Mike Montour <mail@mmontour.net>

Signed-off-by: Mike Montour <mail@mmontour.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |   75 ++++++++++++++++++++++++++++++---------------
 1 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 285c5ea..00b4811 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -260,28 +260,50 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
+static const DECLARE_TLV_DB_SCALE(rec_mix_tlv, -1500, 300, 0);
+static const DECLARE_TLV_DB_SCALE(mic_preamp_tlv, 1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
+static const unsigned int out_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	/* 0000000 - 0101111 = "Analogue mute" */
+	0, 48, TLV_DB_SCALE_ITEM(-25500, 0, 0),
+	48, 127, TLV_DB_SCALE_ITEM(-7300, 100, 0),
+};
+static const DECLARE_TLV_DB_SCALE(mix_tlv, -1500, 300, 0);
+static const DECLARE_TLV_DB_SCALE(voice_mix_tlv, -1200, 300, 0);
+static const DECLARE_TLV_DB_SCALE(pga_tlv, -1725, 75, 0);
 
 static const struct snd_kcontrol_new wm8753_snd_controls[] = {
-SOC_DOUBLE_R("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0),
-
-SOC_DOUBLE_R("ADC Capture Volume", WM8753_LADC, WM8753_RADC, 0, 255, 0),
-
-SOC_DOUBLE_R("Headphone Playback Volume", WM8753_LOUT1V, WM8753_ROUT1V, 0, 127, 0),
-SOC_DOUBLE_R("Speaker Playback Volume", WM8753_LOUT2V, WM8753_ROUT2V, 0, 127, 0),
-
-SOC_SINGLE("Mono Playback Volume", WM8753_MOUTV, 0, 127, 0),
-
-SOC_DOUBLE_R("Bypass Playback Volume", WM8753_LOUTM1, WM8753_ROUTM1, 4, 7, 1),
-SOC_DOUBLE_R("Sidetone Playback Volume", WM8753_LOUTM2, WM8753_ROUTM2, 4, 7, 1),
-SOC_DOUBLE_R("Voice Playback Volume", WM8753_LOUTM2, WM8753_ROUTM2, 0, 7, 1),
-
-SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8753_LOUT1V, WM8753_ROUT1V, 7, 1, 0),
-SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8753_LOUT2V, WM8753_ROUT2V, 7, 1, 0),
-
-SOC_SINGLE("Mono Bypass Playback Volume", WM8753_MOUTM1, 4, 7, 1),
-SOC_SINGLE("Mono Sidetone Playback Volume", WM8753_MOUTM2, 4, 7, 1),
-SOC_SINGLE("Mono Voice Playback Volume", WM8753_MOUTM2, 0, 7, 1),
+SOC_DOUBLE_R_TLV("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0, dac_tlv),
+
+SOC_DOUBLE_R_TLV("ADC Capture Volume", WM8753_LADC, WM8753_RADC, 0, 255, 0,
+		 adc_tlv),
+
+SOC_DOUBLE_R_TLV("Headphone Playback Volume", WM8753_LOUT1V, WM8753_ROUT1V,
+		 0, 127, 0, out_tlv),
+SOC_DOUBLE_R_TLV("Speaker Playback Volume", WM8753_LOUT2V, WM8753_ROUT2V, 0,
+		 127, 0, out_tlv),
+
+SOC_SINGLE_TLV("Mono Playback Volume", WM8753_MOUTV, 0, 127, 0, out_tlv),
+
+SOC_DOUBLE_R_TLV("Bypass Playback Volume", WM8753_LOUTM1, WM8753_ROUTM1, 4, 7,
+		 1, mix_tlv),
+SOC_DOUBLE_R_TLV("Sidetone Playback Volume", WM8753_LOUTM2, WM8753_ROUTM2, 4,
+		 7, 1, mix_tlv),
+SOC_DOUBLE_R_TLV("Voice Playback Volume", WM8753_LOUTM2, WM8753_ROUTM2, 0, 7,
+		 1, voice_mix_tlv),
+
+SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8753_LOUT1V, WM8753_ROUT1V, 7,
+	     1, 0),
+SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8753_LOUT2V, WM8753_ROUT2V, 7,
+	     1, 0),
+
+SOC_SINGLE_TLV("Mono Bypass Playback Volume", WM8753_MOUTM1, 4, 7, 1, mix_tlv),
+SOC_SINGLE_TLV("Mono Sidetone Playback Volume", WM8753_MOUTM2, 4, 7, 1,
+	       mix_tlv),
+SOC_SINGLE_TLV("Mono Voice Playback Volume", WM8753_MOUTM2, 0, 7, 1,
+	       voice_mix_tlv),
 SOC_SINGLE("Mono Playback ZC Switch", WM8753_MOUTV, 7, 1, 0),
 
 SOC_ENUM("Bass Boost", wm8753_enum[0]),
@@ -291,10 +313,13 @@ SOC_SINGLE("Bass Volume", WM8753_BASS, 0, 15, 1),
 SOC_SINGLE("Treble Volume", WM8753_TREBLE, 0, 15, 1),
 SOC_ENUM("Treble Cut-off", wm8753_enum[2]),
 
-SOC_DOUBLE_TLV("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1, rec_mix_tlv),
-SOC_SINGLE_TLV("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1, rec_mix_tlv),
+SOC_DOUBLE_TLV("Sidetone Capture Volume", WM8753_RECMIX1, 0, 4, 7, 1,
+	       rec_mix_tlv),
+SOC_SINGLE_TLV("Voice Sidetone Capture Volume", WM8753_RECMIX2, 0, 7, 1,
+	       rec_mix_tlv),
 
-SOC_DOUBLE_R("Capture Volume", WM8753_LINVOL, WM8753_RINVOL, 0, 63, 0),
+SOC_DOUBLE_R_TLV("Capture Volume", WM8753_LINVOL, WM8753_RINVOL, 0, 63, 0,
+		 pga_tlv),
 SOC_DOUBLE_R("Capture ZC Switch", WM8753_LINVOL, WM8753_RINVOL, 6, 1, 0),
 SOC_DOUBLE_R("Capture Switch", WM8753_LINVOL, WM8753_RINVOL, 7, 1, 1),
 
@@ -326,8 +351,8 @@ SOC_ENUM("De-emphasis", wm8753_enum[8]),
 SOC_ENUM("Playback Mono Mix", wm8753_enum[9]),
 SOC_ENUM("Playback Phase", wm8753_enum[10]),
 
-SOC_SINGLE("Mic2 Capture Volume", WM8753_INCTL1, 7, 3, 0),
-SOC_SINGLE("Mic1 Capture Volume", WM8753_INCTL1, 5, 3, 0),
+SOC_SINGLE_TLV("Mic2 Capture Volume", WM8753_INCTL1, 7, 3, 0, mic_preamp_tlv),
+SOC_SINGLE_TLV("Mic1 Capture Volume", WM8753_INCTL1, 5, 3, 0, mic_preamp_tlv),
 
 SOC_ENUM_EXT("DAI Mode", wm8753_enum[26], wm8753_get_dai, wm8753_set_dai),
 
-- 
1.5.5.3
