From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Tue, 28 Sep 2004 15:16:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928131618.236CE39006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 70A7B311
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 15:16:18 +0200 (MEST)
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
Last Modified:              09-28-2004 15:16 CEST
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

----------------------------------------------------------------------
 rncbc - 09-26-2004 22:00 CEST 
----------------------------------------------------------------------
Just uploaded netconsole.out.2.txt which is the result after updating to
full ALSA 1.0.7rc1 CVS (full update: alsa-kernel, alsa-driver, alsa-lib,
alsa-oss, alsa-tools, alsa-utils and alsa-firmware).

The ohci_hcd oops remains, but the badness on usb_unlink_urb has vanished,
as Karsten predicted.

Some other run-time info that someone might find useful:

-----------------------------------------------------------------
# uname -a

Linux lambda 2.6.9-rc2-mm3-S6.3 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 Sun Sep 26 12:54:30 WEST 2004 i686
unknown unknown GNU/Linux

-----------------------------------------------------------------
# cat /proc/asound/version

Advanced Linux Sound Architecture Driver Version 1.0.7rc1.
Compiled on Sep 26 2004 for kernel 2.6.9-rc2-mm3-S6.3.

-----------------------------------------------------------------
# cat /proc/asound/cards

0 [A5451          ]: ALI5451 - ALI 5451
                     ALI 5451 at 0x1000, irq 5
1 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/003)

-----------------------------------------------------------------
# grep . /proc/asound/*/*/xrun_debug

/proc/asound/A5451/pcm0c/xrun_debug:2
/proc/asound/A5451/pcm0p/xrun_debug:2
/proc/asound/card0/pcm0c/xrun_debug:2
/proc/asound/card0/pcm0p/xrun_debug:2
/proc/asound/card1/pcm0c/xrun_debug:2
/proc/asound/card1/pcm0p/xrun_debug:2
/proc/asound/USX2Y/pcm0c/xrun_debug:2
/proc/asound/USX2Y/pcm0p/xrun_debug:2

-----------------------------------------------------------------
# cat /proc/interrupts

           CPU0       
  0:     165578          XT-PIC  timer  0/65578
  1:        309          XT-PIC  i8042  1/309
  2:          0          XT-PIC  cascade  0/0
  5:          1          XT-PIC  ALI 5451  0/0
  8:          1          XT-PIC  rtc  0/1
  9:         21          XT-PIC  acpi  0/21
 10:       4760          XT-PIC  ohci_hcd, ohci_hcd, ohci1394, eth0 
0/4760
 11:          5          XT-PIC  yenta  5/5
 12:        114          XT-PIC  i8042  0/114
 14:       4156          XT-PIC  ide0  0/4156
 15:         11          XT-PIC  ide1  0/11
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

-----------------------------------------------------------------
# grep . /proc/irq/*/*/threaded

/proc/irq/10/eth0/threaded:1
/proc/irq/10/ohci1394/threaded:1
/proc/irq/10/ohci_hcd/threaded:0
/proc/irq/10/ohci_hcd/threaded:0
/proc/irq/11/yenta/threaded:1
/proc/irq/12/i8042/threaded:0
/proc/irq/14/ide0/threaded:1
/proc/irq/15/ide1/threaded:1
/proc/irq/1/i8042/threaded:0
/proc/irq/5/ALI 5451/threaded:0
/proc/irq/8/rtc/threaded:0
/proc/irq/9/acpi/threaded:1

-----------------------------------------------------------------
# grep . /sys/block/hd*/queue/max_sectors_kb

/sys/block/hda/queue/max_sectors_kb:16
/sys/block/hdc/queue/max_sectors_kb:16

-----------------------------------------------------------------
# grep . /proc/sys/kernel/*_preemption

/proc/sys/kernel/hardirq_preemption:1
/proc/sys/kernel/kernel_preemption:1
/proc/sys/kernel/softirq_preemption:1
/proc/sys/kernel/voluntary_preemption:1

----------------------------------------------------------------------
 karsten - 09-26-2004 22:18 CEST 
----------------------------------------------------------------------
erm, found the bug:
snd-usb-usx2y currently really can't cope with ohci,
as ohci_hcd doesn't use specified urb->start_frame values.
Only ISO_ASAP is supported and start_frame is 16Bit where
uhci start_frame is 10Bit.
... <bulb crackling> ...

----------------------------------------------------------------------
 karsten - 09-27-2004 13:51 CEST 
----------------------------------------------------------------------
Rui, please test "snd-usb-usx2y.patch.0.7.3+ohci" and feed back.
This patch applies to cvs-head only, not the experimental branch.

----------------------------------------------------------------------
 rncbc - 09-27-2004 23:49 CEST 
----------------------------------------------------------------------
OK. First results are that we're halfway there :)

Applied and installed the "snd-usb-usx2y.patch.0.7.3+ohci" patch on my
laptop, taking alsa-kernel/driver CVS HEAD as of yesterday (2004-09-26),
giving it a local version 1.0.7rc1.1.

First tests with aplay gives it a thumbs up SUCCESS! Can play and hear
actual sound from audio output (headphones), while using the intended hw:1
alsa native interface--netconsole log capture of this historic event is
engraved on "netconsole.out.3.aplay_OK.txt".

Second round, now with jackd, shows that there's still work to be done.
The edited netconsole session is given by
"netconsole.out.4.jackd_HANGS.txt". Obviously, no sound could be heard or
worked out, as the jack "alsa" backend seems to hang/loop endlessly in
usbusx2yaudio.c:844:snd_usX2Y_pcm_prepare(dbcd6794).

The exact jackd startup command line is shown as inserted on the log
capture file.

Nevertheless, given that the main showstopper (kernel oops) is about to
being solved, I'm now seeing the light at end of the tunnel ;) I hope its
not a train coming :)

Thanks Karsten.

----------------------------------------------------------------------
 karsten - 09-28-2004 15:16 CEST 
----------------------------------------------------------------------
Rui, please test "snd-usb-usx2y.patch.0.7.3+ohci_1" and feed back.
Again, this patch applies to cvs-head only, not the experimental branch.

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
09-26-04 21:52 rncbc          File Added: netconsole.out.2.txt                    
09-26-04 22:00 rncbc          Bugnote Added: 0001925                       
09-26-04 22:18 karsten        Bugnote Added: 0001927                       
09-27-04 13:48 karsten        File Added: snd-usb-usx2y.patch.0.7.3+ohci                    
09-27-04 13:51 karsten        Bugnote Added: 0001936                       
09-27-04 23:22 rncbc          File Added: netconsole.out.3.aplay_OK.txt                    
09-27-04 23:22 rncbc          File Added: netconsole.out.4.jackd_HANGS.txt                    
09-27-04 23:49 rncbc          Bugnote Added: 0001943                       
09-28-04 15:13 karsten        File Added: snd-usb-usx2y.patch.0.7.3+ohci_1                    
09-28-04 15:16 karsten        Bugnote Added: 0001945                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
