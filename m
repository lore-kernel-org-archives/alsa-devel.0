From: Dennis van der Meer <dvdmeer@wanadoo.nl>
Subject: Re: Terratec Aureon Space
Date: Sat, 07 Jun 2003 00:31:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030607002652.016594f8@192.168.10.1>
References: <5.1.0.14.2.20030604194558.016464c0@192.168.10.1>
 <5.1.0.14.2.20030603193926.01638eb0@192.168.10.1>
 <5.1.0.14.2.20030529001556.01651020@192.168.10.1>
 <s5h65nnnrnx.wl@alsa2.suse.de>
 <s5hk7c2m4h8.wl@alsa2.suse.de>
 <5.1.0.14.2.20030604194558.016464c0@192.168.10.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznkxlmpb.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have been playing around with the controls and setting them as specified
but I am still unable to enable the digital out. I have verified that 
digital out
is not enabled by looking at the back of the card and check if the red light
is on (which is not the case).
I have also provided a dump from amixer in the hopes that someone can
figure out what is wrong:

numid=1,iface=CARD,name='ICE1724 EEPROM'
   ; type=BYTES,access=r----,values=52
   : 
values=0x11,0x45,0x15,0x3b,0x13,0x02,0x13,0x80,0xf8,0xc2,0xff,0xff,0xbf,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xbf,0x00
numid=28,iface=MIXER,name='Master Playback Volume'
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=86
numid=29,iface=MIXER,name='ADC Volume'
   ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
   : values=28
numid=30,iface=MIXER,name='ADC Volume',index=1
   ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
   : values=27
numid=31,iface=MIXER,name='Capture Route'
   ; type=ENUMERATED,access=rw---,values=2,items=8
   ; Item #0 'CD Left'
   ; Item #1 'CD Right'
   ; Item #2 'Aux Left'
   ; Item #3 'Aux Right'
   ; Item #4 'Line Left'
   ; Item #5 'Line Right'
   ; Item #6 'Mic Left'
   ; Item #7 'Mic Right'
   : values=4,4
numid=18,iface=MIXER,name='IEC958 Playback Con Mask',device=1
   ; type=IEC958,access=r----,values=1
   : values=?
numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',device=1
   ; type=IEC958,access=r----,values=1
   : values=?
numid=14,iface=MIXER,name='IEC958 Playback Route'
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=3
numid=15,iface=MIXER,name='IEC958 Playback Route',index=1
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=16,iface=MIXER,name='IEC958 Output Switch'
   ; type=BOOLEAN,access=rw---,values=1
   : values=on
numid=20,iface=MIXER,name='DAC Volume'
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=21,iface=MIXER,name='DAC Volume',index=1
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=22,iface=MIXER,name='DAC Volume',index=2
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=23,iface=MIXER,name='DAC Volume',index=3
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=24,iface=MIXER,name='DAC Volume',index=4
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=25,iface=MIXER,name='DAC Volume',index=5
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=26,iface=MIXER,name='DAC Volume',index=6
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=27,iface=MIXER,name='DAC Volume',index=7
   ; type=INTEGER,access=rw---,values=1,min=0,max=101,step=0
   : values=88
numid=5,iface=MIXER,name='H/W Playback Route'
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=6,iface=MIXER,name='H/W Playback Route',index=1
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=7,iface=MIXER,name='H/W Playback Route',index=2
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=8,iface=MIXER,name='H/W Playback Route',index=3
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=9,iface=MIXER,name='H/W Playback Route',index=4
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=10,iface=MIXER,name='H/W Playback Route',index=5
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=11,iface=MIXER,name='H/W Playback Route',index=6
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=12,iface=MIXER,name='H/W Playback Route',index=7
   ; type=ENUMERATED,access=rw---,values=1,items=5
   ; Item #0 'PCM Out'
   ; Item #1 'H/W In 0'
   ; Item #2 'H/W In 1'
   ; Item #3 'IEC958 In L'
   ; Item #4 'IEC958 In R'
   : values=4
numid=2,iface=MIXER,name='Multi Track Internal Clock'
   ; type=ENUMERATED,access=rw---,values=1,items=16
   ; Item #0 '8000'
   ; Item #1 '9600'
   ; Item #2 '11025'
   ; Item #3 '12000'
   ; Item #4 '16000'
   ; Item #5 '22050'
   ; Item #6 '24000'
   ; Item #7 '32000'
   ; Item #8 '44100'
   ; Item #9 '48000'
   ; Item #10 '64000'
   ; Item #11 '88200'
   ; Item #12 '96000'
   ; Item #13 '176400'
   ; Item #14 '192000'
   ; Item #15 'IEC958 Input'
   : values=8
numid=13,iface=MIXER,name='Multi Track Peak'
   ; type=INTEGER,access=r----,values=22,min=0,max=255,step=0
   : values=0,0,0,0,0,0,0,0,0,0,172,175,0,0,0,0,0,0,0,0,0,0
numid=3,iface=MIXER,name='Multi Track Rate Locking'
   ; type=BOOLEAN,access=rw---,values=1
   : values=off
numid=4,iface=MIXER,name='Multi Track Rate Reset'
   ; type=BOOLEAN,access=rw---,values=1
   : values=on
numid=17,iface=PCM,name='IEC958 Playback Default',device=1
   ; type=IEC958,access=rw---,values=1
   : values=?


>as said, for digital outs, use "iec958" device.  but you might need to
>wrap "plug" layer to convert the formats, etc. to play back non-24bit
>samples.
>
>         % aplay -D plug:iec958 foo.wav

Ok, done that but still no output, which makes sense since the red light on 
the back
of the card isn't on.


Dennis



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
