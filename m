From: Quentin Denis <quentin@brinkum2005.de>
Subject: Mic on the Envy24 (ICE 1712)
Date: Wed, 7 Jul 2004 12:26:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407071226.29418.quentin@brinkum2005.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi @ all!

i've some problems activating my microphone on my terratec soundcard with t=
he=20
envy24-chip! here is the output of amixer:

=2D----------------------------------------------------------

Simple mixer control 'IEC958',0
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'IEC958 Multi',0
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 66 [69%] [on]
=A0 Front Right: Capture 66 [69%] [on]
Simple mixer control 'IEC958 Multi',1
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 66 [69%] [on]
=A0 Front Right: Capture 66 [69%] [on]
Simple mixer control 'IEC958',1
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'ADC',0
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 113 [89%]
Simple mixer control 'ADC',1
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 114 [90%]
Simple mixer control 'ADC',2
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 115 [91%]
Simple mixer control 'ADC',3
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 113 [89%]
Simple mixer control 'ADC',4
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 113 [89%]
Simple mixer control 'ADC',5
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 112 [88%]
Simple mixer control 'Analog Input Select',0
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'Breakbox LED',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]
Simple mixer control 'DAC',0
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 122 [96%]
Simple mixer control 'DAC',1
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 97 [76%]
Simple mixer control 'DAC',2
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 96 [76%]
Simple mixer control 'DAC',3
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 97 [76%]
Simple mixer control 'DAC',4
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 96 [76%]
Simple mixer control 'DAC',5
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 127
=A0 Mono: 97 [76%]
Simple mixer control 'Deemphasis',0
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'Deemphasis',1
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'Deemphasis',2
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'Front Digital Input',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]
Simple mixer control 'H/W',0
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W',1
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W',2
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W',3
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W',4
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W',5
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'H/W Multi',0
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 68 [71%] [on]
=A0 Front Right: Capture 68 [71%] [on]
Simple mixer control 'H/W Multi',1
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 70 [73%] [on]
=A0 Front Right: Capture 70 [73%] [on]
Simple mixer control 'H/W Multi',2
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 70 [73%] [on]
=A0 Front Right: Capture 70 [73%] [on]
Simple mixer control 'H/W Multi',3
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 68 [71%] [on]
=A0 Front Right: Capture 68 [71%] [on]
Simple mixer control 'H/W Multi',4
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 68 [71%] [on]
=A0 Front Right: Capture 68 [71%] [on]
Simple mixer control 'H/W Multi',5
=A0 Capabilities: cvolume cswitch
=A0 Capture channels: Front Left - Front Right
=A0 Limits: Capture 0 - 96
=A0 Front Left: Capture 68 [71%] [on]
=A0 Front Right: Capture 68 [71%] [on]
Simple mixer control 'IPGA Analog',0
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'IPGA Analog',1
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'IPGA Analog',2
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'IPGA Analog',3
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'IPGA Analog',4
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'IPGA Analog',5
=A0 Capabilities: cvolume
=A0 Capture channels: Mono
=A0 Limits: Capture 0 - 36
=A0 Mono: Capture 0 [0%]
Simple mixer control 'Multi',0
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 74 [77%] [on]
=A0 Front Right: Playback 74 [77%] [on]
Simple mixer control 'Multi',1
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 72 [75%] [on]
=A0 Front Right: Playback 72 [75%] [on]
Simple mixer control 'Multi',2
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 73 [76%] [on]
=A0 Front Right: Playback 73 [76%] [on]
Simple mixer control 'Multi',3
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 73 [76%] [on]
=A0 Front Right: Playback 73 [76%] [on]
Simple mixer control 'Multi',4
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 72 [75%] [on]
=A0 Front Right: Playback 72 [75%] [on]
Simple mixer control 'Multi',5
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 76 [79%] [on]
=A0 Front Right: Playback 76 [79%] [on]
Simple mixer control 'Multi',6
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 74 [77%] [on]
=A0 Front Right: Playback 74 [77%] [on]
Simple mixer control 'Multi',7
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 64 [67%] [on]
=A0 Front Right: Playback 64 [67%] [on]
Simple mixer control 'Multi',8
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 70 [73%] [on]
=A0 Front Right: Playback 70 [73%] [on]
Simple mixer control 'Multi',9
=A0 Capabilities: pvolume pswitch
=A0 Playback channels: Front Left - Front Right
=A0 Limits: Playback 0 - 96
=A0 Front Left: Playback 72 [75%] [on]
=A0 Front Right: Playback 72 [75%] [on]
Simple mixer control 'Multi Track Internal Clock',0
=A0 Capabilities:
=A0 Mono:
Simple mixer control 'Multi Track Peak',0
=A0 Capabilities: volume
=A0 Playback channels: Front Left - Front Right - Front Center - Rear Left =
=2D=20
Rear Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?=
=20
=2D ? - ?
=A0 Limits: 0 - 255
=A0 Mono: 0 [0%]
=A0 Front Left:
=A0 Front Right:
=A0 Front Center:
=A0 Rear Left:
=A0 Rear Right:
=A0 Woofer:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
=A0 ?:
Simple mixer control 'Multi Track Rate Locking',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]
Simple mixer control 'Multi Track Rate Reset',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]
Simple mixer control 'Multi Track Volume Rate',0
=A0 Capabilities: volume volume-joined
=A0 Playback channels: Mono
=A0 Limits: 0 - 255
=A0 Mono: 5 [2%]
Simple mixer control 'Optical Digital Input',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]
Simple mixer control 'Phono Analog Input',0
=A0 Capabilities: pswitch pswitch-joined
=A0 Playback channels: Mono
=A0 Mono: Playback [on]

=2D-------------------------------------------------------------

i don't really know how to do!^^

thx for help!

Quentin


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
