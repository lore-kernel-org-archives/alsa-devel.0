From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Handle low measured DC offsets for
	wm_hubs devices
Date: Fri, 21 Jan 2011 18:02:31 +0000
Message-ID: <1295632951-23446-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B2531037EA
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:02:35 +0100 (CET)
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

The DC servo codes are actually signed numbers so need to be treated as
such.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index c466982..613df5d 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -91,6 +91,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 static void calibrate_dc_servo(struct snd_soc_codec *codec)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	s8 offset;
 	u16 reg, reg_l, reg_r, dcs_cfg;
 
 	/* If we're using a digital only path and have a previously
@@ -149,16 +150,14 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 			hubs->dcs_codes);
 
 		/* HPOUT1L */
-		if (reg_l + hubs->dcs_codes > 0 &&
-		    reg_l + hubs->dcs_codes < 0xff)
-			reg_l += hubs->dcs_codes;
-		dcs_cfg = reg_l << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
+		offset = reg_l;
+		offset += hubs->dcs_codes;
+		dcs_cfg = (u8)offset << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 
 		/* HPOUT1R */
-		if (reg_r + hubs->dcs_codes > 0 &&
-		    reg_r + hubs->dcs_codes < 0xff)
-			reg_r += hubs->dcs_codes;
-		dcs_cfg |= reg_r;
+		offset = reg_r;
+		offset += hubs->dcs_codes;
+		dcs_cfg |= (u8)offset;
 
 		dev_dbg(codec->dev, "DCS result: %x\n", dcs_cfg);
 
-- 
1.7.2.3
