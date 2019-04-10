From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: fix error handling when
 try_module_get() fails.
Date: Wed, 10 Apr 2019 10:50:10 +0100
Message-ID: <20190410095010.GD6106@sirena.org.uk>
References: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8391509918069456157=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E6AEF8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 11:50:18 +0200 (CEST)
In-Reply-To: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8391509918069456157==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 12:30:25PM -0700, Ranjani Sridharan wrote:
> Handle error before returning when try_module_get() fails
> to prevent inconsistent mutex lock/unlock.
>=20
> Fixes: 52034add7 (ASoC: pcm: update module refcount if
> 		  module_get_upon_open is set)
>=20
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

You keep on adding blank lines after your Fixes: lines for some reason,
this is unusual and will probably confuse some tooling.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytvFEACgkQJNaLcl1U
h9ATngf/fkHMlmYNpIrhLTG3VTz5e+U99aNBRfv95dKNcUXmnzH+4e/wBEElSYmR
TzydlncTBKXCO0LhNSQhBr+ykAyzHZhEvNzb/g9mHcuTzZwASzMFOG/8O3urgREs
3ph6dVVoCOTae3EYnhmBczSxk8b43y7ImnenY+BpFES+RbCJ/ZrIDpMVcGRnEvor
vyo7xJ/9WGbMYHI1tusi3+9HNm5QZ8x/IzBElpdjtKVPTvgafbGWka6lF0hGpVAc
IdX9/+KeNlH7mukGy2nYJL/XYuYHxLU/gc35waPLrS1f1Yr/kOWiJ2PHScVVMuoH
9D2GEgJdeZr3ZXI1643NifgtlQrqgw==
=ro76
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

--===============8391509918069456157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8391509918069456157==--
