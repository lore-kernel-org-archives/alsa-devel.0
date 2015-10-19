From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 02/10] ASoC: img: Add driver for I2S
 input controller
Date: Mon, 19 Oct 2015 18:47:32 +0100
Message-ID: <20151019174732.GG32054@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2992134259866398615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A0E265B4F
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 19:47:48 +0200 (CEST)
In-Reply-To: <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============2992134259866398615==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 01:40:29PM +0100, Damien Horsley wrote:

> +static inline u32 img_i2s_in_ch_disable(struct img_i2s_in *i2s, u32 chan)
> +{
> +	u32 reg;
> +
> +	reg = img_i2s_in_ch_readl(i2s, chan, IMG_I2S_IN_CH_CTL);
> +	reg &= ~IMG_I2S_IN_CH_CTL_ME_MASK;
> +	img_i2s_in_ch_writel(i2s, chan, reg, IMG_I2S_IN_CH_CTL);
> +
> +	return reg;
> +}
> +
> +static inline void img_i2s_in_ch_enable(struct img_i2s_in *i2s, u32 chan,
> +					u32 reg)
> +{
> +	reg |= IMG_I2S_IN_CH_CTL_ME_MASK;
> +	img_i2s_in_ch_writel(i2s, chan, reg, IMG_I2S_IN_CH_CTL);
> +}

The APIs here all seem a bit odd - for example the enable API taking a
register value as an argument (normally reg is a register address BTW)
and returning a value but the disable API doing a read/modify/write
cycle.

> +static inline void img_i2s_in_flush(struct img_i2s_in *i2s)
> +{
> +	int i;
> +	u32 reg;
> +
> +	for (i = 0; i < i2s->active_channels; i++) {
> +		reg = img_i2s_in_ch_disable(i2s, i);
> +		reg |= IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
> +		reg &= ~IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
> +		img_i2s_in_ch_enable(i2s, i, reg);
> +	}
> +}

This all seems to be connected to this, which is itself slightly funky
especially in the context of the only user...

> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		reg = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
> +		reg &= ~IMG_I2S_IN_CTL_ME_MASK;
> +		img_i2s_in_writel(i2s, reg, IMG_I2S_IN_CTL);
> +		img_i2s_in_flush(i2s);
> +		break;

...which looks like it'll enable everything, then disable and reenable.
Plus needing to do a flush on trigger seems weird.

> +	if ((channels < 2) ||
> +			(channels > (i2s->max_i2s_chan * 2)) ||
> +			(channels % 2))
> +		return -EINVAL;

This indentation is very weird.

> +	control_mask = (u32)(~IMG_I2S_IN_CTL_16PACK_MASK &
> +			~IMG_I2S_IN_CTL_ACTIVE_CHAN_MASK);

> +	chan_control_mask = (u32)(~IMG_I2S_IN_CH_CTL_16PACK_MASK &
> +			~IMG_I2S_IN_CH_CTL_FEN_MASK &
> +			~IMG_I2S_IN_CH_CTL_FMODE_MASK &
> +			~IMG_I2S_IN_CH_CTL_SW_MASK &
> +			~IMG_I2S_IN_CH_CTL_FW_MASK &
> +			~IMG_I2S_IN_CH_CTL_PACKH_MASK);

This also looks very odd.  Normally we'd write masks as being the valid
bits and or them together.

> +	i2s->clk_sys = devm_clk_get(dev, "sys");
> +	if (IS_ERR(i2s->clk_sys))
> +		return PTR_ERR(i2s->clk_sys);

Please print an error message so people can tell why things failed.

> +	rst = devm_reset_control_get(dev, "rst");
> +	if (IS_ERR(rst)) {
> +		dev_dbg(dev, "No top level reset found\n");

You should check for -EPROBE_DEFER here and just return the error here
if you get it (on the basis that the reset framework ought to be using a
different error if there's nothing bound in DT).

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJSyvAAoJECTWi3JdVIfQa/wH/1w0CE8JNBK6L1LreMlGdTEa
/32HzAyos5fILFvDBuasU5vyS+KzGh6TGDEnbk0yaHF4wh3mvGdDe4A2YFP7Wta1
sTuLuCyqL1br1YHfW7VMpuksmOpCnka8jruGdcFwTy7o32GWgUJsLX/l8spaIzwQ
kXUSbfa4SC7CBCzfJh+STbhG3XkfxMOAulkJKIJ3rKCaR1A8ImcmSBLIzY180k1/
cD+gppD54FcuYM0sfEm7CnOKavalHc0sAnBK6DJZs6kq44XhZCnHa1VVSwzPZkJe
lKIcsIKGsqbP26BszLtzTKAgKwUKO9rzISgK5CGSLwT9wOBwtbI7ZMEM+j3L7sc=
=nTHX
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--

--===============2992134259866398615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2992134259866398615==--
