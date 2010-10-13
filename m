From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Control for line output gain
Date: Wed, 13 Oct 2010 11:08:18 +0300
Message-ID: <1286957298-28615-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A9DE424340
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:08:35 +0200 (CEST)
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
index bf6d01f..4d86bf6 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -524,6 +524,22 @@ static const struct soc_enum dac33_fifo_mode_enum =
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(dac33_fifo_mode_texts),
 			    dac33_fifo_mode_texts);
 
+/* L/R Line Output Gain */
+static const char *lr_lineout_gain_texts[] = {
+	"Line 0.25V/V DAC 1V/V", "Line 0.5V/V DAC 2V/V",
+	"Line 1V/V DAC 4V/V", "Line 2V/V DAC 8V/V",
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
