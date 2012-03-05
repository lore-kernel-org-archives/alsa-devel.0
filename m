From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Mon, 5 Mar 2012 14:49:20 +0000
Message-ID: <20120305144920.GR3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7504079574811441819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AB9710432C
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:49:22 +0100 (CET)
In-Reply-To: <1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7504079574811441819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
Content-Disposition: inline


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 10:30:59PM +0800, Shawn Guo wrote:

> +/**
> + * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node
> + *
> + * @np: pointer to the I2C device tree node
> + * @buf: buffer to be filled with the dev_name of the I2C device
> + * @len: the length of the buffer
> + *
> + * This function determines the dev_name for an I2C node.  This is the name
> + * that would be returned by dev_name() if this device_node were part of a
> + * 'struct device'  It's ugly and hackish, but it works.
> + *
> + * The dev_name for such devices include the bus number and I2C address. For
> + * example, "cs4270.0-004f".
> + */
> +int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)

This doesn't seem at all Freescale specific, it should be a generic
helper, and in fact there already is one - the machine driver can set
codec_of_node in the card structure to point to the device node and then
the core should figure out binding to the device for you.  If it doesn't
we should fix the core.

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVNJqAAoJEBus8iNuMP3dLHYP/2qAWEA/tHSiQ5kWb/7vy991
987A5Dq0oSE9j8mbPrOG01Ulgdv5TBdRAx6OenK9H7SldNO10XPbHYt34JP3hWJe
SVYcOnFgW0RHvpKebmTlek89jPKCNFNZCNv9wGYArWyg8deJGlwaaZnjKdi9x6d9
SN8Y1KTZzhb/dYvy0i/5pDYC/l1aXYiusj/bpeALQcHHdQpHvSdx/tcm4FLFQ9l7
MCLN50M87rYGB6o6aucuULMalXz4ELku418u1jbcZFRqVqLwk+2n5jUuvGfQ6NT1
V8Ev2WKbj71FIbR7OZVdjMtwsR+0PmSKEGNBsIDsgr7AOUiCxyiRsKjPNNTpW+bx
vWB1LwRmjtQkbkLnj8qeLnUeHn5AzETKgymAfq0Jz+kXDGHZ0q1wcwa1v3jGtHWr
iM+PJpPX2UmE1QYNJIbN8rc72r1vP1PtR7MhRdKOtJbpod+JcpPuy9OyEuKaLegT
XR/XNVZaku6Sd2LJKvOETlzHj1hOcfKhjnH/LyoXJzImz8RMcTvSQnjOCbQJUpFG
NHEmt3heWpGbMxlbfgD1D/1VVyS8uSXInzagfUbOWJmUtld+EbhT//eVbtkUt6UT
zygotsqJkkh5ygjq6Yw7kbLv06M+iMrO+WTiSYUq3TWmEHWFbeAPSwnLb9SNvKlE
ebUaQY86ySJPhOykQutZ
=YrIH
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--

--===============7504079574811441819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7504079574811441819==--
