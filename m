From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove ifdefs for GPIO_SYSFS
Date: Wed, 21 Dec 2011 00:01:34 +0000
Message-ID: <1324425694-26168-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28F7B1038C3
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 01:01:38 +0100 (CET)
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

It is part of the GPIO API so should be stubbed appropriately.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 6c5ebd3..ee4353f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -341,10 +341,8 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 					gpios[i].gpio, ret);
 		}
 
-#ifdef CONFIG_GPIO_SYSFS
 		/* Expose GPIO value over sysfs for diagnostic purposes */
 		gpio_export(gpios[i].gpio, false);
-#endif
 
 		/* Update initial jack status */
 		snd_soc_jack_gpio_detect(&gpios[i]);
@@ -376,9 +374,7 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 	int i;
 
 	for (i = 0; i < count; i++) {
-#ifdef CONFIG_GPIO_SYSFS
 		gpio_unexport(gpios[i].gpio);
-#endif
 		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
 		cancel_delayed_work_sync(&gpios[i].work);
 		gpio_free(gpios[i].gpio);
-- 
1.7.7.3
