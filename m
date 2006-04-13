From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002016]: Choppy/skippy sound on onboard SiS SI7012-controller
Date: Thu, 13 Apr 2006 22:06:17 +0200
Message-ID: <520ca58042a4faa5463b50edf5f3c471@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0093178
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 22:06:17 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2016> 
======================================================================
Reported By:                Ensnared
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2016
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger"
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-12-2006 04:40 CEST
Last Modified:              04-13-2006 22:06 CEST
======================================================================
Summary:                    Choppy/skippy sound on onboard SiS SI7012-controller
Description: 
The sound on my specific sound controller is very bad. The times it even
plays, the quality is very choppy and it skips almost like a scratched CD,
which makes it pretty much unusable.

I suspect this might be specific for my model laptop as I'm having a hard
time finding anyone else with the same problem, but I've tried several
distros and kernel versions, and the card works in Windows.

The laptop is an Elite Group G732, which has a SiS mainboard chipset with
the SI7012 onboard controller (Realtek ALC202 chip).

I've tried messing with the buffer_size and period_size in asound.conf,
which seem to have some impact on the "pattern" of the chopping and
skipping, but there are no values that I've found that will get rid of
them entirely.

I'm assuming this is an incompatibility with the driver and this specific
hardware, but I could obviously be wrong.

I've tried using the version of ALSA in the 2.6.10, 2.6.12 and 2.6.16.2
kernels, as well as compiled the latest stable and developement releases
of ALSA myself. The result is the same for them all.
======================================================================

----------------------------------------------------------------------
 Ensnared - 04-13-06 21:47 
----------------------------------------------------------------------
cat /proc/asound/cards gives this:
 0 [SI7012         ]: ICH - SiS SI7012
                      SiS SI7012 with ALC202 at 0x1400, irq 18

Looks like it might be slightly different - ALC202 for me, ALC100 for you
but I don't know if this means a big difference in hardware. Since you're
having the same symptom I suspect it's pretty much the same problem
though.

I'm unable to turn on debugging as I've compiled alsa without debug
options. I can try recompiling it with debugging and see what happens.

----------------------------------------------------------------------
 Ensnared - 04-13-06 22:06 
----------------------------------------------------------------------
Recompiled the drivers --with-debug=all now and set the xrun_debug to 2 for
all three of my pcm-entries. The result from my syslog when playing a file
using aplay (with no other arguments than the filename) is this:

Apr 13 21:58:13 localhost kernel: [4294957.754000] ALSA
/home/roy/download/alsa/alsa-driver-1.0.11rc5/acore/../alsa-kernel/core/pcm_lib.c:209:
Unexpected hw_pointer value [1] (stream = 0, delta: -1023, max jitter =
8192): wrong interrupt acknowledge?
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+545175187/1069872128] snd_pcm_period_elapsed+0x3c3/0x3d0 [snd_pcm]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+544844389/1069872128] snd_intel8x0_interrupt+0x185/0x260
[snd_intel8x0]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[handle_IRQ_event+57/109] handle_IRQ_event+0x39/0x6d
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [__do_IRQ+163/252]
__do_IRQ+0xa3/0xfc
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [__do_softirq+66/145]
__do_softirq+0x42/0x91
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [do_IRQ+25/36]
do_IRQ+0x19/0x24
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[common_interrupt+26/32] common_interrupt+0x1a/0x20
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+542386745/1069872128] acpi_processor_idle+0x0/0x27f [processor]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+542387000/1069872128] acpi_processor_idle+0xff/0x27f [processor]
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [cpu_idle+60/81]
cpu_idle+0x3c/0x51
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [start_kernel+369/429]
start_kernel+0x171/0x1ad
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[unknown_bootoption+0/474] unknown_bootoption+0x0/0x1da
Apr 13 21:58:14 localhost kernel: [4294958.052000] ALSA
/home/roy/download/alsa/alsa-driver-1.0.11rc5/acore/../alsa-kernel/core/pcm_lib.c:209:
Unexpected hw_pointer value [1] 

It seems to be the same thing repeated over and over for as long as the
soundfile plays, but if the full log needs to be posted, let me know.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 04:40 Ensnared       New Issue                                    
04-12-06 04:40 Ensnared       Distribution              => Ubuntu 5.10 "Breezy
Badger"
04-12-06 04:40 Ensnared       Kernel Version            => 2.6.x           
04-12-06 06:57 razorbroom     Note Added: 0009239                          
04-13-06 21:47 Ensnared       Note Added: 0009271                          
04-13-06 22:06 Ensnared       Note Added: 0009276                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
