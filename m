From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Split WM8731 enumeration array into
	individual enums
Date: Thu,  2 Dec 2010 11:47:53 +0000
Message-ID: <1291290474-816-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1291290474-816-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6785A103A62
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:47:57 +0100 (CET)
In-Reply-To: <1291290474-816-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is much more maintainable than the array.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c90e025..8003761 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -64,12 +64,15 @@ static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
 #define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
+
 static const char *wm8731_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
 
-static const struct soc_enum wm8731_enum[] = {
-	SOC_ENUM_SINGLE(WM8731_APANA, 2, 2, wm8731_input_select),
-	SOC_ENUM_SINGLE(WM8731_APDIGI, 1, 4, wm8731_deemph),
-};
+static const struct soc_enum wm8731_insel_enum =
+	SOC_ENUM_SINGLE(WM8731_APANA, 2, 2, wm8731_input_select);
+
+static const struct soc_enum wm8731_deemph_enum =
+	SOC_ENUM_SINGLE(WM8731_APDIGI, 1, 4, wm8731_deemph);
+
 
 static const DECLARE_TLV_DB_SCALE(in_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(sidetone_tlv, -1500, 300, 0);
@@ -96,7 +99,7 @@ SOC_SINGLE_TLV("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1,
 SOC_SINGLE("ADC High Pass Filter Switch", WM8731_APDIGI, 0, 1, 1),
 SOC_SINGLE("Store DC Offset Switch", WM8731_APDIGI, 4, 1, 0),
 
-SOC_ENUM("Playback De-emphasis", wm8731_enum[1]),
+SOC_ENUM("Playback De-emphasis", wm8731_deemph_enum),
 };
 
 /* Output Mixer */
@@ -108,7 +111,7 @@ SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
 
 /* Input mux */
 static const struct snd_kcontrol_new wm8731_input_mux_controls =
-SOC_DAPM_ENUM("Input Select", wm8731_enum[0]);
+SOC_DAPM_ENUM("Input Select", wm8731_insel_enum);
 
 static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("OSC", WM8731_PWR, 5, 1, NULL, 0),
-- 
1.7.1
