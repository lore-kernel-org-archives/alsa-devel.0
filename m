From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 8/8] ASoC: fsl: disable ssi irq for imx
Date: Thu, 22 Aug 2013 11:11:32 +0100
Message-ID: <20130822101132.GY26118@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1334493901967628219=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1334493901967628219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Content-Disposition: inline


--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 05:06:01PM +0200, Markus Pargmann wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>=20
> We have to disable the ssi irq, as it is not safe for all platforms to
> write back into the status register. It also runs into non-linefetch
> aborts.

Applied, thanks.

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFePRAAoJELSic+t+oim9jo0P/Ar7MapbZ0cBLFGxY8GAeUqE
hTKWU8pF/UHWc0Q4skg22XsoucXKYtuPsIINTpXa7QpA37xW+8c6DZUtk5orP9v5
P7LvNJztAix/WFeH1Z0DYCoTf1zKwJPf/f8EZLu4yvPJ1dbqHbmeSqhS/B1GfUKO
jUwS/oKkzfakI0IBoogcXna9a6Cr0A1J2tvjFrT9Rgxxp3FRM7QBs7t0YMkZYdB1
Xp8o1uFhTbRWO7sXo8gisFcFB/NLQbkGFJBUfg3xrQ+/dNYV1T7jU43FaWjOjitl
8yG7bOid4LxZx8H+WwZuiFBrGTukmiUryEF7XXue4ripnudoB6qSavc3XixORH7k
eWh59JcaNR+Fw4PId8vIrRCLaiGa53ra7BsoV3Z8DZLAP2TVhYb7U9TX8fzRekBS
IcSwqwlO3Vx4LHl6EIzHt47etdlqfb0CeueqPfPO7y2OBz8386GjeXMb2yTjMD1o
bkX4A8+noBK3hmhEDgj+tpfwaC39kseE7fkafFPMQTC8LbxgL4kGarHikiI8iVNs
wJmpJVtk7RaHbCuEY6YOIhEnvKntcjcYrV1fT7AxOLevAC0+Q1eGK02D6eZ6h63i
K+oP7rvl8sMKtC5PwxJjlruih3IptemDWhCW8ctubXVdbIzo1z2wvjZv8ohK5gld
6o+zVPB2KlcUeQNG1lS3
=Ovud
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--


--===============1334493901967628219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1334493901967628219==--
