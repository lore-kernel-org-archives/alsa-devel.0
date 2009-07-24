From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Jack handling enhancements as suggested
	by subsystem maintainer
Date: Fri, 24 Jul 2009 02:48:57 +0200
Message-ID: <200907240248.58433.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B4B69103A44
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 02:49:54 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch adds a few small enhancements to the ASoC jack handling, as 
suggested by Mark in his comments to my Amstrad Delta driver, and a few fixes 
for related bugs found while learning Mark's code and testing results.

Enhancements:
1. Update status of an ASoC jack while associating it with new gpios.
2. Really update DAPM pins while associating them with an ASoC jack.
3. Export ASoC jack gpios over gpiolib sysfs for diagnostic purposes.

Fixes:
1. Apply mask on jack status report before using it, just for case.
2. While updating jack associated DAPM pins, use full resulting jack status,
   not the status report passed as an argument.

Created and tested on linux-2.6.31-rc3

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- linux-2.6.31-rc3/sound/soc/soc-jack.c.orig	2009-07-14 03:18:52.000000000 +0200
+++ linux-2.6.31-rc3/sound/soc/soc-jack.c	2009-07-24 02:47:06.000000000 +0200
@@ -73,14 +73,15 @@ void snd_soc_jack_report(struct snd_soc_
 	oldstatus = jack->status;
 
 	jack->status &= ~mask;
-	jack->status |= status;
+	jack->status |= status & mask;
 
-	/* The DAPM sync is expensive enough to be worth skipping */
-	if (jack->status == oldstatus)
+	/* The DAPM sync is expensive enough to be worth skipping.
+	 * However, empty mask means pin synchronization is desired. */
+	if (mask && (jack->status == oldstatus))
 		goto out;
 
 	list_for_each_entry(pin, &jack->pins, list) {
-		enable = pin->mask & status;
+		enable = pin->mask & jack->status;
 
 		if (pin->invert)
 			enable = !enable;
@@ -228,8 +229,16 @@ int snd_soc_jack_add_gpios(struct snd_so
 		if (ret)
 			goto err;
 
+#ifdef CONFIG_GPIO_SYSFS
+		/* Expose GPIO value over sysfs for diagnostic purposes */
+		gpio_export(gpios[i].gpio, false);
+#endif
+
 		INIT_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
+
+		/* Update initial jack status */
+		snd_soc_jack_gpio_detect(&gpios[i]);
 	}
 
 	return 0;
@@ -258,6 +267,9 @@ void snd_soc_jack_free_gpios(struct snd_
 	int i;
 
 	for (i = 0; i < count; i++) {
+#ifdef CONFIG_GPIO_SYSFS
+		gpio_unexport(gpios[i].gpio);
+#endif
 		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
 		gpio_free(gpios[i].gpio);
 		gpios[i].jack = NULL;
