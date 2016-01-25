From: Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
Date: Sun, 24 Jan 2016 19:26:43 -0800
Message-ID: <8E11A1EE-D73B-462E-A493-39571A17F2C3@pobox.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi> <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi> <20160124173701.GU3880@lunn.ch> <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com> <20160124214020.GA28667@jirafa.cyrius.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160124214020.GA28667-IRMp5PtgtdoigzW5ZibpNwC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


On Jan 24, 2016, at 1:40 PM, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org> wrote:

> * Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org> [2016-01-24 12:56]:
>>> It would be good to have a Tested-by: from Rick.
>>> 
>> If someone will make a .deb I can download, I'll be happy to install
>> it and test it.  Please be explicit in describing what and how you
>> want tested.
> 
> Check your email. :)
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 


Got it.

Looks like mmc works with that kernel.  I was able to mount /dev/mmcblk0p1 and read files from it.

Sound we have some progress:

> root@base:~# ls -l /dev/snd
> total 0
> drwxr-xr-x 2 root root       60 Jan 24 18:23 by-path
> crw-rw---- 1 root audio 116,  2 Jan 24 18:23 controlC0
> crw-rw---- 1 root audio 116,  4 Jan 24 18:23 pcmC0D0c
> crw-rw---- 1 root audio 116,  3 Jan 24 18:23 pcmC0D0p
> crw-rw---- 1 root audio 116,  1 Jan 24 18:23 seq
> crw-rw---- 1 root audio 116, 33 Jan 24 18:23 timer
> root@base:~# cat /proc/asound/devices 
>   2: [ 0]   : control
>   3: [ 0- 0]: digital audio playback
>   4: [ 0- 0]: digital audio capture
>  33:        : timer
> root@base:~# cat /proc/asound/cards   
>  0 [i2scs42l51hifi ]: i2s-cs42l51-hif - i2s-cs42l51-hifi
>                       i2s-cs42l51-hifi

Full of hope, I did "aptitude install mp321" which went without any visible problems.

Then hooked up a pair of earphones to the "speaker" plug on the Client and ran

> root@base:~# mpg321 -v /tmp/Jersey.mp3 
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> Version 0.3.2-1 (2012/03/25). Written and copyrights by Joe Drew,
> now maintained by Nanakos Chrysostomos and others.
> Uses code from various people. See 'README' for more!
> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
> Title	: The Jersey Bounce              Artist : Zazuzaz                       
> Album	: An Evening with ZaZuZaz        Year	 : 2000
> Comment : Amazon.com Song ID: 201809221  Genre : Jazz                          
> 
> Directory: /tmp
> Playing MPEG stream from Jersey.mp3 ...
> MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 0, BPF : 2560
> Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
> Bitrate: 128 Kbits/s, Extension value: 0
> Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 2
> ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
> ^C                                                                            
> [0:20] Decoding of Jersey.mp3 finished.

So it seemed to be running OK...  But there was no sound in the earphones.  I also tried adding option "-g 50" to set the gain explicitly.  Still no sound.

Is there a hardware jumper I need to set to activate sound on the OpenRD Client board?

Do I need to install another package? For example, "aptitude search '~i alsa'" gives no output, indicating, I believe, that there are no installed packages with "alsa" in their name.

The message:
> ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
seems suspicious.

Any thoughts?
Rick


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
