From: Bob Ham <node@users.sourceforge.net>
Subject: Re: guitar + sblive + ardour + ladspa effects
Date: 31 Jul 2002 16:56:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1028130993.4010.34.camel@insanity>
References: <1027973318.10978.62.camel@insanity>
	<s5hr8hkeyqa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VjHOvaX8hjUH6u4Et2ob"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8hkeyqa.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-VjHOvaX8hjUH6u4Et2ob
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-07-31 at 15:52, Takashi Iwai wrote:

> on emu10k1, the signals from ac97 are routed to the capture fifo and
> then you can record them.  in addition, you can route other sources
> and mix them to this capture fifo.  the switch shown above does this.
> if these switches are on, then the signals from livedrive are routed
> and mixed with the signals from ac97 (if enabled).
>
> there are another switches, "Line LiveDrive Playback Volume".
> this will route the input of livedrive to the DAC, i.e. you'll hear 
> the sounds from front speakers.
> i guess, these switches are still turned on, in your case.

Something appears to be going wrong, then, as I've still not got stuff
being recorded while the "Line LiveDrive" (in alsamixer, which appears
to correspond to the "Line LiveDrive Playback" in amixer) is not turned
up.  The amixer output that is attached doesn't record what's going into
the line-in.  In fact, the only way that I can get stuff to be recorded
from the line-in is to turn up the line-in playback and turn on capture
on the "Mix" device (whatever that is.)  The amixer output for that
setup is also attached.

Bob

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/

--=-VjHOvaX8hjUH6u4Et2ob
Content-Disposition: attachment; filename=sblive-mixer.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sblive-mixer.txt; charset=UTF-8

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 31 [100%] [on]=20
  Front Right: Playback 31 [100%] [on]=20
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
Simple mixer control 'Headphone LFE',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Headphone',1
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 0 [0%] [on]=20
  Front Right: Playback 0 [0%] [on]=20
Simple mixer control 'Headphone Center',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right=20
  Mono:=20
  Front Left: Playback [off]=20
  Front Right: Playback [off]=20
Simple mixer control 'Bass',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: 0 - 40
  Mono: 19 [48%]=20
  Front Left: Playback [on]=20
  Front Right: Playback [on]=20
Simple mixer control 'Treble',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: 0 - 40
  Mono: 20 [50%]=20
  Front Left: Playback [on]=20
  Front Right: Playback [on]=20
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: volume volume-joined pswitch
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] Playback [on]=20
Simple mixer control '3D Control Sigmatel - Rear Depth',0
  Capabilities: volume volume-joined pswitch
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] Playback [on]=20
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 14 [45%] [on]=20
  Front Right: Playback 14 [45%] [on]=20
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off]=20
  Front Right: Playback 0 [0%] [off]=20
Simple mixer control 'Surround Digital',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off]=20
  Front Right: Playback 100 [100%] Capture 0 [0%] [off]=20
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 0 [0%] [on]=20
  Front Right: Playback 0 [0%] [on]=20
Simple mixer control 'Music',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [on]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [on]=20
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [on] Capture [off]=20
  Front Right: Playback 0 [0%] [on] Capture [off]=20
Simple mixer control 'Line LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 100 [100%] [on]=20
  Front Right: Playback 0 [0%] Capture 100 [100%] [on]=20
Simple mixer control 'Line LiveDrive',1
  Capabilities: pvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 100 [100%] Capture [on]=20
  Front Right: Playback 100 [100%] Capture [on]=20
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'IEC958 Coaxial',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'IEC958 Optical',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right=20
  Front Left: Playback [off]=20
  Front Right: Playback [off]=20
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15=20
  Mono: Playback 0 [0%] [off]=20
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [on]=20
  Front Right: Playback 0 [0%] [off] Capture [on]=20
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right=20
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [on]=20
  Front Right: Capture 15 [100%] [on]=20
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] [on] Capture 100 [100%]=20
  Front Right: Playback 100 [100%] [on] Capture 100 [100%]=20
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]=20

--=-VjHOvaX8hjUH6u4Et2ob
Content-Disposition: attachment; filename=sblive-mixer-rec.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sblive-mixer-rec.txt; charset=UTF-8

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 31 [100%] [on]=20
  Front Right: Playback 31 [100%] [on]=20
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
Simple mixer control 'Headphone LFE',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Headphone',1
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 0 [0%] [on]=20
  Front Right: Playback 0 [0%] [on]=20
Simple mixer control 'Headphone Center',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right=20
  Mono:=20
  Front Left: Playback [off]=20
  Front Right: Playback [off]=20
Simple mixer control 'Bass',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: 0 - 40
  Mono: 19 [48%]=20
  Front Left: Playback [on]=20
  Front Right: Playback [on]=20
Simple mixer control 'Treble',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: 0 - 40
  Mono: 20 [50%]=20
  Front Left: Playback [on]=20
  Front Right: Playback [on]=20
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: volume volume-joined pswitch
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] Playback [on]=20
Simple mixer control '3D Control Sigmatel - Rear Depth',0
  Capabilities: volume volume-joined pswitch
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] Playback [on]=20
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 17 [55%] [on]=20
  Front Right: Playback 17 [55%] [on]=20
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off]=20
  Front Right: Playback 0 [0%] [off]=20
Simple mixer control 'Surround Digital',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off]=20
  Front Right: Playback 100 [100%] Capture 0 [0%] [off]=20
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100=20
  Mono: Playback 0 [0%] [on]=20
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 0 [0%] [on]=20
  Front Right: Playback 0 [0%] [on]=20
Simple mixer control 'Music',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [on]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [on]=20
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [on] Capture [off]=20
  Front Right: Playback 0 [0%] [on] Capture [off]=20
Simple mixer control 'Line LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 54 [54%] Capture 100 [100%] [on]=20
  Front Right: Playback 54 [54%] Capture 100 [100%] [on]=20
Simple mixer control 'Line LiveDrive',1
  Capabilities: pvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100=20
  Front Left: Playback 100 [100%] Capture [on]=20
  Front Right: Playback 100 [100%] Capture [on]=20
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswit=
ch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'IEC958 Coaxial',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'IEC958 Optical',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]=20
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]=20
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right=20
  Front Left: Playback [off]=20
  Front Right: Playback [off]=20
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15=20
  Mono: Playback 0 [0%] [off]=20
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswit=
ch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right=20
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [on]=20
  Front Right: Capture 15 [100%] [on]=20
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [on]=20
  Front Right: Capture [on]=20
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] [on] Capture 100 [100%]=20
  Front Right: Playback 0 [0%] [on] Capture 100 [100%]=20
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]=20

--=-VjHOvaX8hjUH6u4Et2ob--



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
