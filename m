From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: tlv320aic3x: Add controls for
	selecting HP power down modes
Date: Fri, 23 Dec 2016 11:21:12 +0200
Message-ID: <20161223092112.7992-4-peter.ujfalusi@ti.com>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 149C0266949
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 10:21:11 +0100 (CET)
In-Reply-To: <20161223092112.7992-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

When the HP drivers are powered down, their output can be placed in
high-impedance state or it can be weakly driven to the VCM level.
High-impedance mode provides better power saving in the expense of pop
noise when powering up the HP.
When the output is driven to VCM level the artifacts can be minimized, but
the power down power consumption will be slightly higher.

The patch adds way to select the HPL/R power-down mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index bc220f83dd1f..3e66dedeafac 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -305,6 +305,13 @@ static const char * const aic3x_rampup_step[] = { "0ms", "1ms", "2ms", "4ms" };
 static SOC_ENUM_SINGLE_DECL(aic3x_rampup_step_enum, HPOUT_POP_REDUCTION, 2,
 			    aic3x_rampup_step);
 
+static const char * const aic3x_output_pdown_mode[] = {
+	"Drive to a common-mode", "High-impedance mode"};
+static SOC_ENUM_SINGLE_DECL(aic3x_hpl_pdown_mode_enum, HPLOUT_CTRL, 2,
+			    aic3x_output_pdown_mode);
+static SOC_ENUM_SINGLE_DECL(aic3x_hpr_pdown_mode_enum, HPROUT_CTRL, 2,
+			    aic3x_output_pdown_mode);
+
 /*
  * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
  */
@@ -392,6 +399,9 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 
+	SOC_ENUM("Left HP Power Down mode", aic3x_hpl_pdown_mode_enum),
+	SOC_ENUM("Right HP Power Down mode", aic3x_hpr_pdown_mode_enum),
+
 	/*
 	 * Note: enable Automatic input Gain Controller with care. It can
 	 * adjust PGA to max value when ADC is on and will never go back.
-- 
2.11.0
