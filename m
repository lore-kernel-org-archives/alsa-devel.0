From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [Fwd:  Multiple cards.]
Date: Wed, 12 Jun 2002 21:15:32 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D073B64.2010200@boosthardware.com>
References: <3D071F9B.1090302@boosthardware.com> <s5hk7p42158.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA24239
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2002 14:10:49 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 12 Jun 2002 19:16:59 +0900,
> Patrick Shirkey wrote:
> 
>>In your example you don't say whether your cards have are stereo or mono 
>>  channels.
>>
>>I get this ouput when starting jack
>>
>>----
>># jackd -R -v -d alsa -d ttable
>>jackd 0.33.0
>>Copyright 2001-2002 Paul Davis and others.
>>jackd comes with ABSOLUTELY NO WARRANTY
>>This is free software, and you are welcome to redistribute it
>>under certain conditions; see the file COPYING for details
>>
>>3475 waiting for signals
>>creating alsa driver ... ttable|1024|2|48000|swmon
>>ALSA: no playback configurations available
>>ALSA: cannot configure capture channel
>>cannot load driver module alsa
>>jack main caught signal 15
>>-----
>>
>>Using the following in my .asoundrc file. I'm not sure if it is correct 
>>as card0 has two stereo pcm devices. I'm not sure whether they are being 
>>defined in the following or not.
>>
>>Does
>>
>>         slaves.a.channels 2
>>
>>refer to the pcm devices
>>
>>         eg. hw:0,0 and hw:0,1
>>
>>or the first two mono channels available on card0?
>>
>>         eg. left and right channels on hw:0,0
> 
> 
> the latter.  hw:0,0 and hw:0,1 are different substreams,
> i.e. different pcms.
> 
> if your second card has only one channel, then the amount of resultant
> channels will be three, as you modified.  it should work so.
> 
> do both cards support the same condition (48kHz) ?
>  
> 

Yes. Testing them seperately they both work at 48Khz

Do you know what this means?

----
# aplay  -f dat -D ttable /1REC/beastie_boys-track_8.wav
Playing WAVE '/1REC/beastie_boys-track_8.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
aplay: set_params:737: Broken configuration for this PCM: no 
configurations available

# arecord -f cd -D multi -c 3 | aplay -D multi
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Channels 3
arecord: set_params:737: Broken configuration for this PCM: no 
configurations available
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Channels 3
aplay: set_params:737: Broken configuration for this PCM: no 
configurations available
----



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
