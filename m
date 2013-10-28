From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Mon, 28 Oct 2013 08:06:39 -0700
Message-ID: <20131028150639.GA10936@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131024095118.GH31415@sirena.org.uk>
 <526A1568.9010100@linux.intel.com>
 <20131025100618.GR18506@sirena.org.uk>
 <526A4B11.5000802@linux.intel.com>
 <1382961194.2334.23.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382961194.2334.23.camel@loki>
Sender: linux-acpi-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2013 at 11:53:14AM +0000, Liam Girdwood wrote:
> On Fri, 2013-10-25 at 13:42 +0300, Jarkko Nikula wrote:

> > Yes, I don't see any urgent reason to push this hack in. Better to chec=
k=20
> > dev_name change first. What I'm going to propose there is "spix.y" to=
=20
> > "spi-INTABCD:xy" and "x-00yz" to "i2c-INTABCD:xy"

> We probably need to be able to match on ACPI name alone as some BIOS
> settings can change the I2C bus number and break the name match used at
> bind time. e.g. on Haswell the codec can either be on I2C bus 0 or 7.

Indeed.  The way I initially read the suggestion above the idea was to
replace the bus number with the ACPI name for the device which seemed
sensible but now I reread the bus number is still there.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbn11AAoJELSic+t+oim9NH0P/03Ba96/mhYjEIa5OxlL+JKx
rA1KiLKyaX3YO1CNYNCxzBUGVNWenrjmlBoD+LZVe6WDhLCwOEiyUNgn8ZESJpvG
+7git4Xz53+qEJQYbicxn+hMBhRRDGgET1nAR1mAdL1uMYo6zppDL+VpQqzLvQsi
d0nk1YabVjaSJurMBoHZ0JSSVCjslcwa/8Ex9566emfNYmhASJ+Rj2OvMh33v4jT
xQ0lsauaVxvHP9EWYVH/6qgZWuGrf/K7jKoXSrb5GGuPUhjOFvZGQoSt/9JxHgPx
aR4SU6arni5stn4lP7SRMtsKjk+qcl5uQlbVaYcRXZ3fjE3QQJruj3+9rB2rDYLQ
9W/SqSeM/bCmwakHZYwxPbYfxwpRKof7og4rfVh/3YK/sNkoG/N+LtBGOKr5dR5q
VvzaCDiD590KhAuw/Ij0nNqzu24uGKm1wk+6HWBKS5I6Jp8578oNQPs0HDMgezZh
hVSWhGqMqO4SUPc+HBKh6mxgmqd9zNaYxpHDxplcmDY97eMf8Zqh0RD6NJj4e5zU
94K8rqK54FK7GiRmgkHjzjm+8b28YWmbNpMmCkn8aB2+mo0hC14++no2+1K4CPiR
ZO+VoTwbfyAZYCzW0yosWCZmQgDF5yjh4HhRI26mNbiki0N/6x0V+o+MEwZrfQuE
5Kvt2t42JazyT6TDCsLO
=eMif
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
