From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001209]: Headphone and Front Mic are switched
Date: Fri, 24 Jun 2005 19:14:08 +0200
Message-ID: <1761e12c3b6f3898be0eb88dffc732ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 283A51F4
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 19:14:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1209> 
======================================================================
Reported By:                alfred-ganz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1209
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-23-2005 20:02 CEST
Last Modified:              06-24-2005 19:14 CEST
======================================================================
Summary:                    Headphone and Front Mic are switched
Description: 
I installed alsa-driver-1.0.9b.tar.bz2, and the back panel
assignments that I can test seem to be assigned properly.
However, there is some sound coming out of the front mike jack,
and input is accepted through the headphone jack. Since these
jacks work as expected with Windows XP, I suspect that they are
misassigned in the driver.
Hardware: RealTek ALC655 AC'97 with ALC880(D)

Please let me know if there is anything else that you need from
me.

Thank you, AG

======================================================================

----------------------------------------------------------------------
 tiwai - 06-24-05 17:48 
----------------------------------------------------------------------
What is your machine above all?  Any relevant kernel message if you use the
CVS version (you should have one)?

You can try different model type via model=xxx module option for
snd-hda-intel.  See ALSA-Configuration.txt.

Also, attach the output of /proca/sound/card0/codec#* file for checking.

----------------------------------------------------------------------
 alfred-ganz - 06-24-05 19:14 
----------------------------------------------------------------------
Kernel messages:
kernel: ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 10 (level, low) -> IRQ
10
kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Machine is Acer APFV
Sound as stated earlier: RealTek ALC655 AC'97 with ALC880(D)
It has 6 jacks in the back, 2 jacks in the front
back output: LineOut, (Rear) SideSurround, CenterSurround, Rear,
back input: LineIn, Mic,
front output: Headphone,
front input: FrontMic.

Where can I find: "See ALSA-Configuration.txt"
did a "find" over the cvs tree, didn't find it?

Here is /proc/asound/card0/codec#2:
#########
Codec: Realtek ALC880
Address: 2
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
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 10
     0x18* 0x19 0x1a 0x1b 0x1c 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals: 0xad 0xad
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x19 0x19
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x00 0x00
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x00 0x00
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x00 0x00
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
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
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
########

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-05 20:02 alfred-ganz    New Issue                                    
06-23-05 22:35 alfred-ganz    Note Added: 0005195                          
06-23-05 23:21 alfred-ganz    Note Added: 0005197                          
06-23-05 23:29 erik           Note Added: 0005198                          
06-23-05 23:55 alfred-ganz    Note Added: 0005201                          
06-24-05 11:13 tiwai          Note Added: 0005211                          
06-24-05 15:42 alfred-ganz    Note Added: 0005229                          
06-24-05 15:46 tiwai          Note Added: 0005230                          
06-24-05 16:07 alfred-ganz    Note Added: 0005231                          
06-24-05 16:34 tiwai          Note Added: 0005234                          
06-24-05 16:42 alfred-ganz    Note Added: 0005235                          
06-24-05 16:54 alfred-ganz    Note Added: 0005236                          
06-24-05 17:26 alfred-ganz    Note Added: 0005240                          
06-24-05 17:48 tiwai          Note Added: 0005243                          
06-24-05 19:14 alfred-ganz    Note Added: 0005250                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
