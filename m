From: Bob Ham <node@users.sourceforge.net>
Subject: Re: sblive line capture woes
Date: Fri, 18 Oct 2002 19:10:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021018181045.GB20966@depression.ath.cx>
References: <1027973318.10978.62.camel@insanity> <s5hr8hkeyqa.wl@alsa2.suse.de> <20021018175259.GA20966@depression.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021018175259.GA20966@depression.ath.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2002 at 06:53:20PM +0100, Bob Ham wrote:

> The output of amixer is attached, so as there's no ambiguity.

It is now, at least

Bob
--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amixer-failed-capture.txt"

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 28 [90%] [on] 
  Front Right: Playback 28 [90%] [on] 
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [off] 
Simple mixer control 'Headphone LFE',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Headphone',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 100 
  Front Left: Playback 0 [0%] 
  Front Right: Playback 0 [0%] 
Simple mixer control 'Headphone Center',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right 
  Mono: 
  Front Left: Playback [off] 
  Front Right: Playback [off] 
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right 
  Limits: 0 - 40
  Mono: 20 [50%] 
  Front Left: 
  Front Right: 
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right 
  Limits: 0 - 40
  Mono: 20 [50%] 
  Front Left: 
  Front Right: 
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] 
Simple mixer control '3D Control Sigmatel - Rear Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] 
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 19 [61%] [on] 
  Front Right: Playback 19 [61%] [on] 
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities:
  Mono: 
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] 
  Front Right: Playback 0 [0%] [off] 
Simple mixer control 'Surround Digital',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off] 
  Front Right: Playback 100 [100%] Capture 0 [0%] [off] 
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 100 [100%] 
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 100 [100%] 
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off] 
  Front Right: Playback 100 [100%] Capture 0 [0%] [off] 
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 0 [0%] 
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 0 [0%] 
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 100 
  Front Left: Playback 0 [0%] 
  Front Right: Playback 0 [0%] 
Simple mixer control 'Music',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] Capture 0 [0%] [off] 
  Front Right: Playback 100 [100%] Capture 0 [0%] [off] 
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'Line LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 100 [100%] [on] 
  Front Right: Playback 0 [0%] Capture 100 [100%] [on] 
Simple mixer control 'Line LiveDrive',1
  Capabilities: pvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 
  Front Left: Playback 0 [0%] Capture [off] 
  Front Right: Playback 0 [0%] Capture [off] 
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [on] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono: 
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [off] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'IEC958 Coaxial',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off] 
  Front Right: Playback 0 [0%] Capture 0 [0%] [off] 
Simple mixer control 'IEC958 Optical',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off] 
  Front Right: Playback 0 [0%] Capture 0 [0%] [off] 
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right 
  Front Left: Playback [off] 
  Front Right: Playback [off] 
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15 
  Mono: Playback 0 [0%] [off] 
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [on] 
  Front Right: Playback 0 [0%] [off] Capture [on] 
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono: 
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right 
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [on] 
  Front Right: Capture 15 [100%] [on] 
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 100 [100%] 
  Front Right: Playback 0 [0%] Capture 100 [100%] 
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 

--J/dobhs11T7y2rNN--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
