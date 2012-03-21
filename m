From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Wed, 21 Mar 2012 16:09:13 +0000
Message-ID: <20120321160913.GF3226@opensource.wolfsonmicro.com>
References: <1331275160-31757-1-git-send-email-tomoya.rohm@gmail.com>
	<1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7948949949326479860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69135103E56
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 17:09:16 +0100 (CET)
In-Reply-To: <1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7948949949326479860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 09:00:59PM +0900, Tomoya MORINAGA wrote:
> This driver is for LAPIS Semiconductor ML7213 IOH I2S.

So, I just said to the SPEAr guys that I really want to see support for
non-cyclic dmaengine added to the helper library rather than open
coding.  We're seeing lots of platforms moving to dmaengine (as well as
those that are in already yours is one of three out of tree platforms
I'm aware of that have actively submitted stuff) and with this number of
platforms we really need to get stuff factored out - there's enough
people working on these platforms that it should be possible to add the
support to the dmaengine library code.

A few relatively minor comments below and due to the above I haven't
really reviwed the DMA but overall this looks pretty good.

> +static struct ioh_i2s_data *i2s_data;
> +static struct ioh_i2s_dma *dmadata;

These shouldn't be global, they should be device specific and passed
around.

> +static int ml7213i2s_dai_set_dai_sysclk(struct snd_soc_dai *dai,
> +					int clk_id, unsigned int freq, int dir)
> +{
> +	u32 reg[MAX_I2S_CH];
> +	void *iobase = i2s_data->iobase;
> +	int i;
> +
> +	for (i = 0; i < MAX_I2S_CH; i++) {
> +		reg[i] = ioread32(iobase + I2SCLKCNT0_OFFSET + 0x10 * i);
> +		if (clk_id == IOH_MASTERCLKSEL_MCLK)
> +			reg[i] &= ~ML7213I2S_MASTER_CLK_SEL;
> +		else if (clk_id == IOH_MASTERCLKSEL_MLBCLK)
> +			reg[i] |= ML7213I2S_MASTER_CLK_SEL;
> +		iowrite32(reg[i], iobase + I2SCLKCNT0_OFFSET + 0x10 * i);

This looks like it should be a switch statement on clk_id, this will
also catch bad parameters that might get passed in.

> +		if ((slot < MAX_I2S_CH) &&
> +				(!(tx_mapped & (1 << slot)))) {
> +			dmadata[i].mapped_tx_ch = slot;
> +			tx_mapped |= 1 << slot;
> +		} else
> +			return -EINVAL;

Braces on both sides of the if please.

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaf0jAAoJEBus8iNuMP3dP8sQAJ19/ztENVH2a7eKjUI8CsYR
vsvlXD4iHH72BEzl8doZsfupd2AJsguYi0MdKhgt+SgW5pIBzxK/0Kz6R028iy8i
OctKi9WZi5ohI+ME22ZM2bTnhXgO8OAzgpmHvzzseUt3WzG80NKjwo8625A34EZd
i41o41b42xg16N8PrPfQEaTwH3bcjY6Tj4stuIvFPrSC9lYjPgcH3djvxC9hTT/k
rYD6nz1khYjN6/jD3kJfVnt8kvgpHrYEyUQc/69WqunlQSCRO1fop6tiKlXujHHd
DpwbjBQseJ5T2BFlaVuyQN655aHFfoG9S8xFvldayLg/yQ+2nhW5iSwbh3aZhn0x
mmhAYkWerCfurhCutVqiloVFyluwEfPdORDMWMxRxj8gh0UQiq9GUtx9xrwOhTuR
PjuDXAK2cSkrabeK3gXQ6Vu8HR9Rpsrw9m2rO9uIndp5JywNtnUHZaCRli9ibUHt
1rcvItmn04/UNgQ7EdHI/Or16vAkc2f/4cddx4UQysQzOAYS1wo0ShZpq4wcBfan
PXQnjw3I3CSm1+2qcY608v8GPiRPEXUz/WjIYm6Lr41UazVkFoEEpk3zDiYLe2Vt
3sXcBRvCAO7Ao6BXwWtE1Sj8u/b/VKgkeJM5iPBfj+v5ys6MUsCpgd+Zx+irVQ/t
pSeM1DHey5BABCO0VaER
=PjgL
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--

--===============7948949949326479860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7948949949326479860==--
