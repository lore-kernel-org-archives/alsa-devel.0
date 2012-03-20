From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
	Audio Codec
Date: Tue, 20 Mar 2012 15:25:49 +0000
Message-ID: <20120320152547.GB3445@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9207557363670935162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C8C310425E
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:25:57 +0100 (CET)
In-Reply-To: <a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org


--===============9207557363670935162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 05:03:45PM +0530, Rajeev Kumar wrote:
> This patch adds the support for STA529 audio codec.
> Details of the audio codec can be seen here:
> http://www.st.com/internet/imag_video/product/159187.jsp

Please use subject lines appropriate for the subsystem.  If your commits
look visually different to all the other commits in the log that's not a
good sign.

> +config SND_SOC_STA529
> +	tristate
> +	depends on I2C
> +

Drop the dependency, none of the other CODECs have this for a reason...

> +#include <linux/platform_device.h>

If you need this something went wrong...

> +static const u8 sta529_reg[STA529_CACHEREGNUM] = {

Use regmap for register I/O.

> +struct sta529 {
> +	unsigned int sysclk;
> +	enum snd_soc_control_type control_type;
> +	void *control_data;

Your device only supports I2C, no need for the infrastructure for other
buses (though this will go away with regmap).

> +static const char *pwm_mode_text[] = { "binary", "headphone", "ternary",
> +	"phase-shift"};
> +static const char *interface_mode_text[] = { "slave", "master"};

ALSA controls always use capitalisation.

> +	case SND_SOC_BIAS_PREPARE:
> +		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
> +				POWER_UP);
> +		snd_soc_update_bits(codec, STA529_MISC, 1, 0x01);

One of these has magic numbers and the other doesn't, and the magic
numbers are a little confusing as the mask is written in decimal but the
binary in hex.

> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		pdata = 1;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		pdata = 2;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		pdata = 3;
> +		break;
> +	}

Return an error on unsupported sample sizes.

> +	default:
> +		printk(KERN_WARNING, "bad rate\n");
> +		return -EINVAL;
> +	}

dev_warn() - always use the dev_ prints where possible.

> +	sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> +	mdelay(10);

Absolutely no - why are you doing this?

> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0) & ~CODEC_MUTE_VAL;
> +
> +	if (mute)
> +		mute_reg |= CODEC_MUTE_VAL;
> +
> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);

You're always setting the same value here...

> +	snd_soc_add_controls(codec, sta529_snd_controls,
> +			ARRAY_SIZE(sta529_snd_controls));
> +
> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
> +			ARRAY_SIZE(sta529_new_snd_controls));

Use the initialisers in the card struct.

> +	sta529 = kzalloc(sizeof(struct sta529), GFP_KERNEL);
> +	if (sta529 == NULL)
> +		return -ENOMEM;

devm_kzalloc().

> +static int __init sta529_modinit(void)

module_i2c_driver().

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKF0AAoJEBus8iNuMP3d1y0QAJP1T7OWkIrhojN8oY4aKuqz
oX4jCRAVuXFlc+5JccnBJaF0EQmV48qxnp5fViNYjdAKtJx1XMDoIvPZzaYfF/4s
2JuGnfdC8E4AqRdXgHkWFzxohLCe2mH5UC9YS4gymPoNIBfaEH1MNYnxie7NzGi7
VYeiphsKwGybXHrEZEM1CM76NFoEDk717v6ra0vJtqmADFfNUXv0ETvDJOipQqYz
AI+iwWtKMnFJlRDMGa6lriqAsjo/nLhdfP99C3TH7GlQWuUCyDtUMLNodH4XyH0B
CssGMeYX8eDRWSIQDy40+jHA57rxEJOkbl6MARDHGqwzLcfu0xfT7tR7KTRx6vvk
mQe7Qor8HBJ2jh/oEFX3dVKQYm9tU8OmXCLmWOsZXZzbVsVEmwwC/9gaywFjA7Il
uKn4vYNhHL1TSYOxjXg0OGSHTpL5PlSs9ajfkRGImsCUzHIbBxn7A0FL0RsWHHPL
u/l7vVJdQR95CtIl03wS+RmoEL+DmVLUiwgyRK3BWQNC19mezZgpizsGFV/ppFlM
ZA85MsdzxXnukE6umiDIW1T8vfOYZdwOe91fK+bu44ptH0LcaLB92TTe1Tep+drg
uyYRLVpblvN6LM7vk6IriHILd8GZrmifpd6QK52LW4IzjWXmn9MgCcP22kWPIS26
v23KSAx6ggCu6B+8CyrF
=UYnz
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--===============9207557363670935162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9207557363670935162==--
