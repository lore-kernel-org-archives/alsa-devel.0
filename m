From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Trigger wm_hubs series update
	startup off a separate flag
Date: Wed, 22 Jun 2011 13:20:16 +0100
Message-ID: <1308745217-21062-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 703C12469D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 14:20:21 +0200 (CEST)
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

Allowing the two to be used independently.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    1 +
 sound/soc/codecs/wm8994.c  |    1 +
 sound/soc/codecs/wm_hubs.c |    3 +--
 sound/soc/codecs/wm_hubs.h |    1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 9e5ff78..03af7ad 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1434,6 +1434,7 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 
 	wm8993->hubs_data.hp_startup_mode = 1;
 	wm8993->hubs_data.dcs_codes = -2;
+	wm8993->hubs_data.series_startup = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 86e67e7..44153be 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2918,6 +2918,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			wm8994->hubs.dcs_codes = -5;
 			wm8994->hubs.hp_startup_mode = 1;
 			wm8994->hubs.dcs_readback_mode = 1;
+			wm8994->hubs.series_startup = 1;
 			break;
 		default:
 			wm8994->hubs.dcs_readback_mode = 1;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 586265b..8042999 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -107,8 +107,7 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		return;
 	}
 
-	/* Devices not using a DCS code correction have startup mode */
-	if (hubs->dcs_codes) {
+	if (hubs->series_startup) {
 		/* Set for 32 series updates */
 		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
 				    WM8993_DCS_SERIES_NO_01_MASK,
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index f8a5e97..aeb5871 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -23,6 +23,7 @@ struct wm_hubs_data {
 	int dcs_codes;
 	int dcs_readback_mode;
 	int hp_startup_mode;
+	int series_startup;
 
 	bool class_w;
 	u16 class_w_dcs;
-- 
1.7.5.4
