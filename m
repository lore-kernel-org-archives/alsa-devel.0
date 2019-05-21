From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Date: Tue, 21 May 2019 10:44:38 -0700
Message-ID: <20190521174438.GA2821@google.com>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190518063949.GY4319@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> On Fri, 17 May 2019, Gwendal Grignou wrote:
>=20
> > Lee,
> >=20
> > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > used on chromebook using a squashed version of these patches.
> > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > respectively)
> > Please let me know if you have any questions.
>=20
> Is no one else from Chromium going to review?
>=20
> These seem like quite important changes.
>=20

I've gone ahead and acked the whole series. Enric and I are OK with this go=
ing
in for 5.3, and as Gwendal mentioned, he's landed these changes into our
production kernels for Chrome OS as well, so this is what we want to sync o=
n.

Let me know if you have any other concerns.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXOQ5BgAKCRBzbaomhzOw
wt8HAP9uU1klLrzkR34L7NbfgwEDQgELzBnyp0zr6eH8FswIUwEAhSZ8hXpksiuJ
cuKw4zj4F0wocqqx1xPt59u73qeMXgM=
=Zm0H
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
