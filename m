From: Gerald Raaf <graaf@attglobal.net>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main
 board.(Summary)
Date: Sun, 28 Sep 2003 22:41:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F774771.73111352@attglobal.net>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com> <s5h7k4snyhl.wl@alsa2.suse.de> <3F539A3E.3030508@icem.com> <3F53B38B.6070307@icem.com> <3F75D029.60502@icem.com> <3F77395B.8080208@icem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

i got the same problem as Carsten, with the same behavior. And i agree with him
that it would
really nice if the nforce2 onboard soundchip would work like a cmi card.

in addition to Carsten i got some additional Information for the nforce2 chip
(ASUS A7N8X Deluxe MoBo).

I wanted to record a 1 second wav to convert it to an mp2 for dvdauthoring,
with the following command.
arecord -twav -fdat -d1 /silent.wav

with that command i got an error with "DMA or IRQ trouble" (see below). I think
that parts of the
sound-chip aren't found by driver because they use different IRQ's and Memory
regions, that would
explain the error message in syslog.
i hope with this information and the information from Carsten Koch, you will able
to find
where the problem is.

with kind regards
Gerald

part of syslog message (no additional information):
Sep 28 19:40:59 vdr-eth0 kernel: ALSA ../alsa-kernel/core/pcm_lib.c:2452: capture
read error (DMA or IRQ trouble?)


the output of lspci -vvv for nforce2 chip:
00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio
[Via VT82C686B] (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio
Controler (MCP) (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at e000 [size=256]
        Region 1: I/O ports at e400 [size=128]
        Region 2: Memory at ed080000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



and here is the output from /proc/asound/cards
0 [nForce2        ]: NFORCE - NVidia nForce2
                     NVidia nForce2 at 0xed080000, irq 21

and here is the output from /proc/asound/pcm
00-00: Intel ICH : NVidia nForce2 : playback 1 : capture 1
00-01: Intel ICH - IEC958 : NVidia nForce2 - IEC958 : playback 1

and here is the output from /proc/asound/nForce2/ac97#0

 0-0/0: Realtek ALC650 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Consumer PCM Category=0x0 Generation=0 Rate=48kHz Accuracy=0
Locked

and here is the output from /proc/asound/nForce2/ac97#0regs
0:00 = 5980
0:02 = 0000
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 0000
0:10 = 1f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0000
0:1a = 0000
0:1c = 0f0f
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 05c5
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 9f80
0:38 = 9f9f
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0004
0:62 = 4220
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0800
0:6c = 0000
0:6e = 0014
0:70 = 0211
0:72 = 00a0
0:74 = 0043
0:76 = 0000
0:78 = 8003
0:7a = 57c3
0:7c = 414c
0:7e = 4720




Carsten Koch schrieb:

> I forgot two more things:
>
> 1) If there is anything else you would like me to try out or any
>     additional information from that system, I will be glad to help.
>
> 2) Is anyone else having similar problems?
>     Is it just me or do other nforce2 users also have the feeling
>     that Alsa supports IEC958 much, much better on the CMI8738
>     than on nforce2?
>
> Thanks again and Cheers,
>
> Carsten.
>
> Carsten Koch wrote:
> > Hi,
> >
> > here is a summary of my adventures with Alsa sound through SPDIF
> > on my Abit NF7 nforce2 main board.
> >
> > First I want to thank Takashi and James for their friendly and
> > sedulous help.
> > Without them, I would have gotten no sound to work through the SPDIF
> > output at all.
> >
> > In the end, we got almost everything to work, except for the loop-through
> > from SPDIF in to SPDIF out. Unfortunately, this is a requirement
> > for me, so I gave up and now installed an additional C-Media PCI CMI8738
> > sound card on my PC, which works perfectly right out of the box.
> >
> > In particular, with the C-Media PCI CMI8738, alsamixer provides me
> > with a "IEC958 Loop" switch, which I need to loop the digital sound
> > output of my DVB card to the sound card output which is connected
> > to my HiFi equipment.
> >
> > Other things that I find *much* user-friendlier about Alsa with the
> > CMI8738 compared to Alsa with the on-board nforce 2 sound include:
> >
> > *  The CMI8738 default device (hw:0.0) plays through both the
> >    analog output and the SPDIF output at the same time. No need
> >    to tweak defaults through a .asoundrc file.
> >    The nforce2 default device (hw:0.0) only plays through the
> >    analog output.
> >
> > *  All programs I tested (mpg123, alsaplayer, mpg321, kde desktop
> >    sound) simply worked with the CMI8738. No tweaking, no special
> >    parameters, no quirks.
> >    With nforce2 sound, I needed a different tweak for each
> >    of them (if one was available at all) and some were causing
> >    strange effects. See the previous mails in this thread.
> >
> > So far my general remarks from a user perspective.
> >
> >  From a technical perspective, the nforce2 provides the following 8
> > IEC958 controls:
> >
> > % amixer controls | fgrep IEC958
> > numid=50,iface=MIXER,name='IEC958 Input Monitor'
> > numid=36,iface=MIXER,name='IEC958 Playback Con Mask'
> > numid=37,iface=MIXER,name='IEC958 Playback Pro Mask'
> > numid=40,iface=MIXER,name='IEC958 Playback AC97-SPSA'
> > numid=38,iface=MIXER,name='IEC958 Playback Default'
> > numid=39,iface=MIXER,name='IEC958 Playback Switch'
> > numid=48,iface=MIXER,name='IEC958 Capture Switch'
> > numid=49,iface=MIXER,name='Analog to IEC958 Output'
> >
> > While the CMI8738 provides the following 11 IEC958 controls:
> > % amixer controls | fgrep IEC958
> > numid=30,iface=MIXER,name='IEC958 5V'
> > numid=29,iface=MIXER,name='IEC958 Copyright'
> > numid=32,iface=MIXER,name='IEC958 In Monitor'
> > numid=37,iface=MIXER,name='IEC958 In Phase Inverse'
> > numid=38,iface=MIXER,name='IEC958 In Select'
> > numid=28,iface=MIXER,name='IEC958 In Valid'
> > numid=31,iface=MIXER,name='IEC958 Loop'
> > numid=36,iface=MIXER,name='IEC958 Mix Analog'
> > numid=34,iface=MIXER,name='IEC958 Playback Con Mask',device=2
> > numid=27,iface=MIXER,name='IEC958 Output Switch'
> > numid=33,iface=PCM,name='IEC958 Playback Default',device=2
> >
> > note in particular that the IEC958 Loop is missing on the nforce2.
> > Also, on the CMI8738, SPDIF out is available through hw:0,0 (the default
> > for most programs), while the nforce2 only gave me access to the
> > SPDIF out via hw:0,1 - and that was only 48kHz (a hardware attribute of the
> > chip), so I had to use plughw:0,1 which caused other problems.
> >
> > So, for now my problem is solved by installing an additional sound card -
> > unfortunately at the expense of a precious PCI slot. :-(
> >
> > Any work on Alsa that will make the nforce2 driver as good as the cmipci
> > driver will be highly appreciated.
> >
> > Cheers,
> >
> > Carsten.
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >
>
> --
>     ___________________________________________________________
>    (                                                           )
>    | Carsten Koch                  Phone: +49-4286-920001      |
>    | ICEM Technologies GmbH          Fax: +49-4286-1608        |
>    | Sotheler Mühlenweg 15        mailto:Carsten.Koch@icem.com |
>    | 27404 Elsdorf-Hatzte, Germany  http://www.icem.com        |
>    (___________________________________________________________)
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
