From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Trying to write a codec,
	can someone help me with	the basics?
Date: Thu, 26 Oct 2006 12:01:45 -0700
Message-ID: <1161889305.18211.114.camel@razman>
References: <a6f0b350610261154l7c91cf1drd9f16fa0d6480665@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a6f0b350610261154l7c91cf1drd9f16fa0d6480665@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: enigma_0Z <enigma.0za@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am planning on adding support for the 5045 series of Conexant codecs
to my patch once I shake out the initial bugs.  I should be checking
this in tomorrow.  It would be best to have all of the Conexant support
in one code file.  If you do get something working, though, let me know
and I'll integrate your code in.

I'll add your device id when I get started on the 5045 code.

Thanks,

Tobin

On Thu, 2006-10-26 at 14:54 -0400, enigma_0Z wrote:
> Hi all,
> 
> I've got an HP dv6000z laptop with internal speakers, line out, line
> in, a built-in mic, and spdif out. The chipset is an nVidia MCP51.
> 
> --lspci--
> 00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio
> (rev a2) 
> --lspci -v
> 00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio
> (rev a2)
>         Subsystem: Hewlett-Packard Company Unknown device 30b7
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50 
>         Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>         Capabilities: [6c] HyperTransport: MSI Mapping 
> --lspci -vn
> 00:10.1 0403: 10de:026c (rev a2)
>         Subsystem: 103c:30b7
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
>         Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>         Capabilities: [6c] HyperTransport: MSI Mapping
> --cat /proc/asound/card0/codec#0 (when headphone and speakers are
> working) 
> Codec: Generic 14f1 ID 5045
> Address: 0
> Vendor Id: 0x14f15045
> Subsystem Id: 0x103c30b7
> Revision Id: 0x100100
> Default PCM: rates 0x140, bits 0x0e, types 0x1
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A 
> Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x21 0x21]
>   Pincap 0x0810014: OUT EAPD Detect
>   Pin Default 0x92170010: [Fixed] Speaker at Int Front 
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 2
>      0x19* 0x17
> Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1 
>   Amp-Out vals:  [0x1c 0x1c]
>   Pincap 0x08113c: IN OUT HP Detect
>   Pin Default 0x01214020: [Jack] HP Out at Ext Rear
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0xc0: OUT HP
>   Power: 0x0
>   Connection: 2 
>      0x19* 0x17
> Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x2b 0x2b]
>   Pincap 0x08113c: IN OUT HP Detect
>   Pin Default 0x01813030: [Jack] Line In at Ext Rear 
>     Conn = 1/8, Color = Blue
>   Pin-ctls: 0x20: IN
>   Power: 0x0
>   Connection: 2
>      0x19 0x17*
> Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x21447040: [Jack] SPDIF Out at Sep Rear 
>     Conn = RCA, Color = Yellow
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x18
> Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
>   Pincap 0x081124: IN Detect
>   Pin Default 0x97a70050: [Fixed] Mic at Int Riser 
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x20: IN
> Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x99330060: [Fixed] CD at Int ATAPI
>     Conn = ATAPI, Color = Unknown 
>   Pin-ctls: 0x00:
> Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
>   Amp-Out vals:  [0x06]
> Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In 
>   Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
>   Amp-In vals:  [0x94 0x94] [0x17 0x17] [0x94 0x94] [0x94 0x94] [0x94
> 0x94]
>   Power: 0x0
>   Connection: 5
>      0x19 0x14 0x12 0x11 0x15
> Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital 
>   PCM: rates 0x040, bits 0x06, types 0x5
> Node 0x19 [Audio Output] wcaps 0xc11: Stereo
>   PCM: rates 0x540, bits 0x0e, types 0x1
>   Power: 0x0
> Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1 
>   Amp-In vals:  [0x97 0x97] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
> 0x00]
>   Power: 0x0
>   Connection: 5
>      0x17 0x14 0x12 0x11 0x15*
> Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
> 
> I've got a hacked version of alsa 1.0.12 that only partially fixes the
> problem. It makes the mixers come up peroperly, but only sometimes. If
> they come up wrong, instead of having headphones, speaker, and PCM, I
> have PCM and master, and the headphone jacks (spdif and line-out) are
> disabled entirely. If I reboot the system, however (no full poweroff),
> when the computer comes back up, everything is proper. 
> 
> In windows, the device comes up as a conexant chip. I've tried a fix
> on the alsa bugtrac, but it is for the 5047 chip, and this says that
> the chip ID is '5045'. So I am trying to write my own codec for the
> card. My questions are: 
> 
> 0. Is there a kernel option or an option to the alsa module to make it
> always come up like above?
> 1. Should I write a new driver or a codec and what's the difference?
> 2. How do I write a codec/driver for a sound card 
> 3. How do I use the information from /proc/asound/card0/codec#0 to
> write the codec/driver?
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
