From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dapm: Break out of widget search
 when source and sink are located
Date: Thu, 7 May 2015 12:25:50 +0100
Message-ID: <20150507112550.GT15510@sirena.org.uk>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3879475385100023333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E38972606E0
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 13:26:02 +0200 (CEST)
In-Reply-To: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3879475385100023333==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fNiTSQzYLOUQOoB2"
Content-Disposition: inline


--fNiTSQzYLOUQOoB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 11:33:58AM +0100, Charles Keepax wrote:
> Currently snd_soc_dapm_add_route will continue to search the widget list
> even after both the source and sink for the route have been located.
> This patch breaks out of the search when both are located giving a
> small improvement in probe time for drivers.

Applied, thanks.

--fNiTSQzYLOUQOoB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS0u+AAoJECTWi3JdVIfQk3MH/RWDpsCOU1CwPJ37MuUE20gE
CbmNBMDx+xr54baTIHJ6wiyFqES3+E9OKI0H0D+2nNmQ43IjjjQU+oSw5R9uPmUd
5iCylRH5GjrL/GFoxvAYpAfH/7Na/eR/aO6qpk+CdDRRGbHBwtTTd3mvyCWxqnu7
yI8Gvm17slQPZGmbiITr/2SUnYJX9JcScBQBBhVCz6QabqrQFBeyisQrM0AbPwp+
VCDgNueqwCY7zBGa6XaiDZzLbUafrOGmkRhT3yqLGg2OaeJpMi+3aqDDditQ3GXQ
MZqBBJjsqnQIMNOh9P9YPcEZRIJausrMHolY/BpSXhMakpt3baeCqkquyTY/ZoI=
=DPaZ
-----END PGP SIGNATURE-----

--fNiTSQzYLOUQOoB2--

--===============3879475385100023333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3879475385100023333==--
