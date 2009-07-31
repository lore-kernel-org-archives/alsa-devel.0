From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: jack: Fix race in snd_soc_jack_add_gpios
Date: Fri, 31 Jul 2009 21:15:25 +0200
Message-ID: <1249067725-25791-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-063.synserver.de (smtp-out-063.synserver.de
	[212.40.180.63]) by alsa0.perex.cz (Postfix) with SMTP id 696AF24662
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 21:15:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The irq can fire as soon as it has been requested, thus all fields accessed
from within the irq handler must be initialized prior to requesting the irq.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
The patch is against alsa-kernel/master but I guess something similar should also
go into 2.6.31.

 sound/soc/soc-jack.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 4aa7d8f..1d455ab 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -221,6 +221,9 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (ret)
 			goto err;
 
+		INIT_WORK(&gpios[i].work, gpio_work);
+		gpios[i].jack = jack;
+
 		ret = request_irq(gpio_to_irq(gpios[i].gpio),
 				gpio_handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -234,9 +237,6 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		gpio_export(gpios[i].gpio, false);
 #endif
 
-		INIT_WORK(&gpios[i].work, gpio_work);
-		gpios[i].jack = jack;
-
 		/* Update initial jack status */
 		snd_soc_jack_gpio_detect(&gpios[i]);
 	}
-- 
1.5.6.5
