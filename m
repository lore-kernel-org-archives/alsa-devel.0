From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.14-rc2: audio stopped working?
Date: Fri, 29 Sep 2017 20:15:43 +0200
Message-ID: <20170929181543.GA23070@amd>
References: <20170929112518.GA15736@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5192581751400305443=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3148A266CE8
 for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2017 20:15:43 +0200 (CEST)
In-Reply-To: <20170929112518.GA15736@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5192581751400305443==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I've had sound problems in chromium for long long time. It produces
> choppy auduo just after boot and then it works, probably after
> chromium restart. May have something to do with pulseaudio. Not sure.
>=20
> Anyway... sound in flightgear usually worked, and now it does
> not. mplayer works, chromium works (sometimes choppy, as usual).

Went back to kernel that should be working, at ... audio is still
broken. Let me debug it some more.
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnOjc8ACgkQMOfwapXb+vLfmwCff++shF/jTkFaE755DMAO4E7b
TMIAoIwwhzlH5luCySzJiFaUaF/qMJ3M
=w6Vh
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============5192581751400305443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5192581751400305443==--
