From: Bob Ham <node@users.sourceforge.net>
Subject: Re: sblive line capture woes
Date: Fri, 18 Oct 2002 22:17:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021018211649.GA22671@depression.ath.cx>
References: <20021018200317.GA22229@depression.ath.cx> <Pine.LNX.4.33.0210182021520.626-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210182021520.626-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel @ lists. sourceforge. net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2002 at 08:31:10PM +0200, Jaroslav Kysela wrote:

> Thanks. I don't see the problem at first glance. Are you trying to capture 
> signal from LiveDrive line #1?

No, from 'Line LineDrive',0

> Could you follow these steps?
> 
> Please, turn everything off (volumes and mute controls).

I ran the attached script, which appears to do the job.  The amixer output
is also attached.

> And type 
> this command:
> 
> amixer sset 'Line LiveDrive',0 capture 100 cap

Didn't work :(

> It should be sufficient. If not, it might be that we have some different 
> names for EMU10K1 inputs. Then could you try these commands 
> (simultaneously, if input works, try determine the right one)?
> 
> amixer sset 'Line LiveDrive',1 capture 100 cap
> amixer sset 'IEC958 TTL',0 capture 100 cap
> amixer sset 'Zoom Video',0 capture 100 cap
> amixer sset 'IEC958 Optical' capture 100 cap
> amixer sset 'IEC958 Coaxial' capture 100 cap
> amixer sset 'Line LiveDrive' capture 100 cap

Didn't work either :(

> AC'97 controls should be off. There's none connection between AC'97 
> and these inputs. Good luck.

I'll bear that in mind.

By the way, and I've no idea if it has any bearing but my snd-emu10k1
options include snd_extin=0x3fc3 snd_extout=0x1fff.

Bob

--M9NhX3UHpAaciwkO
Content-Type: application/x-sh
Content-Disposition: attachment; filename="emu10k1-everything-off.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Aamixer scontrols | \=0A  sed -e "s/^Simple mixer control '//=
" | \=0A  grep -v "External Amplifier" | \=0A  grep -v "SB Live Analog/Digi=
tal" | \=0A  while read control; do \=0A    amixer sset "'$control" 0 mute;=
 \=0A    amixer sset "'$control" nocapture; \=0A  done=0A
--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amixer-contents-everything-off.txt"

numid=40,iface=MIXER,name='Master Mono Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=41,iface=MIXER,name='Master Mono Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=36,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=37,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
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
  : values=0,0
numid=30,iface=MIXER,name='Tone Control - Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=29,iface=MIXER,name='Tone Control - Treble'
  ; type=INTEGER,access=rw---,values=2,min=0,max=40,step=0
  : values=0,0
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
  : values=off
numid=58,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=12,iface=MIXER,name='Surround Digital Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=11,iface=MIXER,name='Surround Digital Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=10,iface=MIXER,name='Surround Digital Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=38,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=39,iface=MIXER,name='Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=13,iface=MIXER,name='Center Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=0
numid=14,iface=MIXER,name='LFE Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=100,step=0
  : values=0
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
  : values=0,0
numid=6,iface=MIXER,name='Wave Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=5,iface=MIXER,name='Wave Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=7,iface=MIXER,name='Music Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=9,iface=MIXER,name='Music Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=8,iface=MIXER,name='Music Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=22,iface=MIXER,name='Line LiveDrive Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=27,iface=MIXER,name='Line LiveDrive Capture Switch',index=1
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=21,iface=MIXER,name='Line LiveDrive Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
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
  : values=off
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
  : values=4,4
numid=60,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=61,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
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
  : values=0,0
numid=15,iface=MIXER,name='AC97 Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=100,step=0
  : values=0,0
numid=69,iface=MIXER,name='EMU10K1 PCM Send Routing'
  ; type=INTEGER,access=rw---,values=12,min=0,max=15,step=0
  : values=0,0,0,0,0,0,0,0,0,0,0,0
numid=70,iface=MIXER,name='EMU10K1 PCM Send Volume'
  ; type=INTEGER,access=rw---,values=12,min=0,max=255,step=0
  : values=0,0,0,0,0,0,0,0,0,0,0,0
numid=71,iface=MIXER,name='EMU10K1 PCM Volume'
  ; type=INTEGER,access=rw---,values=3,min=0,max=65535,step=0
  : values=0,0,0
numid=68,iface=MIXER,name='External Amplifier Power Down'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=171,iface=MIXER,name='SB Live Analog/Digital Output Jack'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=35,iface=PCM,name='EFX voices mask'
  ; type=BOOLEAN,access=rw---,values=32
  : values=on,off,off,off,off,off,off,off,off,off,off,off,on,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off

--M9NhX3UHpAaciwkO--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
