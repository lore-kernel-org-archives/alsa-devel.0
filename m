From: Tim Goetze <tim@quitte.de>
Subject: via82xx 1.0.0rc1 experience
Date: Thu, 4 Dec 2003 13:47:07 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312041139490.458@autumn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

i have a new box with an ASRock K7VM2 board, it comes with an on-board
audio interface:

<lspci -vv>
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
        Subsystem: Unknown device 1849:3059
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at cc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
</lspci>

it works fine on 2.4.22 with alsa-driver-1.0.0rc1 and these module
options:

<modules.conf>
options snd-via82xx index=0 id=ac97 ac97_clock=48000 dxs_support=2
</modules.conf>

other dxs_support values cause block-size *and* erratic distortion in
the output sound. ac97_clock=44100 causes slowed-down playback.

however, to enable analog output (only one present on the board) the
mixer controls for 'headphone' not 'master' must be unmuted (volume
and playback switch). since they aren't accessible from alsamixer this
had me puzzling for a while.

before i turned on CONFIG_X86_UP_IOAPIC, the relevant IRQ was shared
between eth0, usb-uhci and snd-via82xx. as a result, when the PCM was
playing, it stopped when there was eth0 traffic (IRQ dropped?) and
resumed playing when the mouse was moved (usb-uhci IRQ?). the oss
driver (via82cxxx_audio) played steadily under the same circumstances.
now things work perfectly however, another welcome opportunity for me
to thank you for your fine efforts.

one question remains: iiutc, the hw DACs run at a fixed rate of 48kHz.
then again when playing 44.1 kHz audio i read this:

<hw_params>
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 2048
buffer_size: 16384
tick_time: 10000
OSS format: S16_LE
OSS channels: 2
OSS rate: 44100
OSS period bytes: 8192
OSS periods: 8
</hw_params>

so is my understanding about fixed-rate DACs incorrect, or is there
resampling going on? the output audio quality is quite good fwiw.

tim


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
