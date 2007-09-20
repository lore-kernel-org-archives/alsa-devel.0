From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] sun-cs4231: mce_down cleanup after ad1848
Date: Thu, 20 Sep 2007 16:46:18 +0200
Message-ID: <20070920164618.6d1fccac.krzysztof.h1@poczta.fm>
References: <20070919233742.c09c6f1f.krzysztof.h1@poczta.fm>
	<s5hbqbxqzsl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E360124442
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 16:38:39 +0200 (CEST)
In-Reply-To: <s5hbqbxqzsl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Sep 2007 14:36:26 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 19 Sep 2007 23:37:42 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This simplifies and fixes waiting loops of the mce_down()
> > function after Trent Piepho's patch for AD1848.
> > It also makes busy_wait() function call not atomic.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> I can't apply it cleanly on HG tree.  Which patch is missing?
> 
> 

That's my fault. I took a wrong file as a reference. The correct patch
is attached (cs4231-mce.diff).

BTW. The file which I downloaded from the HG tree does not compile.
If you can apply the patch cs4231-compile.diff there is an error in the
HG tree (introduced by importing a patch from Linux kernel). 
The cs4231-compile fixes the compilation error.

Regards,
Krzysztof




----------------------------------------------------------------------
Wygrasz, czy przegrasz?

>>> http://link.interia.pl/f1bbd

--Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P
Content-Type: application/octet-stream;
 name="cs4231-mce.diff"
Content-Disposition: attachment;
 filename="cs4231-mce.diff"
Content-Transfer-Encoding: quoted-printable

diff -urp linux-sparc/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-sparc/sound/sparc/cs4231.c	2007-09-19 23:31:16.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-20 15:37:24.859844619 +0200
@@ -400,65 +400,44 @@ static void snd_cs4231_mce_up(struct snd
=20
 static void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 {
-	unsigned long flags;
-	unsigned long end_time;
-	int timeout;
+	unsigned long flags, timeout;
+	int reg;
=20
-	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_busy_wait(chip);
+	spin_lock_irqsave(&chip->lock, flags);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("mce_down [%p] - auto calibration time out (0)\n",
 			    CS4231U(chip, REGSEL));
 #endif
 	chip->mce_bit &=3D ~CS4231_MCE;
-	timeout =3D __cs4231_readb(chip, CS4231U(chip, REGSEL));
-	__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
+	reg =3D __cs4231_readb(chip, CS4231U(chip, REGSEL));
+	__cs4231_writeb(chip, chip->mce_bit | (reg & 0x1f),
 			CS4231U(chip, REGSEL));
-	if (timeout =3D=3D 0x80)
-		snd_printdd("mce_down [%p]: serious init problem - "
-			    "codec still busy\n",
-			    chip->port);
-	if ((timeout & CS4231_MCE) =3D=3D 0) {
+	if (reg =3D=3D 0x80)
+		snd_printdd("mce_down [%p]: serious init problem "
+			    "- codec still busy\n", chip->port);
+	if ((reg & CS4231_MCE) =3D=3D 0) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
 	}
=20
 	/*
-	 * Wait for (possible -- during init auto-calibration may not be set)
-	 * calibration process to start. Needs upto 5 sample periods on AD1848
-	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
+	 * Wait for auto-calibration (AC) process to finish, i.e. ACI to go low.
 	 */
-	msleep(1);
-
-	/* check condition up to 250ms */
-	end_time =3D jiffies + msecs_to_jiffies(250);
-	while (snd_cs4231_in(chip, CS4231_TEST_INIT) &
-		CS4231_CALIB_IN_PROGRESS) {
-
-		spin_unlock_irqrestore(&chip->lock, flags);
-		if (time_after(jiffies, end_time)) {
-			snd_printk("mce_down - "
-				   "auto calibration time out (2)\n");
-			return;
-		}
-		msleep(1);
-		spin_lock_irqsave(&chip->lock, flags);
-	}
-
-	/* check condition up to 100ms */
-	end_time =3D jiffies + msecs_to_jiffies(100);
-	while (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT) {
+	timeout =3D jiffies + msecs_to_jiffies(250);
+	do {
 		spin_unlock_irqrestore(&chip->lock, flags);
-		if (time_after(jiffies, end_time)) {
-			snd_printk("mce_down - "
-				   "auto calibration time out (3)\n");
-			return;
-		}
 		msleep(1);
 		spin_lock_irqsave(&chip->lock, flags);
-	}
+		reg =3D snd_cs4231_in(chip, CS4231_TEST_INIT);
+		reg &=3D CS4231_CALIB_IN_PROGRESS;
+	} while (reg && time_before(jiffies, timeout));
 	spin_unlock_irqrestore(&chip->lock, flags);
+
+	if (reg)
+		snd_printk(KERN_ERR
+			   "mce_down - auto calibration time out (2)\n");
 }
=20
 static void snd_cs4231_advance_dma(struct cs4231_dma_control *dma_cont,

--Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P
Content-Type: application/octet-stream;
 name="cs4231-compile.diff"
Content-Disposition: attachment;
 filename="cs4231-compile.diff"
Content-Transfer-Encoding: quoted-printable

Only in linux-2.6.23/sound/sparc/: .built-in.o.cmd
Only in linux-2.6.23/sound/sparc/: built-in.o
diff -urp linux-sparc/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-sparc/sound/sparc/cs4231.c	2007-09-19 23:31:16.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-20 16:43:58.423177145 +0200
@@ -1089,10 +1068,6 @@ static int __init snd_cs4231_probe(struc
=20
 	spin_lock_irqsave(&chip->lock, flags);
=20
-
-	/* Reset DMA engine (sbus only).  */
-	chip->p_dma.reset(chip);
-
 	/* clear any pendings IRQ */
 	__cs4231_readb(chip, CS4231U(chip, STATUS));
 	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));

--Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Thu__20_Sep_2007_16_46_18_+0200_VBxB9eU0OIl+/H+P--
