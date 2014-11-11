From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] ASoC: tlv320aic3x: Add output driver
	pop reduction controls
Date: Tue, 11 Nov 2014 10:59:01 +0200
Message-ID: <1415696341-12802-3-git-send-email-peter.ujfalusi@ti.com>
References: <1415696341-12802-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 81EBB264F52
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 09:59:11 +0100 (CET)
In-Reply-To: <1415696341-12802-1-git-send-email-peter.ujfalusi@ti.com>
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
 sound/soc/codecs/tlv320aic3x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 990140058aa6..f0a828119aba 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -279,6 +279,16 @@ static SOC_ENUM_SINGLE_DECL(aic3x_lagc_decay_enum, LAGC_CTRL_A, 0,
 static SOC_ENUM_SINGLE_DECL(aic3x_ragc_decay_enum, RAGC_CTRL_A, 0,
 			    aic3x_agc_decay);
 
+static const char * const aic3x_poweron_time[] = {
+	"0us", "10us", "100us", "1ms", "10ms", "50ms",
+	"100ms", "200ms", "400ms", "800ms", "2s", "4s" };
+static SOC_ENUM_SINGLE_DECL(aic3x_poweron_time_enum, HPOUT_POP_REDUCTION, 4,
+			    aic3x_poweron_time);
+
+static const char * const aic3x_rampup_step[] = { "0ms", "1ms", "2ms", "4ms" };
+static SOC_ENUM_SINGLE_DECL(aic3x_rampup_step_enum, HPOUT_POP_REDUCTION, 2,
+			    aic3x_rampup_step);
+
 /*
  * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
  */
@@ -408,6 +418,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_adc_hpf_enum),
+
+	/* Pop reduction */
+	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
+	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
 };
 
 static const struct snd_kcontrol_new aic3x_mono_controls[] = {
-- 
2.1.3
