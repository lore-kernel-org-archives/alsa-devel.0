From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Mon, 7 Jan 2019 12:19:19 +0000
Message-ID: <20190107121919.GA9570@sirena.org.uk>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8688111516383424272=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33B20267B50
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:19:26 +0100 (CET)
In-Reply-To: <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============8688111516383424272==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 12:15:35PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:

> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>

> Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?

Yes.  I've also applied it already and it's *still* being sent without
either a cover letter or the rest of the series :(

Sinan:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzQ8YACgkQJNaLcl1U
h9Dk3gf/VSotM7FP5LrgR8nnd8s0QCNxDaJNzQKDeK5QNqcuJTjFXHnueHbqQTN1
XTK8OXYLK8DYqVDYpv+3HAdYdb1p0U/oEZo1kDof0et7g3+HnWy5h09jWxjREbw9
GdAVB5B4muqL0O9iAXXGnk+nubHbVccT3Ksf3qRwxQk10ttkjUWiYEGu12B3d08U
0UmuzpXOmm3TUPvydt+myreT99t22YBTAXgYYR5uESOoFrB88yn+AFu35LNZD3mh
OgnMFAF5pXoFGAlP0FuLlmDbvW0Y5VUsUKe4iP9iWVK3wTt52bONrao5f98vl9hR
ydbZSx4dHQ5kMURR4qvl0PQzQc8e5A==
=HdFs
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

--===============8688111516383424272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8688111516383424272==--
