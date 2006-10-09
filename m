From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: No Subject
Date: Mon, 09 Oct 2006 16:31:07 -0700
Message-ID: <1160436668.17297.149.camel@razman>
References: <1160435595.452ad78b8d1be@imp8-g19.free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3LBNr4du7Gp5xiOhPOUh"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160435595.452ad78b8d1be@imp8-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-3LBNr4du7Gp5xiOhPOUh
Content-Type: multipart/alternative; boundary="=-r8zbyzQbHiltY2v6ikiA"


--=-r8zbyzQbHiltY2v6ikiA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, here is a slightly different approach.  If this one works, then
there is an undocumented register in the 883 that is being used (well,
at least it's listed as vendor defined).

I also corrected the subdevice ID.

Tobin

On Tue, 2006-10-10 at 01:13 +0200, albox@free.fr wrote:

> 
> It doesn't work for me either (at least, I can load the driver after using the
> patch from Takashi).
> 
> Here are some details :
> 
> lspci -nv says:
> 0000:00:1b.0 0403: 8086:27d8 (rev 02)
>         Subsystem: 161f:2054
>         Flags: bus master, fast devsel, latency 0, IRQ 82
>         Memory at d5300000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable+
>         Capabilities: [70] #10 [0091]
> 
> $ dmesg | grep ALSA
> [17179588.696000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:680:
> codec_mask = 0x3
> [17179588.876000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:1741:
> hda_codec: model 'medion' is selected
> [17179589.604000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245:
> si3054: cannot initialize. EXT MID = 0000
> [17179589.612000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257:
> Link Frame Detect(FDT) is not ready (line status: 0000)
> [17179635.900000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1142:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> [17179635.900000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
> [17179635.908000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
> [17179635.916000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
> [17179635.924000] ALSA
> /home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
> 
> $ cat /proc/asound/card0/codec#0
> Codec: Realtek ALC883
> Address: 0
> Vendor Id: 0x10ec0883
> Subsystem Id: 0x161fd82b
> Revision Id: 0x100002
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
>   PCM: rates 0x560, bits 0x1e, types 0x1
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x160, bits 0x06, types 0x1
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x160, bits 0x06, types 0x1
>   Connection: 1
>      0x22
> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>   PCM: rates 0x560, bits 0x1e, types 0x1
>   Connection: 1
>      0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x00 0x00] [0x1f 0x1f] [0x00 0x00] [0x00 0x00] [0x00 0x00]
> [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 10
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x1f 0x1f]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x06 0x06]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x0b 0x07]
>   Connection: 2
>      0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x06 0x06]
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
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011110: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011112: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011111: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e 0x0f* 0x26
> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x02a11c3f: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x99830130: [Fixed] Line In at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x20: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x0221111f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>   Pincap 0x0820: IN
>   Pin Default 0x99830131: [Fixed] Line In at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x00:
> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
>     Conn = Optical, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x06
> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>   Pincap 0x0820: IN
>   Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear
>     Conn = RCA, Color = Orange
>   Pin-ctls: 0x00:
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x25 0x0b
> 
> 
> I also tried speaker-test but nothing happened. I'll now try the tarball that
> Remy posted last weekend and I'll let you know if it works...
> 
> Cheers,
> AL

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-r8zbyzQbHiltY2v6ikiA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Ok, here is a slightly different approach.&nbsp; If this one works, then there is an undocumented register in the 883 that is being used (well, at least it's listed as vendor defined).<BR>
<BR>
I also corrected the subdevice ID.<BR>
<BR>
Tobin<BR>
<BR>
On Tue, 2006-10-10 at 01:13 +0200, albox@free.fr wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>

<FONT COLOR="#000000">It doesn't work for me either (at least, I can load the driver after using the</FONT>
<FONT COLOR="#000000">patch from Takashi).</FONT>

<FONT COLOR="#000000">Here are some details :</FONT>

<FONT COLOR="#000000">lspci -nv says:</FONT>
<FONT COLOR="#000000">0000:00:1b.0 0403: 8086:27d8 (rev 02)</FONT>
<FONT COLOR="#000000">        Subsystem: 161f:2054</FONT>
<FONT COLOR="#000000">        Flags: bus master, fast devsel, latency 0, IRQ 82</FONT>
<FONT COLOR="#000000">        Memory at d5300000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">        Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0</FONT>
<FONT COLOR="#000000">Enable+</FONT>
<FONT COLOR="#000000">        Capabilities: [70] #10 [0091]</FONT>

<FONT COLOR="#000000">$ dmesg | grep ALSA</FONT>
<FONT COLOR="#000000">[17179588.696000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:680:</FONT>
<FONT COLOR="#000000">codec_mask = 0x3</FONT>
<FONT COLOR="#000000">[17179588.876000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:1741:</FONT>
<FONT COLOR="#000000">hda_codec: model 'medion' is selected</FONT>
<FONT COLOR="#000000">[17179589.604000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245:</FONT>
<FONT COLOR="#000000">si3054: cannot initialize. EXT MID = 0000</FONT>
<FONT COLOR="#000000">[17179589.612000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257:</FONT>
<FONT COLOR="#000000">Link Frame Detect(FDT) is not ready (line status: 0000)</FONT>
<FONT COLOR="#000000">[17179635.900000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1142:</FONT>
<FONT COLOR="#000000">azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11</FONT>
<FONT COLOR="#000000">[17179635.900000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:</FONT>
<FONT COLOR="#000000">hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11</FONT>
<FONT COLOR="#000000">[17179635.908000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:</FONT>
<FONT COLOR="#000000">hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11</FONT>
<FONT COLOR="#000000">[17179635.916000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:</FONT>
<FONT COLOR="#000000">hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11</FONT>
<FONT COLOR="#000000">[17179635.924000] ALSA</FONT>
<FONT COLOR="#000000">/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:630:</FONT>
<FONT COLOR="#000000">hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11</FONT>

<FONT COLOR="#000000">$ cat /proc/asound/card0/codec#0</FONT>
<FONT COLOR="#000000">Codec: Realtek ALC883</FONT>
<FONT COLOR="#000000">Address: 0</FONT>
<FONT COLOR="#000000">Vendor Id: 0x10ec0883</FONT>
<FONT COLOR="#000000">Subsystem Id: 0x161fd82b</FONT>
<FONT COLOR="#000000">Revision Id: 0x100002</FONT>
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
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x160, bits 0x06, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x23</FONT>
<FONT COLOR="#000000">Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x160, bits 0x06, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x22</FONT>
<FONT COLOR="#000000">Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x1f</FONT>
<FONT COLOR="#000000">Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x1f 0x1f] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">[0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Connection: 10</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17</FONT>
<FONT COLOR="#000000">Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x02 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x06 0x06]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x03 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x0b 0x07]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x04 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x06 0x06]</FONT>
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
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011110: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011112: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d* 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011111: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e* 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e 0x0f* 0x26</FONT>
<FONT COLOR="#000000">Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02a11c3f: [Jack] Mic at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x99830130: [Fixed] Line In at Int ATAPI</FONT>
<FONT COLOR="#000000">    Conn = ATAPI, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x0221111f: [Jack] HP Out at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0xc0: OUT HP</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1c [Pin Complex] wcaps 0x400001: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x1d [Pin Complex] wcaps 0x400000: Mono</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x99830131: [Fixed] Line In at Int ATAPI</FONT>
<FONT COLOR="#000000">    Conn = ATAPI, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x06</FONT>
<FONT COLOR="#000000">Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = RCA, Color = Orange</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono</FONT>
<FONT COLOR="#000000">Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]</FONT>
<FONT COLOR="#000000">[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x25 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x25 0x0b</FONT>


<FONT COLOR="#000000">I also tried speaker-test but nothing happened. I'll now try the tarball that</FONT>
<FONT COLOR="#000000">Remy posted last weekend and I'll let you know if it works...</FONT>

<FONT COLOR="#000000">Cheers,</FONT>
<FONT COLOR="#000000">AL</FONT>
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

--=-r8zbyzQbHiltY2v6ikiA--

--=-3LBNr4du7Gp5xiOhPOUh
Content-Disposition: attachment; filename=medion-test.patch
Content-Type: text/x-patch; name=medion-test.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-10-08 10:58:28.000000000 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2006-10-09 10:50:03.000000000 -0700
@@ -112,6 +112,7 @@
 	ALC883_6ST_DIG,
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
+	ALC883_MEDION,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -5080,6 +5081,8 @@
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
 	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x161f, .pci_subdevice = 0x2054,
+	  .modelname = "medion", .config = ALC883_MEDION }
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5167,6 +5170,20 @@
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_MEDION] = {
+		.mixers = { alc883_base_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc882_init_verbs,
+				alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	}
+
 };
 
 

--=-3LBNr4du7Gp5xiOhPOUh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-3LBNr4du7Gp5xiOhPOUh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-3LBNr4du7Gp5xiOhPOUh--
