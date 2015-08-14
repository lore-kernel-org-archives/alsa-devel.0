From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: handle reset_pin logical
	state correctly
Date: Fri, 14 Aug 2015 20:01:26 +0100
Message-ID: <20150814190126.GI10748@sirena.org.uk>
References: <1437154736-15320-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5674636862471746352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB22226659C
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:12:56 +0200 (CEST)
In-Reply-To: <1437154736-15320-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5674636862471746352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D+MycPccvPlP5/X+"
Content-Disposition: inline


--D+MycPccvPlP5/X+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2015 at 10:38:56AM -0700, Anatol Pomozov wrote:
> According to the datasheet RESET is active low pin, i.e. system goes to r=
eset
> state when pin is low.
>=20
> Handle logic state correctly - set reset_pin to logical 0 at boot time, a=
nd
> set it to logical 1 when we need to reset the chip.

I'm a bit confused here - how was the original code (written by you it
seems...) tested?  This looks like it's fixing the device being held in
reset when it should be operation which seems like something that'd get
noticed.  Are there existing systems that the current code works for
which we need to handle here?

--D+MycPccvPlP5/X+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzjsCAAoJECTWi3JdVIfQJXoH/0GyyTzG7/V2eA9eDCHRgq+u
15wEXBglT6GGH0HgIueqJDiRwSEOXd0zq1giQBO4WWjhAPrsa5wB57gZMG278s3o
MXyGwwjVYPZ1vLkI4pOXZ/B4orw3gcOaUk7SLX9aD2ompg2T3fMsAM21WDZg6/gH
dTnbv4dVcry0rdx0LnPPQ0OfPVCARc2ArkvtIWCAjYmTCRWrpjltpkbzonfdAjm+
7cm+O7K6guHIpVlDotfeQM41r//78bao8FrEEAphKkLhPCxhfiWTPNW6/xNb4HW2
0hKwD0XTDw+yYYo8+f2Emsg9JlrWIT1OvsJDj2maHqoJYzRzKpoe7IYYcO+0lX0=
=jB3d
-----END PGP SIGNATURE-----

--D+MycPccvPlP5/X+--

--===============5674636862471746352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5674636862471746352==--
