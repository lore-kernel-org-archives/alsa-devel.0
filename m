From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Mon, 18 Oct 2004 23:07:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018210710.DE82C11030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4A8DC2F2
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2004 23:07:11 +0200 (MEST)
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
Last Modified:              10-18-2004 23:07 CEST
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

----------------------------------------------------------------------
 karsten - 10-10-2004 15:37 CEST 
----------------------------------------------------------------------
This one makes a difference: usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz
After switching to my via-chipset-baset PC, I suddenly found myself in the
club of the "sequence error" victims ;-)
On that via system its ok now: no "sequence error" no more.
also made two real crash bugs vanish.
So please test this and forget the
usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz.
As before setup a 2.6.9xyz kernel, cp the tar's content into it and build
everything inside the kernel.
The rawusb version isn't yet done.

----------------------------------------------------------------------
 roswel - 10-10-2004 18:45 CEST 
----------------------------------------------------------------------
Ok, i will try it now, but i've a question. When you say : "... and build
everything inside the kernel.", do you mean that i should not build it as
a module? Because actually, i always build my kernel with snd-usb-ux2y as
a module, as all the asla stuffs.

----------------------------------------------------------------------
 karsten - 10-10-2004 20:27 CEST 
----------------------------------------------------------------------
"... and build everything inside the kernel." means:
use only the kernel tree, not the alsa-kernel or alsa-driver tree.
to build as module is ok.

----------------------------------------------------------------------
 roswel - 10-11-2004 21:13 CEST 
----------------------------------------------------------------------
I'm sorry to say that it still crash. After about one hour, jack crash with
the following log :
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe (pipe))

and the following kernel log : 
Oct 12 02:58:10 localhost kernel: Sequence Error!(hcd_frame=1639
ep=10out;wait=613,frame=614).
Oct 12 02:58:10 localhost kernel: Most propably some urb of usb-frame 613
is still missing.
Oct 12 02:58:10 localhost kernel: Cause could be too long delays in
usb-hcd interrupt handling.
Oct 12 02:58:10 localhost kernel: This driver definitely wants 1 interrupt
per ms.
Oct 12 02:58:10 localhost kernel: To make it work for a system that can't
deliver interrupts reliably at that rate,
Oct 12 02:58:10 localhost kernel: You'd have to make it work for NRPACKS >
1. To start, grep for NRPACKS in this code ;-)Oct 12 02:58:10 localhost
kernel: usx2yaudio.c:268:0 c28df840 state=8
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:268:1 c28df800 state=8
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:281:0 status=0
start_frame=614
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:281:1 status=-115
start_frame=613
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:281:0 status=0
start_frame=614
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:281:1 status=-115
start_frame=613
Oct 12 02:58:10 localhost kernel: usx2yaudio.c:328:hcd_frame=1639 ep=8in
status=0 start_frame=614
Oct 12 02:58:11 localhost kernel: usx2yaudio.c:328:hcd_frame=614 ep=10out
status=0 start_frame=613
Oct 12 02:58:11 localhost kernel: usx2yaudio.c:328:hcd_frame=614 ep=8in
status=0 start_frame=613
Oct 12 02:58:16 localhost kernel:
usx2yaudio.c:637:snd_usX2Y_pcm_trigger(STOP)
Oct 12 02:58:16 localhost kernel:
usx2yaudio.c:637:snd_usX2Y_pcm_trigger(STOP)
Oct 12 02:58:16 localhost kernel:
usx2yaudio.c:888:snd_usX2Y_hw_free(ce708bc0)
Oct 12 02:58:16 localhost kernel: usx2yaudio.c:458:usX2Y_urbs_release()
10
Oct 12 02:58:16 localhost kernel: usx2yaudio.c:458:usX2Y_urbs_release() 8
Oct 12 02:58:16 localhost kernel:
usx2yaudio.c:888:snd_usX2Y_hw_free(ce708b00)
Oct 12 02:58:16 localhost kernel: usx2yaudio.c:458:usX2Y_urbs_release() 8


I also got 4 xruns while i was not using my laptop, just listening music
(i've no xruns using jackd on my intel_i8x0), coming with the following
kernel log :

Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:637:snd_usX2Y_pcm_trigger(STOP)
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:637:snd_usX2Y_pcm_trigger(STOP)
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:923:snd_usX2Y_pcm_prepare(ce708b00)
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:422:usX2Y_substream_prepare(c28df800) ep=8 urb0=d4be8100
urb1=d4be8180
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:923:snd_usX2Y_pcm_prepare(ce708bc0)
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:422:usX2Y_substream_prepare(c28df840) ep=10 urb0=d4be8200
urb1=d4be8280
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:624:snd_usX2Y_pcm_trigger(START)
Oct 12 02:55:27 localhost kernel:
usx2yaudio.c:624:snd_usX2Y_pcm_trigger(START)

But i've a good point for this patch! I can now relaunch jackd without
having to restart my laptop :)

Hope it will be helpful for you :)

And thanx again for your hard work!

----------------------------------------------------------------------
 rncbc - 10-14-2004 11:25 CEST 
----------------------------------------------------------------------
Hi,

After taking usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz, which needed
some janitor editing, like removing a few references to the experimental
hwdeppcm stuff (aka as needed for jack usx2y backend driver), I've
rearranged it to build for 2.6.9-rc4-mm1, and uploaded the plain kernel
patch here (linux-2.6.9-usx2y-0.8.3c.patch.gz). 

Please, notice that "my" snd-usb-usx2y version is 0.8.3c. Don't know if
this is "legal" but decided likewise just to be certain in running the
correct module version amongst the plethora of kernels I have around here
these days :)

OK, things are that general results are no big difference from previous
versions: jackd don't stand for long, either in realtime mode (-R) or not.
See the test sessions outputs I could collect and also uploaded here:

  usx2y_jackd-R.{0,1}.out - for jackd running realtime: the behavior is
still the same as previously reported: jackd -R stalls and is always
kicked out by the jack_watchdog quite shortly after it's launched.

  usx2y_jackd.{0,1}.out - for jackd running non-realtime: the "sequence"
errors seems to ge gone, but not for good: they still appear now and then
(e.g. only one shows up, in one of these tests). On every occasion, after
a minute or so from being started, jackd stalls on some annoyingly ALSA
poll timeouts (~34secs), hosing the complete session. This situation is
exposed on the usx2y_jackd.1.out session log file.

Note: the difference between the 0 and 1 files are the number of process
cycles jackd was allowed to run for the test sessions: 0=1000cycles,
1=10000cycles.

Hope this helps.
Cheers.

edited on: 10-14-04 11:25

----------------------------------------------------------------------
 behappy_ - 10-14-2004 15:26 CEST 
----------------------------------------------------------------------
dunno if it helps, but i can run jack with the oss driver just fine with
this driver version:

filename:      
/lib/modules/2.6.9-rc3-ShouldWork/kernel/sound/usb/usx2y/snd-usb-usx2y.ko
author:         Karsten Wiese <annabellesgarden@yahoo.de>
description:    TASCAM US-X2Y Version 0.8.3a
license:        GPL
parm:           index:Index value for US-X2Y.
parm:           id:ID string for US-X2Y.
parm:           enable:Enable US-X2Y.
vermagic:       2.6.9-rc3-ShouldWork gcc-3.3
depends:        snd-usb-lib,snd-page-alloc,snd-pcm,snd,snd-hwdep
alias:          usb:v1604p8001dl*dh*dc*dsc*dp*ic*isc*ip*
alias:          usb:v1604p8007dl*dh*dc*dsc*dp*ic*isc*ip*
alias:          usb:v1604p8005dl*dh*dc*dsc*dp*ic*isc*ip*

----------------------------------------------------------------------
 karsten - 10-15-2004 01:30 CEST 
----------------------------------------------------------------------
behapppy_:
you run it on ohci or uhci?

----------------------------------------------------------------------
 karsten - 10-15-2004 01:40 CEST 
----------------------------------------------------------------------
usx2y_linux-2.6.9-rc2-mm4-S7_041014.tar.gz
has NRPACKS configurable from 1 to 4.
tested ok here @uhci.
Bigger values == worse latency but more error tolerant

AND:
a changed, untested (don't have ohci chip) ohci-hcd.c!!!
Please check it out, especially with this ohci-hcd.c. If things work on
ohci, I'll get back to the rawusb thing ;-)

----------------------------------------------------------------------
 rncbc - 10-15-2004 12:06 CEST 
----------------------------------------------------------------------
Uploaded kernel diff patches against 2.6.9-rc4-mm1, for convenience and
reference:

  linux-2.6.9-rc4-mm1_usx2y-0.8.3d.patch.gz - snd-usb-usx2y stuff only.
  linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz - ohci-hcd changes only.

Karsten, please review the ohci-hcd patch and check if it has your
specific changes. Incidentally, your ohci-hcd.c file version (as of the
usx2y_linux-2.6.9-rc2-mm4-S7_041014.tar.gz archive) is an old one, which
breaks the ALi usb controller initialization on my laptop.

Couldn't test yet, as my US-224 is far away atm.

BTW, How exactly is NRPACKS configurable?

----------------------------------------------------------------------
 behappy_ - 10-15-2004 12:55 CEST 
----------------------------------------------------------------------
yep, OHCI

willy@Zeryn:~$ lspci | grep USB
0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo/Pangea USB
0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo/Pangea USB
willy@Zeryn:~$ dmesg | grep ohci
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0001:10:18.0: Apple Computer Inc. KeyLargo/Pangea USB
ohci_hcd 0001:10:18.0: irq 27, pci mem c9010000
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:10:19.0: Apple Computer Inc. KeyLargo/Pangea USB (https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002)
ohci_hcd 0001:10:19.0: irq 28, pci mem c9012000
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:19.0: wakeup
willy@Zeryn:~$

----------------------------------------------------------------------
 karsten - 10-16-2004 00:38 CEST 
----------------------------------------------------------------------
the linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz looks ok! really wonder if it
works....
NRPACKS is currently only configurable at compile time. see usbusx2y.h.

edited on: 10-16-04 00:38

----------------------------------------------------------------------
 rncbc - 10-16-2004 00:58 CEST 
----------------------------------------------------------------------
With usx2y-0.8.3d and ohci-hcd patches applied, jackd results are no better
than before. I find the situation is quite the same: jackd stalls.

I still don't know how to tweak NRPACKS > 1. Is it via hardcoded in the
module source code, or is it an isotheric module parameter?

P.S. Oops. Seen the previous bugnote edit. So I'll have to go on 
hardcoding ;)

edited on: 10-16-04 00:58

----------------------------------------------------------------------
 rncbc - 10-16-2004 03:05 CEST 
----------------------------------------------------------------------
OK. Did try the NRPACKS increase path, and things got a LOT better. jackd
doesn't stall anymore, at least as systematic as before. 

Summary: NRPACKS=3 seems to be a mistake, can't even open alsa backend,
don't know why. Proceeding with NRPACKS=4, and wondered no more, jack -R
just works now.

Output info has been yet again collected and uploaded, and this time just
while running jackd in realtime mode (jackd -R):

usx2y_jack-R.3.out - for snd-usb-usx2y built with NRPACKS=3.
usx2y_jack-R.4.out - same with NRPACKS=4.

However I've noticed some quirks, like jack_watchdog killing jackd by no
reason I could catch. Sometimes it goes all the way, on and on, some other
times not.

Then, I've took real advantage of the RT preemption as of Ingo's
2.6.9-rc4-mm1-RT-U3 kernel patch(es) and after some tweaks on the
SCHED_FIFO priorities of some IRQ handlers, including the one for
ohci_hcd, the miracle seems to become real. :)

I'm actually running `jackd -R -dalsa -r44100 -n2' at this precise moment,
for almost an hour non-stop. No xrun, no artifact, no nothing. Am I
dreaming already?

Seems strange, in my whole ignorance, that NRPACKS=3 didn't made it. But
with NRPACKS=4 I got finally out of the tunnel darkness ;)

So, what next? Making this nrpacks a module parameter? Or does it tell
something on whether the ohci related code path should be really
improved?

Real beats me, for now ;)

Cheers and hurray!

----------------------------------------------------------------------
 karsten - 10-16-2004 14:15 CEST 
----------------------------------------------------------------------
some Qs:
with the U3 preemption patch, IRQ thread priority setting is a must.
Can you retry with smaller NRPACKS and OHCI IRQ thread priority set to
higher than jackd's?
Does the ohci-hcd patch make any difference relating usx2y function and
that bug:
"Debug: sleeping function called from invalid context jackd(11306) at
kernel/mutex.c:25
in_atomic():1 [00000001], irqs_disabled():0" ?

The reason for NRPACKS=3 not working relates to these messages:
"usx2yaudio.c:277:0 status=0 start_frame=31741
usx2yaudio.c:277:1 status=-115 start_frame=31744
usx2yaudio.c:277:0 status=-115 start_frame=31745
usx2yaudio.c:277:1 status=-115 start_frame=31742"
first two lines show playback urb's attributes,
line 3 and four capture urb's attributes.
Things don't work in this case, cause playback and capture urbs don't
start/finish in the same usb-frame: 31741 <> 31742.
This should not happen with the ohci-hcd patch.
So please recheck if the patch is active and  if it makes any difference.

edited on: 10-16-04 14:15

----------------------------------------------------------------------
 rncbc - 10-16-2004 16:31 CEST 
----------------------------------------------------------------------
OK again. 

So I checked about the ohci-hcd patch, and to my suprprise I found that it
wasn't been applied at all. My mistake. So all of my previous reports,
even the successful ones, were about using the stock ohci-hcd source.

But that doesn't seem to matter anymore :) 

As Karten's suggested, and I have also confirmed several times now, that
by just making the ohci_hcd service thread (IRQ 10 in my case, YMMV), with
SCHED_FIFO policy and realtime priority a bit higher than jackd's, I get a
pretty working US-224 on jackd -R, even with NRPACKS=1 !!!! :)

As I said, the overall behavior doesn't seem to be affected by the
ohci-hcd patch, whether applied or not.

Here's a litle script I use to set the usb controller service thread
priority, and is candidate for inclusion in the boot/init sequence of my
laptop, permanentely :)

  #!/bin/sh
  #
  ACTION=$1
  NAME=$2
  PRIO=$3  
  IRQS=`grep "$NAME" /proc/interrupts | awk -F: '{print $1}'`
  for IRQ in $IRQS; do
    PID=`pidof "IRQ $IRQ"`
    case $ACTION in
    start)
      echo -n "`basename $0`: start $NAME: prio=$PRIO irq=$IRQ pid=$PID:
"
      chrt --pid --fifo $PRIO $PID && echo "OK" || echo "FAILED"
      ;;
    stop)
      echo -n "`basename $0`: stop $NAME: irq=$IRQ pid=$PID: "
      chrt --pid --other 0 $PID && echo "OK" || echo "FAILED"
      ;;
    status)
      echo "`basename $0`: status $NAME: irq=$IRQ pid=$PID:"
      chrt --pid --verbose $PID
      ;;
    *)
      echo "Usage: `basename $0` {start|stop|status} name [prio]"
      exit 1
      ;;
    esac
  done


For example, if you name this script as "chrt_irq.sh":

1) To make OHCI realtime high,

   chrt_irq.sh start ohci_hcd 60

2) To stop OHCI realtime service,

   chrt_irq.sh stop ohci_hcd

3) To check the status of the OHCI service,

   chrt_irq.sh status ohci_hcd


Of course, you need rml's scheutils for chrt, and the latest of mingo's
voluntary-preempt kernel patch, for this to work with best results, if any
at all.

Cheers.

----------------------------------------------------------------------
 karsten - 10-16-2004 23:13 CEST 
----------------------------------------------------------------------
do me a favour and check NRPACKS=3 with the ohci-hcd patch!
(and OHCI thread priority higher than jack's of course ....)
Please post a dmesg log of that. Really want to know, if the patch works!

edited on: 10-16-04 23:13

----------------------------------------------------------------------
 rncbc - 10-17-2004 02:20 CEST 
----------------------------------------------------------------------
With ohci-hcd patch, RT scheduling high priority trick and NRPACKS=3, I
could let my US-224 to run through jackd -R very smoothly.

See uploaded usx2y_jackd-R.3a.out session output file, with requested
dmesg output in session context line. It is a rather normal and healthy
one, if i may say. 

IMO, I found these results very hard to distinguish from any other, with
the hardcoded settings as NRPACKS=1,2 or 4.

Cheers.

----------------------------------------------------------------------
 karsten - 10-17-2004 13:44 CEST 
----------------------------------------------------------------------
tnx for checking this out. Looks like the ohci-hcd patch can do good.

This bug should be addressed though:
"Debug: sleeping function called from invalid context jackd(10518) at
kernel/mutex.c:25
in_atomic():1 [00000001], irqs_disabled():0
 [<c0115699>] __might_sleep+0xbc/0xcf
 [<c012d0ae>] _mutex_lock+0x2b/0x66
 [<c012d121>] _mutex_lock_irqsave+0x16/0x1a
 [<e00514f5>] hcd_submit_urb+0x4a/0x1a0 [usbcore]
 [<e0174d2d>] usX2Y_urbs_start+0x133/0x26c [snd_usb_usx2y]
......."

Please load snd-usb-usx2y.ko into gdb like this:
$gdb
/lib/modules/2.6.9-rc4-mm1-RT-U3.1/kernel/sound/usb/usx2y/snd-usb-usx2y.ko

than in gdb do
gdb> disassemble usX2Y_urbs_start

and post the output here.

Could also be something caused by the Ingo's U3 stuff?
It also happens without the ohci-hcd patch and inside _mutex_lock_irqsave,
so I think its a good idea to ask Ingo to comment on this bug on lkml.
Maybe first upgrade to the U4(or newer) patch and if the bug shows there
still, post the bug to Ingo on lkml.

edited on: 10-17-04 13:44

----------------------------------------------------------------------
 rncbc - 10-17-2004 22:46 CEST 
----------------------------------------------------------------------
OK. Just uploaded the required info, but with latest 2.6.9-rc4-mm1-RT-U4. 

Those "Debug" traces are only exposed due to CONFIG_DEBUG_PREEMPT and/or 
CONFIG_DEBUG_SPINLOCK_SLEEP being set on the kernel config. Besides that,
the jackd session runs just loud and clear, no xruns, no crackles, no
watchdogs biting from behind ;)

IMHO, this bug thread is almost finished and probable to be closed now, as
the original topic (ohci kernel oops) has been solved. 

OTOH, Karsten, you have my strongest vote to commit this into the
alsa-kernel tree, with fingers crossed to make it in time to the 1.0.7
release. Time is ticking... :)

----------------------------------------------------------------------
 rncbc - 10-18-2004 23:07 CEST 
----------------------------------------------------------------------
For the sake of completeness, I've uploaded here the latest snd-usb-usx2y
version 0.8.4, posted on alsa-devel from Karsten Wiese and rearranged by
me as a plain kernel source tree diff patch (as for 2.6.9-rc4-mm1).

It has been confirmed to build, load and run without incident, as far as 
2.6.9-rc4-mm1-RT-U4 can provide.

Think that's now ready for prime time.

Cheers.

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
10-10-04 15:30 karsten        File Added: usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz                    
10-10-04 15:37 karsten        Bugnote Added: 0002066                       
10-10-04 18:45 roswel         Bugnote Added: 0002067                       
10-10-04 20:27 karsten        Bugnote Added: 0002068                       
10-11-04 21:13 roswel         Bugnote Added: 0002085                       
10-14-04 10:41 rncbc          File Added: linux-2.6.9-usx2y-0.8.3c.patch.gz                    
10-14-04 10:42 rncbc          File Added: usx2y_jackd.0.out                    
10-14-04 10:43 rncbc          File Added: usx2y_jackd.1.out                    
10-14-04 10:43 rncbc          File Added: usx2y_jackd-R.0.out                    
10-14-04 10:44 rncbc          File Added: usx2y_jackd-R.1.out                    
10-14-04 11:21 rncbc          Bugnote Added: 0002138                       
10-14-04 11:25 rncbc          Bugnote Edited: 0002138                      
10-14-04 15:26 behappy_       Bugnote Added: 0002150                       
10-15-04 01:30 karsten        Bugnote Added: 0002162                       
10-15-04 01:32 karsten        File Added: usx2y_linux-2.6.9-rc2-mm4-S7_041014.tar.gz                    
10-15-04 01:40 karsten        Bugnote Added: 0002163                       
10-15-04 11:37 rncbc          File Added: linux-2.6.9-rc4-mm1_usx2y-0.8.3d.patch.gz                    
10-15-04 11:37 rncbc          File Added: linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz                    
10-15-04 12:06 rncbc          Bugnote Added: 0002164                       
10-15-04 12:55 behappy_       Bugnote Added: 0002165                       
10-16-04 00:36 karsten        Bugnote Added: 0002178                       
10-16-04 00:38 karsten        Bugnote Edited: 0002178                      
10-16-04 00:41 rncbc          File Added: usx2y_jackd.2.out                    
10-16-04 00:42 rncbc          File Added: usx2y_jackd-R.2.out                    
10-16-04 00:52 rncbc          Bugnote Added: 0002179                       
10-16-04 00:58 rncbc          Bugnote Edited: 0002179                      
10-16-04 02:35 rncbc          File Added: usx2y_jackd-R.3.out                    
10-16-04 02:35 rncbc          File Added: usx2y_jackd-R.4.out                    
10-16-04 03:05 rncbc          Bugnote Added: 0002182                       
10-16-04 13:58 karsten        Bugnote Added: 0002187                       
10-16-04 14:13 karsten        Bugnote Edited: 0002187                      
10-16-04 14:15 karsten        Bugnote Edited: 0002187                      
10-16-04 14:15 karsten        Bugnote Edited: 0002187                      
10-16-04 16:31 rncbc          Bugnote Added: 0002188                       
10-16-04 23:11 karsten        Bugnote Added: 0002189                       
10-16-04 23:13 karsten        Bugnote Edited: 0002189                      
10-17-04 02:09 rncbc          File Added: usx2y_jackd-R.3a.out                    
10-17-04 02:20 rncbc          Bugnote Added: 0002190                       
10-17-04 13:32 karsten        Bugnote Added: 0002191                       
10-17-04 13:38 karsten        Bugnote Edited: 0002191                      
10-17-04 13:44 karsten        Bugnote Edited: 0002191                      
10-17-04 22:26 rncbc          File Added: usx2y_jackd-R.out-2.6.9-rc4-mm1-RT-U4.0                    
10-17-04 22:27 rncbc          File Added: gdb_disassemble_usX2Y_urbs_start-2.6.9-rc4-mm1-RT-U4.0                    
10-17-04 22:46 rncbc          Bugnote Added: 0002193                       
10-18-04 22:56 rncbc          File Added: linux-2.6.9-rc4-mm1_usx2y-0.8.4.patch.gz                    
10-18-04 23:07 rncbc          Bugnote Added: 0002200                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
