From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001049]: No sound at all
Date: Tue, 19 Apr 2005 17:55:04 +0200
Message-ID: <16b72633b07746bc97bcea980eaa235c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9058D1C2
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:55:05 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1049> 
======================================================================
Reported By:                DF5JT
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1049
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             04-13-2005 11:25 CEST
Last Modified:              04-19-2005 17:55 CEST
======================================================================
Summary:                    No sound at all
Description: 
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



======================================================================

----------------------------------------------------------------------
 tiwai - 04-13-05 16:34 
----------------------------------------------------------------------
Please attach /etc/asound.state, /proc/asound/card0/codec*/* files.

----------------------------------------------------------------------
 DF5JT - 04-13-05 16:52 
----------------------------------------------------------------------
/etc/asound.state:

state.Azalia {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 64'
                iface MIXER
                name 'Front Playback Volume'
                value.0 43
                value.1 43
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Front Playback Switch'
                value.0 true
                value.1 true
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 64'
                iface MIXER
                name 'Surround Playback Volume'
                value.0 34
                value.1 34
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 64'
                iface MIXER
                name 'Center Playback Volume'
                value 45
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 64'
                iface MIXER
                name 'LFE Playback Volume'
                value 41
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Center Playback Switch'
                value true
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'LFE Playback Switch'
                value true
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Headphone Playback Switch'
                value.0 true
                value.1 true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                value.0 18
                value.1 18
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Capture Switch'
                value.0 false
                value.1 false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                index 1
                value.0 16
                value.1 16
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Capture Switch'
                index 1
                value.0 false
                value.1 false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                index 2
                value.0 20
                value.1 20
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Capture Switch'
                index 2
                value.0 false
                value.1 false
        }
        control.16 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                comment.item.2 Line
                comment.item.3 CD
                iface MIXER
                name 'Input Source'
                value Line
        }
        control.17 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                comment.item.2 Line
                comment.item.3 CD
                iface MIXER
                name 'Input Source'
                index 1
                value CD
        }
        control.18 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                comment.item.2 Line
                comment.item.3 CD
                iface MIXER
                name 'Input Source'
                index 2
                value Mic
        }
        control.19 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.20 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.21 {
                comment.access 'read write'
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'IEC958 Playback Switch'
                value false
        }
}
pcm.default {
        type plug
        slave.pcm svol
}
pcm.svol {
        type softvol
        slave.pcm 'hw:0,0'
        control {
                name Master
        }
}

/proc/asound/card0/codec*:

Codec: Realtek ALC880
Address: 0
Vendor Id: 0x10ec0880
Subsystem Id: 0x0
Revision Id: 0x100800
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
  Amp-In vals: 0x92 0x92
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x90 0x90
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x94 0x94
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals: 0xa3 0xa3
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x2b 0x2b
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x22 0x22
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x2d 0x29
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x40 0x40
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e 0x0f
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01014020: Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01014021: Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01019022: Line Out at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01013023: Line Out at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01a19031: Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x21: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x02a19060: Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01813030: Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x02214050: HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x9933f170: CD at Int ATAPI
    Conn = ATAPI, Color = Other
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x99f3f180: Other at Int ATAPI
    Conn = ATAPI, Color = Other
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01442100: SPDIF Out at Ext Rear
    Conn = RCA, Color = Grey
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x01c42110: SPDIF In at Ext Rear
    Conn = RCA, Color = Grey
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono

----------------------------------------------------------------------
 tiwai - 04-13-05 17:19 
----------------------------------------------------------------------
First, remove non-standard definition in ~/.asoundrc until the culprit is
found.

The problem is likely the misconfiguration of assignment of pin nodes.
Try to pass module option "model=5stack" to snd-hda-intel.  And check
whether you get outputs from other jacks (surround and center/lfe).
Check even input jacks whether any sound comes out.

----------------------------------------------------------------------
 DF5JT - 04-15-05 12:08 
----------------------------------------------------------------------
I have no .asoundrc under ~/, so it is using the default configuration of
/etc/asound.state.

Indeed, there was some sound coming out of the "Front" jack, very softly
and rather distortedly when I use "model=5stack". The notebook has a
headphone jack plus "Front", "Surround" and Center as well as "Audio-In"
and an optical SPDIF-jack. I assume that would make "model=3stack-digout"
the correct module option.

What does this contents in /proc/asound/hda-intel_test/oss_mixer mean:

VOLUME "Front" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "Headphone" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

The sound device *definitely* works perfect under Linux on this computer.
There is a program called "PowerCinema Linux" on one of the partitions and
it boots into a minimal linux, using the framebuffer device and it plays
all kinds of videos, DVDs and mp3s.

So somehow the "wiring" seems to be incorrect.

Arrgh.

----------------------------------------------------------------------
 stransky - 04-15-05 12:38 
----------------------------------------------------------------------
The bug is maybee in alsa-lib-stack.patch included to alsa-utils-1.0.6, in
FC3. Could you please try remove this patch from src.rpm and test it?

----------------------------------------------------------------------
 DF5JT - 04-15-05 14:09 
----------------------------------------------------------------------
Hello Martin,

I changed the SPEC file to exclude the patch and rebuilt the package.
Alas, no change after installation and restart of the soundsystem.

----------------------------------------------------------------------
 tiwai - 04-19-05 17:52 
----------------------------------------------------------------------
Try to pass model=5stack-digout module option to snd-hda-intel module.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 11:25 DF5JT          New Issue                                    
04-13-05 11:25 DF5JT          Distribution              => Fedora Core 3   
04-13-05 11:25 DF5JT          Kernel Version            => 2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
04-13-05 11:25 DF5JT          Issue Monitored: DF5JT                       
04-13-05 16:34 tiwai          Note Added: 0004469                          
04-13-05 16:52 DF5JT          Note Added: 0004470                          
04-13-05 17:19 tiwai          Note Added: 0004473                          
04-15-05 12:08 DF5JT          Note Added: 0004497                          
04-15-05 12:38 stransky       Note Added: 0004498                          
04-15-05 14:09 DF5JT          Note Added: 0004499                          
04-19-05 17:52 tiwai          Note Added: 0004529                          
04-19-05 17:55 tiwai          Category                 PCI - azx => PCI -
hda-intel
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
