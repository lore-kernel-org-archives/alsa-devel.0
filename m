From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: remove bogus SLEEP mode from wm8978
	driver
Date: Thu, 28 Jan 2010 16:28:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001281627540.4356@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E7F0E1037FE
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 16:28:44 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Tests showed, that bit 6 of the WM8978_POWER_MANAGEMENT_2 register of wm8978
affects codec clocks. Being useless for suspend / resume, it cannot be used in
bias-level control either. Remove this bit handling.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/codecs/wm8978.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index b86ef47..8dcebaa 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -873,9 +873,7 @@ static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	/* Also switch PLL off */
 	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);
-	/* Put to sleep */
-	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0x40);
-	
+
 	return 0;
 }
 
@@ -887,9 +885,6 @@ static int wm8978_resume(struct platform_device *pdev)
 	int i;
 	u16 *cache = codec->reg_cache;
 
-	/* Wake up the codec */
-	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0);
-
 	/* Sync reg_cache with the hardware */
 	for (i = 0; i < ARRAY_SIZE(wm8978_reg); i++) {
 		if (i == WM8978_RESET)
-- 
1.6.2.4
