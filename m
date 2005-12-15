From: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Subject: Re: Tips on debugging ALSA driver snd_es18xx
Date: Thu, 15 Dec 2005 14:52:03 -0200
Message-ID: <20051215165203.GC5793@cortazar>
References: <20051215013411.GK7983@cortazar> <1134635237.43a128e5e75fa@webmail.uni-halle.de> <20051215111213.GA3636@cortazar> <1134660339.43a18af3d7aa4@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1134660339.43a18af3d7aa4@webmail.uni-halle.de>
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


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Clemens Ladisch wrote on Dec, 15:
> > This was curious: the wav files I tried with aplay ended too quickly, so I
> > looked for longer ones. My surprise: no sound from the longer ones. It gave
> > me the impression to be related to the sound source being coded for 16 or
> > 8-bits, if I'm not speaking just plain nonsense.
> 
> Please add this to your ~/.asoundrc:
> 
> pcm.u8 {
> 	type plug
> 	slave.pcm {
> 		type linear
> 		slave {
> 			pcm "hw:0"
> 			format U8
> 		}
> 	}
> }

May I ask you what this snippet does ?

> and try to play some 16-bit file to the ALSA device named "u8" instead of the
> default one.  If this works, there is a bug in the driver in relation with
> 16-bit data.

Fantastic, Clemens ! You hit the bull's eye. Now the scenario is:

1) aplay -Du8 produces sound from 8 or 16-bit data (the same I used before) on 
   both speakers

2) xmms and gxine produce sound only on the left speaker. I've attached a file 
   with the few config parameters which are explicitly set for gxine (the rest 
   is commented out, therefore, default). xmms saves every single parameter, 
   so I'm just sending the ALSA stanza.  My eye didn't catch anything that 
   might be related to usage of left/right speakers. Just in case, I'm also 
   attaching my mixer settings.

3) speaker-test -Du8 produces what I suppose is pink noise on both speakers, 
   but I noticed that its output included only "0 - Front Left"

I guess we're almost there. I thought I'd be doing the hard work, but you've 
been doing everything. I'm really happy and thankful for having posted the 
problem here. Now I've got to capitalize on this and learn more.

Would you have any suggestions regarding (2) ?

If this is indeed a bug in the driver, should I file a bug in ALSA BTS ?

Thanks immensely for your providencial help
Paulo

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=amixer_contents

numid=2,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=1,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=55,56
numid=28,iface=MIXER,name='Hardware Master Volume Split'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=27,iface=MIXER,name='Hardware Master Playback Switch'
  ; type=BOOLEAN,access=r----,values=2
  : values=on,on
numid=26,iface=MIXER,name='Hardware Master Playback Volume'
  ; type=INTEGER,access=r----,values=2,min=0,max=63,step=0
  : values=55,56
numid=24,iface=MIXER,name='3D Control - Level'
  ; type=INTEGER,access=rw---,values=1,min=0,max=63,step=0
  : values=63
numid=25,iface=MIXER,name='3D Control - Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=14,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=15,iface=MIXER,name='PCM Playback Volume',index=1
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=16,iface=MIXER,name='PCM Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=5,iface=MIXER,name='FM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=19,iface=MIXER,name='FM Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=3,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=18,iface=MIXER,name='Line Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=4,iface=MIXER,name='CD Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=21,iface=MIXER,name='CD Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=14,14
numid=23,iface=MIXER,name='Mic Boost (+26dB)'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=7,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=17,iface=MIXER,name='Mic Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=9,iface=MIXER,name='PC Speaker Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=7,step=0
  : values=7
numid=8,iface=MIXER,name='Aux Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=22,iface=MIXER,name='Aux Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=6,iface=MIXER,name='Mono Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=15,15
numid=20,iface=MIXER,name='Mono Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=13,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=1,items=8
  ; Item #0 'Mic'
  ; Item #1 'Mic Master'
  ; Item #2 'CD'
  ; Item #3 'AOUT'
  ; Item #4 'Mic1'
  ; Item #5 'Mix'
  ; Item #6 'Line'
  ; Item #7 'Master'
  : values=7
numid=12,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=11,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=10,10
numid=10,iface=MIXER,name='Record Monitor'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gxine.cfg"

gui.experience_level:Master of the known universe
gui.post_plugins.audio_visualisation:None
audio.driver:alsa
audio.device.alsa_default_device:u8
audio.device.alsa_front_device:u8
video.driver:opengl
video.output.opengl_renderer:2D_Tex
engine.performance.memcpy_method:mmx
misc.wizards_shown:6

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xmms.cfg"

[ALSA]
buffer_time=500
period_time=50
thread_buffer_time=3000
pcm_device=u8
mixer_card=0
mixer_device=PCM
soft_volume=FALSE
volume_left=100
volume_right=100

--0F1p//8PRICkK4MW--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
