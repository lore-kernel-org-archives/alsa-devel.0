From: Arek Korbik <arek.korbik@eee.strath.ac.uk>
Subject: [PATCH] intel8x0 - fixes 'periodical noisy output'
Date: Tue, 20 Apr 2004 21:22:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1082492527.1407.131.camel@deeli.eee.strath.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CtJsfO2e93NV+EAsMxtN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-CtJsfO2e93NV+EAsMxtN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

It seems, the ICH3 chipset (82801CA/CAM AC'97) in my laptop doesn't
behave according the Intel's specification: 'FIFOE interrupts' are
generated on buffer underrun/overrun even though FEIE bit is not set in
the control register. It doesn't happen too often, but when it does
happen the driver's idea of the hardware state gets 'desynchronised'
with the actual state, as interrupt handler doesn't recognise this
condition and preparing next buffer fragment increases card's LVI
register while the CIV register remains without changes - the card had
not finished processing the current fragment yet. In the result card's
CIV and LVI registers indicate the same buffer fragment, and from this
point on every buffer fragment prepared by driver is effectively the
last-and-only valid fragment available to the hardware. Which
p-p-p-pops!

To summarise: hardware generates an interrupt when it should not - the
driver should handle it (the simplest solution: ignore). The attached
patch:
 - adds interrupt-on-FIFOE handling(/ignoring) to handler routine

Possibly it addresses/resolves #0000086, #0000145, #0000131, ...?

Two notes:
 - although the solution is quite general and should not break things on
other chipset versions, I've only tested it (successfully!) on my ICH3;
 - I'm not sure how does it affect input devices - the driver initial
intention is not to handle this kind of interrupts anyway, but well...


I hope this helps and makes some of you as happy as, finally, me!

Arek


--=-CtJsfO2e93NV+EAsMxtN
Content-Description: intel8x0 interrupt-on-FIFOE handling patch
Content-Disposition: inline; filename=alsa.diff
Content-Type: text/x-patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.135
diff -b -p -u -r1.135 intel8x0.c
--- alsa-kernel/pci/intel8x0.c	14 Apr 2004 17:24:32 -0000	1.135
+++ alsa-kernel/pci/intel8x0.c	20 Apr 2004 14:51:41 -0000
@@ -777,9 +777,13 @@ static inline void snd_intel8x0_update(i
 	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
 	if (civ == ichdev->civ) {
 		// snd_printd("civ same %d\n", civ);
+		if (igetbyte(chip, port + ICH_REG_OFF_SR) & ICH_FIFOE) {
+			step = 0;
+		} else {
 		step = 1;
 		ichdev->civ++;
 		ichdev->civ &= ICH_REG_LVI_MASK;
+		}
 	} else {
 		step = civ - ichdev->civ;
 		if (step < 0)
@@ -789,6 +793,7 @@ static inline void snd_intel8x0_update(i
 		ichdev->civ = civ;
 	}
 
+	if (step > 0) {
 	ichdev->position += step * ichdev->fragsize1;
 	ichdev->position %= ichdev->size;
 	ichdev->lvi += step;
@@ -808,6 +813,7 @@ static inline void snd_intel8x0_update(i
 		spin_unlock(&chip->reg_lock);
 		snd_pcm_period_elapsed(ichdev->substream);
 		spin_lock(&chip->reg_lock);
+		}
 	}
 	iputbyte(chip, port + ichdev->roff_sr, ICH_FIFOE | ICH_BCIS | ICH_LVBCI);
 }

--=-CtJsfO2e93NV+EAsMxtN--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
