From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Wed, 15 Dec 2004 02:15:42 +0100
Message-ID: <200412150215.42816.annabellesgarden@yahoo.de>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93> <32821.192.168.1.5.1103069479.squirrel@192.168.1.5> <32825.192.168.1.5.1103069843.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32825.192.168.1.5.1103069843.squirrel@192.168.1.5>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 15 Dezember 2004 01:17 schrieb Rui Nuno Capela:
> Hi Karsten,
> >>
> >> The first one is about a repeatable kernel crash happening on my SUSE
> >> 9.2 Pro box (P4/HT), but also on my Mdk 10.1 laptop (P4/UP), everytime
> >> I try to aplay against the hw:N,2 device (N=soundcard index). See below
> >> for the whole data and the proper oops dumps. As every kernel crash,
> >> the system is left in a very dangerous and unstable state, so that this
> >> particular issue should be addressed ASAP.
> >
> > OK, that one is fixed by attached patch.
> > Takashi: Please apply with
> >>>>>>>
> > Summary: return -EBUSY from snd_usX2Y_usbpcm_open(),
> >   if the associated hwdep device is not opened.
> >
> > It now works as originally intended. Had forgotten a pair of parenthesis.
> >
> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> > <<<<<<
> >
> 
> With this patch applied, I always get:
> 
> ALSA lib pcm_hw.c:1172:(snd_pcm_hw_open) open /dev/snd/pcmC2D2p failed:
> Device or resource busy
> 
> either from jackd or aplay on hw:2,2. It doesn't matter whether
> snd-usb-usx2y is loaded on index=1 or index=2. The resulty is *always*
> resource busy.
> 
> Guess the patch doesn't really help, eh? I does not crash however ;)

Thats "correct behaviour":
usx2y-wise hw:n,2 is only valid for "rawusb pcm". aplay talks "standard pcm", so it cannot use hw:n,2 but only hw:n (or hw:n,0).
Technically,  snd_pcm_open() called for usx2y's hw:n,2 device will only succeed, if the hwdep device n,1 is opened already.
Also then (hwdep device n,1 opened) snd_pcm_open() calls for usx2y's hw:n,0 (or hw:n) will return -EBUSY.
In short:
hw:n is for "standard alsa pcm"
hw:n,2 is for "rawusb pcm" (currently only usable with jackd's usx2y driver)
Does hw:n (without the ",2") work with aplay and jackd -d alsa?

cheers,
Karsten


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
