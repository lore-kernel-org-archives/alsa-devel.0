From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] sound: soc: add ASoC board driver for Armada 370 DB
Date: Tue, 11 Feb 2014 12:48:44 +0000
Message-ID: <20140211124844.GO13533@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-4-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8234343329288165325=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391102051-5319-4-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8234343329288165325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 06:14:07PM +0100, Thomas Petazzoni wrote:

> +	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
> +	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0)
> +		return ret;

Set .dai_fmt in the DAI link.

> +static int a370db_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_enable_pin(dapm, "Out Jack");
> +	snd_soc_dapm_enable_pin(dapm, "In Jack");

No need to do this, everything defaults to enabled.

> +
> +	card->dev = &pdev->dev;
> +
> +	return snd_soc_register_card(card);
> +}

devm_snd_soc_register_card().

> +static const struct of_device_id a370db_dt_ids[] = {
> +	{ .compatible = "marvell,a370db-audio" },
> +	{ },
> +};

No binding document for this, and you should be using DT to look up the
controller and CODEC rather than hard coding their names (which may
change in future when instantiated from DT, especially the platform
device).

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+hwoAAoJELSic+t+oim9pVIQAJTai2BwZtif3mIfrRVVeT+u
uIoxKM66PXb/JxLxDtU3yuIv6TCDiETXycldX8wysJ1KoW3aiyn7ed6E8pPMWUns
3y9/hLqygLhom5lam6L6XKrEWwEw6Ny2ehrRTgV/5JsMPvohXIhKaS1TCvVwOcmF
B9g+USWAHPWOmyESvaNrcONBBqGKK3d7/PXjL4VOsucZct7dROjrKZYy0VRi1KAY
0wISDEZH6gqQVDWwkKfgHs90czh1W5Gjbqq9Frs1lHHmC4Ot2gV3nm5SAGOVpheN
UWK/KlP8gGCi9wHbIFSebIcV1atirSiNtybVrSN69JQWOy9hViH+QHwYq0ib1dLJ
SC85UctWL/ZaYpXCtYlVOUn+sow+T0h5BSYxpwdXOqR9YaKuNz+K8Mj4VBYLn6zj
b761yT346geUTMmZOeVG6Ei1Hm/7NGBj2SEmW6fuLj7jHaGuk30JUAeL+pDshANK
1BTElaheOwTr6eFjovh3iDxBZKtkWrFsP1rh6JhUu7VoqwXFDW+EXoM3it28ahR0
eubAEL8xLMaCO91WVziPT2TGBoJT9uipUCHuI9fQbwjBE+v9to5ns/aagSWBqVer
xFL0BzgN5z03ZwlkUsI7fC86EZpbe4IzINFajMJytcgDN60vfT+V6YPjjzw0xETN
4GKMoAa33+AZI8MKWX6v
=hwTN
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--


--===============8234343329288165325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8234343329288165325==--
