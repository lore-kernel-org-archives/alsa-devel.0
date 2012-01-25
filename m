From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.4
Date: Wed, 25 Jan 2012 11:35:09 +0000
Message-ID: <20120125113508.GC3687@opensource.wolfsonmicro.com>
References: <20120124201157.GB1135@opensource.wolfsonmicro.com>
	<s5h39b4n8lw.wl%tiwai@suse.de>
	<20120124204615.GE1135@opensource.wolfsonmicro.com>
	<s5hvco0xhx9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3402816375222375175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70271103B93
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 12:35:10 +0100 (CET)
In-Reply-To: <s5hvco0xhx9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3402816375222375175==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2012 at 10:14:42AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Jan 24, 2012 at 09:33:47PM +0100, Takashi Iwai wrote:

> > > Yeah, my git is still 1.7.8.x and it doesn't seem to work well with

> > Oh, well.  I think it's the tag rather than the signed bit.

> I'm not entirely sure who to blame.  The error message is:
>=20
>   % git pull git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.=
git asoc-3.3-20120124
>   fatal: Couldn't find remote ref asoc-3.3-20120124

That's the tagging - older (and by older I mean "currently released")
versions of git can only pull from branches so that's just saying it
can't find the tag object.

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPH+jmAAoJEBus8iNuMP3dyN0P/RfaMjKXIOyCFw0XcmBB0GmT
dJ9bju3XUf0ipeCwCguCOA4oXwDSoCSNa3hevfDONx/Oa3oHJi6nJpZ3rf+bamVH
oLBVTPzb3hi+kC19Eg+3drV6R6ZwBsuGP1AbZaKR5YphUhq6cb5MNz3FrpIL4L3v
Wer4QAxFYYbjoP1vfHXlE23kfBsJ1UII8pIjcSO9eCFe6kJtA7gaN9d/ctOejjAZ
HlnKngVxcRXzkC5VsK/O4h8eTUiiWaj+TDxwMbrPyivtBYzcehe563FSUld/XKJO
6mEitEtKiZQcs3fDkM7NmrQ7bG2aFrcMVc2JiVVzlCiT/NH0j+9mY4Px4KWz8KYu
EA0Hmkav28GbZsjer0T90yBbk2vRLz8HXQzl5TQVOrwgAWkV6PmI3FUBvyyma35V
6ArIZD+lO6yr2iLEsbyNzPV+I5HnonrKm79sCqLWP0KXAwqHKm11+AOS3HVd7XdO
ATedtmSZb7+YL6dBY1vK3Jwzr/oBebez3q4Q/nCvGHGp2+wYpVgHbZm2yQXbSlkN
CMgac1kyKwom5PtjbFIFQpmuHlZaCsPMLZo9cCRnbtGRyjr+f2DvOyJHyeBjxdLz
yPVAg0IKB3E3siPnrwXpwQ16uJJ9xdx4VtzgS2EVBUVbYeyf+qhYrfLMNAICtbvn
GYQalkdYanV2O6T1E7C4
=Qegf
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--===============3402816375222375175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3402816375222375175==--
