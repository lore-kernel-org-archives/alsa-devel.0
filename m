From: Bob Ham <node@users.sourceforge.net>
Subject: Re: sblive line capture woes
Date: Fri, 18 Oct 2002 21:03:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021018200317.GA22229@depression.ath.cx>
References: <20021018175259.GA20966@depression.ath.cx> <Pine.LNX.4.33.0210181920240.626-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210181920240.626-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2002 at 07:22:08PM +0200, Jaroslav Kysela wrote:

> Please, send us output from 'amixer scontents' and 'amixer contents' to 
> figure out the problem. Thanks.

Attached.

Bob

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amixer-contents.txt"

numid=40,iface=MIXER,name='Master Mono Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=41,iface=MIXER,name='Master Mono Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=36,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=37,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=22,22
numid=33,iface=MIXER,name='Headphone Center Playback Switch',index=1
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=34,iface=MIXER,name='Headphone LFE Playback Switch',index=1
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=32,iface=MIXER,name='Headphone Playback Volume',index=1
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=28,iface=MIXER,name='Tone Control - Bass'
  ; type=INTEGER,access=rw---,values=2,min=0,max=40,step=0
  : values=20,20
numid=30,iface=MIXER,name='Tone Control - Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=29,iface=MIXER,name='Tone Control - Treble'
  ; type=INTEGER,access=rw---,values=2,min=0,max=40,step=0
  : values=20,20
numid=63,iface=MIXER,name='3D Control - Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=66,iface=MIXER,name='3D Control Sigmatel - Depth'
  ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
  : values=0
numid=67,iface=MIXER,name='3D Control Sigmatel - Rear Depth'
  ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
  : values=0
numid=62,iface=MIXER,name='PCM Out Path & Mute'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'pre 3D'
  ; Item #1 'post 3D'
  : values=0
numid=57,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=58,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=23,23
numid=12,iface=MIXER,name='Surround Digital Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=11,iface=MIXER,name='Surround Digital Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=10,iface=MIXER,name='Surround Digital Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=100,100
numid=38,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=39,iface=MIXER,name='Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=13,iface=MIXER,name='Center Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=100
numid=14,iface=MIXER,name='LFE Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=100
numid=3,iface=MIXER,name='Wave Center Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=0
numid=4,iface=MIXER,name='Wave LFE Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=0
numid=2,iface=MIXER,name='Wave Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=1,iface=MIXER,name='Wave Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=100,100
numid=6,iface=MIXER,name='Wave Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=5,iface=MIXER,name='Wave Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=7,iface=MIXER,name='Music Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=100,100
numid=9,iface=MIXER,name='Music Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=8,iface=MIXER,name='Music Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=22,iface=MIXER,name='Line LiveDrive Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=27,iface=MIXER,name='Line LiveDrive Capture Switch',index=1
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=21,iface=MIXER,name='Line LiveDrive Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=100,100
numid=20,iface=MIXER,name='Line LiveDrive Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=26,iface=MIXER,name='Line LiveDrive Playback Volume',index=1
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=49,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=50,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=51,iface=MIXER,name='CD Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=52,iface=MIXER,name='CD Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=48,iface=MIXER,name='Mic Boost (+20dB)'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=65,iface=MIXER,name='Mic Select'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Mic1'
  ; Item #1 'Mic2'
  : values=0
numid=46,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=47,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=44,iface=MIXER,name='Phone Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=45,iface=MIXER,name='Phone Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=53,iface=MIXER,name='Video Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=54,iface=MIXER,name='Video Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=42,iface=MIXER,name='PC Speaker Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=43,iface=MIXER,name='PC Speaker Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=0
numid=55,iface=MIXER,name='Aux Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=56,iface=MIXER,name='Aux Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=64,iface=MIXER,name='Mono Output Select'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Mix'
  ; Item #1 'Mic'
  : values=1
numid=59,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=3,3
numid=60,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=61,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=25,iface=MIXER,name='IEC958 Coaxial Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=24,iface=MIXER,name='IEC958 Coaxial Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=23,iface=MIXER,name='IEC958 Coaxial Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=19,iface=MIXER,name='IEC958 Optical Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=18,iface=MIXER,name='IEC958 Optical Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=17,iface=MIXER,name='IEC958 Optical Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=31,iface=MIXER,name='IEC958 Optical Raw Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=166,iface=MIXER,name='IEC958 Playback Default'
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=168,iface=MIXER,name='IEC958 Playback Default',index=1
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=170,iface=MIXER,name='IEC958 Playback Default',index=2
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=165,iface=MIXER,name='IEC958 Playback Mask'
  ; type=IEC958,access=r----,values=1
  : values=?
numid=167,iface=MIXER,name='IEC958 Playback Mask',index=1
  ; type=IEC958,access=r----,values=1
  : values=?
numid=169,iface=MIXER,name='IEC958 Playback Mask',index=2
  ; type=IEC958,access=r----,values=1
  : values=?
numid=16,iface=MIXER,name='AC97 Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=100,100
numid=15,iface=MIXER,name='AC97 Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=69,iface=MIXER,name='EMU10K1 PCM Send Routing'
  ; type=INTEGER,access=rw---,values=12,min=0,max=15,step=0
  : values=0,1,2,3,0,1,2,3,0,1,2,3
numid=70,iface=MIXER,name='EMU10K1 PCM Send Volume'
  ; type=INTEGER,access=rw---,values=12,min=0,max=255,step=0
  : values=255,255,0,0,255,0,0,0,0,255,0,0
numid=71,iface=MIXER,name='EMU10K1 PCM Volume'
  ; type=INTEGER,access=rw---,values=3,min=0,max=65535,step=0
  : values=65535,65535,65535
numid=68,iface=MIXER,name='External Amplifier Power Down'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=171,iface=MIXER,name='SB Live Analog/Digital Output Jack'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=35,iface=PCM,name='EFX voices mask'
  ; type=BOOLEAN,access=rw---,values=32
  : values=on,off,off,off,off,off,off,off,off,off,off,off,on,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amixer-scontents.txt"

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 22 [71%] [on] 
  Front Right: Playback 22 [71%] [on] 
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
  Front Left: Playback 23 [74%] [on] 
  Front Right: Playback 23 [74%] [on] 
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
Simple mixer control 'EMU10K1 PCM',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center 
  Limits: 0 - 65535
  Mono: 65535 [100%] 
  Front Left: 
  Front Right: 
  Front Center: 
Simple mixer control 'EMU10K1 PCM Send',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left - Rear Right - Woofer - ? - ? - ? - ? - ? - ? 
  Limits: 0 - 255
  Mono: 255 [100%] 
  Front Left: 
  Front Right: 
  Front Center: 
  Rear Left: 
  Rear Right: 
  Woofer: 
  ?: 
  ?: 
  ?: 
  ?: 
  ?: 
  ?: 
Simple mixer control 'EMU10K1 PCM Send Routing',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left - Rear Right - Woofer - ? - ? - ? - ? - ? - ? 
  Limits: 0 - 15
  Mono: 0 [0%] 
  Front Left: 
  Front Right: 
  Front Center: 
  Rear Left: 
  Rear Right: 
  Woofer: 
  ?: 
  ?: 
  ?: 
  ?: 
  ?: 
  ?: 
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 

--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
