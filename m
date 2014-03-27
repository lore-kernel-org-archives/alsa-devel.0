From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: set up channel
 status bits for S/PDIF mode
Date: Thu, 27 Mar 2014 13:18:23 +0000
Message-ID: <20140327131823.GM30768@sirena.org.uk>
References: <1395916060-16234-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2044706812713888080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A34E26536F
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 14:18:44 +0100 (CET)
In-Reply-To: <1395916060-16234-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2044706812713888080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8c07nsHwQobhlezh"
Content-Disposition: inline


--8c07nsHwQobhlezh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 11:27:40AM +0100, Daniel Mack wrote:
> In DIT (S/PDIF) mode, program the transmitted user bits to reflect the
> configured sample rate, along with some other details.

Applied, thanks.

--8c07nsHwQobhlezh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNCUcAAoJELSic+t+oim9R24P/jHCzKRd5PRw0jAm9sr3nEu2
kTJTLMLV6z2vjvbLkRlFrKU92bn9J+SMnyoRKQtuZ4dMBn5zIuoxT1ftAAOBO2xJ
63cH1E+wRol2WKN6M6d5hgCMKe7BkYeYpkzCqP3QcpJ25hsh1MLj631tafG4VCFb
I68ko6V2pvSA7tH0q7nXP4ROdi9/yWBAt4lFxeHv5oDZYIwTe3qBGGO3ZSHY501p
TxI4ratr8tLo23+rKDKwoSlB/s7EerpxOKtRVbvLii2ws8LjdtzBIJkozAZ699EJ
GGXSyk6ORmwBpWoX1UgYyfUNqy3itO2FmGL/eByufeOiBaZ1Mmh2X01ajPhxzrLy
se3RWPfkozn7FOauP3PjtinrApZQ/+a54pwELmRjL1DioNdMO7jc+GYBoQQISBTC
cO1cVqav+57Pvl2G8D2SIR/plHVq2o8fFMhGQWB4TWWsjeceSgVObriM/83OF5LQ
YF/z9Xg4yL697sSzpn/Cfz7ZRN56t1fzwtqHSAXqSzeX/C9L7CmlXq+foW2Dc23t
TwUua8rxlzIi7fc8PHJfmulgYhEfimbB2nrjviffiOAL0qVNeXRutfqp12TEONXl
OnsIKDUEvNsxW9AooTGZDcfcMyoOt+Q4ZhHWeQKnakzn0sXxP0p4MWZwgg9CtU+D
xczbmXuTbT5XuSl0PQBe
=lSJ5
-----END PGP SIGNATURE-----

--8c07nsHwQobhlezh--

--===============2044706812713888080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2044706812713888080==--
