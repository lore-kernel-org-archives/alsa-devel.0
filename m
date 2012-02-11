From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 11/12] ASoC: alc5632: Fix Capture/Playback
	attributes for microphone inputs
Date: Sat, 11 Feb 2012 23:10:44 +0200
Message-ID: <1328994645-8237-12-git-send-email-leon@leon.nu>
References: <1328994645-8237-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A4FBF103A4E
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:11:28 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1252422eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:11:28 -0800 (PST)
In-Reply-To: <1328994645-8237-1-git-send-email-leon@leon.nu>
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
Cc: Paul Fertser <fercerpav@gmail.com>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Paul Fertser <fercerpav@gmail.com>

According to the mixer path diagram input sources' attenuators logically
belong to the playback path and DMIC boost only affects capture.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index e52fb81..94f6a2a 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -177,17 +177,17 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 			ALC5632_VOICE_DAC_VOL, 0, 63, 0, vdac_tlv),
 	SOC_SINGLE("Voice DAC Playback Switch",
 			ALC5632_VOICE_DAC_VOL, 12, 1, 1),
-	SOC_SINGLE_TLV("Phone Capture Volume",
+	SOC_SINGLE_TLV("Phone Playback Volume",
 			ALC5632_PHONE_IN_VOL, 8, 31, 1, vol_tlv),
-	SOC_DOUBLE_TLV("LineIn Capture Volume",
+	SOC_DOUBLE_TLV("LineIn Playback Volume",
 			ALC5632_LINE_IN_VOL, 8, 0, 31, 1, vol_tlv),
 	SOC_DOUBLE_TLV("Master Playback Volume",
 			ALC5632_STEREO_DAC_IN_VOL, 8, 0, 63, 1, vdac_tlv),
 	SOC_DOUBLE("Master Playback Switch",
 			ALC5632_STEREO_DAC_IN_VOL, 15, 7, 1, 1),
-	SOC_SINGLE_TLV("Mic1 Capture Volume",
+	SOC_SINGLE_TLV("Mic1 Playback Volume",
 			ALC5632_MIC_VOL, 8, 31, 1, vol_tlv),
-	SOC_SINGLE_TLV("Mic2 Capture Volume",
+	SOC_SINGLE_TLV("Mic2 Playback Volume",
 			ALC5632_MIC_VOL, 0, 31, 1, vol_tlv),
 	SOC_DOUBLE_TLV("Rec Capture Volume",
 			ALC5632_ADC_REC_GAIN, 8, 0, 31, 0, adc_rec_tlv),
@@ -195,7 +195,7 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 			ALC5632_MIC_CTRL, 10, 3, 0, boost_tlv),
 	SOC_SINGLE_TLV("Mic 2 Boost Volume",
 			ALC5632_MIC_CTRL, 8, 3, 0, boost_tlv),
-	SOC_SINGLE_TLV("DMIC Boost Volume",
+	SOC_SINGLE_TLV("DMIC Boost Capture Volume",
 			ALC5632_DIGI_BOOST_CTRL, 0, 7, 0, dig_tlv),
 	SOC_SINGLE("DMIC En Capture Switch",
 			ALC5632_DIGI_BOOST_CTRL, 15, 1, 0),
-- 
1.7.3.4
