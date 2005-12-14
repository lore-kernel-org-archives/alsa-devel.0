From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001650]: Only front channel available
Date: Wed, 14 Dec 2005 09:24:55 +0100
Message-ID: <6983ed6c3d4274b308d5d1cfaf16d111@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF9FD196
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 09:24:55 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1650> 
======================================================================
Reported By:                tycordinal
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1650
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.31
======================================================================
Date Submitted:             12-14-2005 09:24 CET
Last Modified:              12-14-2005 09:24 CET
======================================================================
Summary:                    Only front channel available
Description: 
Only front channel PCM could be heard, despite that surround51 has been
selected as output device. SPDIF device opened failed.

Characteristic:
[root@oo proc]# cd asound/
[root@oo asound]# ls
card0  cards  devices  Intel  modules  oss  pcm  seq  timers  version
[root@oo asound]# ll
total 0
dr-xr-xr-x    4 root     root            0 Dec 14 16:25 card0
-r--r--r--    1 root     root            0 Dec 14 16:25 cards
-r--r--r--    1 root     root            0 Dec 14 16:25 devices
lrwxrwxrwx    1 root     root            5 Dec 14 16:25 Intel -> card0
-r--r--r--    1 root     root            0 Dec 14 16:25 modules
dr-xr-xr-x    2 root     root            0 Dec 14 16:25 oss
-r--r--r--    1 root     root            0 Dec 14 16:25 pcm
dr-xr-xr-x    2 root     root            0 Dec 14 16:25 seq
-r--r--r--    1 root     root            0 Dec 14 16:25 timers
-r--r--r--    1 root     root            0 Dec 14 16:25 version
[root@oo asound]# cd Intel
[root@oo Intel]# ls
codec#2  id  pcm0c  pcm0p
[root@oo Intel]# cat id
Intel
[root@oo Intel]# cat codec#2
Codec: SigmaTel STAC9221D A2
Address: 2
Vendor Id: 0x83847683
Subsystem Id: 0x80860013
Revision Id: 0x103201
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x0221421f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x01a19023: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x01813221: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x01114210: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN
  Pin Default 0x40f0f0f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Other
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT
  Pin Default 0x40f0f0f1: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Other
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40f0f0f2: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Other
  Pin-ctls: 0x00:
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN
  Pin Default 0x40f0f0f3: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Other
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x02a19320: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40f0f0f4: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Other
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
[root@oo Intel]#                            

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-14-05 09:24 tycordinal     New Issue                                    
12-14-05 09:24 tycordinal     Kernel Version            => 2.4.31          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
