From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Wed, 15 Dec 2004 14:05:05 -0000 (WET)
Message-ID: <46792.195.245.190.94.1103119505.squirrel@195.245.190.94>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>   
    <32821.192.168.1.5.1103069479.squirrel@192.168.1.5>   
    <32825.192.168.1.5.1103069843.squirrel@192.168.1.5>   
    <200412150215.42816.annabellesgarden@yahoo.de>
    <42583.195.245.190.93.1103103043.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42583.195.245.190.93.1103103043.squirrel@195.245.190.93>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Karsten,

>   jackd -d usx2y -d hw:n,2 ... returns a 'resource busy' condition.
>
> Without the 0.8.7.1 patch, it works BUT iif n < 2; if n >= 2, I get the
> 'hwdep' assertion failure on jackd; aplay crashes on either value of n.
>
> With the patch applied, I always get the "resource busy" error on 'jackd
> -d usx2y -d hw:n,2 ...' and on 'aplay -D hw:n,2 ...'.
>
> So, the sacred question is: How can I make jackd to work with the "rawusb"
> interface?
>
> Just a clueless question: does it need a newer version for the jackd usx2y
> backend driver? I'm still using your's original one you've ever posted.
> I've been maintaining it as a jack patch and can be found on my personal
> home server (http://www.rncbc.org/usx2y/jack-0.99.35-usx2y.patch.gz).
>

I found the culprid, almost for sure.

On jack/drivers/usx2y/usx2y_driver.c:2158, you may find there's this
hardcoded:

    snd_hwdep_open(&driver->hwdep_handle, "hw:1,1", O_RDWR);
                                           ^^^^^^

so I guess this could only work if snd-usb-usx2y is your second soundcard
(index=1). Indeed it was on all my successful tests. That explains a lot
of trouble.

Simple dummy question: how can I avoid that hardwiring, and fill in the
proper soundcard index number n, as in "hw:n,1" ? In other words, how can
I retrieve that number, given the alsa device name (e.g. str="hw:2,2")
without going dirty as in sscanf(str, "hw:%d", &n); ?

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
