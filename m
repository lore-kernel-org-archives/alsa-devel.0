From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: fix channel swap issue
 when	stream starts
Date: Thu, 21 Mar 2019 14:13:54 +0000
Message-ID: <20190321141354.GF5684@sirena.org.uk>
References: <f05c95e5371336a8e3b0c395dc4cef70922f0caa.1551248985.git.shengjiu.wang@nxp.com>
 <VI1PR0402MB3392C426C2F5D65322A04253E3400@VI1PR0402MB3392.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5230688707467654898=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14DEEF80791
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 15:14:08 +0100 (CET)
In-Reply-To: <VI1PR0402MB3392C426C2F5D65322A04253E3400@VI1PR0402MB3392.eurprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org


--===============5230688707467654898==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 02:08:20AM +0000, S.j. Wang wrote:
> Hi Mark
>=20
>     Can this patch be accepted?  Or need I do any update?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTnCEACgkQJNaLcl1U
h9B9bQf/fXCvrAe4VwBHDEDbRf25Ej5zqtjF0y7qCYvdakFF9KQyS7I8Q04b5JZs
x0qnlJVQYUWs1Bm81uqw3Y90Pej9oQ/zxCzwt2eJjvlbRkTt2eB/1mueC0MaN6qz
x3KcDt3FvhKZZqOb6Xmy2WvgJTdp3+ySDy68Z5Hrfqo6oTTMp2IuxxBSWjpFPKBE
Swv2JRAZUb3Mp5CSEDKJ3yZEtyl58/JIud97D8UJ7jXV6YsD+EJqLqKaty22sM3C
+3l65wd2tNIEr3cQhMUpseXUmye+IGIlBKtRxQuO3V/R0NTfEyzXfKm7pzw6/hpe
VfcDZXZamrsiOl5IsNsmqdsKqM493g==
=7Mjh
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

--===============5230688707467654898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5230688707467654898==--
