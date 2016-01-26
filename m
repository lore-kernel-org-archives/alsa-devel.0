From: Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
Date: Mon, 25 Jan 2016 17:55:17 -0800
Message-ID: <E4776C8C-158A-4A3D-B6D8-A6D347CE94B1@pobox.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi> <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi> <20160124173701.GU3880@lunn.ch> <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com> <20160124214020.GA28667@jirafa.cyrius.com> <8E11A1EE-D73B-462E-A493-39571A17F2C3@pobox.com> <20160125182459.GE15550@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160125182459.GE15550-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


On Jan 25, 2016, at 10:24 AM, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> wrote:

> Hi,
> 
> On Sun, Jan 24, 2016 at 07:26:43PM -0800, Rick Thomas wrote:
>>> root@base:~# cat /proc/asound/devices 
>>>  2: [ 0]   : control
>>>  3: [ 0- 0]: digital audio playback
>>>  4: [ 0- 0]: digital audio capture
>>> 33:        : timer
>>> root@base:~# cat /proc/asound/cards   
>>> 0 [i2scs42l51hifi ]: i2s-cs42l51-hif - i2s-cs42l51-hifi
>>>                      i2s-cs42l51-hifi
>> 
>> Full of hope, I did "aptitude install mp321" which went without any visible problems.
>> 
>> Then hooked up a pair of earphones to the "speaker" plug on the Client and ran
>> 
>>> root@base:~# mpg321 -v /tmp/Jersey.mp3 
>>> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
>>> Version 0.3.2-1 (2012/03/25). Written and copyrights by Joe Drew,
>>> now maintained by Nanakos Chrysostomos and others.
>>> Uses code from various people. See 'README' for more!
>>> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
>>> Title	: The Jersey Bounce              Artist : Zazuzaz                       
>>> Album	: An Evening with ZaZuZaz        Year	 : 2000
>>> Comment : Amazon.com Song ID: 201809221  Genre : Jazz                          
>>> 
>>> Directory: /tmp
>>> Playing MPEG stream from Jersey.mp3 ...
>>> MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 0, BPF : 2560
>>> Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
>>> Bitrate: 128 Kbits/s, Extension value: 0
>>> Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 2
>>> ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
>>> ^C                                                                            
>>> [0:20] Decoding of Jersey.mp3 finished.
>> 
>> So it seemed to be running OK...  But there was no sound in the
>> earphones. I also tried adding option "-g 50" to set the gain explicitly.
>> Still no sound.
>> 
>> Is there a hardware jumper I need to set to activate sound on the
>> OpenRD Client board?
> 
> On my board I need to say "amixer set PCM on". Can you post the full
> output from "amixer" without any parameters?
> 
> Also check if you have this line in dmesg:
> 
> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
> 
> If it says "spdif" the player runs but is silent.
> 
> A.

Martin suggested that I install alsa-utils and run alsamixer in order to remove any extraneous "mute" setting.  I did that (I didn't realize alsamixer was runnable from the command line -- good to know!)

I did that and it worked!  "The Jersey Bounce" never sounded so good!

I'll do the tests that Aaro suggest, just for completeness, but it will have to wait til later tonight.

So we can add -- 

Tested-by: Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>

Enjoy!
Rick


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
