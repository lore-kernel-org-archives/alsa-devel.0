From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Date: Fri, 19 Apr 2019 16:25:07 +0100
Message-ID: <20190419152507.GU2803@sirena.org.uk>
References: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410660248572819041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B71EF807B6
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 17:25:10 +0200 (CEST)
In-Reply-To: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org


--===============0410660248572819041==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2019 at 11:01:21AM +0000, S.j. Wang wrote:

> > fsl_esai_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >=20
> > +       pm_runtime_enable(&pdev->dev);
> > +

> I just have a question, do I need to add pm_runtime_idle(&pdev->dev)?

It gets used to help drivers get into the correct state on startup, if
you're unsure if it's 100% required it shouldn't hurt.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly56FIACgkQJNaLcl1U
h9CGCwf/V4SKmPiu420k0g+uofTrLtN6Jv9aTQuGhf7zO7AX1stWXlkVwZwj6RZK
XC7w1TLKHMVSJUp+U5nUKH9lrbIPsldykON2Mn1cK7TQRIXMXoXgZgBZRagddQkU
iP0RupSAma6LT4/o4RHV6pjp2qDMU8oJfIUcBqiyFQsmaEMvYK14izz7hOScKwIb
VZMnFG60t8T7AxVCKda6cW72ikkuV1pvAENJ2j36iTNfaFA9Ufo/du99PNZK+9bW
o34ZkH1FrcKZRgM0gQ3icbYUxQQV+WflxfFayC4M/qfCXjJiVoAbvEpLzfSSVYtW
Irvy3o+JKq311kA8vioI3gdp9HFhUg==
=6lYl
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--

--===============0410660248572819041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0410660248572819041==--
