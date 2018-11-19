From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Tue, 20 Nov 2018 00:57:13 +0100
Message-ID: <20181119235713.GB7367@amd>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108171701.4444-4-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some of Huawei laptops come with a LED in the micmute key. This patch
> enables and disable this LED accordingly.
>=20
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>

NAK.

We already have a LED subsystem.=20

> +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> +#include <linux/platform_data/x86/huawei_wmi.h>
> +
> +static int (*huawei_wmi_micmute_led_set_func)(bool);
> +

So we should not be doing this.

Thinkpad ACPI module exports its LEDs there, for example.

Thanks,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvzTdkACgkQMOfwapXb+vJHtgCfSrSy/HEgobRBwkYpnbJZM5jI
n7sAoKGojJc/+y6lgXlowIZ45WRVDCd0
=9SXS
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
