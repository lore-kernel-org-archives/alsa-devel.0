From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Tue, 20 Nov 2018 10:10:39 +0100
Message-ID: <20181120091039.GA16916@amd>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com>
 <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr2fgfcrm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 08:07:09, Takashi Iwai wrote:
> On Tue, 20 Nov 2018 00:57:13 +0100,
> Pavel Machek wrote:
> >=20
> > > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> > > +#include <linux/platform_data/x86/huawei_wmi.h>
> > > +
> > > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> > > +
> >=20
> > So we should not be doing this.
> >=20
> > Thinkpad ACPI module exports its LEDs there, for example.
>=20
> Both thinkpad_acpi and dell_laptop provide the interface to HD-audio
> in the very same way like this.

Not good :-(. Please don't add new ones, general purpose LEDs should
really use LED subsystem.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvzz48ACgkQMOfwapXb+vIkMACdEeoyQ4jBZysPQAqy3DjYT1sm
0k0AnRxCmwXuVea/WgwOxCu8zCdtjWHb
=YXqr
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
