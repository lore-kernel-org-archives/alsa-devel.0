From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/9] ASoC: fsl-ssi: Add offline_config
	flag
Date: Thu, 19 Dec 2013 13:16:43 +0000
Message-ID: <20131219131643.GA31886@sirena.org.uk>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6758763901894237683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 02206265470
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 14:16:51 +0100 (CET)
In-Reply-To: <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6758763901894237683==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYjFa3qL1bvncypl"
Content-Disposition: inline


--lYjFa3qL1bvncypl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 12:57:41PM +0100, Markus Pargmann wrote:

> +	/*
> +	 * imx51 and later SoCs have a slightly different IP that allows the
> +	 * SSI configuration while the SSI unit is running.
> +	 *
> +	 * More important, it is necessary on those SoCs to configure the
> +	 * sperate TX/RX DMA bits just before starting the stream
> +	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
> +	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
> +	 * how the SDMA unit handles the DMA request.
> +	 *
> +	 * SDMA units are present on devices starting at imx35 but the imx35
> +	 * reference manual states that the DMA bits should not be changed
> +	 * while the SSI unit is running (SSIEN). So we support the necessary
> +	 * online configuration of fsl-ssi starting at imx51.
> +	 */
> +	if (hw_type != FSL_SSI_MX51)
> +		ssi_private->offline_config = true;
> +

This is really confusing.  I'd expect a switch statement here
enumerating the pre-i.MX51 hardware types otherwise if there's a new
variant added it'll do the wrong thing - the comment sounds like the
opposite of the test.

--lYjFa3qL1bvncypl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsvG4AAoJELSic+t+oim90KgP/1HnS1tYYZHev/sPvEXhVWDR
JnOJLI7shFLxMvaA8XS7YTNBp0PU4KYnLtSjxgPwRdGoc8jPcDZk1bZH+Tn6ln0M
4BBUN5Kk0pB3jXvuTnxdHPaFG/hDlA5y3YJVUZ3NB5plA9Yi1Rv5Wr69s67Mah1E
NmlANMtPokMgCWS+XeMQWxHWxV+QzgTR//DxuCwYTzHvvyUl0+fsS1691NYD/YND
kKjW8/O5sjNgaVPgAKqAjPx6M6rQO52e1gYGafyCEwd37AirApRrpAYW9Hf1bgdr
tpmnEBUq7E4Bfv5hmWkWg0zO09eg+kRXHcgggEOBp1fS4oYLoi3V8XTXVTw7OTCI
G3wIbj0Snq1crDpokVMmp45pYS55yVCYR3z8x5XPwlA3cOtlMw5xQ/fbLjCi2B/S
ufxVrXC+mkL+C6OEWwZC/312gVBLXBA9KB+hToSn0WGqK/opHPWMknRGDlC4hpZX
JRPsNN6qTTnXlxIdvk5kB9jmo+Cgdcyhseg0Mn/PVTtedlOwnfJbk4Q2L9xjOHWl
ncDXTakmrbrphS6IjwpPtNM4y8cvqg3Vj2Qr/prVFJxCHHDMCdglZEFZZU9TRevC
I6LRyhvlw5FjSXdRTR1dBlFVs23t7hNw/SY20TSOkzLljoT64rRp0AHVh4mjDq7K
r7N/Ab4tEUwBr6HFIZQ7
=x8cL
-----END PGP SIGNATURE-----

--lYjFa3qL1bvncypl--

--===============6758763901894237683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6758763901894237683==--
