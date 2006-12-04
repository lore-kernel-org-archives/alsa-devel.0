From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 15:45:57 -0800
Message-ID: <1165275957.32312.103.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>  <45748CF5.8040800@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1375700490=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45748CF5.8040800@sourcegear.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@sourcegear.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1375700490==
Content-Type: multipart/alternative; boundary="=-iE8OwkZh2sjqmt2yu4N5"


--=-iE8OwkZh2sjqmt2yu4N5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Couple of other things I'd need to look at.  Could you stop the driver
(modprobe -r snd-hda-intel), clear the dmesg log (dmesg -c), then reload
the driver and send the dmesg output?  I'd like to verify the pins being
detected with what is configured in the driver.  Also, the lspci command
output didn't include the subsystem ID which is odd.  It should have had
a line similar to "Subsystem: Unknown device 1631:c017".

For grins, try "model=arima".  This should toggle the eapd control bit.

Tobin

On Mon, 2006-12-04 at 15:02 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > Well, to start, we'll need to know the exact codec information.  Type
> > "cat /proc/asound/card0/codec*" to find out.  To add your specific
> > configuration to the driver (if it isn't in the tree already), we'll
> > also need the subsystem ID from lspci.  Assuming the audio device is on
> > pci bus 0:1b.0, type 'lspci -s 0:1b -vn" to get that.
> 
> I should have included those in my first message, sorry (they're at the
> bottom of this one).  Thanks for your help.
> 
> >From there, it's probably just a matter of trying different config
> > models from the ALSA-Configuration.txt (it's in
> > alsa-driver-1.0.13/alsa-kernel/Documentation if you downloaded the
> > driver source, or it is in the kernel documentation).
> 
> I've tried a dozen or so, and they all seem to load correctly and
> correctly influence the mixers.  I'll verify I was trying the right ones.
> 
> hansen:~% sudo lspci -s 0:1b -vn
> 00:1b.0 0403: 8086:269a (rev 09)
> 	Flags: bus master, fast devsel, latency 0, IRQ 225
> 	Memory at 92f00000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 	Capabilities: [70] Express Unknown type IRQ 0
> 
> Codec: Realtek ALC885
> Address: 0
> Vendor Id: 0x10ec0885
> Subsystem Id: 0x106b0c00
> Revision Id: 0x100103
> Default PCM: rates 0x560, bits 0x0e, types 0x1
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x04 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x05 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>   PCM: rates 0x5e0, bits 0x1e, types 0x1
> Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x560, bits 0x0e, types 0x1
>   Connection: 1
>      0x24
> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x560, bits 0x0e, types 0x1
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x560, bits 0x0e, types 0x1
>   Connection: 1
>      0x22
> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>   PCM: rates 0x560, bits 0x1e, types 0x1
>   Connection: 1
>      0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x95 0x95] [0x97 0x97] [0x00
> 0x00] [0x10 0x10] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
>   Connection: 10
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x33 0x33]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x05 0x0b
> Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x01014150: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x88a0967c, nsteps=0x03, stepsize=0x100, mute=25
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083c: IN OUT HP Detect
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083c: IN OUT HP Detect
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e 0x0f* 0x26
> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x02214040: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x01813110: [Jack] Line In at Ext Rear
>     Conn = 1/8, Color = Blue
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x90100130: [Fixed] Speaker at Int N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x20: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08373c: IN OUT HP Detect
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x20: IN
> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>   Pincap 0x0820: IN
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x20: IN
> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x0145e160: [Jack] SPDIF Out at Ext Rear
>     Conn = Optical, Color = White
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x06
> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>   Pincap 0x0820: IN
>   Pin Default 0x01c5e120: [Jack] SPDIF In at Ext Rear
>     Conn = Optical, Color = White
>   Pin-ctls: 0x20: IN
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x88a0967c, nsteps=0x03, stepsize=0x100, mute=25
>   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80
> 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80]
>   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>   Amp-Out vals:  [0x40 0x40]
>   Connection: 2
>      0x25 0x0b
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-iE8OwkZh2sjqmt2yu4N5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Couple of other things I'd need to look at.&nbsp; Could you stop the driver (modprobe -r snd-hda-intel), clear the dmesg log (dmesg -c), then reload the driver and send the dmesg output?&nbsp; I'd like to verify the pins being detected with what is configured in the driver.&nbsp; Also, the lspci command output didn't include the subsystem ID which is odd.&nbsp; It should have had a line similar to &quot;Subsystem: Unknown device 1631:c017&quot;.<BR>
<BR>
For grins, try &quot;model=arima&quot;.&nbsp; This should toggle the eapd control bit.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2006-12-04 at 15:02 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; Well, to start, we'll need to know the exact codec information.  Type</FONT>
<FONT COLOR="#000000">&gt; &quot;cat /proc/asound/card0/codec*&quot; to find out.  To add your specific</FONT>
<FONT COLOR="#000000">&gt; configuration to the driver (if it isn't in the tree already), we'll</FONT>
<FONT COLOR="#000000">&gt; also need the subsystem ID from lspci.  Assuming the audio device is on</FONT>
<FONT COLOR="#000000">&gt; pci bus 0:1b.0, type 'lspci -s 0:1b -vn&quot; to get that.</FONT>

<FONT COLOR="#000000">I should have included those in my first message, sorry (they're at the</FONT>
<FONT COLOR="#000000">bottom of this one).  Thanks for your help.</FONT>

<FONT COLOR="#000000">&gt;From there, it's probably just a matter of trying different config</FONT>
<FONT COLOR="#000000">&gt; models from the ALSA-Configuration.txt (it's in</FONT>
<FONT COLOR="#000000">&gt; alsa-driver-1.0.13/alsa-kernel/Documentation if you downloaded the</FONT>
<FONT COLOR="#000000">&gt; driver source, or it is in the kernel documentation).</FONT>

<FONT COLOR="#000000">I've tried a dozen or so, and they all seem to load correctly and</FONT>
<FONT COLOR="#000000">correctly influence the mixers.  I'll verify I was trying the right ones.</FONT>

<FONT COLOR="#000000">hansen:~% sudo lspci -s 0:1b -vn</FONT>
<FONT COLOR="#000000">00:1b.0 0403: 8086:269a (rev 09)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0, IRQ 225</FONT>
<FONT COLOR="#000000">	Memory at 92f00000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">	Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-</FONT>
<FONT COLOR="#000000">	Capabilities: [70] Express Unknown type IRQ 0</FONT>

<FONT COLOR="#000000">Codec: Realtek ALC885</FONT>
<FONT COLOR="#000000">Address: 0</FONT>
<FONT COLOR="#000000">Vendor Id: 0x10ec0885</FONT>
<FONT COLOR="#000000">Subsystem Id: 0x106b0c00</FONT>
<FONT COLOR="#000000">Revision Id: 0x100103</FONT>
<FONT COLOR="#000000">Default PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Default Amp-In caps: N/A</FONT>
<FONT COLOR="#000000">Default Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">Node 0x02 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x03 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x04 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x05 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM: rates 0x5e0, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x24</FONT>
<FONT COLOR="#000000">Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x23</FONT>
<FONT COLOR="#000000">Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x22</FONT>
<FONT COLOR="#000000">Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x1f</FONT>
<FONT COLOR="#000000">Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x95 0x95] [0x97 0x97] [0x00</FONT>
<FONT COLOR="#000000">0x00] [0x10 0x10] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]</FONT>
<FONT COLOR="#000000">  Connection: 10</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17</FONT>
<FONT COLOR="#000000">Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x33 0x33]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x02 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x03 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x04 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x05 0x0b</FONT>
<FONT COLOR="#000000">Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01014150: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Green</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d* 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x88a0967c, nsteps=0x03, stepsize=0x100, mute=25</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e* 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e 0x0f* 0x26</FONT>
<FONT COLOR="#000000">Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02214040: [Jack] HP Out at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Green</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01813110: [Jack] Line In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Blue</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x90100130: [Fixed] Speaker at Int N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08373c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0xc0: OUT HP</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1c [Pin Complex] wcaps 0x400001: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">Node 0x1d [Pin Complex] wcaps 0x400000: Mono</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">  Pin Default 0x0145e160: [Jack] SPDIF Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = White</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x06</FONT>
<FONT COLOR="#000000">Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x01c5e120: [Jack] SPDIF In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = White</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono</FONT>
<FONT COLOR="#000000">Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono</FONT>
<FONT COLOR="#000000">Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x88a0967c, nsteps=0x03, stepsize=0x100, mute=25</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80</FONT>
<FONT COLOR="#000000">0x80]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x25 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x40 0x40]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x25 0x0b</FONT>

</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-iE8OwkZh2sjqmt2yu4N5--



--===============1375700490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1375700490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1375700490==--
