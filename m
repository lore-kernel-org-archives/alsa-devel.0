From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Wed, 15 Dec 2004 09:30:43 -0000 (WET)
Message-ID: <42583.195.245.190.93.1103103043.squirrel@195.245.190.93>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
    <32821.192.168.1.5.1103069479.squirrel@192.168.1.5>
    <32825.192.168.1.5.1103069843.squirrel@192.168.1.5>
    <200412150215.42816.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412150215.42816.annabellesgarden@yahoo.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten,

>> >>>>>>>
>> > Summary: return -EBUSY from snd_usX2Y_usbpcm_open(),
>> >   if the associated hwdep device is not opened.
>> >
>> > It now works as originally intended. Had forgotten a pair of
>> parenthesis.
>> >
>> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
>> > <<<<<<
>> >
>>
>> With this patch applied, I always get:
>>
>> ALSA lib pcm_hw.c:1172:(snd_pcm_hw_open) open /dev/snd/pcmC2D2p failed:
>> Device or resource busy
>>
>> either from jackd or aplay on hw:2,2. It doesn't matter whether
>> snd-usb-usx2y is loaded on index=1 or index=2. The resulty is *always*
>> resource busy.
>>
>
> Thats "correct behaviour":
> usx2y-wise hw:n,2 is only valid for "rawusb pcm". aplay talks "standard
> pcm", so it cannot use hw:n,2 but only hw:n (or hw:n,0).
> Technically,  snd_pcm_open() called for usx2y's hw:n,2 device will only
> succeed, if the hwdep device n,1 is opened already.
> Also then (hwdep device n,1 opened) snd_pcm_open() calls for usx2y's
> hw:n,0 (or hw:n) will return -EBUSY.
> In short:
> hw:n is for "standard alsa pcm"
> hw:n,2 is for "rawusb pcm" (currently only usable with jackd's usx2y
> driver)
> Does hw:n (without the ",2") work with aplay and jackd -d alsa?
>

Yes,

  jackd -d alsa -d hw:n ... works OK,

but

  jackd -d usx2y -d hw:n,2 ... returns a 'resource busy' condition.

Without the 0.8.7.1 patch, it works BUT iif n < 2; if n >= 2, I get the
'hwdep' assertion failure on jackd; aplay crashes on either value of n.

With the patch applied, I always get the "resource busy" error on 'jackd
-d usx2y -d hw:n,2 ...' and on 'aplay -D hw:n,2 ...'.

So, the sacred question is: How can I make jackd to work with the "rawusb"
interface?

Just a clueless question: does it need a newer version for the jackd usx2y
backend driver? I'm still using your's original one you've ever posted.
I've been maintaining it as a jack patch and can be found on my personal
home server (http://www.rncbc.org/usx2y/jack-0.99.35-usx2y.patch.gz).

Please, have a look and check if it still fits in.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
