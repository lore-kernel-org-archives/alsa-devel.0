From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Add max98090 codec driver
Date: Tue, 20 Nov 2012 20:14:42 +0900
Message-ID: <20121120111441.GJ10560@opensource.wolfsonmicro.com>
References: <8739044mr0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4694890090398569500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34F8026532E
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 12:14:52 +0100 (CET)
In-Reply-To: <8739044mr0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4694890090398569500==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WAAb/gZE1HXiAv4U"
Content-Disposition: inline


--WAAb/gZE1HXiAv4U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 02:00:54AM -0800, Kuninori Morimoto wrote:

Overall this looks pretty good, a few issues below mostly to do with
updating to more current kernel APIs.

> +/* RESET / STATUS / INTERRUPT REGISTERS */
> +#define M98090_0x00_SW_RESET		0x00

The standard for Maxim drivers is to use MAX as the prefix rather than
M.

> +static const u8 max98090_reg[] = {
> +	0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, /* 0x00 - 0x07 */

Use regmap for register I/O please.

> +	snd_soc_write(codec, M98090_0x06_DAI_IF, val);

More idiomatic is snd_soc_update_bits() so we don't do the write if
there's no change (as is very common).

> +	ret = snd_soc_read(codec, M98090_0xFF_REV_ID);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read device revision: %d\n", ret);
> +		return ret;
> +	}
> +	dev_info(dev, "revision 0x%02x\n", ret);

With regmap this should be moved to the I2C level probe.

> +	snd_soc_add_codec_controls(codec, max98090_snd_controls,
> +				   ARRAY_SIZE(max98090_snd_controls));

Initialise these from the snd_soc_codec_driver.

--WAAb/gZE1HXiAv4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq2YZAAoJELSic+t+oim9idwP/3r3Rj/vtvOOslzsLNzyvMD/
slA1nAyEExVyGfFjvF3jpNUorhEf3Wu28uYdPX3WcZwVBFmb/q4v4UJT7c2iK64e
RTRPxU+vaY/saVQitFpDYC8xKVJ2lKwrVrpL77NNFPlOEKSoMRrNdE5cwPkPQA1r
AMoG2909IRqTkU3xQfI2OrkckR6Rh3ZfvSFGyFH2NhyOhP5S81ogjUNj1aTMlqyC
5WelNHVzb3zZDotRzBrSnVwuPjp2Ow3dR8drzA4HiPIzSgbcpKDIrFXbQhD1cfyh
wNLBE/X2z2kSxTXw2S54OXj7QF4xAQwiwyJU5c/qWVVq3a5TMtkWQgp6hsCN2Qh3
cVbPauhrB7flH5mndHGsfBmRPQKNr6pWNn6zZDnl9I8LDo8sOItjQ5sxR0R/EIxJ
SQSpQ85Czpulw1qfCql8iu2xhT2DbVk6HWasYlBPapHCBL7YJmBg8Oq2cMXXYI9h
6vg+TPLvnds652cD9wI9lOy8IowJRJZTOdOAH0hW9hIswvBMme88MPQpGO5VtQjS
eN3BKfzSG4uiuG0i7LTBGoWv4+4FXVIUHdf6LqWDu/SWdfEDpjrxEgtXdzLqIhka
ZsG95C3JGWr8Ka0rgxBY4meziI+0evh5XAZmZkteT4c5nrbK4ESu+VdKifIJtLeT
iYrOlqHcvtgIhf50oOl3
=mTqc
-----END PGP SIGNATURE-----

--WAAb/gZE1HXiAv4U--

--===============4694890090398569500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4694890090398569500==--
