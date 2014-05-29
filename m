From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8804: Allow control of master
 clock divider in PLL generation
Date: Thu, 29 May 2014 16:01:24 +0100
Message-ID: <20140529150124.GN5099@sirena.org.uk>
References: <1401372483-10216-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0712963303767977108=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1E88261A0A
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 17:01:40 +0200 (CEST)
In-Reply-To: <1401372483-10216-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, florian.meier@koalo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0712963303767977108==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
Content-Disposition: inline


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2014 at 03:08:03PM +0100, Charles Keepax wrote:
> From: Daniel Matuschek <info@crazy-audio.com>
>=20
> WM8804 can run with PLL frequencies of 256xfs and 128xfs for
> most sample rates. At 192kHz only 128xfs is supported. The

Applied, thanks.

> Looks like the version of this patch that was sent in didn't
> apply on the ASoC tree which is probably why it seems to
> have been missed. Not sure whether this was an email client
> fail or the patch was generated against the wrong tree but
> as it is a useful patch I have taken the liberty of fixing
> it up (code is exactly the same) and resending.

The patch just wasn't sent to me - looking in the mailing list archives
I see:

| To: alsa-devel@alsa-project.org
| Cc: tiwai@suse.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.c=
om,
|         Dimitris.Papastamos@wolfsonmicro.com, linux-kernel@vger.kernel.org

As covered in Documentation/SubmittingPatches patches should be sent to
maintainers.

--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTh0vBAAoJELSic+t+oim9XtkQAI8Om1ICe0e90yzJm1/Of11Z
96jgL6J958XgtdzKGYUI+/GL2KmWbwPsdXUBaXU2Pqoa0YY222o8q1lmKQ0dHPj3
41nrwMsZSC4pos5qPMqjVKazHurby1Ozbz7ObNbN3e9n/Qcx28FffBOxfhqZzmKm
2cxOo2MbCyA7Ws656HMMiWKoyIiarbUHUFKluSYi1Nu47OXN2I3Iia8Shj3zldc5
Oy9899ioeaxYFnTI0OadJjVEK7YQXSn9M6jpVOjzPvE+RYqEZTMs7coW0OaMhemw
tUsbHpxhUZR+Y6kko91qX5jwrskS4tWrxKzhN1nxksYP/3PJCtf4tADIp7QR//J2
7yCbeIgfhfFgmafgM/YaewiM5ZNW3mRX2odTe5kN/trKEIZFqZMDAQmSzdaX1VYU
uvpOOfHg4uXTIbnnlBrspmvCP2AbgcNi9+AhUPt7j5Cki+v+dGvFW06gFRpfdcRD
ETw6ZT40Ry6e38i8xAADgIldVZiUACM6/GEJUiJuFkmAlh1Kjo8mG3zG6sgjDqR2
rU3n/aC8gqALzKrm1l/OE8pt4pM+L+yePOQyiMQoycmvKmBLnMwFSwuY5zt3f17v
Bn3Xre+Xw1pzzvXa/93wzPWPZDf0dE8eszSmpy9KkMzaB7DBkR6yQQUuj4hu6vc8
la6YcQpl7tY8RyLqT8wq
=eYtI
-----END PGP SIGNATURE-----

--LvAn5G4Ewe70kJ1i--

--===============0712963303767977108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0712963303767977108==--
