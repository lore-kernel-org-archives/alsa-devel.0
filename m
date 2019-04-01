From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/10] ACPI / utils: Introduce
 acpi_dev_get_first_match_dev() helper
Date: Mon, 1 Apr 2019 14:23:08 +0700
Message-ID: <20190401072308.GD2059@sirena.org.uk>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <20190328171729.44002-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5911700954738424892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96060F89610
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 09:23:20 +0200 (CEST)
In-Reply-To: <20190328171729.44002-2-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5911700954738424892==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 07:17:20PM +0200, Andy Shevchenko wrote:
> The acpi_dev_get_first_match_name() is missing put_device() call
> and thus keeping reference counting unbalanced.
>=20
> In order to fix the issue introduce a new helper to convert existing users
> one-by-one to a better API. And then remove the old one.

Acked-by: Mark Brown <broonie@kernel.org>

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhvFkACgkQJNaLcl1U
h9CfVwf9HI0pZk+Z+ehn8o4fu2GIlocSGL0J3RM/XTqgcfr7l25I8VJ5OY4XIjvx
CF78KzbqnSzYe1cozgb5ZfpCq/m9CWEftEyyH8LG2K8rvkG34uG8+4hcG2CiRf4m
9evfeVg7f4Pgh5bAWji9ATYHn66ad6KC/hI5D1A2P/57r4H99d9XOav0OJDYUr4R
JalXFc90uj5uzT3nhKtFtdXOCY34Z/pqwRTBI9zh8bJKWqIoYjOXSVF5PT9QbAc8
YColLAcXSTGujFMTAfIt1OegQCVHU6u/dQIIEfdIzpLK0tG16lML9ahExfpXoZvO
nnJ0uDdr5AxtS3HvlvfLmJadwLw+lw==
=6KQ6
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============5911700954738424892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5911700954738424892==--
