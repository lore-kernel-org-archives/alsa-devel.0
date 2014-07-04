From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7] ASoC: add RT286 CODEC driver
Date: Fri, 4 Jul 2014 18:50:35 +0100
Message-ID: <20140704175035.GE19453@sirena.org.uk>
References: <1403246473-11055-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6368621119425620648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC8632659F8
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 19:50:44 +0200 (CEST)
In-Reply-To: <1403246473-11055-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6368621119425620648==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2014 at 02:41:13PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch adds Realtek ALC286 codec driver.

I've applied this but there are small number of remaining issues which
should be fixed - please send followup patches for them.

> +static int rt286_probe(struct snd_soc_codec *codec)
> +{
> +	struct rt286_priv *rt286 =3D snd_soc_codec_get_drvdata(codec);
> +	int i, ret;
> +
> +	ret =3D snd_soc_read(codec,
> +		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID));
> +	if (ret !=3D RT286_VENDOR_ID) {
> +		dev_err(codec->dev,
> +			"Device with ID register %x is not rt286\n", ret);
> +		return -ENODEV;
> +	}

Most of this probe function doesn't depend on ASoC at all and so should
be done at the I2C level probe not here - that way errors are detected
earlier and the device is initialised even if the sound card as a whole
isn't ready yet.

> +	if (!rt286->pdata.cbj_en) {
> +		snd_soc_write(codec, RT286_CBJ_CTRL2, 0x0000);
> +		snd_soc_write(codec, RT286_MIC1_DET_CTRL, 0x0816);
> +		snd_soc_write(codec, RT286_MISC_CTRL1, 0x0000);
> +		snd_soc_update_bits(codec,
> +					RT286_CBJ_CTRL1, 0xf000, 0xb000);
> +	} else {
> +		snd_soc_update_bits(codec,
> +					RT286_CBJ_CTRL1, 0xf000, 0x5000);
> +	}
> +
> +	mdelay(10);

I notice that the resume doesn't have these delays in it - is that not a
problem if the device lost power over suspend?

> +	rt286->i2c->irq =3D 0;
> +	if (rt286->i2c->irq) {

The assignment looks like some test code which was left in by mistake.

> +		ret =3D request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
> +			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
> +		if (ret !=3D 0) {

This is only released in the I2C level remove() (the the fix should be
to move the request to the I2C level probe()).

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtulnAAoJELSic+t+oim9MSMP/Ak6fLfAb0c+IsDowxozlU9i
MlgF5WDiTAtibLDk5vMdCTx1TASxxkEGdPrtVnLF8244DtElMS0S98Nyjd0C/six
RwUmV9//QgymBOcM6Gb5s6eVNiWu2HR1JPwwWyrWhbrZOoUEj1jS/7S9GNcjLAwf
AL18Fxgtm0Nxsu/Qm0y8TRFNqaC/bRR67Ew9hiEYncmaxLW9lK7mJBSkmpKQmeH4
E/a0dIDVsXtauLd+Qpwa3GKhIaT6u7TmcJoRjzEa1Yy/YidcWjSiC7zWoCv6vaj8
a5aFBEJyJnZj0RsbAH8FVau2pEW0PwdrxCbd1tWMdAFzJvxgYNdO6/GVHi9TNyyX
Q7EJTC0aOSDV5fM4gVsTicpRbEW3rE7lYPhNioZTN6M6s9TLMfTQTvJRVEsRkJlc
I2JvY8SQbiEASB/BSFqEENzyFQ2hSBwfSUEGR/pravbIQQovz//CvSPUG/wRQem6
oMSW+LMEu8U58C/83EQA6rVKiQLwQmC5dmBrkx508NljX+ydqgcJB3flxf84ewlW
k/WOPCDyeVdxuYJ+Zht7yOlOmNvT7JFtMCtKV4Hf4bZxw/LvZKdi+xrzlDmkkPHw
7rcIvk9eu6dFmK5TG6nq9TuuXB7FstbEN3VN6XVDF+3RR8E9Mk2BGvhn8kF8aLiB
veVtRHDmtVRh9EGCmud/
=wLcw
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

--===============6368621119425620648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6368621119425620648==--
