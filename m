From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel on macbook5,
	1 (was:	lockdep	warning	on	2.6.29-rc1	with	pulseaudio)
Date: Wed, 14 Jan 2009 22:04:42 +0100
Message-ID: <1231967082.21021.1.camel@johannes>
References: <1231866121.3847.6.camel@johannes>
	<s5hiqoj870o.wl%tiwai@suse.de> <1231868779.3840.11.camel@johannes>
	<s5hk58yfko5.wl%tiwai@suse.de> <1231928348.3730.7.camel@johannes>
	<s5h4p0288sb.wl%tiwai@suse.de> <1231949930.3789.1.camel@johannes>
	<s5hk58x7t74.wl%tiwai@suse.de> <1231950785.3789.4.camel@johannes>
	<s5hbpu97r0t.wl%tiwai@suse.de> <1231953755.3776.4.camel@johannes>
	<s5h3aflei4z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2607872420157364342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id C447210384A
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 22:05:04 +0100 (CET)
In-Reply-To: <s5h3aflei4z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2607872420157364342==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ChqMxE9feDMX8CQkfmtm"


--=-ChqMxE9feDMX8CQkfmtm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-14 at 21:40 +0100, Takashi Iwai wrote:

> > Now, I actually get sound with model=3Dmbp3, but the controls are all
> > wrong, e.g. line-out controls the built-in speakers, and the speaker
> > on/off control doesn't do anything to the speakers. Also, I need to tur=
n
> > up the volumes pretty much to max to get any output at all, which seems
> > a little strange. I'll try to figure out what the controls really are
> > and see if I can make a new model that links it all up correctly.
>=20
> Ah, good to hear.  Then we have really a better hope now.

Yeah, I just need to figure out the correct set of controls and outputs.
Any hints here?

> > Anyway, sorry for the bother and thanks for all the help.
> >=20
> > In other news, I've got a new aoa patch that actually works on the olde=
r
> > models, but so far doesn't fix the quiet sound problem either, I'm stil=
l
> > working with Andreas on that. And I'm also working with somebody else t=
o
> > get optical output on topaz-based machines.
>=20
> Great.  I can merge 2.6.30 materials at any time.  So feel free to
> submit patches.

The last status looks like we're missing to turn on the "master" amps
via a GPIO, so it should be simple to fix, while not so simple to
debug :) I'll send you patches separately.

johannes

--=-ChqMxE9feDMX8CQkfmtm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJblNoAAoJEKVg1VMiehFY/vMP/ikZ+QndOrNuL530bJjy6qPw
WQYf2+uxf7zivbIL4azMNEsCs4wju3mbTrs+uLEGKg2/iiYBqsZ635lYhuIV9CN8
D1LCM9MPwhS+tovhM7ko6TYsS+X6cI8GEynJa0h/rxLIDCyHeFUeBUGH1z0kJvhm
6QGiY705slwsI8xStlQzBK3eJnCzvVQlUzXs/w6+gJ9yh2hkV4JHHTW53wople40
/cQS3dk/vG0iaoKBe5fD/0LcmCxbELme2rvyK2hdny0+N3lKCLr3wyMGd37kHan8
uO/xuEm+UJAikhAfx+uGKSzOLBY1USsO4TrrrtP8OenFDEOLiWC11cIwrlRrRIF4
oeKhb3MAP+GMbAt7lKZkUHZ0k62mOGL2DY3fcKTgJprdxzqOcsUSzI9t99XUoB/c
30wvL2Uj3EuyHFN6VwXZGP40EG+th2Eukejki0nH6RdQiAa4FAm43toHUuOlVILk
kRt6pvOd+xM1891AgTWu6do+3MjUPPUP/LmHpNvE9Vm/CaGHz1yvvC8tXTuxDVwQ
ypFfop375X7ZmhiFoYxUTxkLnll02g/HmFxmIl573pt6ZcjMq2o7pfHs6zR1lKSV
C4s46fbaatO7XUdyb0olkiKRdzxxHxtwhFKLr9+FBsIsTGgOe8PUXG7OEFRlaoaj
CCLLd0PWA+e/go1+N4ry
=ktW/
-----END PGP SIGNATURE-----

--=-ChqMxE9feDMX8CQkfmtm--


--===============2607872420157364342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2607872420157364342==--
