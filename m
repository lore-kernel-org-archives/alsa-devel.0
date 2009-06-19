From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/3] ASoC: TWL4030: Add AVADC Clock Priority
Date: Fri, 19 Jun 2009 03:23:42 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3543F31D@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8657A10389D
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:23:49 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

AVDAC clk priority allows to determine the path ADC must
be connected when the codec is in option2 and both audio
and voice paths are enabled.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 780217a..fd5b30f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1036,6 +1036,16 @@ static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
  */
 static DECLARE_TLV_DB_SCALE(input_gain_tlv, 0, 600, 0);
 
+/* AVADC clock priority */
+static const char *twl4030_avadc_clk_priority_texts[] = {
+	"Voice high priority", "Audio high priority"
+};
+
+static const struct soc_enum twl4030_avadc_clk_priority_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_AVADC_CTL, 2,
+			ARRAY_SIZE(twl4030_avadc_clk_priority_texts),
+			twl4030_avadc_clk_priority_texts);
+
 static const char *twl4030_rampdelay_texts[] = {
 	"27/20/14 ms", "55/40/27 ms", "109/81/55 ms", "218/161/109 ms",
 	"437/323/218 ms", "874/645/437 ms", "1748/1291/874 ms",
@@ -1137,6 +1147,8 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_TLV("Analog Capture Volume", TWL4030_REG_ANAMIC_GAIN,
 		0, 3, 5, 0, input_gain_tlv),
 
+	SOC_ENUM("AVADC Clock Priority", twl4030_avadc_clk_priority_enum),
+
 	SOC_ENUM("HS ramp delay", twl4030_rampdelay_enum),
 
 	SOC_ENUM("Vibra H-bridge mode", twl4030_vibradirmode_enum),
-- 
1.5.4.3
