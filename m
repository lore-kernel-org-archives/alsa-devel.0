From: prasannatsmkumar <prasannatsmkumar@gmail.com>
Subject: Re: Low volume with Realtek ALC 883.
Date: Thu, 20 Dec 2012 23:14:07 +0530
Message-ID: <CANc+2y6P1+3y7oUz0r_O=ZGBqRRGFgjtk3hk4_ZiUjkjyke45g@mail.gmail.com>
References: <CANc+2y6O3YT9uuc1zS9FD01Kx8ws3fZsmfyvWpvGSZZk1OviPQ@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CANc+2y6O3YT9uuc1zS9FD01Kx8ws3fZsmfyvWpvGSZZk1OviPQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 20, 2012 at 11:07 PM, prasannatsmkumar
<prasannatsmkumar@gmail.com> wrote:
> Hi ALSA people,
>
> I am having a Realtek ALC 883 chip. The sound volume is very low
> compared to what I hear in windows - I maintain same speaker volume
> and play same audio. If I keep the volume as 10% in windows I have to
> keep a volume of at least 25+% in Linux. Is there any way to improve
> it? I have been seeing such a situation for past 4 or 5 years (from
> Fedora 9 period till today). I have tried several distributions
> (Fedora, Vector Linux, PC Linux OS, Ubuntu, Mint) and all have the
> same behaviour. Currently I am running Ubuntu 11.10 with 3.5 kernel.
>
> $cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.25.
>
> Should I file a bug? If so in which component (kernel or pulseaudio)?
>
> Thanks in advance,
> PrasannaKumar

Please feel free to ask for information necessary to solve this issue.
I have copied output of some commands that may be useful for
understanding or digging this issue.

dmesg | grep hda output:
[   30.648663] snd_hda_intel 0000:00:1b.0: >irq 43 for MSI/MSI-X
[   30.716741] hda_codec: ALC883: SKU not ready 0x411111f0

lspci -vvv output (only info related audio device is in mail all
others are stripped):
00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High
Definition Audio Controller (rev 01)
    Subsystem: Intel Corporation Device d605
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 43
    Region 0: Memory at 501c0000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 4189
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=02 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

amixer output:
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 13 [42%] [-27.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [off]
  Front Right: Playback 31 [100%] [12.00dB] [off]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 3 [100%] [30.00dB]
  Front Right: 3 [100%] [30.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [off]
  Front Right: Playback 31 [100%] [12.00dB] [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 8 [26%] [0.00dB] [on]
  Front Right: Capture 8 [26%] [0.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-12.00dB] [off]
  Front Right: Capture 0 [0%] [-12.00dB] [off]
Simple mixer control '2ch-Upmix Master',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 255
  Front Left: 255 [100%]
  Front Right: 255 [100%]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Rear Mic'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Rear Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 2 [67%] [20.00dB]
  Front Right: 2 [67%] [20.00dB]

Thanks and Regards,
PrasannaKumar
