From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Allow GPIO jack detection to be
	configured as a wake source
Date: Fri, 18 Feb 2011 00:42:45 +0000
Message-ID: <1297989766-1274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 612C624337
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 01:42:48 +0100 (CET)
In-Reply-To: <>
References: <>
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

Some systems wish to use jacks as wake sources. Provide a wake flag in the
GPIO configuration which causes the driver to enable the IRQ as a wake
source.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 +++
 sound/soc/soc-jack.c |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4ccf1e4..fb57c33 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -436,6 +436,7 @@ struct snd_soc_jack_zone {
  * @report:       value to report when jack detected
  * @invert:       report presence in low state
  * @debouce_time: debouce time in ms
+ * @wake:	  enable as wake source
  */
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio {
@@ -444,6 +445,8 @@ struct snd_soc_jack_gpio {
 	int report;
 	int invert;
 	int debounce_time;
+	bool wake;
+
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
 
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 4579ee0..1382251 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -330,6 +330,14 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (ret)
 			goto err;
 
+		if (gpios[i].wake) {
+			ret = set_irq_wake(gpio_to_irq(gpios[i].gpio), 1);
+			if (ret != 0)
+				printk(KERN_ERR
+				  "Failed to mark GPIO %d as wake source: %d\n",
+					gpios[i].gpio, ret);
+		}
+
 #ifdef CONFIG_GPIO_SYSFS
 		/* Expose GPIO value over sysfs for diagnostic purposes */
 		gpio_export(gpios[i].gpio, false);
-- 
1.7.2.3
