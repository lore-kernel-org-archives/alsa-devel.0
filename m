From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Sun, 1 Nov 2015 11:54:38 +0900
Message-ID: <20151101025438.GH28319@sirena.org.uk>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
 <1446217461-2106-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2471954668234558894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 970F326061B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 09:53:47 +0100 (CET)
In-Reply-To: <1446217461-2106-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2471954668234558894==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+84OEkE2sKTXuqtJ"
Content-Disposition: inline


--+84OEkE2sKTXuqtJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2015 at 08:34:18PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> The UEFI BIOS does not create a machine entry for Linux devices
> so add a table style machine registration to fix this missing
> entry

How does this relate to the existing sst_acpi code?  This might be
clearer with a user...

> +static struct sst_machines *sst_acpi_find_machine(
> +	struct sst_machines *machines)
> +{
> +	struct sst_machines *mach;
> +	bool found =3D false;
> +
> +	for (mach =3D machines; mach->codec_id; mach++)
> +		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
> +						  sst_acpi_mach_match,
> +						  &found, NULL)) && found)
> +			return mach;
> +
> +	return NULL;
> +}

=2E..but the code looks extremely similar.

--+84OEkE2sKTXuqtJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWNX7tAAoJECTWi3JdVIfQeEkH+wYwpovk0GHxdl/XxzMhpKBw
0ZabnTJtD90faJXGGVztnrYEMCcLbvGiZYgsadyYcGyomjf/BfZt2FGQJCbbDIGh
jDerfYEFxY0JoKsJXIYTioNYly7QGDoHSzYkmvPYIyOAIjOYYdJLPsvehPYM++LO
T5f93EsERrQyXJ8W2R1e4X0NjYAooJ0gWPf4n0C8HiR2E41XwpNIdJyVjl1g1CR4
OmJoK/cUvWUoVyjCKx6WM2ljIN15dzxjQtULDhnHKlYim/i8qpD/ThT5iwY6N8lk
NDcXvlahWdjUDmI14ikmBij8sY6VS2sO10akQ+Z2Io4lFrJ860RRfJtjU9F0hhw=
=R0iO
-----END PGP SIGNATURE-----

--+84OEkE2sKTXuqtJ--

--===============2471954668234558894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2471954668234558894==--
