From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: hdsp multiface pci.
Date: Sun, 19 Jan 2003 21:08:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E2A952E.6060305@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Using latest cvs, I have been trying to get this device working for my 
friend. We have had some success but it is unreliable.

We could get sound out of the lineout port after using this command

  amixer -D hw:0 cset numid=5 0,0,16384

numid=5,iface=PCM,name='Mixer'
   ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
   : values=16384,0,0

Using

  	numid=5 26,26,16384
  	numid=5 27,27,16384
or
  	numid=5 10,10,16384 <<<--- 10 appears to be line out id

seem to do nothing.

Sometimes after trying to use aplay and usually when trying alsaplayer 
amixer resets the volume to 0.

Is this buggy behaviour?

How do other people manage to get things done with the hdsp?

Is it a known issue with alsaplayer in the same way that the hdsp-9652 
doesn't work well with it?

Here is the output of

  	amixer -D hw:0 contents

in case it is useful.

------------------

numid=3,iface=MIXER,name='IEC958 Playback Con Mask'
   ; type=IEC958,access=r----,values=1
   : values=?
numid=4,iface=MIXER,name='IEC958 Playback Pro Mask'
   ; type=IEC958,access=r----,values=1
   : values=?
numid=11,iface=MIXER,name='Chn',index=1
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=17,iface=MIXER,name='Chn',index=2
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=23,iface=MIXER,name='Chn',index=3
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=29,iface=MIXER,name='Chn',index=4
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=35,iface=MIXER,name='Chn',index=5
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=41,iface=MIXER,name='Chn',index=6
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=47,iface=MIXER,name='Chn',index=7
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=53,iface=MIXER,name='Chn',index=8
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=59,iface=MIXER,name='Chn',index=9
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=65,iface=MIXER,name='Chn',index=10
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=71,iface=MIXER,name='Chn',index=11
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=77,iface=MIXER,name='Chn',index=12
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=83,iface=MIXER,name='Chn',index=13
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=89,iface=MIXER,name='Chn',index=14
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=95,iface=MIXER,name='Chn',index=15
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=101,iface=MIXER,name='Chn',index=16
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=107,iface=MIXER,name='Chn',index=17
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=113,iface=MIXER,name='Chn',index=18
   ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
   : values=0
numid=6,iface=PCM,name='IEC958 Input Connector'
   ; type=ENUMERATED,access=rw---,values=1,items=3
   ; Item #0 'ADAT1'
   ; Item #1 'Coaxial'
   ; Item #2 'Internal'
   : values=2
numid=7,iface=PCM,name='IEC958 Output also on ADAT1'
   ; type=BOOLEAN,access=rw---,values=1
   : values=off
numid=1,iface=PCM,name='IEC958 Playback Default'
   ; type=IEC958,access=rw---,values=1
   : values=?
numid=12,iface=PCM,name='Input Peak',index=1
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=102656,0
numid=18,iface=PCM,name='Input Peak',index=2
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=89600,0
numid=24,iface=PCM,name='Input Peak',index=3
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=87296,0
numid=30,iface=PCM,name='Input Peak',index=4
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=87808,0
numid=36,iface=PCM,name='Input Peak',index=5
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=90624,0
numid=42,iface=PCM,name='Input Peak',index=6
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=123136,0
numid=48,iface=PCM,name='Input Peak',index=7
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=126976,0
numid=54,iface=PCM,name='Input Peak',index=8
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=162304,0
numid=60,iface=PCM,name='Input Peak',index=9
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=66,iface=PCM,name='Input Peak',index=10
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=72,iface=PCM,name='Input Peak',index=11
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=78,iface=PCM,name='Input Peak',index=12
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=84,iface=PCM,name='Input Peak',index=13
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=90,iface=PCM,name='Input Peak',index=14
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=96,iface=PCM,name='Input Peak',index=15
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=102,iface=PCM,name='Input Peak',index=16
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=108,iface=PCM,name='Input Peak',index=17
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=114,iface=PCM,name='Input Peak',index=18
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=16,iface=PCM,name='Input RMS',index=1
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=463024331
numid=22,iface=PCM,name='Input RMS',index=2
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=451976321
numid=28,iface=PCM,name='Input RMS',index=3
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=463546985
numid=34,iface=PCM,name='Input RMS',index=4
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=494462528
numid=40,iface=PCM,name='Input RMS',index=5
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=478606310
numid=46,iface=PCM,name='Input RMS',index=6
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=52,iface=PCM,name='Input RMS',index=7
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=58,iface=PCM,name='Input RMS',index=8
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=64,iface=PCM,name='Input RMS',index=9
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=70,iface=PCM,name='Input RMS',index=10
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=76,iface=PCM,name='Input RMS',index=11
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=82,iface=PCM,name='Input RMS',index=12
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=88,iface=PCM,name='Input RMS',index=13
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=94,iface=PCM,name='Input RMS',index=14
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=100,iface=PCM,name='Input RMS',index=15
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=106,iface=PCM,name='Input RMS',index=16
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=112,iface=PCM,name='Input RMS',index=17
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=118,iface=PCM,name='Input RMS',index=18
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=10,iface=PCM,name='Line Out'
   ; type=BOOLEAN,access=rw---,values=1
   : values=on
numid=5,iface=PCM,name='Mixer'
   ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
   : values=16384,0,0
numid=13,iface=PCM,name='Output Peak',index=1
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=19,iface=PCM,name='Output Peak',index=2
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=25,iface=PCM,name='Output Peak',index=3
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=31,iface=PCM,name='Output Peak',index=4
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=37,iface=PCM,name='Output Peak',index=5
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=43,iface=PCM,name='Output Peak',index=6
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=49,iface=PCM,name='Output Peak',index=7
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=55,iface=PCM,name='Output Peak',index=8
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=61,iface=PCM,name='Output Peak',index=9
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=67,iface=PCM,name='Output Peak',index=10
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=73,iface=PCM,name='Output Peak',index=11
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=79,iface=PCM,name='Output Peak',index=12
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=85,iface=PCM,name='Output Peak',index=13
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=91,iface=PCM,name='Output Peak',index=14
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=97,iface=PCM,name='Output Peak',index=15
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=103,iface=PCM,name='Output Peak',index=16
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=109,iface=PCM,name='Output Peak',index=17
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=115,iface=PCM,name='Output Peak',index=18
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=9,iface=PCM,name='Passthru'
   ; type=BOOLEAN,access=rw---,values=1
   : values=off
numid=14,iface=PCM,name='Playback Peak',index=1
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=2147483392,15
numid=20,iface=PCM,name='Playback Peak',index=2
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=26,iface=PCM,name='Playback Peak',index=3
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=32,iface=PCM,name='Playback Peak',index=4
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=38,iface=PCM,name='Playback Peak',index=5
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=44,iface=PCM,name='Playback Peak',index=6
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=50,iface=PCM,name='Playback Peak',index=7
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=56,iface=PCM,name='Playback Peak',index=8
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=62,iface=PCM,name='Playback Peak',index=9
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=68,iface=PCM,name='Playback Peak',index=10
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=74,iface=PCM,name='Playback Peak',index=11
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=80,iface=PCM,name='Playback Peak',index=12
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=86,iface=PCM,name='Playback Peak',index=13
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=92,iface=PCM,name='Playback Peak',index=14
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=98,iface=PCM,name='Playback Peak',index=15
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=104,iface=PCM,name='Playback Peak',index=16
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=110,iface=PCM,name='Playback Peak',index=17
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=116,iface=PCM,name='Playback Peak',index=18
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0
numid=15,iface=PCM,name='Playback RMS',index=1
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=21,iface=PCM,name='Playback RMS',index=2
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=27,iface=PCM,name='Playback RMS',index=3
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=33,iface=PCM,name='Playback RMS',index=4
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=39,iface=PCM,name='Playback RMS',index=5
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=45,iface=PCM,name='Playback RMS',index=6
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=51,iface=PCM,name='Playback RMS',index=7
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=57,iface=PCM,name='Playback RMS',index=8
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=63,iface=PCM,name='Playback RMS',index=9
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=69,iface=PCM,name='Playback RMS',index=10
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=75,iface=PCM,name='Playback RMS',index=11
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=81,iface=PCM,name='Playback RMS',index=12
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=87,iface=PCM,name='Playback RMS',index=13
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=93,iface=PCM,name='Playback RMS',index=14
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=99,iface=PCM,name='Playback RMS',index=15
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=105,iface=PCM,name='Playback RMS',index=16
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=111,iface=PCM,name='Playback RMS',index=17
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=117,iface=PCM,name='Playback RMS',index=18
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0
numid=8,iface=PCM,name='Preferred Sync Source'
   ; type=ENUMERATED,access=rw---,values=1,items=6
   ; Item #0 'Internal'
   ; Item #1 'Word'
   ; Item #2 'ADAT Sync'
   ; Item #3 'IEC958'
   ; Item #4 'ADAT1'
   ; Item #5 'ADAT2'
   : values=0


------------------


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
