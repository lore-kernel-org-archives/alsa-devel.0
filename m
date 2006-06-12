From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Mon, 12 Jun 2006 23:14:42 +0200
Message-ID: <3e21efab0a821b0790cc1e4fec96da11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 854F6152
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 23:14:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174> 
======================================================================
Reported By:                carllivitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2174
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2122_FC5smp
======================================================================
Date Submitted:             05-30-2006 17:11 CEST
Last Modified:              06-12-2006 23:14 CEST
======================================================================
Summary:                    No sound at all using snd-hda-intel / alsa-1.0.11
Description: 
On my new Toshiba Satellite Pro P100 laptop, I cannot get sound from the
speakers or headphone jack. It has never worked.

I've used the standard FC5 kernel and the updated kernel
(2.6.16-1.2122FC5smp) without success. 

I've downloaded and installed the alsa-*-1.0.11 drivers etc, but still no
sound. Everything is unmuted, alsamixer can turn the volume controls up
and down, KDE's kmix also works fine but still no sound. There are no
error messages in the syslog. 

I've also tried using the 'single_cmd=1' module loading option. 

I tried the CVS version of ALSA, but it didn't work with my kernel - there
were unresolved symbols that I couldn't resolve. I'm back to using the
1.0.11 version.

======================================================================

----------------------------------------------------------------------
 carllivitt - 06-12-06 23:10 
----------------------------------------------------------------------
Aha! Thankyou, but it still doesn't work. None of the module model options
worked.  I just tried each in turn, playing a sound after each.

I checked /proc/asound/card0/codec#0 and this is what it reported:

[root@localhost Documentation]# cat /proc/asound/card0/codec#0
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
  Amp-In vals:  [0x8e 0x8e] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
  Connection: 6
     0x19 0x14 0x15* 0x1a 0x16 0x10
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


Any ideas???

----------------------------------------------------------------------
 rlrevell - 06-12-06 23:14 
----------------------------------------------------------------------
It's a driver bug, apparently your codec is not supported.  You'll have to
wait for a fix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 17:11 carllivitt     New Issue                                    
05-30-06 17:11 carllivitt     Distribution              => Fedora Core 5   
05-30-06 17:11 carllivitt     Kernel Version            => 2.6.16-1.2122_FC5smp
06-04-06 23:36 carllivitt     Issue Monitored: carllivitt                    
06-04-06 23:37 carllivitt     Note Added: 0010065                          
06-12-06 21:51 carllivitt     Note Added: 0010174                          
06-12-06 22:03 rlrevell       Note Added: 0010175                          
06-12-06 22:52 carllivitt     Note Added: 0010176                          
06-12-06 22:54 rlrevell       Note Added: 0010177                          
06-12-06 23:10 carllivitt     Note Added: 0010178                          
06-12-06 23:14 rlrevell       Note Added: 0010179                          
======================================================================
