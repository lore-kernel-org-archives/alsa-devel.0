From: David Fries <dfries@mail.win.org>
Subject: [PATCH] opl3sa2.c more detail on irq allocation fail
Date: Fri, 9 Jan 2004 20:08:23 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040110020823.GB2399@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I need this patch so in the future if something is taking the irq and
I don't notice it I'll at least have a message saying so.

I tried the 2.4.22 kernel and all it would tell me was that the opl3sa
module couldn't find the hardware.  Finally I went back and added some
printk messages to track down where the problem was.  It turns out
that acpi was allocating irq 5 to the pcmcia socket where 2.4.21 and
before left that interrupt free.  If I had a message like the one
below I would have had something to look for.  It turns out that
2.4.23 works fine, it just assigns all the pci devices to use irq 11,
which works, but isn't optional.

Is this the right place to send patches?

Index: opl3sa2.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/opl3sa2.c,v
retrieving revision 1.30
diff -u -r1.30 opl3sa2.c
--- opl3sa2.c	14 Oct 2003 13:08:14 -0000	1.30
+++ opl3sa2.c	10 Jan 2004 02:06:31 -0000
@@ -771,6 +771,7 @@
 	if ((err = snd_opl3sa2_detect(chip)) < 0)
 		goto __error;
 	if (request_irq(xirq, snd_opl3sa2_interrupt, SA_INTERRUPT, "OPL3-SA2/3", (void *)chip)) {
+		snd_printk(KERN_ERR "Could not allocate interrupt %d\n", xirq);
 		err = -ENODEV;
 		goto __error;
 	}

-- 
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
