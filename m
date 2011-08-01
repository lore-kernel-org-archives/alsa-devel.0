From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Support separate left and right
	channel dcs_codes values
Date: Mon,  1 Aug 2011 14:12:52 +0900
Message-ID: <1312175572-13551-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1312175572-13551-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98F77243DC
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 08:04:38 +0200 (CEST)
In-Reply-To: <1312175572-13551-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Some devices can have performance optimized by setting different offsets
for left and right channels.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    3 ++-
 sound/soc/codecs/wm8994.c  |    3 ++-
 sound/soc/codecs/wm_hubs.c |   13 +++++++------
 sound/soc/codecs/wm_hubs.h |    3 ++-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 19fc081..eec8e14 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1437,7 +1437,8 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	int ret, i, val;
 
 	wm8993->hubs_data.hp_startup_mode = 1;
-	wm8993->hubs_data.dcs_codes = -2;
+	wm8993->hubs_data.dcs_codes_l = -2;
+	wm8993->hubs_data.dcs_codes_r = -2;
 	wm8993->hubs_data.series_startup = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e1e9aca..d3c4f80 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2960,7 +2960,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		switch (wm8994->revision) {
 		case 2:
 		case 3:
-			wm8994->hubs.dcs_codes = -5;
+			wm8994->hubs.dcs_codes_l = -5;
+			wm8994->hubs.dcs_codes_r = -5;
 			wm8994->hubs.hp_startup_mode = 1;
 			wm8994->hubs.dcs_readback_mode = 1;
 			wm8994->hubs.series_startup = 1;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 524bdc6..ca8ce03 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -179,18 +179,19 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "DCS input: %x %x\n", reg_l, reg_r);
 
 	/* Apply correction to DC servo result */
-	if (hubs->dcs_codes) {
-		dev_dbg(codec->dev, "Applying %d code DC servo correction\n",
-			hubs->dcs_codes);
+	if (hubs->dcs_codes_l || hubs->dcs_codes_r) {
+		dev_dbg(codec->dev,
+			"Applying %d/%d code DC servo correction\n",
+			hubs->dcs_codes_l, hubs->dcs_codes_r);
 
 		/* HPOUT1R */
 		offset = reg_r;
-		offset += hubs->dcs_codes;
+		offset += hubs->dcs_codes_r;
 		dcs_cfg = (u8)offset << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 
 		/* HPOUT1L */
 		offset = reg_l;
-		offset += hubs->dcs_codes;
+		offset += hubs->dcs_codes_l;
 		dcs_cfg |= (u8)offset;
 
 		dev_dbg(codec->dev, "DCS result: %x\n", dcs_cfg);
@@ -228,7 +229,7 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 
 	/* If we're applying an offset correction then updating the
 	 * callibration would be likely to introduce further offsets. */
-	if (hubs->dcs_codes || hubs->no_series_update)
+	if (hubs->dcs_codes_l || hubs->dcs_codes_r || hubs->no_series_update)
 		return ret;
 
 	/* Only need to do this if the outputs are active */
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 676b125..c674c7a 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -23,7 +23,8 @@ extern const unsigned int wm_hubs_spkmix_tlv[];
 
 /* This *must* be the first element of the codec->private_data struct */
 struct wm_hubs_data {
-	int dcs_codes;
+	int dcs_codes_l;
+	int dcs_codes_r;
 	int dcs_readback_mode;
 	int hp_startup_mode;
 	int series_startup;
-- 
1.7.5.4
