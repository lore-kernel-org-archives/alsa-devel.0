From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 4/7] ASoC: fsl-ssi: Add support for imx-pcm-fiq
Date: Tue, 6 Aug 2013 17:59:02 +0100
Message-ID: <20130806165902.GI6427@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4045837212536054041=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374924716-23475-5-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4045837212536054041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Content-Disposition: inline


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2013 at 01:31:53PM +0200, Markus Pargmann wrote:
> Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
> Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
> and the SIER flags are set differently.

Applied, thanks.  Ideally we'd have a quirk infrastructure to figure out
if this is required but it really doesn't seem worth it.

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAStTAAoJELSic+t+oim90NEP/iejTLJ0utMaxJuTm/fENJ2C
SbQDPJleYw90NzBJOTpaRdyju5vX+lg4+CJpYGI6DR+EkDCc36kioaDLpRi1b22N
TOUGXaV4n1ORiMgtg4bYgRLUKJo8Z2GNCLU6xO5C7eBgPZcJCT0Z2KwqQsd1oxir
XjVBGstfEUzQJzu9cC6ObyPk/TlPmikvlxbGdA6eenlSEd/VliS3ZhQVdqObjUI6
53aXlB5UOMwvjdS2tCeVSioZB6m89sLdRjvbROgLNAY8mlHcm/TyAGQRAT9Cef0e
Xy2LW0vFq41dHoUGmTclVM59CM2LZ60HtpQVkINoiUTkq8psLtXcU0XL2zKKOQvp
3c5g5B0mo6LMQKEggmRuThcS/HPP5Fcwyz1TGgXGBuHayTk4t8x39MwYz+AzFWQg
fR7os46+0HvambM6DpJLmCRUIosA7Q4u/fo2eqZfB+IG2NAQh6ryeWo/OC37lamD
5CcJRNn6NexwOtOZCcb+UVkxt7Bcsi/9d4ddCJ1kQDTEA9579kyqM5juzjXVF8xc
B0I+rks5kZhB3Lr6csu2Yx+TuqoB9YbBee6WSrNZDiXLoLRFLXCgVNhDxlpwjuYZ
2ImLP7zWZgllC6flebEiU6cUFZg6ov3IqayDL3SnTt6LjZh78PdcI9OKvT44X7dm
aJcud+vBe2gVYuzMYtsC
=wjg/
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--


--===============4045837212536054041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4045837212536054041==--
