From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio/Midiman - partial success
Date: Fri, 13 Sep 2002 23:30:55 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D81F69F.8090401@boosthardware.com>
References: <s5hn0qryq08.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0209100853400.12586-100000@studcom.urz.uni-halle.de>	<s5h65xbp6n2.wl@alsa2.suse.de>	<3D817ECC.5030904@boosthardware.com> <s5hsn0et9d6.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 13 Sep 2002 14:59:40 +0900,
> Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Tue, 10 Sep 2002 10:58:34 +0200 (METDST),
>>>Clemens Ladisch wrote:
>>>
>>>
>>>>>>The two PCM devices cannot be used at the same time anyway, so I think
>>>>>>creating a quirk for interface 0 which says "ignore this" could work.
>>>>>>Takashi, any comments?
>>>>>
>>>>>i think implementing a semaphore (or flag) for each endpoint would be
>>>>>better, so that the driver can find generally double-endpoints
>>>>>problem.
>>>>
>>>>I cannot imagine anybody else would be stupid enough to design a device
>>>>with double endpoints. But then I didn't imagine Midiman would, either.
>>>>Oh well, Murphy's Law ...  :-(
>>>
>>>
>>>since many (at least plural :) devices have this problem, i changed
>>>the usbaudio code slightly.  now a pcm stream is created per endpoint
>>>instead of interface.
>>>
>>>on this version, m-audio's device should have one (for duo) or two
>>>(for quattro) pcm devices.
>>>
>>>please let me know if any problems arise with this change.
>>>
>>
>>FYI: I have found that using the quattro with jack is rock solid when 
>>only accessing one of the pcms at a time at 48khz even as normal user.
> 
> 
> oh, that's bad.  could you show the output of
> /proc/asound/card0/stream* ?
> 

Au contraire, It's good. Well it was until I updated alsa-lib and jack. 
I will backout and retest there.

Anyhow.

----
  cat /proc/asound/card2/stream0
M Audio USB AudioSport Quattro (tm) : USB Audio

Playback:
   Status: Stop
   Altset 1
     Format: S16_LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 88200, 96000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000
   Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000

Capture:
   Status: Stop
   Altset 1
     Format: S16_LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 11025, 22050, 44100
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 88200, 96000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000
   Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000


  cat /proc/asound/card2/stream1
M Audio USB AudioSport Quattro (tm) : USB Audio #1

Playback:
   Status: Stop
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 4 OUT (ADAPTIVE)
     Rates: 88200, 96000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 4 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000
   Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 4 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000

Capture:
   Status: Stop
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 6 IN (SYNC)
     Rates: 88200, 96000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 6 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000
   Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 6 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000

----

> 
> did you run jack with 48k immediately after setting 96k?
> so, some old configuration is left and this makes the difference.
> perhaps this is also the problem once you reported that the driver
> works only after once capture runs.
> 

No it was playback from the internal pcm :) I see the problem though. 
It's because the quattro only supports 96Khz at 24_3Le. So JACK cannot 
access the pcm as there is no support for this bit rate in JACK.

Apart from that the sound quality of playback when running native alsa 
is crisp and clean. It's hard to tell if the pitch is out or not. It 
could be that I'm not used to listening to such high quality signals :)

But when I record a signal through hw:2,0 while playing (full dulplex) 
both signals (i/o - hw:2,0) become distorted. I have a 48Khz wav file 
for you to listen to.

http://www.boosthardware.com/audio/sine-0913.wav

This is probably contributing to the distortion in JACK too. As JACK 
opens both input and output.  I just confirmed that the quality is much 
better when using the Playback only option.

eg.    jackd -v -d alsa -d quattro1 -p 768 -P




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
