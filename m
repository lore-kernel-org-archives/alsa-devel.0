From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Used lock version to update
	shim registers
Date: Tue, 27 Jan 2015 18:36:55 +0000
Message-ID: <20150127183655.GI21293@sirena.org.uk>
References: <1421796023-29262-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5665281173326448750=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 402E12612D2
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 19:37:01 +0100 (CET)
In-Reply-To: <1421796023-29262-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5665281173326448750==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jmRPoIC9n3oXxCzZ"
Content-Disposition: inline


--jmRPoIC9n3oXxCzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2015 at 07:20:23AM +0800, Jie Yang wrote:
> We need hold lock each time updating shirm registers, otherwise,
> we may set unexpected values to them when they are set in
> different thread at different time sequence.

Applied, thanks.

--jmRPoIC9n3oXxCzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx9rGAAoJECTWi3JdVIfQa80H/jvc/ygZwsrjq3Nm9kDIxuQK
vPvTpH9eoWca5I92MUKq6VDYU69TVYWdKU4glsZwGz00/sf6rCC86y5pSYrL86JI
rv2vQZvyZMRgxnRkRbIn3WbxBR5U+eTPh44Cf5/7H2doXp4bQjjQeMEWuF42c/gr
iNRd30I0WDWZhlqDtJSS0vvFQU4LKZvvpwJSE/fXbgG5Wa0gV5jz6ZtVGIxJoUjf
+3JuvAFoeT42U/K364bG7Ok6V7pn5vF7HNkPkNRcihx8RgEU1i+kLO4ALHxgR5O9
ty3NvVY6h++7a0YNRzP+7BAhq0K8AA47oJasV8KNVTDiLV7ebsQL6JpW/3HD/t4=
=WoJi
-----END PGP SIGNATURE-----

--jmRPoIC9n3oXxCzZ--

--===============5665281173326448750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5665281173326448750==--
