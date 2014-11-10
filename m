From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Add output driver pop
	reduction controls
Date: Mon, 10 Nov 2014 12:27:32 +0200
Message-ID: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 882E92606B3
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:27:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Output driver has two parameters that can be configured to reduce
pop noise: power-on delay and ramp-up step time. Two new kcontrols
have been added to set these parameters.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index f7c2a575a892..70f8b8be9173 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -270,6 +270,15 @@ static const struct soc_enum aic3x_agc_decay_enum[] = {
 	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
 };
 
+static const char * const aic3x_poweron_time[] = {
+	"0us", "10us", "100us", "1ms", "10ms", "50ms",
+	"100ms", "200ms", "400ms", "800ms", "2s", "4s" };
+static const char * const aic3x_rampup_step[] = { "0ms", "1ms", "2ms", "4ms" };
+static const struct soc_enum aic3x_pop_reduction_enum[] = {
+	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 4, 12, aic3x_poweron_time),
+	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 2, 4, aic3x_rampup_step),
+};
+
 /*
  * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
  */
@@ -399,6 +408,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+
+	/* Pop reduction */
+	SOC_ENUM("Output Driver Power-On time", aic3x_pop_reduction_enum[0]),
+	SOC_ENUM("Output Driver Ramp-up step", aic3x_pop_reduction_enum[1]),
 };
 
 static const struct snd_kcontrol_new aic3x_mono_controls[] = {
-- 
2.1.3
