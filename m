From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 17 Mar 2008 23:00:41 +0100
Message-ID: <47DEEA09.9000108@keyaccess.nl>
References: <20080313042402.CE3D7DBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050005060905050709030305"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B09A6103876
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 22:59:54 +0100 (CET)
In-Reply-To: <20080313042402.CE3D7DBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050005060905050709030305
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 13-03-08 05:24, Bob Tracy wrote:

> Rene Herman wrote:
>> Okay, and applying the attached just makes your sound completely dead in the 
>> water?
>> (patch to delete es1888_init function)
> 
> Oddly enough, the patch had no effect whatsoever (at least with the
> ALSA drivers: I didn't try building a kernel with the OSS "sb" driver).
> Just to make sure I wasn't "benefiting" from initialization inherited
> from a prior boot, I even powered-down the machine for 30 seconds
> before booting on the new kernel.  snd-sb8 still works, and snd-es18xx
> is still broken (in exactly the same way as before).

Okay, thought I'd stare at this thing a bit -- there's no specific 1888 
documentation available it seems but I did notice something in the 1878 
datasheet which might mean something. The docs says that bits 0-1 are don't 
care for DMA but don't for IRQ, so could it possibly be as simple as the 
attached?

1878 sheet doesn't document register 0x7f, it seems...

Assuming it's not just this, this thing is going to require quite a bit of 
trial and error and without the hardware this will be troublesome. I expect 
this is not it, since the arch init code also doesn't care about bit 0 when 
setting that same register for IRQ 5.

If this is not it -- I'd try s/0x50/0x10/ in that line, even completely 
commenting out the IRQ setting line (with the arch code built in) and just 
generally frolic around 'till something blows up...

Rene.


--------------050005060905050709030305
Content-Type: text/plain;
 name="es18xx_trial_and_error.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx_trial_and_error.diff"

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 90498e4..71d1b96 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1449,16 +1449,16 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
 		switch (chip->irq) {
 		case 2:
 		case 9:
-			irqmask = 0;
+			irqmask = 0x0;
 			break;
 		case 5:
-			irqmask = 1;
+			irqmask = 0x5;
 			break;
 		case 7:
-			irqmask = 2;
+			irqmask = 0xa;
 			break;
 		case 10:
-			irqmask = 3;
+			irqmask = 0xf;
 			break;
 		default:
 			snd_printk(KERN_ERR "invalid irq %d\n", chip->irq);
@@ -1497,7 +1497,7 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
 		}
 
 		/* Enable and set Audio 1 IRQ */
-		snd_es18xx_write(chip, 0xB1, 0x50 | (irqmask << 2));
+		snd_es18xx_write(chip, 0xB1, 0x50 | irqmask);
 		/* Enable and set Audio 1 DMA */
 		snd_es18xx_write(chip, 0xB2, 0x50 | (dma1mask << 2));
 		/* Set Audio 2 DMA */
@@ -1513,7 +1513,9 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip)
 			   FM enabled */
 			snd_es18xx_mixer_write(chip, 0x40, 0x43 | (chip->mpu_port & 0xf0) >> 1);
 		}
+#if 0
 		snd_es18xx_mixer_write(chip, 0x7f, ((irqmask + 1) << 1) | 0x01);
+#endif
 	}
 	if (chip->caps & ES18XX_NEW_RATE) {
 		/* Change behaviour of register A1

--------------050005060905050709030305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050005060905050709030305--
