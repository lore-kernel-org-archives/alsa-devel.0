From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/23] ASoC: tas2552: Fix kernel crash
 when the codec is loaded but not part of a card
Date: Thu, 4 Jun 2015 17:25:27 +0100
Message-ID: <20150604162527.GJ14071@sirena.org.uk>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
 <1433423075-14142-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2601059658998785553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E0626061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 18:25:33 +0200 (CEST)
In-Reply-To: <1433423075-14142-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2601059658998785553==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nZJfpKFx8DwcDuUR"
Content-Disposition: inline


--nZJfpKFx8DwcDuUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 04:04:14PM +0300, Peter Ujfalusi wrote:
> If the card is not part of any card the tas_data->codec is NULL since it =
is
> set only during snd_soc_codec_driver.probe, which is not yet called.

> @@ -120,6 +120,9 @@ static void tas2552_sw_shutdown(struct tas2552_data *=
tas_data, int sw_shutdown)
>  {
>  	u8 cfg1_reg;
> =20
> +	if (!tas_data->codec)
> +		return;
> +

This fixes the crash but isn't whatever the function is doing important
(so we should fix by using regmap for the I/O or something)?

--nZJfpKFx8DwcDuUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcHv2AAoJECTWi3JdVIfQnjsH/1bp9qMtCNGylv+AHl+GAZ1Q
KKnRW0I3XDHlPcpJgHdUG8dGh8I/RV28VoaiTKdJLq1SxT4DkNYvvkoOeeSyQPiS
5FntQJK3yJiPirjxaJF8UJjQX1wD5mP3L3ObNw4JgTUocrIja15UL+AdQez/1HHf
g60QQmAywrR4k138uifklmGtp5zz4FbvrxnyovkNv23yerqkEyF+R903E/tQj27Z
EkGpX46LnXzKS3f/tAKQAerpp2uY1ftd8btxlojEUP/m1+lpmuhgzmHCQuTEfDB4
EisA64Dx9Rqh9fjHXeH7EqqzdOrcG+pv2z+kkaa8QPO162KrzeiNdR70sa0Z46c=
=165i
-----END PGP SIGNATURE-----

--nZJfpKFx8DwcDuUR--

--===============2601059658998785553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2601059658998785553==--
