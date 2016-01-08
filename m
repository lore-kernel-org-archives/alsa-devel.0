From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: wm8960: add DAC mono mix kcontrol
Date: Fri, 8 Jan 2016 16:57:01 +0800
Message-ID: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 by alsa0.perex.cz (Postfix) with ESMTP id E4CE326040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 09:54:30 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In normal operation, the left and right channel digital audio data is
converted to analogue in two separate DACs. There is a mono-mix mode
where the two audio channels are mixed together digitally and then
converted to analogue using only one DAC, while the other DAC is
switched off. The mono-mix signal can be selected to appear on both
analogue output channels. The mono mix is automatically attenuated by
6dB to prevent clipping.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 162def8..029031b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -153,6 +153,7 @@ static const char *wm8960_adc_data_output_sel[] = {
 	"Left Data = Right ADC; Right Data = Right ADC",
 	"Left Data = Right ADC; Right Data = Left ADC",
 };
+static const char *wm8960_dmonomix[] = {"Stereo", "Mono"};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -162,6 +163,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
 	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
+	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 4, 2, wm8960_dmonomix),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -304,6 +306,7 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
 
 SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
+SOC_ENUM("DAC Mono Mix", wm8960_enum[7]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
1.9.1
