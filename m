From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use delayed work for debounce of GPIO
	based jacks
Date: Wed,  6 Oct 2010 16:05:01 -0700
Message-ID: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 935E5103986
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 01:04:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Rather than block the workqueue by sleeping to do the debounce use delayed
work to implement the debounce time. This should also mean that we extend
the debounce time on each new bounce, potentially allowing shorter debounce
times for clean insertions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is completely untested as I do not have any systems to hand which
can make use of this functionality but I believe it should work - I've
CCed a couple of the OMAP people since they seem to be the main users.

 include/sound/soc.h  |    2 +-
 sound/soc/soc-jack.c |   11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 493b3a4..4fb079e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -385,7 +385,7 @@ struct snd_soc_jack_gpio {
 	int invert;
 	int debounce_time;
 	struct snd_soc_jack *jack;
-	struct work_struct work;
+	struct delayed_work work;
 
 	int (*jack_status_check)(void);
 };
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 8862770..8a0a920 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -188,9 +188,6 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 	int enable;
 	int report;
 
-	if (gpio->debounce_time > 0)
-		mdelay(gpio->debounce_time);
-
 	enable = gpio_get_value(gpio->gpio);
 	if (gpio->invert)
 		enable = !enable;
@@ -211,7 +208,8 @@ static irqreturn_t gpio_handler(int irq, void *data)
 {
 	struct snd_soc_jack_gpio *gpio = data;
 
-	schedule_work(&gpio->work);
+	schedule_delayed_work(&gpio->work,
+			      msecs_to_jiffies(gpio->debounce_time));
 
 	return IRQ_HANDLED;
 }
@@ -221,7 +219,7 @@ static void gpio_work(struct work_struct *work)
 {
 	struct snd_soc_jack_gpio *gpio;
 
-	gpio = container_of(work, struct snd_soc_jack_gpio, work);
+	gpio = container_of(work, struct snd_soc_jack_gpio, work.work);
 	snd_soc_jack_gpio_detect(gpio);
 }
 
@@ -262,7 +260,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (ret)
 			goto err;
 
-		INIT_WORK(&gpios[i].work, gpio_work);
+		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
 		ret = request_irq(gpio_to_irq(gpios[i].gpio),
@@ -312,6 +310,7 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 		gpio_unexport(gpios[i].gpio);
 #endif
 		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
+		cancel_delayed_work_sync(&gpios[i].work);
 		gpio_free(gpios[i].gpio);
 		gpios[i].jack = NULL;
 	}
-- 
1.7.1
