From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001176]: problem with alsa-driver and asus m5a notebook
Date: Fri, 12 Aug 2005 15:48:27 +0200
Message-ID: <afd3785999d5e09af6105f56812b3cab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07082211
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 15:48:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1176> 
======================================================================
Reported By:                Ballbreaker
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1176
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.12-rc5
======================================================================
Date Submitted:             06-09-2005 13:44 CEST
Last Modified:              08-12-2005 15:48 CEST
======================================================================
Summary:                    problem with alsa-driver and asus m5a notebook
Description: 
I use gentoo-linux on an asus m5a notebook. Installation of alsa-driver
works without any error messages. xmms, aplay etc. play files, but i can't
hear anything. alsa-mixer shows me all the mixer-controls. I didn't forget
to unmute, and with windows sound is working fine - so i think there is a
problem with the alsa-driver and this notebook (on other notebooks with
the same sound-chip alsa is working).

I tried the following, always with the same results:
- compile alsa in the kernel
- compile alsa as kernel modules
- emerge alsa-driver (version 1.0.9-rc3 - 1.0.9-rc4 is not in portage
yet)
- compile alsa-driver manually (version 1.0.9-rc4)

Everything seems to work fine, but i can't hear anything, so maybe this is
a bug in the alsa-driver.
Would be great if somebody could tell me how i get alsa working on my
notebook  ;-)

Greetz,
thomas


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001311 drivers load but unmuting channels / ad...
======================================================================

----------------------------------------------------------------------
 Ballbreaker - 08-11-05 19:45 
----------------------------------------------------------------------
same problem with alsa cvs version.


content of /proc/asound/card0/codec#0:

Codec: Realtek ALC880
Address: 0
Vendor Id: 0x10ec0880
Subsystem Id: 0x0
Revision Id: 0x90500
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x1d 0x1d
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a* 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x1d 0x1d
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a 0x1b 0x1c* 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c* 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals: 0xb8 0xb8
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x36 0x36
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x36 0x36
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x37 0x37
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x37 0x37
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d* 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono

----------------------------------------------------------------------
 tiwai - 08-12-05 15:48 
----------------------------------------------------------------------
Did you try model="asus" option?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 13:44 Ballbreaker    New Issue                                    
06-09-05 13:44 Ballbreaker    Distribution              => gentoo          
06-09-05 13:44 Ballbreaker    Kernel Version            => 2.6.12-rc5      
06-09-05 16:11 Ballbreaker    Issue Monitored: Ballbreaker                    
06-09-05 16:12 Ballbreaker    Issue End Monitor: Ballbreaker                    
06-09-05 16:19 Ballbreaker    Issue Monitored: Ballbreaker                    
08-05-05 08:39 perex          Relationship added       related to 0001311  
08-09-05 21:09 askel          Note Added: 0005735                          
08-11-05 14:26 tiwai          Note Added: 0005756                          
08-11-05 19:45 Ballbreaker    Note Added: 0005762                          
08-12-05 15:48 tiwai          Note Added: 0005774                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
