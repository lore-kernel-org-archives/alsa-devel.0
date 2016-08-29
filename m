From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] ASoC: rt5677: Add ACPI support
Date: Mon, 29 Aug 2016 08:24:14 -0400
Message-ID: <20160829122414.GQ8799@bill-the-cat>
References: <cover.1472071966.git.john@metanate.com>
 <89438b4e87725c528e325ce278a0f4319402db28.1472071966.git.john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wr1Q/2bz0MCWWNYv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <89438b4e87725c528e325ce278a0f4319402db28.1472071966.git.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, Genki Marshall <genki@genki.is>
List-Id: alsa-devel@alsa-project.org


--wr1Q/2bz0MCWWNYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 10:06:35PM +0100, John Keeping wrote:

> The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, but
> does not use the standard DT property names so add a new function to
> parse the codec properties from these ACPI properties.
>=20
> Also, the GPIOs are only available by index, so we need to register a
> mapping to allow machine drivers to access the GPIOs by name.
>=20
> Signed-off-by: John Keeping <john@metanate.com>

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wr1Q/2bz0MCWWNYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxCluAAoJEIf59jXTHXZSOk8QAIZm1lrfpWk61RexbIQ/tozc
C0hypWs6iJK8AXzbnbFdWcyh44+OERVcrplKlq2Pw9xNihK1qNvNYuASmz+62Mc2
BHsYQ7Rx+URBqg81L9LvAR9IO/c6+7TVbvBN4J4vaZ8TrQ1BY6bY1BDrW5TwHhit
SQ7aUI8xdHeo3s3eBJ16P4bSz3lHsgDqPH792Ix8PirIuViY544xYeP6Zg0UY8WX
clvpiv4kx4B1h9LSn+gzRUyYHyyYuipWCZgnHMoIS81U9CbyETBn0UzBwqa3PU8W
Ow0yiGR1ZmvDxqFmO4qrK+uzyCxtohAaqpZt1k6Cdqs9SdPK4z1S2faa0zKfuv15
+ciUxOsiI/idPb5dOguQcH4AqWuKGSyoT7P9pZaa4TalTM9RhrG9V8S/J85asjZA
3C/IZ5wb6FSRG3eVYbHG3FEk4ni5hQWjEboferiKo0UlAfukXElNpj+ucjtQv0ck
PCampkdRfuG8HMQA5z7NuLs3FTSBKG9tKLEd2V72RG3N4IdLt5OJuq9Q0guY7Y6h
Qk8W5PZOvb5hB371FIlubb6VKKozXcFyNePfkuOIFCsZf4EC73BGfLEZtFozfcLO
onWq8CMV9ywlSspu3Y+xkiQb/8q3L6fcryhJnNho/HrHidW+tMfndpISgwXJHgOl
jECo88Uw0AsXVSBSgzlT
=lcJd
-----END PGP SIGNATURE-----

--wr1Q/2bz0MCWWNYv--
