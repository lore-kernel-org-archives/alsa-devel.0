From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: Ux500: Add platform-driver
Date: Mon, 23 Apr 2012 19:31:40 +0100
Message-ID: <20120423183140.GV8318@opensource.wolfsonmicro.com>
References: <1334914394-27518-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4495906957340221162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA0041042BF
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 20:31:42 +0200 (CEST)
In-Reply-To: <1334914394-27518-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4495906957340221162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pEAjBjStGYT6H+Py"
Content-Disposition: inline


--pEAjBjStGYT6H+Py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 11:33:14AM +0200, Ola Lilja wrote:
> Add platform-driver handling all DMA-activities.

Overall this looks really good, but it depends on the stream print thing
as well.  There's a few very nitpicky issues also:

> -config SND_SOC_UX500_MSP_I2S
> +config SND_SOC_UX500_PLAT_MSP_I2S

Should be in the previous patch.

> -snd-soc-ux500-msp-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
> -obj-$(CONFIG_SND_SOC_UX500_MSP_I2S) += snd-soc-ux500-msp-i2s.o
> +snd-soc-ux500-plat-msp-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
> +obj-$(CONFIG_SND_SOC_UX500_PLAT_MSP_I2S) += snd-soc-ux500-plat-msp-i2s.o

Likewise.

> +	dev_dbg(dev, "%s: Init runtime private data.\n", __func__);
> +	ux500_pcm_data = kzalloc(sizeof(struct ux500_pcm), GFP_KERNEL);
> +	if (ux500_pcm_data == NULL)
> +		return -ENOMEM;
> +	ux500_pcm_data->msp_id = dai->id;

devm_kzalloc()?

--pEAjBjStGYT6H+Py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlaAGAAoJEBus8iNuMP3diCsP/R/CdHPDzRFykWr8N88RAbqE
1QrSOsI7kdSUwg99p/sYlzsdU8z4P4w5nFkqTXYj6wIFN2J8iGaW3wm/YHGxkaqB
2k1COU09rF6p4CAqqfdD6e1lEZowrb8kujTC9twCI+ZLZfG8Wf5QXJcCayFXiw4+
thbWMIh/Y9IKJQr4M0JipSYcUQvLDrhL9A7uWyt/9mS/7ECCyKe2yPuvdId/OwK9
EkTe5p6QpKlKRqsjzHn9k/yKh2uwTuDbLYaV9IGBnV7mgXmHvq6sPfvY5n6heESC
F76weuykXn93S0Scgrn/YJinTYS6wnVLTVivP/iFaV3365v2MQMs10Jz0tNrZ5qF
BRiCogFNc6LzoWlCHkZwzP5m5sQ69phv7WBfYU42WiQ6+rBe/Es78Mb+RJ8iiLGm
ZKl0KI0DEugf1CXVV4rWqh9mQqfA8BPt01UU1xfdF5pmrakU8YYBZHpz0/R47Dbo
dlLgZZ9ZIz2sa4+oxM5TXZyNTzTYfSzDqusRtQrthd7lc/npPguRkfeoxrO3gPFt
qyWNb14Jv8S5+czPJ0liiL8HQwuNHqSJCqb4FqmKCNmn3P6kkSlGNvLJKlDSFA7M
VDUlNyF+CpnMM8Z19tzBM1eCQUsONQjFnfN4uHeS1CwquTJUBF6LuRX/wL3MUBr9
LgULqyMjwoHGg9jkVeU5
=xCu5
-----END PGP SIGNATURE-----

--pEAjBjStGYT6H+Py--

--===============4495906957340221162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4495906957340221162==--
