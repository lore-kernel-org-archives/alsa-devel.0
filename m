From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002016]: Choppy/skippy sound on onboard SiS SI7012-controller
Date: Wed, 12 Apr 2006 06:57:19 +0200
Message-ID: <63ba2bd95e02e6ec4ed002e9b8d52551@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC7C516C
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 06:57:19 +0200 (MEST)
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
Last Modified:              04-12-2006 06:57 CEST
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
 razorbroom - 04-12-06 06:57 
----------------------------------------------------------------------
I believe I have similar troubles with this same driver.  Chipset is also a
SiS 7012.  Using Debian with a vanilla 2.6.16 kernel but no 2.6.x kernel
I've used has solved the problems.  The choppiness is xruns I suspect.

lspci:
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at dc00 [size=256]
        I/O ports at d400 [size=64]
        Capabilities: [48] Power Management version 2

lsmod:
Module                  Size  Used by
xt_tcpudp               3136  1
iptable_filter          2304  1
snd_intel8x0           26908  0
snd_ac97_codec         90668  1 snd_intel8x0
snd_ac97_bus            1856  1 snd_ac97_codec
snd_pcm_oss            54432  0
snd_mixer_oss          16256  1 snd_pcm_oss
snd_pcm                79816  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              19844  1 snd_pcm
snd                    46848  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               6880  1 snd
snd_page_alloc          8840  2 snd_intel8x0,snd_pcm
i2c_sis630              6284  0
ip_tables              10392  1 iptable_filter
x_tables                9604  2 xt_tcpudp,ip_tables
tuner                  52140  0
tda9887                15568  0
bttv                  163836  0
usblp                  11456  0
ohci_hcd               14852  0
sr_mod                 13668  0
sym53c8xx              73108  0
scsi_transport_spi     19328  1 sym53c8xx
sidewinder             11200  0
ns558                   2056  0
gameport               10504  3 sidewinder,ns558
joydev                  8192  0
ati_remote              9736  0
radeon                106144  0
sis900                 19264  0
crc32                   4032  1 sis900
video_buf              17220  1 bttv
firmware_class          7744  1 bttv
i2c_algo_bit            8520  1 bttv
v4l2_common             6656  2 tuner,bttv
btcx_risc               4104  1 bttv
ir_common               8132  1 bttv
tveeprom               13456  1 bttv
i2c_core               16784  6
i2c_sis630,tuner,tda9887,bttv,i2c_algo_bit,tveeprom
ov511                  72596  0
compat_ioctl32          1024  2 bttv,ov511
videodev                6976  2 bttv,ov511
usb_storage            31172  0

cat /proc/asound/cards:
 0 [SI7012         ]: ICH - SiS SI7012
                      SiS SI7012 with ALC100,100P at 0xdc00, irq 11

Turned on debugging and here is a sample of what appears in dmesg when the
choppiness occurs:
XRUN: pcmC0D0p
 [<f8babd77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8b74652>] snd_intel8x0_interrupt+0x182/0x230 [snd_intel8x0]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8babd77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8b74652>] snd_intel8x0_interrupt+0x182/0x230 [snd_intel8x0]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
Unexpected hw_pointer value [2] (stream = 0, delta: -418, max jitter =
4456): wrong interrupt acknowledge? [<f8badfa9>] snd_pcm_update_hw_ptr
+0x129/0x260 [snd_pcm] [<f8ba8bb5>] snd_pcm_common_ioctl1+0x695/0x1080
[snd_pcm] [<f8b746ca>] snd_intel8x0_interrupt+0x1fa/0x230 [snd_intel8x0]
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c02e4e55>] schedule+0x2f5/0x5c0
 [<c02e54fc>] schedule_timeout+0x4c/0xc0
 [<f8bab4af>] snd_pcm_lib_write_transfer+0x9f/0xd0 [snd_pcm]
 [<c0162578>] poll_freewait+0x48/0x60
 [<c0162a82>] do_select+0x422/0x4a0
 [<f8ba9adf>] snd_pcm_playback_ioctl1+0x5f/0x4d0 [snd_pcm]
 [<f8baa9ec>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bbcbf5>] snd_pcm_oss_ioctl+0xa65/0xbe0 [snd_pcm_oss]
 [<c0161c0a>] do_ioctl+0x2a/0x80
 [<c0161cb2>] vfs_ioctl+0x52/0x2b0
 [<c016392b>] sys_select+0x11b/0x200
 [<c0161f55>] sys_ioctl+0x45/0x70
 [<c0102b45>] syscall_call+0x7/0xb

And yes, I can always reproduce this.  Usually all it takes is loading up
a bunch of images (use your imagination) in a browser and switching window
focus or changing desktops.

Ensnared: maybe if you echo 1 or 2 (as root, not sudo) to
/proc/asound/card0/pcm*/xrun_debug you can get some more info from dmesg. 
There is a kernal option (alsa debug?) that must be turned on for this to
work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 04:40 Ensnared       New Issue                                    
04-12-06 04:40 Ensnared       Distribution              => Ubuntu 5.10 "Breezy
Badger"
04-12-06 04:40 Ensnared       Kernel Version            => 2.6.x           
04-12-06 06:57 razorbroom     Note Added: 0009239                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
