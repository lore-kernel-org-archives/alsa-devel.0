From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 15 Mar 2009 12:14:18 +0100
Message-ID: <87d4cjghrp.fsf@free.fr>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
	<20090314224648.GB6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 562952435D
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 12:14:25 +0100 (CET)
In-Reply-To: <20090314224648.GB6523@sirena.org.uk> (Mark Brown's message of
	"Sat\, 14 Mar 2009 22\:46\:49 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

<snip>
All first comments OK.
> Again, this should specify that ths only applies to PXA27x.
>
>> +	if (!pdata) {
>> +		is_ac97_resetgpio_113 = 1;
>> +	} else {
>> +		if (pdata->reset_gpio_95)
>> +			is_ac97_resetgpio_95 = 1;
>> +		if (pdata->reset_gpio_113)
>> +			is_ac97_resetgpio_113 = 1;
>> +	}
>
> This should be something more like:
>
> 	if (pdata) {
> 		switch (pdata->reset_gpio) {
> 		case 95:
> 		case 113:
> 			reset_gpio = pdata->reset_gpio;
> 			break;
> 		case 0:
> 			break;
> 		default:
> 			dev_err(dev, "Invalid reset GPIO %d\n",
> 				pdata->reset_gpio);
> 		}
> 	}
>
> 	if (cpu_is_pxa27x() && !reset_gpio)
> 		reset_gpio = 113;
Here I'll ask for a change.

You assume a reset gpio is _always_ provided on pxa27x CPUs. I do not. There may
be faulty boards where no gpio line is dedicated to AC97 reset, or AC97 reset
line is commanded by a helper chip.

Please check the new patch if you agree with the changes.

Cheers.

--
Robert

>From 630a1b73898b1eeffc07062c4a6d4e845c33e022 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 19 Feb 2009 21:35:42 +0100
Subject: [PATCH v2] Allow choice in ac97 gpio reset line

As the PXA27x series allow 2 gpios to reset the ac97 bus,
allow through platform data configuration the definition of
the correct gpio which will reset the AC97 bus.

This comes from a silicon defect on the PXA27x series, where
the gpio must be manually controlled in warm reset cases.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
---
 include/sound/pxa2xx-lib.h  |   14 +++++++++
 sound/arm/pxa2xx-ac97-lib.c |   68 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 2fd3d25..9ee0f19 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -42,4 +42,18 @@ extern int pxa2xx_ac97_hw_resume(void);
 extern int pxa2xx_ac97_hw_probe(struct platform_device *dev);
 extern void pxa2xx_ac97_hw_remove(struct platform_device *dev);
 
+/* AC97 platform_data */
+/**
+ * struct pxa2xx_ac97_platform_data - pxa ac97 platform data
+ * @reset_gpio: AC97 reset gpio (normally gpio113 or gpio95)
+ *
+ * Platform data should only be specified for pxa27x CPUs where a silicon bug
+ * prevents correct operation of the reset line. If not specified, the default
+ * behaviour is to consider gpio 113 as the AC97 reset line, which is the
+ * default on most boards.
+ */
+struct pxa2xx_ac97_platform_data {
+	int reset_gpio;
+};
+
 #endif
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 35afd0c..1df4b0b 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -31,6 +31,7 @@ static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
 static struct clk *ac97_clk;
 static struct clk *ac97conf_clk;
+static int reset_gpio;
 
 /*
  * Beware PXA27x bugs:
@@ -42,6 +43,45 @@ static struct clk *ac97conf_clk;
  * 1 jiffy timeout if interrupt never comes).
  */
 
+enum {
+	RESETGPIO_FORCE_HIGH,
+	RESETGPIO_FORCE_LOW,
+	RESETGPIO_NORMAL_ALTFUNC
+};
+
+/**
+ * set_resetgpio_mode - computes and sets the AC97_RESET gpio mode on PXA
+ * @mode: chosen action
+ *
+ * As the PXA27x CPUs suffer from a AC97 bug, a manual control of the reset line
+ * must be done to insure proper work of AC97 reset line.  This function
+ * computes the correct gpio_mode for further use by reset functions, and
+ * applied the change through pxa_gpio_mode.
+ */
+static void set_resetgpio_mode(int resetgpio_action)
+{
+	int mode = 0;
+
+	if (reset_gpio)
+		switch (resetgpio_action) {
+		case RESETGPIO_NORMAL_ALTFUNC:
+			if (reset_gpio == 113)
+				mode = 113 | GPIO_OUT | GPIO_DFLT_LOW;
+			if (reset_gpio == 95)
+				mode = 95 | GPIO_ALT_FN_1_OUT;
+			break;
+		case RESETGPIO_FORCE_LOW:
+			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_LOW;
+			break;
+		case RESETGPIO_FORCE_HIGH:
+			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_HIGH;
+			break;
+		};
+
+	if (mode)
+		pxa_gpio_mode(mode);
+}
+
 unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
@@ -137,10 +177,10 @@ static inline void pxa_ac97_warm_pxa27x(void)
 
 	/* warm reset broken on Bulverde,
 	   so manually keep AC97 reset high */
-	pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
+	set_resetgpio_mode(RESETGPIO_FORCE_HIGH);
 	udelay(10);
 	GCR |= GCR_WARM_RST;
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
 	udelay(500);
 }
 
@@ -308,8 +348,8 @@ int pxa2xx_ac97_hw_resume(void)
 		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
 	}
 	if (cpu_is_pxa27x()) {
-		/* Use GPIO 113 as AC97 Reset on Bulverde */
-		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		/* Use GPIO 113 or 95 as AC97 Reset on Bulverde */
+		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
 	}
 	clk_enable(ac97_clk);
 	return 0;
@@ -320,6 +360,24 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
 int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
+	struct pxa2xx_ac97_platform_data *pdata = dev->dev.platform_data;
+
+	if (pdata) {
+		switch (pdata->reset_gpio) {
+		case 95:
+		case 113:
+			reset_gpio = pdata->reset_gpio;
+			break;
+		case 0:
+			break;
+		default:
+			dev_err(dev, "Invalid reset GPIO %d\n",
+				pdata->reset_gpio);
+		}
+	} else {
+		if (cpu_is_pxa27x())
+			reset_gpio = 113;
+	}
 
 	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
 		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
@@ -330,7 +388,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 
 	if (cpu_is_pxa27x()) {
 		/* Use GPIO 113 as AC97 Reset on Bulverde */
-		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
 		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
 		if (IS_ERR(ac97conf_clk)) {
 			ret = PTR_ERR(ac97conf_clk);
-- 
1.5.6.5
