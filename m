From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Fri,  8 Oct 2004 22:30:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008203028.4CF964800E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D7FF6258
	for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2004 22:30:28 +0200 (MEST)
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
Last Modified:              10-08-2004 22:30 CEST
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
 rncbc - 09-28-2004 22:02 CEST 
----------------------------------------------------------------------
Just uploaded netconsole.out.2.txt which is the result after updating to
full ALSA 1.0.7rc1 CVS (full update: alsa-kernel, alsa-driver, alsa-lib,
alsa-oss, alsa-tools, alsa-utils and alsa-firmware).

The ohci_hcd oops remains, but the badness on usb_unlink_urb has vanished,
as Karsten predicted.

Some other run-time info that someone might find useful:

--
# uname -a

Linux lambda 2.6.9-rc2-mm3-S6.3 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 Sun Sep 26 12:54:30 WEST 2004 i686
unknown unknown GNU/Linux

--
# cat /proc/asound/version

Advanced Linux Sound Architecture Driver Version 1.0.7rc1.
Compiled on Sep 26 2004 for kernel 2.6.9-rc2-mm3-S6.3.

--
# cat /proc/asound/cards

0 [A5451          ]: ALI5451 - ALI 5451
                     ALI 5451 at 0x1000, irq 5
1 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/003)

--
# grep . /proc/asound/*/*/xrun_debug

/proc/asound/A5451/pcm0c/xrun_debug:2
/proc/asound/A5451/pcm0p/xrun_debug:2
/proc/asound/card0/pcm0c/xrun_debug:2
/proc/asound/card0/pcm0p/xrun_debug:2
/proc/asound/card1/pcm0c/xrun_debug:2
/proc/asound/card1/pcm0p/xrun_debug:2
/proc/asound/USX2Y/pcm0c/xrun_debug:2
/proc/asound/USX2Y/pcm0p/xrun_debug:2

--
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

--
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

--
# grep . /sys/block/hd*/queue/max_sectors_kb

/sys/block/hda/queue/max_sectors_kb:16
/sys/block/hdc/queue/max_sectors_kb:16

--
# grep . /proc/sys/kernel/*_preemption

/proc/sys/kernel/hardirq_preemption:1
/proc/sys/kernel/kernel_preemption:1
/proc/sys/kernel/softirq_preemption:1
/proc/sys/kernel/voluntary_preemption:1

edited on: 09-28-04 22:02

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

----------------------------------------------------------------------
 rncbc - 09-28-2004 22:01 CEST 
----------------------------------------------------------------------
Applied "snd-usb-usx2y.patch.0.7.3+ohci_1" and there's the corresponding
sample netconsole outputs:

  netconsole.out.5.aplay_OOPS.txt
  netconsole.out.6.jackd_OOPS.txt

As you may infer from the filenames, I get kernel oops on both aplay and
jackd.

Maybe this was just another train passing over towards the light ;)

----------------------------------------------------------------------
 karsten - 09-30-2004 01:44 CEST 
----------------------------------------------------------------------
Just checked:
 dmesg.out.7.jackd-R_ABORTS.txt
 dmesg.out.8.jackd_XRUNS.txt
two things to lessen xruns:
1) You can disable disable debug output by
removing or uncommenting the snd_printd and snd_printdd macros and
rebuilding
without alsa debugging options.
2) Make shure that acpid and apmd are shutdown.
Here I run at a customized runlevel 4, where those are disabled.
or enter:
$/etc/init.d/acpid stop
$/etc/init.d/apmd stop

----------------------------------------------------------------------
 rncbc - 09-30-2004 11:44 CEST 
----------------------------------------------------------------------
In the meanwhile, Karsten has written:
> 
> just prepare a plain linux-2.6.9-rc2-mm4-VP-S7 and cp -r the contents
of
> the tar.gz into the linux tree.
>
> Works stably here on uhci_hcd with lsa and usx2y jackd.
> Had evil things happening here when using
> 	CONFIG_USB_DEBUG
> 	CONFIG_USB_BANDWIDTH
> 	CONFIG_REGPARM
> So at first don't use any of those options.
> 	CONFIG_CPU_FREQ is maybe also a showstopper.
> 

Things are really coming out of the dark tunnel :)

Following the suggestion above, the new kernel has been configured as:

 	CONFIG_USB_DEBUG not set
 	CONFIG_USB_BANDWIDTH not set
 	CONFIG_REGPARM not set (not available by VP patch, BTW)
 	CONFIG_CPU_FREQ not set

In all my previous trials, I was using CONFIG_USB_DEBUG set to Y for
obvious reasons: I was trying to collect all the USB debug info I could
get, to hand you :) I'll check soon if having back on this option makes
any difference at all (besides verbosity).

All aboard?

After untarring (usx2y_linux-2.6.9-rc2-mm4-S7.tar.gz) and arrange a proper
kernel source tree patch (linux-2.6.9-rc2-mm4-S7_usx2y.patch.gz), I
succeeded for the very first time to get my US-224 to work on my OHCI
based laptop without a kernel oops. HURRAY! Kudos to Karsten, you're a
champ!

OK. We're getting close to karma :)

However (there's always a but), running jackd is not even near perfection.
Summary is: 

1. jackd -R (realtime) is a NO GO -- see dmesg.out.7.jackd-R_ABORTS.txt. 

2. jackd (non realtime) is prone to XRUNS, if not annoyingly unreliable --
see dmesg.out.7.jackd-XRUNS.txt. 

Common thing in both modes, is the following jackd output message:

ALSA lib pcm_hw.c:521:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed:
Broken pipe

This seems that I'm now on par of bugs https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000549 and https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000541, which is
good news to say the least, given the showstopping I had before ;)

As a side note, the jackd backend driver used in my tests wre the new alsa
experimental one, specific to usx2y and named as such (-d usx2y), while
using a latest patched jackd release (notice my custom versioning:
0.99.0usx2y). 

OTOH, the same kernel, patch and jackd works on my SUSE 9.1 Pro box, P4
2.8GHz/HT SMP, UHCI based, with much less fuss -- can even run jackd -R -p
128 -n 2. However (yes, yet another but) it seems to suffer from some
periodic xruns (something like a burst of 2 consecutive xruns each 10
minutes) than before. I mean before as the original stuff posted on
jackit-devel mailing list recently
(http://sourceforge.net/mailarchive/message.php?msg_id=9597926).

Oh, just noticed Karsten's note about acpid and apmd. Those are not
started. However ACPI modules are loaded.

edited on: 09-30-04 11:44

----------------------------------------------------------------------
 karsten - 09-30-2004 02:11 CEST 
----------------------------------------------------------------------
relating
usx2yhwdeppcm.c:77:activ frame status -18
does it help if you run the laptop from batery?
sometimes usb is fragile....

----------------------------------------------------------------------
 karsten - 10-01-2004 01:23 CEST 
----------------------------------------------------------------------
please recheck version 0.8.0, which I posted to the alsa-devel list.

----------------------------------------------------------------------
 rncbc - 10-07-2004 10:42 CEST 
----------------------------------------------------------------------
Uploaded here my linux kernel patches as for snd-usb-usx2y-0.8.3 and
respective jackd sessions outputs.

These were my latest results on running jackd -R, which still hangs and
bails out in less than a minute (jack_watchdog timeout). I can see now
really badness going on ;) Take a look on the dmesg outputs attached in
the jackd*out.tar.gz archives.

Patches are based on alsa-sound kernel tree as of
linux-2.6.9-rc3-mm1(-S8), and should be applied in the following batch
sequence:

For usx2y-0.8.3:

  1.+ linux-2.6.9-usx2y-0.8.3.patch.gz

For usx2y-0.8.3a (with new hwdep pcm interface added):

  2.+ linux-2.6.9-usx2y-0.8.3a.patch.gz
  3.+ linux-2.6.9-usx2y-0.8.3a_rawusb.patch.gz

Yet again, I find worth of notice that this jackd -R showstopping behavior
only happens on my OHCI based laptop. On my desktop, about the same kernel
and patches, but UHCI based, I get excellent results when compared with
this, erm... as someone else said on alsa-devel list, nightmare ;)

No hard feelings, I must recognize we've come a long way, and I'm sure
we'll square all this out very shortly. Karsten is doing a hell of a job.

Many thanks.

----------------------------------------------------------------------
 roswel - 10-07-2004 15:55 CEST 
----------------------------------------------------------------------
I'm acutally having a UHCI based laptop, and i still run in trouble after a
random time (mostly around one hour). But I'm just discovering that my bug
stories continue in this one, so i will test the last karsten patch,
because i just tried 0.8.0.

I would also thank karsten for his hard work!

----------------------------------------------------------------------
 roswel - 10-07-2004 19:51 CEST 
----------------------------------------------------------------------
So i still run in problem on my UHCI based laptop with patch 0.8.3a. I got
exactly the same error that reported in bug 0000549. I would just had that
when i plug my tascam us122, my ehci driver died because of a fatal error
:
ehci_hcd 0000:00:1d.7: fatal error
ehci_hcd 0000:00:1d.7: HC died; cleaning up

----------------------------------------------------------------------
 behappy_ - 10-08-2004 03:40 CEST 
----------------------------------------------------------------------
i tried the -0.8.3a patches, alsa audio is fine, alsa oss emulation too,
jack just wont work, it will exit because:


willy@Zeryn:~/Samples$ jackd -d alsa -d plughw:0
jackd 0.98.1
[...]
creating alsa driver ...
plughw:0|plughw:0|1024|2|48000|0|0|nomon|swmeter|-|32bit
[...]
could not complete playback of 1024 frames: error = -32
cycle execution failure, exiting
DRIVER NT: could not run driver cycle
jack main caught signal 12

whit -s option jack works, but the sound is very very dirty. in no cases i
get kernel oops or driver's dmesg output, but i havent compiled support
for alsa debug neither for usb debug, i'm using an ohci usb controller on
a ppc architecture

----------------------------------------------------------------------
 karsten - 10-08-2004 22:30 CEST 
----------------------------------------------------------------------
Just uploaded usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz.
As before, this is for in kernel alsa compilation and holds all files
different.
New here is the use of an atomic_t state variable.
I fear, its only relevant for smp systems, nobody of us has?
The problems "sequence error ...." will propably remain the same.
Anyhow I'm looking forward to new reports based in this ;-)

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
09-28-04 21:52 rncbc          File Added: netconsole.out.5.aplay_OOPS.txt                    
09-28-04 21:52 rncbc          File Added: netconsole.out.6.jackd_OOPS.txt                    
09-28-04 22:01 rncbc          Bugnote Added: 0001957                       
09-28-04 22:02 rncbc          Bugnote Edited: 0001925                      
09-29-04 12:38 rncbc          Bug Monitored: rncbc                         
09-30-04 01:19 rncbc          File Added: usx2y_linux-2.6.9-rc2-mm4-S7.tar.gz                    
09-30-04 01:22 rncbc          File Added: linux-2.6.9-rc2-mm4-S7_usx2y.patch.gz                    
09-30-04 01:24 rncbc          File Added: dmesg.out.7.jackd-R_ABORTS.txt                    
09-30-04 01:25 rncbc          File Added: dmesg.out.8.jackd_XRUNS.txt                    
09-30-04 01:44 karsten        Bugnote Added: 0001978                       
09-30-04 02:00 rncbc          Bugnote Added: 0001979                       
09-30-04 02:11 karsten        Bugnote Added: 0001980                       
09-30-04 11:43 rncbc          Bugnote Edited: 0001979                      
09-30-04 11:44 rncbc          Bugnote Edited: 0001979                      
10-01-04 01:23 karsten        Bugnote Added: 0001988                       
10-07-04 10:24 rncbc          File Added: linux-2.6.9-usx2y-0.8.3.patch.gz                    
10-07-04 10:24 rncbc          File Added: linux-2.6.9-usx2y-0.8.3a.patch.gz                    
10-07-04 10:25 rncbc          File Added: linux-2.6.9-usx2y-0.8.3a_rawusb.patch.gz                    
10-07-04 10:26 rncbc          File Added: jackd-usx2y-0.8.3-out.tar.gz                    
10-07-04 10:26 rncbc          File Added: jackd-usx2y-0.8.3a-out.tar.gz                    
10-07-04 10:42 rncbc          Bugnote Added: 0002029                       
10-07-04 15:55 roswel         Bugnote Added: 0002033                       
10-07-04 19:51 roswel         Bugnote Added: 0002038                       
10-07-04 19:52 roswel         Bug Monitored: roswel                        
10-08-04 03:40 behappy_       Bugnote Added: 0002041                       
10-08-04 04:07 behappy_       Bug Monitored: behappy_                      
10-08-04 22:24 karsten        File Added: usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz                    
10-08-04 22:30 karsten        Bugnote Added: 0002058                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
