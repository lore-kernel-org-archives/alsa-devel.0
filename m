From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Sun, 26 Sep 2004 15:43:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040926134347.88A5412009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EFD08292
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2004 15:43:47 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425
======================================================================
Reported By:                rncbc
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     425
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.0 Official
Kernel Version:             2.6.8-rc2
======================================================================
Date Submitted:             08-06-2004 10:53 CEST
Last Modified:              09-26-2004 15:43 CEST
======================================================================
Summary:                    usb-usx2y: System lockup on PCM device open (OHCI)
Description: 
As of ALSA 1.0.6rc1, the US-x2y PCM device driver module exposes a hard
conflict on OHCI based USB controllers, causing a complete system lockup
-- kernel oops on an interrupt handler -- exactly upon starting or
openning the PCM device for audio playback. 
======================================================================

----------------------------------------------------------------------
 rncbc - 08-06-2004 12:16 CEST 
----------------------------------------------------------------------
Just to add, that this issue does not occur as of previous
alsa-driver-1.0.5a, same platform, kernel or hardware. Seems to have been
introduced on CVS semewhere since mid-July. Something about "no sleeping"
in ALSA's pcm START/STOP callbacks, but no sure.

----------------------------------------------------------------------
 karsten - 09-23-2004 20:52 CEST 
----------------------------------------------------------------------
that seams to have something to do with a threaded IRQ10?
Does it also happen with hardirq_preempting off?
Please geneate oops traces from the 2.6.9-rc2-mmx-Sy kernel also. 
If those traces also happen in non usx2y-module area,
find out, which snd_*() call triggers the oops.
Check wether it happens if you disable hyperthreads.
Erm, did I fail to include some important errorchecks after calling
kernel/usb functions?
Run with at least ALSA debug options enabled. Other kernel debug options
may help too.

----------------------------------------------------------------------
 rncbc - 09-24-2004 09:43 CEST 
----------------------------------------------------------------------
Please note that this problem is not related to the voluntary-preempt
kernel patch nor is SMP/HT related. The machine where its beeing exposed
is a Compaq Presario 2516EA (laptop), P4 2.533GHz (UP, no-HT enabled).

Also FWIW, it doesn't matter if ACPI is enabled or not. The point where
the kernel oops occurs seems to be always under ohci_hcd (see
hard-screenshot).

----------------------------------------------------------------------
 rncbc - 09-25-2004 17:18 CEST 
----------------------------------------------------------------------
Now using 2.6.9-rc2-mm3-S6 (voluntary-preempt).

One thing I've noticed, but just related to VP, is that while having
hardirq-preempt=1 and /proc/irq/10/ohci_hcd/threaded=1, the kernel
doesn't
crash when opening the PCM hw device (either via jackd or aplay). But
still useless or zombie anyway. It does crash however when I unplug my
US-224 (switch its power down).

With hardirq-preempt=0 or /proc/irq/10/ohci_hcd/threaded=0, I get the
same
old bad behavior: a kernel oops somewhere on the ohci_irq handling,
almost
immediately when the PCM device is open (e.g. by jackd or aplay). Yet
another screenshot added here (usx2y-oops4.png).

----------------------------------------------------------------------
 karsten - 09-26-2004 15:26 CEST 
----------------------------------------------------------------------
its always dl_done_list().
Please post unassembly of the oops.
Look in linux/Documentation/oops-tracing.txt.
Do:
$gdb /lib/modules/2.6.9-rc2-mm3-S6/kernel/usb/host/ohci_hcd.ko
$disassemble dl_done_list

Or find out the point up until evrything is still ok.
Calling snd_pcm_open from i.e. jackd's alsa or usx2y driver should not
harm anything as no usb_thingy is triggered, no?
That like snd_pcm_hw_params_*() should still be ok.
Most likely things crash in snd_pcm_prepare().

Place exit() calls or debug breaks before those alsa-lib calls. 
Step by step check corresponding snd_usb_usx2y functions:
Place return -EFAULT in those functions before usb subsystem calls.
Ok, erm sounds like complicated?

Mmh, there is this CONFIG_KEXEC kernel option.
http://marc.theaimsgroup.com/?i=<20040915125041.GA15450%20()%20in%20!%20ibm%20!%20com>
Could help if it already works.

Might also set a smaller console font to get more screen estate.
making visible alsa-debug statements being dumped immediately before the
oops.

Or get yourself a pcmcia rs232 card.

edited on: 09-26-04 15:26

----------------------------------------------------------------------
 rncbc - 09-26-2004 15:28 CEST 
----------------------------------------------------------------------
After some netconsole sessions, I have uploaded here the respective output
logs, which would be a bit more intelligible than the actual but
incomplete screenshots.

Both traces are from US-224 power up and firmware initial loads and then
the kernel oops that results from issuing just a simple aplay -D hw:1
somefile.wav.

netconsole.out.0.txt traces a session with all system modules loaded for a
full functional laptop; netconsole.out.1.txt results from a session
without pcmcia and ohci1394 related stuff loaded (and therefore saving
some irq claims).

Hope this eases the search for a solution :)

----------------------------------------------------------------------
 karsten - 09-26-2004 15:43 CEST 
----------------------------------------------------------------------
Please update all of alsa-kernel/usb from cvs head.
"Badness in usb_unlink_urb at drivers/usb/core/urb.c:457" should vanish.
Redo netconsole logs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-06-04 10:53 rncbc          New Bug                                      
08-06-04 10:53 rncbc          File Added: usx2y-oops3.png                    
08-06-04 10:53 rncbc          Distribution              => Mandrake 10.0 Official
08-06-04 10:53 rncbc          Kernel Version            => 2.6.8-rc2       
08-06-04 12:16 rncbc          Bugnote Added: 0001538                       
09-23-04 20:52 karsten        Bugnote Added: 0001849                       
09-24-04 09:43 rncbc          Bugnote Added: 0001858                       
09-25-04 17:13 rncbc          File Added: usx2y-oops4.png                    
09-25-04 17:18 rncbc          Bugnote Added: 0001911                       
09-25-04 17:45 karsten        Bugnote Added: 0001912                       
09-26-04 14:54 karsten        Bugnote Edited: 0001912                      
09-26-04 15:15 rncbc          File Added: netconsole.out.0.txt                    
09-26-04 15:16 rncbc          File Added: netconsole.out.1.txt                    
09-26-04 15:26 karsten        Bugnote Edited: 0001912                      
09-26-04 15:28 rncbc          Bugnote Added: 0001921                       
09-26-04 15:43 karsten        Bugnote Added: 0001922                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
