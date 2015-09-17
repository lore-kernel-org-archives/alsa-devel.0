From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Thu, 17 Sep 2015 12:01:54 +0100
Message-ID: <20150917110154.GC12027@sirena.org.uk>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0237949598874070696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0200261ADC
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 13:02:18 +0200 (CEST)
In-Reply-To: <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============0237949598874070696==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dvO6BQ/1okkHLUrA"
Content-Disposition: inline


--dvO6BQ/1okkHLUrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 02:09:24PM +0800, Shengjiu Wang wrote:

> +	"dma"		  The spba clock is needed when sdma share peripheral
> +			  script is used.

It sounds like this clock is used by the DMA controller - shouldn't the
DMA controller driver be responsible for enabling it?

--dvO6BQ/1okkHLUrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+p2hAAoJECTWi3JdVIfQrRUH/jhZEF0h0twdiozzCWEaZXNl
8nduJ0XRsEXgFkac36WeCJU4adJlwR6ks28AH1FsnxwU/OWhIA9nVKsMqQT12Vd8
LDvosarhFNhAt+Gw3agYWSqtnN3LOXe+FHxAkOePq2Wb3X1A2lWkLvIQZUDZfFlm
FSCSZT2HpholCUpPdEC+NOacLOp4WFnOExMN4ZiGZVrgMC4YqG/J7kvHdd6Vskit
Q2bjAYuNJd3kfEL5ybNlZ7+O6IECNf6iCchWxWu0ffUsw68ojA+yPMjS8a67Rcy3
idDDZBTj92+7sCauTyxD8zW2SdSIv1NaO6mrlE4OeZf4bBLNIXTwKk/c2O6FBRM=
=1BTK
-----END PGP SIGNATURE-----

--dvO6BQ/1okkHLUrA--

--===============0237949598874070696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0237949598874070696==--
