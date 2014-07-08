From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l56: Move ADC/PCM Swap to DAPM
Date: Tue, 8 Jul 2014 18:21:09 +0200
Message-ID: <20140708162109.GB30458@sirena.org.uk>
References: <1404831395-12940-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9069336234328355117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D58012619E9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 18:23:00 +0200 (CEST)
In-Reply-To: <1404831395-12940-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============9069336234328355117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xd76R9tHJzDpbIo0"
Content-Disposition: inline


--xd76R9tHJzDpbIo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 09:56:35AM -0500, Brian Austin wrote:
> The Swap controls for ADC/PCM paths should be in the DAPM domain.

Applied, thanks.

--xd76R9tHJzDpbIo0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvBpyAAoJELSic+t+oim9ydYP+wZOdxYCWG+bqcQOy1S78Ibv
d5be5aAEE4xBbHItjovMBibIHYXZv1QmY8H62QFhuGUhurVi9/jadK2ivMtUx5XN
/pmIZvq2+urHo+oIAXcZAeVDApFeooXQdg+b1LGUw/IPETaebN315T69WwEpvbNb
OxnSkc4M9QcktSB+mDW6M9ho11DHSeN/tcEax7j6SKdQsqIDfqPgZYyHbwbdz1g8
aAl6oT65Q0OWNmfipfk4T6MkVScWdoyCMpgrawwOC/MQ2eH2bckRRIVTGME8eXCC
MbR07wmhyoWOfCPMf7mIjX/WmEBHaVZPHO1fzvGBKnyyz03wezmgjkFfTpekJL5E
pUfz6Bi5Ca5onUWSc/HhUNJRXhdVx6tmW6WferDpznb2xOYdwG4R64DRpka8oSvK
LmEpJbuP/5Pyyv3Orgvar2Nvh13ju9luG7WnQ3dyQzFbtb41MSOgryMgseaE8uyL
uVPy/HSP/dH9MertsdAKVaee5w5O5eWmx3WlB0CCxBb9mxxyBh07tHEhYvm+bmrD
DM4IbVaQjBOG5+Ng5X4gOlVzv0FrFZPms4i+YigtI9LK/4tQR7+pHsoPapYmlvk9
2uqLSdxP0cYVDDbrfq94cJR3WCUm/vFAoVNdaF32uLyr3IidpT8TuIXuz57cfFB+
2yFrxF1cUlv/MppeqACg
=TqK7
-----END PGP SIGNATURE-----

--xd76R9tHJzDpbIo0--

--===============9069336234328355117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9069336234328355117==--
