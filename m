From: Chris Rankin <rankincj@yahoo.com>
Subject: ALSA CVS: SB-Live! (rev7) falls silent
Date: Mon, 15 Aug 2005 21:07:44 +0100 (BST)
Message-ID: <20050815200745.31071.qmail@web52910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,

My old SB-Live! soundcard has suddenly gone very quiet. It's probably a m=
ixer issue, because I can
no longer find the "Master" mixer control in either alsamixer, amixer or =
the OSS mixer. I am
suspecting that it's been reset secretly reset to zero.

My Audigy2 soundcard is working fine, however.

$ amixer
Simple mixer control 'Headphone LFE',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Headphone',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 74 [74%]
  Front Right: Playback 74 [74%]
Simple mixer control 'Headphone Center',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 15 [38%]
  Front Right: 15 [38%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 31 [78%]
  Front Right: 31 [78%]
Simple mixer control 'Surround',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 72 [72%] Capture 0 [0%] [off]
  Front Right: Playback 72 [72%] Capture 0 [0%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 76 [76%]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 76 [76%]
Simple mixer control 'Synth',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 76 [76%] Capture 76 [76%] [off]
  Front Right: Playback 76 [76%] Capture 76 [76%] [off]
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 76 [76%] Capture 76 [76%] [off]
  Front Right: Playback 76 [76%] Capture 76 [76%] [off]
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 76 [76%]
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 76 [76%]
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 84 [84%]
  Front Right: Playback 84 [84%]
Simple mixer control 'Line LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'Line2 LiveDrive',1
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'IEC958 Coaxial',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'IEC958 LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'IEC958 TTL',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 100 [100%]
  Front Right: Playback 0 [0%] Capture 100 [100%]
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

$ mixer
Usage: mixer { bass|treble|synth|pcm2|dig1 } <value>
  or   mixer { +rec|-rec } <devicename>
  or   mixer ?rec (prints the current recording source)

The PCI output is below:

02:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR-
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at d800 [size=3D32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
