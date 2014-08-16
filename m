From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5677: Support DSP function
Date: Sat, 16 Aug 2014 16:55:36 +0100
Message-ID: <20140816155536.GU28623@sirena.org.uk>
References: <1404718621-15516-1-git-send-email-oder_chiou@realtek.com>
 <1404718621-15516-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9093525632567720388=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F94E261AB0
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 23:38:10 +0200 (CEST)
In-Reply-To: <1404718621-15516-3-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============9093525632567720388==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKcNkqnJHUUp475E"
Content-Disposition: inline


--vKcNkqnJHUUp475E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2014 at 03:37:01PM +0800, Oder Chiou wrote:

> +int rt5677_spi_write(u8 *txbuf, size_t len)
> +{
> +	static DEFINE_MUTEX(lock);
> +	int status;
> +
> +	mutex_lock(&lock);
> +
> +	status = spi_write(g_spi, txbuf, len);
> +
> +	mutex_unlock(&lock);

Since this lock is local to the function it doesn't do anything, the SPI
framework has its own locking which makes it reentrant.

> +int rt5677_spi_burst_write(u32 addr, const struct firmware *fw)
> +{
> +	u8 spi_cmd = 0x05;
> +	u8 *write_buf;
> +	unsigned int i, end, offset = 0;
> +
> +	write_buf = kmalloc(8 * 30 + 6, GFP_KERNEL);

Magic numbers!  You also need to be aware that memory allocated by
kmalloc() may not be contigous and while things using the SPI core DMA
handling ought to be able to cope not everything will be.

> +static int rt5677_spi_probe(struct spi_device *spi)
> +{
> +	g_spi = spi;
> +	return 0;
> +}

> +static int rt5677_spi_remove(struct spi_device *spi)
> +{
> +	return 0;
> +}

Delete empty functions.

> +static int __init rt5677_spi_init(void)
> +{
> +	return spi_register_driver(&rt5677_spi_driver);
> +}
> +module_init(rt5677_spi_init);

module_spi_driver()

> +static int rt5677_dsp_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (ucontrol->value.integer.value[0] != 0 && rt5677->dsp_en == false) {
> +		rt5677->dsp_en = true;
> +
> +		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
> +			RT5677_LDO1_SEL_MASK, 0x0);
> +		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
> +			RT5677_PWR_LDO1, RT5677_PWR_LDO1);
> +		regmap_write(rt5677->regmap, RT5677_GLB_CLK2, 0x0080);
> +		regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x07ff);
> +		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x07ff);

This doesn't seem joined up with the rest of the CODEC power management
which suggests there's going to be problems - for example LDO1_SEL_MASK
is also being managed by the existing set_bias_level().  What other
devices do is manage the power for the DSP using a DAPM widget, enabling
it when there's audio flowing through it.

> +	mutex_init(&rt5677->dsp_cmd_lock);
> +
> +	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
> +		RT5677_FIRMWARE1, codec->dev, GFP_KERNEL, codec,
> +		rt5677_fw1_loaded);
> +
> +	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
> +		RT5677_FIRMWARE2, codec->dev, GFP_KERNEL, codec,
> +		rt5677_fw2_loaded);

It would be nicer to be able to only request firmware when needed rather
than loading it once a boot time, that way we use a little less memory
and we'll always have the latest firmware rather than what happened to
be there when the system is booting.

--vKcNkqnJHUUp475E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7371AAoJELSic+t+oim9+8kP/A8kv19FlC/UiA270rHuvOAv
6yfjXVJaUH8t6ACkCtLfe9SBGKR1NC38cv2wZuoKtky0Hfxq4FMTyrnYxBz2U6+q
jXRV/qdFHPjQTTb9rccbLlDCJGvS4nywYb7h8l0Ud+Ca9CyPJ8PiH04XpnCxuoDV
hkOz4Jczya2cA2H3d5a+Syb9vRLBX9MnsnnAUXoXUKlwTGxXyMZdmW1hPz4ucPgL
WbRhE8A0eiNPiamymZm4lRvkJ9m4rq7KLmtdc9AcfW5KPk1BoyxKANQoyFx5qfIT
KkQ3aEoM1iks825We/fp3IkpYJPV1eaHk5EQu7NAqYDJFt354THJMkX7gs9i/nIB
pRXUpmlBUqz9s9VUPYaGaXnrVLzDkxBqa6cf45B/+MD8mVIwnRibMop6sRYK7Ep6
UCBBJks0sG+av2Av/ev3iUzZHqljW74dOIwBoga8bSprOit0YM2hcMKNstGxkWZA
pYHs0Ni3c2Z/Yy3CDV+p3cvrL/3izDWGN2zRinPvtEu5KmFO53qcsJrH33nkSvou
FalykChpDD5zuf0oquOvMcTcJaTzBTOSisqcmgqg1ieibmxHX/kfckD4U94pKJ6X
ikK2eYn91KgUkGqRHRI0GrLF3+FOenN04sMAd+UukfKbzwssfXkprRBUHWghpCT2
IB87LtJzmwvwjIPvitzI
=+tSu
-----END PGP SIGNATURE-----

--vKcNkqnJHUUp475E--

--===============9093525632567720388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9093525632567720388==--
