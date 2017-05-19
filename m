From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: stm32: Add I2S driver
Date: Fri, 19 May 2017 18:33:59 +0100
Message-ID: <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
References: <1495120793-11687-1-git-send-email-olivier.moysan@st.com>
 <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2790957871012226198=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E67DB2667A5
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 19:34:17 +0200 (CEST)
In-Reply-To: <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: olivier moysan <olivier.moysan@st.com>
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============2790957871012226198==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6tmauatph4ecxfay"
Content-Disposition: inline


--6tmauatph4ecxfay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 05:19:52PM +0200, olivier moysan wrote:

This looks good so I'm going to apply it, a few things below though -
can you please send a followup patch for the issue with the Kconfig
symbol?

> --- a/sound/soc/stm/Kconfig
> +++ b/sound/soc/stm/Kconfig
> @@ -5,4 +5,4 @@ menuconfig SND_SOC_STM32
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	select REGMAP_MMIO
>  	help
> -	  Say Y if you want to enable ASoC-support for STM32
> +	  Say Y if you want to enable ASoC support for STM32

This appears to be an unrelated typo fix.

> diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
> index e466a47..8251931 100644
> --- a/sound/soc/stm/Makefile
> +++ b/sound/soc/stm/Makefile
> @@ -4,3 +4,7 @@ obj-$(CONFIG_SND_SOC_STM32) +=3D snd-soc-stm32-sai-sub.o
> =20
>  snd-soc-stm32-sai-objs :=3D stm32_sai.o
>  obj-$(CONFIG_SND_SOC_STM32) +=3D snd-soc-stm32-sai.o
> +
> +# I2S
> +snd-soc-stm32-i2s-objs :=3D stm32_i2s.o
> +obj-$(CONFIG_SND_SOC_STM32) +=3D snd-soc-stm32-i2s.o

Perhaps make this a separate option?  It probably makes sense to rename
the option for the SAI at the same time.

> +
> +	ret =3D clk_prepare_enable(i2s->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(i2s->i2sclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
> +		goto err_pclk_disable;
> +	}

It'd be nice to have runtime PM to disable these when the device is idle
but that's not essential.

--6tmauatph4ecxfay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkfLIcACgkQJNaLcl1U
h9CHnAf+IXsGxqydmvrZlOzBJl5ojod739fGNNDtpjaXuqzW4J/bvG696IE/7xvf
H4UnPIq665ZlwkriuQg3pMYfnR8UQDQJiqh8p7no88+pv0m/L7zQtcFgbG/Bnbal
V4CwY5Rv0VxQETvKqL3Zb55u2WHVxkhE/MiJP5Ux/9gLFaeeEQeLnefB7bdQEaxT
V0dIJ5Q2K4emW94Fsb4yTGGQfsTZAu910yfy/pH5ORSID3ereY1Mvm2h/r/4CDA6
UAEC8oxEp/+BUzO73yQbK3qKoxNn8pXGN7XXCEnb5sKXWjiZX/wr8rzTq/X/5f3I
3SkGHc7emwvwWk/S17hoT4DJZz9I7A==
=JcQo
-----END PGP SIGNATURE-----

--6tmauatph4ecxfay--

--===============2790957871012226198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2790957871012226198==--
