From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: release GPIO when
	component removing
Date: Wed, 8 May 2019 18:48:36 +0900
Message-ID: <20190508094836.GL14916@sirena.org.uk>
References: <20190507051140.240245-1-tzungbi@google.com>
 <20190508063318.GL14916@sirena.org.uk>
 <CA+Px+wWQpvE5H=vM+0u_c3xpuZ8ivfgy0_xB84Ty_dvMAqBSVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6616724082458859819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CBF4F896FF
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:59:06 +0200 (CEST)
In-Reply-To: <CA+Px+wWQpvE5H=vM+0u_c3xpuZ8ivfgy0_xB84Ty_dvMAqBSVg@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>, tiwai@suse.com, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org


--===============6616724082458859819==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wu68CvGel4BZ8z1e"
Content-Disposition: inline


--wu68CvGel4BZ8z1e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 05:27:35PM +0800, Tzung-Bi Shih wrote:

> probe().  What do we expect to do in component's probe()?

Only things that really, really need the card.

> As component's probe() is later than device's, I thought we tend to
> put resource allocation in component's probe() for reasons:
> - to speed up the booting *maybe* a little
> - to allocate resources when really need them

No, this is backwards - there's no point in running through the ASoC
level initialization only to find out we don't have some critical
resource.

> I am using devm_gpiod_put() instead of gpiod_put() so that I suppose
> devm_ should take care of the rest of cleanup.  Do you think this is
> still a mess?

The entire point of devm_ is that it does all the cleanup for you.

--wu68CvGel4BZ8z1e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSpfMACgkQJNaLcl1U
h9Bzmgf+MWD6CGQnDLW009iYmQOxZ2AtXLFHSPWkl/m+Zv8t/2RyWh/DTYTetLpW
oOT507k62Ymfi3bWkYMborHR1rvoWwSi8eHguoL31vjseTvZbm4xxit8rSWkbIW4
uA/KFUDogdxK4kqvNJhjdH3A3Y3LlBeFS/JXNoW4VWa+7dushdlR+euA8A6TlLEb
HGOVMcRd8aoWokidMZXxEivuPSQOTRTz3f4Xejl1eCplhXwIMD7lq/08J6Y/rwk0
DCg+vhLoGafR8pYcJWjqlU926bAo2T2ACZaqCisYsTL6+UdWTlEwVBYEH2aSZX57
7nWR8Qcg49HzJg7ze7DW3CEfnEk5uA==
=sMJM
-----END PGP SIGNATURE-----

--wu68CvGel4BZ8z1e--

--===============6616724082458859819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6616724082458859819==--
