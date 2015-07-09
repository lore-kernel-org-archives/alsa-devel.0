From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add rt298 codec driver
Date: Thu, 9 Jul 2015 12:09:22 +0100
Message-ID: <20150709110922.GK11162@sirena.org.uk>
References: <1435287589-8160-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1538238172384585132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2625265163
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 13:09:31 +0200 (CEST)
In-Reply-To: <1435287589-8160-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, ramesh.babu@intel.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1538238172384585132==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mwyYwuEU+DI08Yj7"
Content-Disposition: inline


--mwyYwuEU+DI08Yj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2015 at 10:59:49AM +0800, Bard Liao wrote:
> It is the initial version of ALC298 codec driver.

I'll apply this but a few things here which you should look at:

> +static int rt298_probe(struct snd_soc_codec *codec)
> +{
> +	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
> +
> +	rt298->codec = codec;
> +
> +	if (rt298->i2c->irq) {
> +		regmap_update_bits(rt298->regmap,
> +					RT298_IRQ_CTRL, 0x2, 0x2);
> +
> +		INIT_DELAYED_WORK(&rt298->jack_detect_work,
> +					rt298_jack_detect_work);
> +		schedule_delayed_work(&rt298->jack_detect_work,
> +					msecs_to_jiffies(1250));

That seems like an awfully long time to wait to do the first jack
detection.  What's this for?

> +static int rt298_i2c_probe(struct i2c_client *i2c,
> +			   const struct i2c_device_id *id)
> +{
> +	struct rt298_platform_data *pdata = dev_get_platdata(&i2c->dev);
> +	struct rt298_priv *rt298;
> +	struct device *dev = &i2c->dev;
> +	const struct acpi_device_id *acpiid;
> +	int i, ret;
> +
> +	pr_info("%s\n", __func__);

This isn't adding anything, you should remove it.

--mwyYwuEU+DI08Yj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnlZhAAoJECTWi3JdVIfQXCsH/1EYPbO8xa36BdeqMNTat0ns
QtDRzBkX9VJApjPPyYSLZRm/OEDqiDXcKM9JcFZNFiSGfBNGPqTaAJAeDYi/lewz
8TawCuxiPkCxz1Vi9W2GzTHVIEj9aRiJ8D81FOXG2sDrLihZVmr/G2krvpmxI8Ep
4NSpWdZPIBGW52pYAyibkRDV4q6fPo2mMYkEUKl2MiaTT45d6fzvXHRnUmG65Bo6
ItQ3xKadCJHaq+GjFl5Ji8rGITK7InXEcJceoY/FtIRwI0QGOWiMWA1TS0O5xbUQ
BfPoqpwhhYfpUBQaiWGT0L8eGhO9nRD2NOfdvW8wqtg6glhV3xz8CR0krdX2pok=
=PEm1
-----END PGP SIGNATURE-----

--mwyYwuEU+DI08Yj7--

--===============1538238172384585132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1538238172384585132==--
