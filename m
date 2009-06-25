From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXT_MUTE gpio to reduce
	pop-noise effect
Date: Thu, 25 Jun 2009 11:03:38 +0300
Message-ID: <200906251103.38818.peter.ujfalusi@nokia.com>
References: <1245896733-3973-1-git-send-email-x0107209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 38D0024B39
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 10:03:50 +0200 (CEST)
In-Reply-To: <1245896733-3973-1-git-send-email-x0107209@ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jorge Eduardo Candelaria <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 25 June 2009 05:25:33 ext Jorge Eduardo Candelaria wrote:
> According to TRM, an external FET controlled by a 1.8V output signal
> can be used to reduce the pop-noise heard when the audio amplifier is
> switched on.

As a note: the TRM suggests to use GPIO6 of TWL for the external FET contro=
l =

(which is than can be controlled by the HS_POP_SET:EXTMUTE bit).

>
> The signal is controlled by a gpio pin and should be defined in the
> machine driver. However, the codec driver takes care of enabling and
> disabling this output during the headset pop attenuation sequence.
>
> If the board does not have an EXT_MUTE, then the machine driver should
> set the value of ext_mute_gpio to -EINVAL through ramp delay setup data,
> to bypass execution of the code that manages the gpio line.

The intention of the twl4030_setup_data is broader than that. It is true, t=
hat =

currently it is only used for the Headset click removal.

>
> Also add a delay to let VMID settle in ramp up sequence.

Probably it is a good idea to add this delay. Without it there can be cases=
, =

when the first samples would have been played while the VMID is ramping up, =

making it a bit distorted (or weaker).

>
> Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
> ---
>  sound/soc/codecs/twl4030.c |   23 +++++++++++++++++++++++
>  sound/soc/codecs/twl4030.h |    1 +
>  2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index df42fa2..e850b30 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -27,6 +27,7 @@
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/gpio.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -620,6 +621,9 @@ static int handsfreerpga_event(struct
> snd_soc_dapm_widget *w,
>
>  static void headset_ramp(struct snd_soc_codec *codec, int ramp)
>  {
> +	struct snd_soc_device *socdev =3D codec->socdev;
> +	struct twl4030_setup_data *setup =3D socdev->codec_data;
> +
>  	unsigned char hs_gain, hs_pop;
>  	struct twl4030_priv *twl4030 =3D codec->private_data;
>  	/* Base values for ramp delay calculation: 2^19 - 2^26 */
> @@ -629,6 +633,11 @@ static void headset_ramp(struct snd_soc_codec *codec,
> int ramp) hs_gain =3D twl4030_read_reg_cache(codec, TWL4030_REG_HS_GAIN_S=
ET);
> hs_pop =3D twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
>
> +	/* Enable external mute, this dramatically reduces
> +	 * the pop-noise */
> +	if (setup && gpio_is_valid(setup->ext_mute_gpio))
> +		gpio_set_value(setup->ext_mute_gpio, 1);
> +
>  	if (ramp) {
>  		/* Headset ramp-up according to the TRM */
>  		hs_pop |=3D TWL4030_VMID_EN;
> @@ -636,6 +645,9 @@ static void headset_ramp(struct snd_soc_codec *codec,
> int ramp) twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
>  		hs_pop |=3D TWL4030_RAMP_EN;
>  		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
> +		/* Wait ramp delay time + 1, so the VMID can settle */
> +		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
> +			twl4030->sysclk) + 1);
>  	} else {
>  		/* Headset ramp-down _not_ according to
>  		 * the TRM, but in a way that it is working */
> @@ -652,6 +664,10 @@ static void headset_ramp(struct snd_soc_codec *codec,
> int ramp) hs_pop &=3D ~TWL4030_VMID_EN;
>  		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
>  	}
> +
> +	/* Disable external mute */
> +	if (setup && gpio_is_valid(setup->ext_mute_gpio))
> +		gpio_set_value(setup->ext_mute_gpio, 0);
>  }
>
>  static int headsetlpga_event(struct snd_soc_dapm_widget *w,
> @@ -2101,6 +2117,7 @@ static int twl4030_init(struct snd_soc_device
> *socdev) /* Configuration for headset ramp delay from setup data */
>  	if (setup) {
>  		unsigned char hs_pop;
> +		unsigned int ext_mute;
>
>  		if (setup->sysclk)
>  			twl4030->sysclk =3D setup->sysclk;
> @@ -2111,6 +2128,12 @@ static int twl4030_init(struct snd_soc_device
> *socdev) hs_pop &=3D ~TWL4030_RAMP_DELAY;
>  		hs_pop |=3D (setup->ramp_delay_value << 2);
>  		twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
> +
> +		if (gpio_is_valid(setup->ext_mute_gpio)) {
> +			ext_mute =3D setup->ext_mute_gpio;
> +			BUG_ON(gpio_request(ext_mute, "ext_mute") < 0);

Releasing the gpio?

> +			gpio_direction_output(ext_mute, 0);
> +		}
>  	} else {
>  		twl4030->sysclk =3D 26000;
>  	}
> diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
> index fe5f395..23a75e2 100644
> --- a/sound/soc/codecs/twl4030.h
> +++ b/sound/soc/codecs/twl4030.h
> @@ -274,6 +274,7 @@ extern struct snd_soc_codec_device
> soc_codec_dev_twl4030; struct twl4030_setup_data {
>  	unsigned int ramp_delay_value;
>  	unsigned int sysclk;
> +	unsigned int ext_mute_gpio;
>  };
>
>  #endif	/* End of __TWL4030_AUDIO_H__ */

I think the HS ext mute should be handled in a different way:
There should be a way to use also the HS_POP_SET:EXTMUTE (TWL GPIO6) or =

external gpio for the extmute.
In order to use the TWL GPIO6 for extmute, the PMBR1:GPIO6_PWM0_MUTE should=
 be =

set to 0x2 initially in TWL, but this is not the job of the codec driver (i=
t =

is platform specific how this pin is used).
Anyways, I think the correct approach should be something like this:

In twl4030.h:

struct twl4030_setup_data {
	unsigned int ramp_delay_value;
	unsigned int sysclk;
+	unsigned int hs_extmute:1;
+	void (*set_hs_extmute)(int mute);
};

Than in the machine driver:
a) No extmute possible
Just don't set any of these new hs_extmute things.

b) extmute is used through TWL GPIO6
Set the hs_extmute to 1
Set the set_hs_extmute to NULL

c) extmute is used through some other ways
Set the hs_extmute to 1

Request the gpio (or whatever you need to control the extmute), also take c=
are =

of the cleanup.
Implement the something like this:

void zoom2_hs_extmute(int mute) {
	gpio_set_value(GPIO_NUMBER, mute)
}

Set the set_hs_extmute to zoom2_hs_extmute

than in the codec driver:
If the hs_extmute is 0, than do nothing about the extmute,
If only the hs_extmute is set, than set/clear the HS_POP_SET:EXTMUTE bit
if both hs_extmute and set_hs_extmute are set, than call the set_hs_extmute =

function.

What do you think?

-- =

P=E9ter
