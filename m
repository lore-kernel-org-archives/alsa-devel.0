From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Allow suppression of series updates
	on wm_hubs devices
Date: Wed, 22 Jun 2011 13:20:17 +0100
Message-ID: <1308745217-21062-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1308745217-21062-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C17D2469B
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 14:20:21 +0200 (CEST)
In-Reply-To: <1308745217-21062-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Some devices do not support manual updates of the DC servo.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    2 +-
 sound/soc/codecs/wm_hubs.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 8042999..2d6c88b 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -194,7 +194,7 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 
 	/* If we're applying an offset correction then updating the
 	 * callibration would be likely to introduce further offsets. */
-	if (hubs->dcs_codes)
+	if (hubs->dcs_codes || hubs->no_series_update)
 		return ret;
 
 	/* Only need to do this if the outputs are active */
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index aeb5871..0d290d2 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -24,6 +24,7 @@ struct wm_hubs_data {
 	int dcs_readback_mode;
 	int hp_startup_mode;
 	int series_startup;
+	int no_series_update;
 
 	bool class_w;
 	u16 class_w_dcs;
-- 
1.7.5.4
