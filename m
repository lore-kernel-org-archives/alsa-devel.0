From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: conversion of opti93x driver to use cs4231-lib
Date: Tue, 8 Jan 2008 17:32:24 +0100
Message-ID: <20080108173224.db107040.krzysztof.h1@poczta.fm>
References: <20080107200801.008a3cc1.krzysztof.h1@poczta.fm>
	<s5hlk707dj7.wl%tiwai@suse.de> <478385D9.1000402@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 94E4B24B34
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:29:07 +0100 (CET)
In-Reply-To: <478385D9.1000402@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 08 Jan 2008 15:16:57 +0100
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 08-01-08 12:38, Takashi Iwai wrote:
> 
> Jaroslav -- do you know/remember why opti93x didn't use cs4231-lib?
> 

One reason is that OPTi93x mixer has slightly different control bits. That's why the first patch is added.

A big part of the second patch changes (removes) lines from the code ifdef-ed for opti93x only. Below
is the part of patch which shows differences in common paths with opti92x. It is much much shorter.

One thing to notice - the changed code has no common patch with opti92x-ad1848 as it is always
ifdef-ed as CS4231 code. So only opti92x-cs4231 can be affected. Judge it from the diff below.

@@ -34,15 +34,10 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
-#ifdef CS4231
+#if defined(CS4231) || defined(OPTi93X)
 #include <sound/cs4231.h>
 #else
-#ifndef OPTi93X
 #include <sound/ad1848.h>
-#else
-#include <sound/control.h>
-#include <sound/pcm.h>
-#endif	/* OPTi93X */
 #endif	/* CS4231 */
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
@@ -110,7 +105,6 @@ module_param(dma2, int, 0444);
 MODULE_PARM_DESC(dma2, "2nd dma # for opti9xx driver.");
 #endif	/* CS4231 || OPTi93X */
 
-#define OPTi9XX_HW_DETECT	0
 #define OPTi9XX_HW_82C928	1
 #define OPTi9XX_HW_82C929	2
 #define OPTi9XX_HW_82C924	3
@@ -1783,11 +748,11 @@ static int __devinit snd_opti9xx_probe(s
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	int error;
 	struct snd_opti9xx *chip = card->private_data;
-#if defined(OPTi93X)
-	struct snd_opti93x *codec;
-#elif defined(CS4231)
+#if defined(CS4231) || defined(OPTi93X)
 	struct snd_cs4231 *codec;
+#ifdef CS4231
 	struct snd_timer *timer;
+#endif
 #else
 	struct snd_ad1848 *codec;
 #endif
@@ -1819,26 +784,31 @@ static int __devinit snd_opti9xx_probe(s
 	if ((error = snd_opti9xx_configure(chip)))
 		return error;
 
-#if defined(OPTi93X)
-	if ((error = snd_opti93x_create(card, chip, chip->dma1, chip->dma2, &codec)))
-		return error;
-	if ((error = snd_opti93x_pcm(codec, 0, &pcm)) < 0)
-		return error;
-	if ((error = snd_opti93x_mixer(codec)) < 0)
-		return error;
-#elif defined(CS4231)
+#if defined(CS4231) || defined(OPTi93X)
 	if ((error = snd_cs4231_create(card, chip->wss_base + 4, -1,
 				       chip->irq, chip->dma1, chip->dma2,
-				       CS4231_HW_DETECT,
-				       0,
+#ifdef CS4231
+				       CS4231_HW_DETECT, 0,
+#else /* OPTi93x */
+				       CS4231_HW_OPTI93X, CS4231_HWSHARE_IRQ,
+#endif
 				       &codec)) < 0)
 		return error;
+	chip->codec = codec;
 	if ((error = snd_cs4231_pcm(codec, 0, &pcm)) < 0)
 		return error;
 	if ((error = snd_cs4231_mixer(codec)) < 0)
 		return error;
+#ifdef CS4231
 	if ((error = snd_cs4231_timer(codec, 0, &timer)) < 0)
 		return error;
+#else /* OPTI93X */
+	error = request_irq(chip->irq, snd_opti93x_interrupt, IRQF_DISABLED, DEV_NAME" - WSS", codec);
+	if (error < 0) {
+		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
+		return error;
+	}
+#endif
 #else
 	if ((error = snd_ad1848_create(card, chip->wss_base + 4,
 				       chip->irq, chip->dma1,


----------------------------------------------------------------------
Chcesz kupic aparat? Sprawdz, ktory jest najlepszy!
Kliknij >>> http://link.interia.pl/f1cd3
