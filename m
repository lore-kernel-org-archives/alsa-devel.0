From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000848]: Intel HDA (C-Media 9880) SPDIF Out
Date: Tue, 25 Jan 2005 18:14:01 +0100
Message-ID: <b1ae910f6b35ccf43eb9a898b6122820@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 46276218
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 18:14:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=848> 
======================================================================
Reported By:                1g0R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   848
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.8-ac8
======================================================================
Date Submitted:             01-25-2005 15:28 CET
Last Modified:              01-25-2005 18:14 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) SPDIF Out
Description: 
When i set in modprobe.conf the options snd-xxx model=full_dig, there is no
output signal on SPDIF (Coax).
I try:
aplay -D hw:0,1 (<--digital out) else.wav
the command run normally, but no output on spdif out.the same with xmms
(with ALSA, on hw:0,1).

======================================================================

----------------------------------------------------------------------
 jbrsubscribe - 01-25-05 18:04 
----------------------------------------------------------------------
I've also tried the SPDIF, but am unable to get sound or record anything.
I've connected the optical output to my digital decoder. The decoder can
see that there is "something" connected, but it does not reproduce the
stream from the HDA SPDIF.
I'm attaching my codec#* here.

----------------------------------------------------------------------
 jbrsubscribe - 01-25-05 18:14 
----------------------------------------------------------------------
Don't know what happened to that file, but here is my codec#

Codec: C-Media CMI9880
Address: 0
Vendor Id: 0x434d4980
Subsystem Id: 0x0
Revision Id: 0x90002
Default PCM: rates 0x540, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x07 [Audio Output] wcaps 0x615: Stereo Digital Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
  PCM: rates 0x000, bits 0x00, types 0x5
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x0a [Audio Input] wcaps 0x100791: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x0
  Connection: 1
     0x13
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01014010: Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x03
Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01813000: Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x04
Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01a19000: Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x05
Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081033f: IN OUT HP
  Pin Default 0x01011014: Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x06
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x02214000: HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x02a19000: Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0863: IN
  Pin Default 0x19330000: CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01450000: SPDIF Out at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x400281: Stereo Digital
  Pincap 0x0830: IN OUT
  Pin Default 0x01c50000: SPDIF In at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x19 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01016012: Line Out at Ext Rear
    Conn = 1/8, Color = Orange
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x20 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01012016: Line Out at Ext Rear
    Conn = 1/8, Color = Grey
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals: 0x80

And here is my /etc/asound.state
(Sorry for all this text, but I don't seem to be able to attach a file
here)

state.HDA {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Center Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'LFE Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Front Mic'
		comment.item.1 'Rear Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		value Line
	}
	control.7 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Front Mic'
		comment.item.1 'Rear Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		index 1
		value Line
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 30'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 30'
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PC Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 117
		value.1 117
	}
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-05 15:28 1g0R           New Issue                                    
01-25-05 15:28 1g0R           Distribution              => Fedora Core 3   
01-25-05 15:28 1g0R           Kernel Version            => 2.6.8-ac8       
01-25-05 18:04 jbrsubscribe   Note Added: 0003408                          
01-25-05 18:05 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-25-05 18:14 jbrsubscribe   Note Added: 0003409                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
