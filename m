From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] intel8x0 - fixes 'periodical noisy output'
Date: Mon, 26 Apr 2004 09:55:22 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404260950420.20041-100000@studcom.urz.uni-halle.de>
References: <1082492527.1407.131.camel@deeli.eee.strath.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1082492527.1407.131.camel@deeli.eee.strath.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arek Korbik <arek.korbik@eee.strath.ac.uk>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Arek Korbik wrote:
> To summarise: hardware generates an interrupt when it should not - the
> driver should handle it (the simplest solution: ignore). The attached
> patch:
>  - adds interrupt-on-FIFOE handling(/ignoring) to handler routine

IMNSHO it's better to check for the buffer completion interrupt status
bit because that is the actual event we want to handle.

The patch below has been applied to CVS.


Regards,
Clemens


-- 
Index: intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.136
diff -u -r1.136 intel8x0.c
--- intel8x0.c	21 Apr 2004 18:18:27 -0000	1.136
+++ intel8x0.c	26 Apr 2004 07:41:50 -0000
@@ -775,11 +775,14 @@
 static inline void snd_intel8x0_update(intel8x0_t *chip, ichdev_t *ichdev)
 {
 	unsigned long port = ichdev->reg_offset;
-	int civ, i, step;
+	int status, civ, i, step;
 	int ack = 0;

+	status = igetbyte(chip, port + ichdev->roff_sr);
 	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
-	if (civ == ichdev->civ) {
+	if (!(status & ICH_BCIS)) {
+		step = 0;
+	} else if (civ == ichdev->civ) {
 		// snd_printd("civ same %d\n", civ);
 		step = 1;
 		ichdev->civ++;
@@ -813,7 +816,8 @@
 		snd_pcm_period_elapsed(ichdev->substream);
 		spin_lock(&chip->reg_lock);
 	}
-	iputbyte(chip, port + ichdev->roff_sr, ICH_FIFOE | ICH_BCIS | ICH_LVBCI);
+	iputbyte(chip, port + ichdev->roff_sr,
+		 status & (ICH_FIFOE | ICH_BCIS | ICH_LVBCI));
 }

 static irqreturn_t snd_intel8x0_interrupt(int irq, void *dev_id, struct pt_regs *regs)




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
