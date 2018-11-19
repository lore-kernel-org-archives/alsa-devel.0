From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v8 1/4] media: Media Device Allocator API
Date: Mon, 19 Nov 2018 09:59:31 +0100
Message-ID: <20181119085931.GA28607@amd>
References: <cover.1541109584.git.shuah@kernel.org>
 <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shuah@kernel.org
Cc: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-11-01 18:31:30, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
>=20
> Media Device Allocator API to allows multiple drivers share a media devic=
e.
> Using this API, drivers can allocate a media device with the shared struct
> device as the key. Once the media device is allocated by a driver, other
> drivers can get a reference to it. The media device is released when all
> the references are released.

Sounds like a ... bad idea?

That's what new "media control" framework is for, no?

Why do you need this?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvye3MACgkQMOfwapXb+vJA3gCfSzUjvJUuuvii9w4a4BBFlKB4
cKMAoK05ssILf7b0q6CHzrTZDJfiadMQ
=u+bp
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
