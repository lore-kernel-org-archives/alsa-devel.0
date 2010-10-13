From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: tlv320dac33: Control for line output
	gain
Date: Wed, 13 Oct 2010 11:56:28 +0300
Message-ID: <1286960188-29334-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 2971410385A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:56:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

New control to select the line output gain.
This gain control affects the linein-to-lineout and
dac-to-loneout gain differently.
Use enum type to select the desired gain combination.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index bf6d01f..58349dc 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -524,6 +524,22 @@ static const struct soc_enum dac33_fifo_mode_enum =
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(dac33_fifo_mode_texts),
 			    dac33_fifo_mode_texts);
 
+/* L/R Line Output Gain */
+static const char *lr_lineout_gain_texts[] = {
+	"Line -12dB DAC 0dB", "Line -6dB DAC 6dB",
+	"Line 0dB DAC 12dB", "Line 6dB DAC 18dB",
+};
+
+static const struct soc_enum l_lineout_gain_enum =
+	SOC_ENUM_SINGLE(DAC33_LDAC_PWR_CTRL, 0,
+			ARRAY_SIZE(lr_lineout_gain_texts),
+			lr_lineout_gain_texts);
+
+static const struct soc_enum r_lineout_gain_enum =
+	SOC_ENUM_SINGLE(DAC33_RDAC_PWR_CTRL, 0,
+			ARRAY_SIZE(lr_lineout_gain_texts),
+			lr_lineout_gain_texts);
+
 /*
  * DACL/R digital volume control:
  * from 0 dB to -63.5 in 0.5 dB steps
@@ -541,6 +557,8 @@ static const struct snd_kcontrol_new dac33_snd_controls[] = {
 		 DAC33_LDAC_DIG_VOL_CTRL, DAC33_RDAC_DIG_VOL_CTRL, 7, 1, 1),
 	SOC_DOUBLE_R("Line to Line Out Volume",
 		 DAC33_LINEL_TO_LLO_VOL, DAC33_LINER_TO_RLO_VOL, 0, 127, 1),
+	SOC_ENUM("Left Line Output Gain", l_lineout_gain_enum),
+	SOC_ENUM("Right Line Output Gain", r_lineout_gain_enum),
 };
 
 static const struct snd_kcontrol_new dac33_mode_snd_controls[] = {
-- 
1.7.3.1
