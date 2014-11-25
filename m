From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/4] ASoC: core: add multi-codec support
	in DT
Date: Tue, 25 Nov 2014 13:21:28 +0000
Message-ID: <20141125132128.GD7712@sirena.org.uk>
References: <cover.1416918909.git.moinejf@free.fr>
 <d380c3d09646c9dda14639b5aa5f0f2b2dc80e33.1416918909.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2072126618999132381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B22265756
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 14:23:37 +0100 (CET)
In-Reply-To: <d380c3d09646c9dda14639b5aa5f0f2b2dc80e33.1416918909.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2072126618999132381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDWkrvKzM17iuZge"
Content-Disposition: inline


--dDWkrvKzM17iuZge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 01:16:12PM +0100, Jean-Francois Moine wrote:
> This patch exports a core function which handles the DT description
> of multi-codec links (as: "sound-dai = <&hdmi 0>, <&spdif_codec>;")
> and creates a CODEC component array in the DAI link.

Applied, thanks.

--dDWkrvKzM17iuZge
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdIJXAAoJECTWi3JdVIfQDY8H/jVuQZCRI8Ra81oQENYBS2AZ
kA2VXXS8q+GDwc/1lne9ys6uizVSnaovBJtrwIfjMi8nri5wpdqAkPTMJiCHnuF/
PmZ5b2wKnM7r85v7PB9xg2xJ0ko4+JURETKmiHm89ZRijwnxnbvt1zxYkOJCQij5
hXdSX8xe9mrgZA8UWS7hQaFi5uVLnp/OU3SH8RHSycDGMHSK3FJNtoPkgVrHUmKW
n/SyfHEycN/J60qgStricuN21h0M9ue9F5xbOd17ucJSlRGU+ZocGEGrKPRSVDST
UJE5EqF03cJe7ZLDdoujM9nqWDjeSdY0AnxEoUINZXdj1b5Divei/BKIAWGZ4N4=
=bRME
-----END PGP SIGNATURE-----

--dDWkrvKzM17iuZge--

--===============2072126618999132381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2072126618999132381==--
