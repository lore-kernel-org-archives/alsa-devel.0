From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5514: add rt5514 SPI driver
Date: Tue, 29 Mar 2016 14:51:21 -0700
Message-ID: <20160329215121.GP2350@sirena.org.uk>
References: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1185191791121318690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D06265D6A
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 23:51:28 +0200 (CEST)
In-Reply-To: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, pc.liao@mediatek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1185191791121318690==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ltdm4mkXNgScZ66"
Content-Disposition: inline


--5ltdm4mkXNgScZ66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2016 at 06:58:21PM +0800, Oder Chiou wrote:

This looks mostly good, a few relatively small things here that should
be simple to fix:

> +static void rt5514_spi_copy_work(struct work_struct *work)
> +{
> +	struct rt5514_dsp *rt5514_dsp =3D
> +		container_of(work, struct rt5514_dsp, copy_work.work);
> +	struct snd_pcm_runtime *runtime =3D rt5514_dsp->substream->runtime;
> +	size_t period_bytes, truncated_bytes =3D 0;
> +
> +	mutex_lock(&rt5514_dsp->dma_lock);

_copy_work() holds dma_lock for the entire time it runs...

> +static int rt5514_spi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct rt5514_dsp *rt5514_dsp =3D
> +			snd_soc_platform_get_drvdata(rtd->platform);
> +
> +	mutex_lock(&rt5514_dsp->dma_lock);
> +	cancel_delayed_work_sync(&rt5514_dsp->copy_work);
> +	rt5514_dsp->substream =3D NULL;
> +	mutex_unlock(&rt5514_dsp->dma_lock);

=2E..but _hw_free() tries to cancel the work while holding dma_lock.  This
means we've got a deadlock, if the work starts running after the mutex
is acquired in _hw_free() then it will block trying to get the mutex
which will never get released because we're waiting for the work to
complete.

Looks like the cancel needs to be after the unlock.

> +static struct spi_driver rt5514_spi_driver =3D {
> +	.driver =3D {
> +			.name =3D "rt5514",
> +			.of_match_table =3D of_match_ptr(rt5514_of_match),

Weird indentation here.

> +static void rt5514_enable_dsp_prepare(struct rt5514_priv *rt5514)
> +{
> +	/* Reset */
> +	regmap_write(rt5514->i2c_regmap, 0x18002000, 0x000010ec);

This is a *very* big table of magic numbers with what look like system
specific settings in there (there seem to be some things routing to and
=66rom the ADC, and some clocking setup...).  Are you sure none of this
depends on the runtime configuration?

> +	if (rt5514->dsp_enabled) {
> +		rt5514_enable_dsp_prepare(rt5514);
> +
> +		request_firmware(&fw, RT5514_FIRMWARE1, codec->dev);
> +		if (fw) {
> +#if defined(CONFIG_SND_SOC_RT5514_SPI)
> +			rt5514_spi_burst_write(0x4ff60000, fw->data,
> +				((fw->size/8)+1)*8);
> +#endif

This will silently report success if SPI support is disabled, I'd expect
either the control would be entirely absent or we'd report an error.

> +		if (snd_soc_codec_get_bias_level(codec) =3D=3D
> +			SND_SOC_BIAS_STANDBY) {
> +			/**
> +			 * If the DSP is enabled in start of recording, the
> +			 * DSP should be disabled, and sync back to normal
> +			 * recording settings to make sure recording
> +			 * properly.
> +			*/
> +			if (rt5514->dsp_enabled) {
> +				rt5514->dsp_enabled =3D 0;
> +				regcache_mark_dirty(rt5514->i2c_regmap);
> +				regcache_mark_dirty(rt5514->regmap);
> +				regcache_sync(rt5514->i2c_regmap);
> +				regcache_sync(rt5514->regmap);
> +			}

This talks specifically about recording but this is in set_bias_level().
I'd expect something to do with the start/stop of recording to be
attached to something like a DAPM event for an ADC or DAI widget.

--5ltdm4mkXNgScZ66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+vjXAAoJECTWi3JdVIfQpiQH+wa1zeoSY118kkWm0xV/m3HY
TB2L/q2+IvuKGBzFcvQO47UdLewGak9Ozo7TvM44un+JIZ24fiZWpFBZQZaVwUHq
IIY/SkcE/b3UQV1aYeeiYbBWktlSrsQekI+asklPXzo5LfF4EAsWpETaetHpaTjE
sA8h/4u5QUbWKpI8g2JS223jbXOBJNouzMYNUg2FYC464t9jEiKt5lisEt4IQ6td
YPaq7WJg1nXFQfqOYH0NqKNBXLv2XCtrkmuDxCChyEqObChJun3q1YWzYAYU933e
0XjsZ3PTRoYa6FHxdhE53QxZ9aRR/XjvmfZlyTsFpe/0X89My7LRfJh/w1ciZBM=
=EjiA
-----END PGP SIGNATURE-----

--5ltdm4mkXNgScZ66--

--===============1185191791121318690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1185191791121318690==--
