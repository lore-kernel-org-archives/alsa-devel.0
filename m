From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Mon, 31 Dec 2018 19:30:17 +0000
Message-ID: <20181231193017.GN1846@sirena.org.uk>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
 <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5040618066953894181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8910C26789E
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 20:30:21 +0100 (CET)
In-Reply-To: <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sinan Kaya <Okaya@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5040618066953894181==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
Content-Disposition: inline


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:

> > I don't have the cover letter or anything for this series, what's going
> > on with dependencies?

> Here is the executive summary:

> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> used to select PCI. This is no longer true.

> You can build an ACPI system without any PCI devices.

So there's no dependency and I can just apply this?

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqbkgACgkQJNaLcl1U
h9Cy7Af/SKh5ExwIo1qfaqbvscfVYRWs0W8VKlzlNdN8kXxt8QCCNdbT/2O4rs6N
+Y/6+FAF8v5ZOBWmOGsnxt8uDP9iLcSWn7y2xOZCAdqbSoWpIQ+lLqRjm3URogit
VWAciGWsmUpqRK3YVGSZS1X73gTaYaSFlK9S3LixBZE+ADnxBDdtGsWPoJcllgvi
38PyqC1eeOLIfuV1Mvp/jVuuFv4PnI4VIDgkE6Wfc6n6xXHkATGeGwsE23oufyVl
7B/6FIJXvtrEG9rVSaXyY4VBX3GA30xYPb97UvDDTe6uY1YVsKSL8LbMzs8SPoKi
U9eTFFH0kA9P27ScaicV6CPKju5z6Q==
=zjWy
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--

--===============5040618066953894181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5040618066953894181==--
