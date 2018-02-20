From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 11:47:08 +0000
Message-ID: <20180220114708.GA6378@sirena.org.uk>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <20180219201440.GA10420@Asurada>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8257123620644519413=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9807267079
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 12:47:09 +0100 (CET)
In-Reply-To: <20180219201440.GA10420@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8257123620644519413==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 12:14:41PM -0800, Nicolin Chen wrote:
> On Mon, Feb 19, 2018 at 03:49:11PM -0300, Fabio Estevam wrote:

> > [    3.065722] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
> > component debugfs directory

> > I haven't started debugging this yet and not sure if this is something
> > fsl driver specific.

> I think it's because we recently changed all CPU dai drivers to
> component drivers, so our drivers should probably add something
> to create debugfs directories I guess...will take a look at it.

Hrm, that's not the goal - if every driver has to do it there's
something wrong.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMCrkACgkQJNaLcl1U
h9AHpgf/YRWihlik6GS9CMpA6dd09D2/Vnnj3I0+O7jXtuVBQZxiA9v5glVO8BuB
LytqqQyFpjZxpdxzHN5Okn1S6zw8HHAAKeOlh5mfarIhjfE0+TYGECDrBKbXqSbR
k/4RTgcWK67qfhfQ8YBVqV1Z9STKTkhPTumc7t9Qaa46Zy5H+tcslmjYtDiTq6DW
irIRHoGLII+kpYlVOs++HzAF7bCcsQdvAtBbIZ//q9g7x5sPUJQLM/EZkMD0DEAJ
5Ngrd8ZC8VnWQcQXZjGBwe6c96volNckewXxAkQnEcKzmYh4BN3LSHlzn3qWtj1M
raIRyqiqljgAQs2Wd1ydfXZEFGu7Mw==
=OTI2
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--===============8257123620644519413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8257123620644519413==--
