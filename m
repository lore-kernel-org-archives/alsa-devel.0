From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct left/right swap in wm_hubs DC
	offset correction
Date: Thu, 23 Jun 2011 19:59:34 +0100
Message-ID: <1308855574-24350-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5150246BD
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 20:59:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It was consistently wrong for everything except WM8993 so should be no
functional change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 4ebc131..2d6c88b 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -133,9 +133,9 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		break;
 	case 1:
 		reg = snd_soc_read(codec, WM8993_DC_SERVO_3);
-		reg_l = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
+		reg_r = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
 			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
-		reg_r = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
+		reg_l = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
 		break;
 	default:
 		WARN(1, "Unknown DCS readback method\n");
@@ -149,13 +149,13 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		dev_dbg(codec->dev, "Applying %d code DC servo correction\n",
 			hubs->dcs_codes);
 
-		/* HPOUT1L */
-		offset = reg_l;
+		/* HPOUT1R */
+		offset = reg_r;
 		offset += hubs->dcs_codes;
 		dcs_cfg = (u8)offset << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 
-		/* HPOUT1R */
-		offset = reg_r;
+		/* HPOUT1L */
+		offset = reg_l;
 		offset += hubs->dcs_codes;
 		dcs_cfg |= (u8)offset;
 
@@ -167,8 +167,8 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
 	} else {
-		dcs_cfg = reg_l << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
-		dcs_cfg |= reg_r;
+		dcs_cfg = reg_r << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
+		dcs_cfg |= reg_l;
 	}
 
 	/* Save the callibrated offset if we're in class W mode and
-- 
1.7.5.4
