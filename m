From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Disable wm_hubs periodic DC servo update
Date: Thu, 28 Jul 2011 12:56:16 +0100
Message-ID: <1311854176-6865-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B94D410380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 13:56:19 +0200 (CEST)
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

This does not function correctly in all circumstances so disable the
periodic updates unconditionally for stable; a future patch will reenable
where appropriate.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 4de6794..4416a76 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -440,9 +440,8 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 		reg |= WM8993_HPOUT1L_DLY | WM8993_HPOUT1R_DLY;
 		snd_soc_write(codec, WM8993_ANALOGUE_HP_0, reg);
 
-		/* Smallest supported update interval */
 		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
-				    WM8993_DCS_TIMER_PERIOD_01_MASK, 1);
+				    WM8993_DCS_TIMER_PERIOD_01_MASK, 0);
 
 		calibrate_dc_servo(codec);
 
-- 
1.7.5.4
