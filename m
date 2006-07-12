From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002276]: No sound
Date: Wed, 12 Jul 2006 08:50:01 +0200
Message-ID: <321eb9d90d57b14eb24f07ec3846dae4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1B0BE237
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 08:50:02 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2276> 
======================================================================
Reported By:                yann
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2276
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 6.06
Kernel Version:             2.6.15-26-686 SMP
======================================================================
Date Submitted:             07-12-2006 06:49 CEST
Last Modified:              07-12-2006 08:50 CEST
======================================================================
Summary:                    No sound
Description: 
Conexant codec (14f1/5047)seems unsuported:

/$ cat /proc/asound/card0/codec#0
Codec: Generic 14f1 ID 5047
Address: 0
Vendor Id: 0x14f15047
Subsystem Id: 0x1179ff31
Revision Id: 0x100000
Default PCM: rates 0x040, bits 0x02, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1e 0x1e]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
  Amp-In vals:  [0x0e 0x0e] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
  Connection: 6
     0x19* 0x14 0x15 0x1a 0x16 0x10
Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1e 0x1e]
  Pincap 0x081001c: OUT HP
  Pin Default 0xc3111010: [Both] Speaker at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 3
     0x19* 0x10 0x16
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP
  Pin Default 0x03811011: [Jack] Line In at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 2
     0x19* 0x16
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP
  Pin Default 0x03a11012: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x16 [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x0860: IN
  Pin Default 0x99330100: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Power: 0x0
Node 0x17 [Pin Complex] wcaps 0x400481: Stereo
  Pincap 0x08324: IN
  Pin Default 0xb7a00100: [Fixed] Mic at Oth Mobile-In
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x21440100: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 1
     0x11
Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals:  [0x07 0x07] [0x07 0x07] [0x80 0x80] [0x17 0x17]
  Power: 0x0
  Connection: 4
     0x10 0x1b 0x1a 0x16
Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0
  Amp-Out vals:  [0x00 0x00]
  Power: 0x0
  Connection: 3
     0x15* 0x14 0x17
Node 0x1b [Audio Selector] wcaps 0x300501: Stereo
  Power: 0x0
  Connection: 2
     0x14* 0x15
Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x08314: OUT
  Pin Default 0x90100112: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono


======================================================================

----------------------------------------------------------------------
 yann - 07-12-06 08:50 
----------------------------------------------------------------------
More infos: Toshiba doc says hda audio is Conexant CX20551-22

Maybe you also need lspci-v output, it appears in other reports (but it
seems all infos are already in codec file):

0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
        Subsystem: Toshiba America Info Systems: Unknown device ff31
        Flags: bus master, fast devsel, latency 0, IRQ 58
        Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

****

also: lsmod output (only snd_XXX printed):

snd_pcm                96708  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              26884  1 snd_pcm
snd                    60004  6
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10784  1 snd
snd_page_alloc         11304  2 snd_hda_intel,snd_pcm

****

I also noticed that with ubuntu, I don't have all controls/utils
installed. As well, for configuration, I only have alsa_base file. But
maybe it's ok (but some fixes refer to controls/files I do not have on my
system).

I'm quite a beginner with Linux, even if I already used (as user only)
other unixes in the past... so if something must be done... like
reinstalling a newer alsa without the automatism of synaptics: ie must
retrieve files, uncompact/compile/install them (where?)... please could
you also reference an up to date howto?

Feel free to ask me more infos if needed...

Regards!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-06 06:49 yann           New Issue                                    
07-12-06 06:49 yann           Distribution              => Ubuntu 6.06     
07-12-06 06:49 yann           Kernel Version            => 2.6.15-26-686 SMP
07-12-06 08:50 yann           Note Added: 0010983                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
