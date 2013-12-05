From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_kree()
Date: Thu, 5 Dec 2013 12:21:13 +0000
Message-ID: <20131205122113.GQ29268@sirena.org.uk>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
 <20131204190211.GD29268@sirena.org.uk>
 <20131205025630.GG8609@MrMyself>
 <20131205111508.GM29268@sirena.org.uk>
 <20131205110727.GA14744@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5368300905154984975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6CC265500
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 13:21:16 +0100 (CET)
In-Reply-To: <20131205110727.GA14744@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5368300905154984975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzM1j1Hh4qIUNijn"
Content-Disposition: inline


--lzM1j1Hh4qIUNijn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 07:07:28PM +0800, Nicolin Chen wrote:

> Then I think it would be plausible if I could refine this patch to
> allow both set_bias_level() and hw_params/free() to control the FLL
> while making them not break each other but coexist, right?

Yes, that makes sense.  It might even be useful to have some support for
this along the style of the bias level support in the core since modern
CODECs all use things like charge pumps and class D amplifiers so this
is becoming a more and more common problem.

--lzM1j1Hh4qIUNijn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoG+2AAoJELSic+t+oim9VUYP/RUCLopjQwJoGrJAlfQ3wtyE
7Z+Scz2i5AD2FIj47YlYmlQP0Y7GkSxmYkfcIrbFTh0Za+Y14qe8dxHKIkDHscal
GfaSXz2uuFcTcxT3pmLBIjjZ2tHzD/X6gAXXYXr41k8/WnDucGOn+PFDRlW+pWHA
FSdsKcY7p2KV002JKo/ZXrMPf3GZiDxdM+7LVc+8iTfwuw7o+bkWLRnCQlzDNYut
S1OvhjbsCe5+NReC9hz3uIYXc8sfcN1XQjkyusy4G9S0/WfJeb7Wo/kN1WJN6QbI
IWUva3FP8Fb32thN8+OZctU689/iHddSF+/6wItplKoNXdfHeNTIXEZaRk05JMaU
KFoLa83zCYWH04t6c2W2bWQ15pFdk9OxuOHWLi7xwk5O08Oy4tnEb+gM6jODpGDO
5RpyNt/uwU5UYFjTRROkp4JDm2ytpTzJlr3ypnUF4kKyOzfr4CWWVTdpt5plFLTK
5oFzjp5rMJxVhm8yePrgtinzzUUBpAlbz++MbQT2Ef8iEbhHgCmTkfmSyA2pbTj2
HHXK2eje+wm+gqsZZQVpMSPOAUmCoZeRCVs5L+GRGrnVIAZB0NvYUrxwxXC1+eRc
CCdpgYsX4w4euYkiHtWK7xu3Pti29/dQTcIVLr7Tm/dJAHE8llb1qZKZ0Fvi4x+u
Do4OIRhk3sWuOB6uzKKL
=Ba77
-----END PGP SIGNATURE-----

--lzM1j1Hh4qIUNijn--

--===============5368300905154984975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5368300905154984975==--
