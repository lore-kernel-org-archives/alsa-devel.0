From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: Add new Realtek ALC5632 CODEC
	driver.
Date: Thu, 10 Nov 2011 12:11:09 +0000
Message-ID: <20111110121108.GC3832@opensource.wolfsonmicro.com>
References: <4eb51219.8238df0a.64ec.ffffdb00@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37B94103AE3
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 13:11:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4eb51219.8238df0a.64ec.ffffdb00@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: leon@leon.nu
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 05, 2011 at 12:38:02PM +0200, leon@leon.nu wrote:
> From: Leon Romanovsky <leon@leon.nu>
> =

> This driver implements basic functionality, using I=B2C for the control
> channel.

This is mostly looking good so I've applied it to save on review time
but there are a few fairly minor issues which you really should address
in follow on patches

> +static int alc5632_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	u16 hp_mute =3D ALC5632_MISC_HP_DEPOP_MUTE_L \
> +						|ALC5632_MISC_HP_DEPOP_MUTE_R;

No need for the \ here.

> +#define ALC5632_ADC_REC_GAIN_COMP(x) (int)((x - ALC5632_ADC_REC_GAIN_BAS=
E) \
> +		/ ALC5632_ADC_REC_GAIN_STEP)
> +
> +#define ALC5632_MIC_BOOST_COMP(x) (int)(x / ALC5632_MIC_BOOST_STEP)
> +
> +#define ALC5632_SPK_OUT_VOL_COMP(x) (int)(x / ALC5632_SPK_OUT_VOL_STEP)

These aren't used and should probably be deleted.

> +static int alc5632_i2c_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct alc5632_priv *alc5632;
> +	int ret, vid1, vid2;
> +
> +	vid1 =3D i2c_smbus_read_word_data(client, ALC5632_VENDOR_ID1);
> +	if (vid1 < 0) {
> +		dev_err(&client->dev, "failed to read I2C\n");
> +		return -EIO;
> +	} else {
> +		dev_info(&client->dev, "got vid1: %x\n", vid1);
> +	}
> +	vid1 =3D ((vid1 & 0xff) << 8) | (vid1 >> 8);

Ideally you should convert the driver over to work with the regmap API
and make use of the cache code it provides.  This is going to be
required at some point in the future and would mean that you could use
the same register I/O functionality here where you're identifying the
device (which is definitely good practice).

I'd also do an initial device reset here to make sure that in the
interval between the driver registering and ASoC starting the hardware
is in a known good state.
