From: <cfreeman@nvidia.com>
Subject: [PATCH] ASoC: jack: export gpio detect
Date: Thu, 3 Apr 2014 15:03:55 -0700
Message-ID: <1396562635-9753-1-git-send-email-cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2D82656F1
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 00:04:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, Christopher Freeman <cfreeman@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Christopher Freeman <cfreeman@nvidia.com>

Export the gpio detect function so machine drivers
may call it.  Interrupts for the jack may be disabled
during sleep, so this allows a machine driver to have
the jack status updated during resume.

Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
---
 include/sound/soc.h  | 1 +
 sound/soc/soc-jack.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6a059c..36383cb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -442,6 +442,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
 void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
+void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio);
 #endif
 
 /* codec register bit access */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0bb5ccc..fd97cc5 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_notifier_unregister);
 
 #ifdef CONFIG_GPIOLIB
 /* gpio detect */
-static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
+void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 {
 	struct snd_soc_jack *jack = gpio->jack;
 	int enable;
@@ -251,6 +251,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 
 	snd_soc_jack_report(jack, report, gpio->report);
 }
+EXPORT_SYMBOL_GPL(snd_soc_jack_gpio_detect);
 
 /* irq handler for gpio pin */
 static irqreturn_t gpio_handler(int irq, void *data)
-- 
1.8.3.2


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
