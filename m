From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Prevent system suspend while debouncing
	wakeup capable GPIO jacks
Date: Sun, 14 Nov 2010 19:26:13 +0000
Message-ID: <1289762773-19239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7ED502446E
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2010 20:26:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwoo <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If the device associated with a GPIO jack is wakeup capable then disable
suspend while we're debouncing the jack so that we skip suspends that race
with the jack.

Note that currently the GPIO based jack has a CODEC associated with it
which we're using right now. These jacks should be reparented against the
card itself and this code adjusted.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 4d95abb..619061d 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -209,6 +209,10 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 static irqreturn_t gpio_handler(int irq, void *data)
 {
 	struct snd_soc_jack_gpio *gpio = data;
+	struct device *dev = gpio->jack->codec->card->dev;
+
+	if (device_may_wakeup(dev))
+		pm_wakeup_event(dev, gpio->debounce_time + 50);
 
 	schedule_delayed_work(&gpio->work,
 			      msecs_to_jiffies(gpio->debounce_time));
-- 
1.7.2.3
