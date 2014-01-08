From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/9] ASoC: fsl-ssi: Fix interrupt stats for imx
Date: Wed, 8 Jan 2014 17:19:33 +0000
Message-ID: <20140108171933.GO31886@sirena.org.uk>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5200393785269159128=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387545096-2334-5-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5200393785269159128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZTJzEv5kHkug0Uuv"
Content-Disposition: inline


--ZTJzEv5kHkug0Uuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 02:11:31PM +0100, Markus Pargmann wrote:
> irqs should only be requested/released with enabled DMA. Previously
> interrupt statistics where disabled for IMX Processors because of
> different writeable SISR bits.
>=20
> This patch introduces support for irqstats on imx processors again by
> creating a sisr writeback mask and introducing a imx35-ssi compatible.

A binding documentation update is needed for this too.

--ZTJzEv5kHkug0Uuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzYihAAoJELSic+t+oim9vfcP/jjO5MdV26azq1LaH7KQltci
fWlY5753WoLh2eEHgjQuVSKykmi9o/2haeC2ag6X6D7q9rWnaN0Q1yj+0drhCYGg
2iXfHkHpIK9K9Nixv15kjhAIaD42NJETt78zbzorp8fzVMRMt1Bhl2OvgmuO8K5Y
DziJrs6VfV3k/cdUbvqSLm4aJ6wxOCAz3c2M9OBjH6zYiAJmnrPY4qe8nZ23HxUo
ubLLXdm/nnOq8ITIznkP+LjGDlvm96Mago7o8Juv1mI2JjllrPKu3wHZ+IVYjpms
P0jzKV3l4pqX7YinkUAdSiQ9fe4oeGK0FonX7APtJBNaPZWI+dfRmQq1eAbv7SgM
wySQbyxWLWXQDbQirLkwJv0q2YBF3Tv+UxTNj+OQF1UZqjXVTe4JiexDbBdNxdJm
crzjv0Hh9hTlPRP4EWrKGp/hEFKgG7hd9Jp658yoDYsSoknjis8zmzIg3Gt2ti1Z
rq7cNybuQlEnmHaJT3ljednYPLnPxZ/zE67eSthR6b+VLz9mqewgvlc0Ghn15jHF
Nn/ScwA7utWgB/K7YilxVT1w1UCiRBPG90oE9HhvlDvAjNMcFQIiO94Ut8vD96dY
z6EJyfwVUxIGeeDlR0zDQYTWX0Dq3GRZZYvl0EaLKFi8m1tQhahMeABTaQao0t7y
eH17tiTFb6/DrxPUP97i
=qocf
-----END PGP SIGNATURE-----

--ZTJzEv5kHkug0Uuv--


--===============5200393785269159128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5200393785269159128==--
