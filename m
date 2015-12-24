From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: wm8960: add kcontrol to select ADC data
	output
Date: Thu, 24 Dec 2015 14:58:03 +0800
Message-ID: <72b882412e24df59de1a6fe63568ac5ee5d998ca.1450940174.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 by alsa0.perex.cz (Postfix) with ESMTP id E2DC52665BB
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 07:55:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

add kcontrol to select ADC data output.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 5380798..162def8 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -147,6 +147,12 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
 static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
 static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
 static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
+static const char *wm8960_adc_data_output_sel[] = {
+	"Left Data = Left ADC;  Right Data = Right ADC",
+	"Left Data = Left ADC;  Right Data = Left ADC",
+	"Left Data = Right ADC; Right Data = Right ADC",
+	"Left Data = Right ADC; Right Data = Left ADC",
+};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -155,6 +161,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_3D, 5, 2, wm8960_3d_lower_cutoff),
 	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
+	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -295,6 +302,8 @@ SOC_SINGLE_TLV("Right Output Mixer Boost Bypass Volume",
 	       WM8960_BYPASS2, 4, 7, 1, bypass_tlv),
 SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
+
+SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
1.9.1
