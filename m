From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max9867 codec driver
Date: Thu, 18 Feb 2016 14:16:11 +0000
Message-ID: <20160218141611.GF7129@sirena.org.uk>
References: <1455758929-24202-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2308833677301752072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A51FB2605E4
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 15:16:17 +0100 (CET)
In-Reply-To: <1455758929-24202-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2308833677301752072==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 17, 2016 at 05:28:49PM -0800, anish kumar wrote:

> +			if (pclk_bclk_ratio == 2)
> +				bclk_value = MAX9867_IFC1B_PCLK_2;
> +			else if (pclk_bclk_ratio == 4)
> +				bclk_value = MAX9867_IFC1B_PCLK_4;
> +			else if (pclk_bclk_ratio == 8)
> +				bclk_value = MAX9867_IFC1B_PCLK_8;
> +			else if (pclk_bclk_ratio == 16)
> +				bclk_value = MAX9867_IFC1B_PCLK_16;
> +			else {
> +				dev_err(codec->dev, "unsupported sampling rate\n");
> +				return -EINVAL;
> +			}
> +			break;

This looks like a switch statement, please write it as a switch
statement.  Please send a followup patch implementing this.

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxdIqAAoJECTWi3JdVIfQ0JAH+wYt40XX5L8SKWNjpTbgl8gC
VjEsyRgrJx/ZX+BQCYb6XM+OKgWqHJLNj19janmGOEv0F2S0YwO5YU9RYUmc20+n
YonH5RjDdxH9QG69/F1oJ+VGNVk9GbFV9RaVVsTpXS0VPbrLxQWjUz75T3dVn2Ux
PRmEbyRdo4+nvJ+KClQwqdkeTLqu9hXkGr3WrdIxIzsilVPb1mHZteuLjtW1XVFv
RXBOxw1gOkpCHCxOf9X7QZjHBL62s3ETdvYOp5u1Q+v2MvBXto2OXFphFld9hNUx
govdphMDcRkSmcq8sa3bz/nhTJ+CaiMEY/dvQ9JotRM0EuFiHYOfRmP7tFVK2I8=
=aQgR
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--

--===============2308833677301752072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2308833677301752072==--
