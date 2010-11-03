From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert soc-jack code to use
	request_any_context_irq()
Date: Wed,  3 Nov 2010 09:36:08 -0400
Message-ID: <1288791368-22772-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC9F624347
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 14:36:02 +0100 (CET)
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

Allow the standard soc-jack GPIO based jack handling to handle the use of
GPIOs which may sleep (such as those on GPIO expanders) by converting the
code to use request_any_context_irq().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 8a0a920..9f07551 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -263,11 +263,12 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
-		ret = request_irq(gpio_to_irq(gpios[i].gpio),
-				gpio_handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				jack->codec->dev->driver->name,
-				&gpios[i]);
+		ret = request_any_context_irq(gpio_to_irq(gpios[i].gpio),
+					      gpio_handler,
+					      IRQF_TRIGGER_RISING |
+					      IRQF_TRIGGER_FALLING,
+					      jack->codec->dev->driver->name,
+					      &gpios[i]);
 		if (ret)
 			goto err;
 
-- 
1.7.1
