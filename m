From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Fri, 19 Aug 2005 05:47:10 -0700 (PDT)
Message-ID: <20050819124710.36978.qmail@web54603.mail.yahoo.com>
References: <Pine.HPX.4.33n.0508171538200.19860-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508171538200.19860-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok..I backport ARM audio changes from 2.6.12 to 2.6.7.
I manage to build a zImage file and manage to make
modules too. However..there are few warnings that i
encounter during make modules

sound/pci/ac97/ac97_codec.c: In function
`snd_ac97_mixer':
sound/pci/ac97/ac97_codec.c:1771: warning: unused
variable `pid'
sound/pci/ac97/ac97_codec.c: At top level:
sound/pci/ac97/ac97_codec.c:1740: warning:
`null_build_ops' defined but not used

Building modules, stage 2.
  MODPOST
*** Warning: "dma_mmap_writecombine"
[sound/arm/snd-pxa2xx-pcm.ko] undefined!
*** Warning: "pxa_set_cken"
[sound/arm/snd-pxa2xx-ac97.ko] undefined!
*** Warning: "snd_ac97_get_short_name"
[sound/arm/snd-pxa2xx-ac97.ko] undefined!

I thought warnings would be ok. I started inserting
modules but when I want to insert the snd-pxa2xx-ac97
module, I get the following error.

[root@ARMCore sound1]$ insmod snd-pxa2xx-ac97.ko
snd_pxa2xx_ac97: Unknown symbol pxa2xx_pcm_new
snd_pxa2xx_ac97: Unknown symbol
snd_ac97_get_short_name
snd_pxa2xx_ac97: Unknown symbol pxa_set_cken
insmod: error inserting 'snd-pxa2xx-ac97.ko': -1
Unknown symbol in module

Which file should I fix? There is not any
snd-pxa2xx-ac97.c file. What does unknown symbol in
module means?

Hope to hear from you soon.

Raymond

--- Clemens Ladisch <clemens@ladisch.de> wrote:

> Chow Raymond wrote:
> > I can't compile a newer kernel version. This is
> > because Compulab Armcore only supports till kernel
> > 2.6.7 and in that contains ALSA 1.0.4.
>=20
> You could backport the ARM audio changes between
> 2.6.7 and 2.6.12, or
> you could port Compulab's changes (if any) to
> 2.6.12.
>=20
>=20
> HTH
> Clemens
>=20
>=20
>=20
>
-------------------------------------------------------
> SF.Net email is Sponsored by the Better Software
> Conference & EXPO
> September 19-22, 2005 * San Francisco, CA *
> Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects
> & Teams * Testing & QA
> Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
