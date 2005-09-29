From: Chris Rankin <rankincj@yahoo.com>
Subject: SB Live! (5.1) has gone silent again with ALSA CVS
Date: Thu, 29 Sep 2005 15:28:25 +0100 (BST)
Message-ID: <20050929142826.9947.qmail@web52902.mail.yahoo.com>
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

This happened before, then fixed itself but is now broken again: my SB Li=
ve! 5.1 (rev 7) card has
lost its Master Volume mixer control, and is now languishing in silence.

02:0a.0 Class 0401: 1102:0002 (rev 07)
        Subsystem: 1102:8061
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR-
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at d800 [size=3D32]
        Capabilities: <available only to root>

02:0a.1 Class 0980: 1102:7002 (rev 07)
        Subsystem: 1102:0020
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR-
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 32
        Region 0: I/O ports at d400 [size=3D8]
        Capabilities: <available only to root>

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
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
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
  Front Left: 20 [50%]
  Front Right: 20 [50%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 20 [50%]
  Front Right: 20 [50%]
Simple mixer control 'Front',0
  Capabilities: pvolume cvolume cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off]
  Front Right: Playback 100 [100%] Capture 0 [0%] [off]
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

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
