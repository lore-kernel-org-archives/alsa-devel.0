From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_hubs: Rename calibrate_dc_servo()
Date: Thu, 26 Jul 2012 14:15:43 +0100
Message-ID: <1343308543-22455-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1343308543-22455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BAA6265E78
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 15:15:53 +0200 (CEST)
In-Reply-To: <1343308543-22455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Really we're enabling it here and the name will become very confusing
shortly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 6ab69f3..05a02e1 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -243,7 +243,7 @@ static void wm_hubs_read_dc_servo(struct snd_soc_codec *codec,
 /*
  * Startup calibration of the DC servo
  */
-static void calibrate_dc_servo(struct snd_soc_codec *codec)
+static void enable_dc_servo(struct snd_soc_codec *codec)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct wm_hubs_dcs_cache *cache;
@@ -556,7 +556,7 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
 				    WM8993_DCS_TIMER_PERIOD_01_MASK, 0);
 
-		calibrate_dc_servo(codec);
+		enable_dc_servo(codec);
 
 		reg |= WM8993_HPOUT1R_OUTP | WM8993_HPOUT1R_RMV_SHORT |
 			WM8993_HPOUT1L_OUTP | WM8993_HPOUT1L_RMV_SHORT;
-- 
1.7.10.4
