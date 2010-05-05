From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap: Add basic audio support for
	Nokia RX-51/N900
Date: Wed, 5 May 2010 09:30:22 +0300
Message-ID: <201005050930.22712.peter.ujfalusi@nokia.com>
References: <1273037477-20626-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D77724648
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 08:30:36 +0200 (CEST)
In-Reply-To: <1273037477-20626-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Jarkko,

this looks good, however I have some comments below.

On Wednesday 05 May 2010 08:31:16 ext Jarkko Nikula wrote:
> This patch adds support for integrated stereo speakers and digital
> microphone found on Nokia RX-51 hardware. This is a cut down version based
> on Maemo kernel sources and earlier patchset by Eduardo Valentin et al.
> =

> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022033.=
ht
> ml
> =

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> ---
> =

> This is for sound-2.6.git. This is independent and boot safe patch but
> audio codec doesn't probe without a few patches to
> arch/arm/mach-omap2/board-rx51-peripherals.c. See
> =

> http://marc.info/?l=3Dlinux-omap&m=3D127290212826770&w=3D2
> =

> Some audio features would need more work and some, even being trivial to
> add, need more testing are there support for them in mainline. Thus this
> heavily simplified and little bit cleaned up version.
> ---
>  sound/soc/omap/Kconfig  |   10 ++
>  sound/soc/omap/Makefile |    2 +
>  sound/soc/omap/rx51.c   |  305
> +++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 317
> insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/rx51.c
> =

> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index f11963c..83be4a7 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -18,6 +18,16 @@ config SND_OMAP_SOC_N810
>         help
>           Say Y if you want to add support for SoC audio on Nokia N810.
> =

> +config SND_OMAP_SOC_RX51
> +       tristate "SoC Audio support for Nokia RX-51"
> +       depends on SND_OMAP_SOC && MACH_NOKIA_RX51
> +       select OMAP_MCBSP
> +       select SND_OMAP_SOC_MCBSP
> +       select SND_SOC_TLV320AIC3X
> +       help
> +         Say Y if you want to add support for SoC audio on Nokia RX-51
> +         hardware. This is also known as Nokia N900 product.
> +
>  config SND_OMAP_SOC_AMS_DELTA
>         tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
>         depends on SND_OMAP_SOC && MACH_AMS_DELTA
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> index 0bc00ca..3a75755 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SND_OMAP_SOC_MCPDM) +=3D snd-soc-omap-mcpdm.o
> =

>  # OMAP Machine Support
>  snd-soc-n810-objs :=3D n810.o
> +snd-soc-rx51-objs :=3D rx51.o
>  snd-soc-ams-delta-objs :=3D ams-delta.o
>  snd-soc-osk5912-objs :=3D osk5912.o
>  snd-soc-overo-objs :=3D overo.o
> @@ -22,6 +23,7 @@ snd-soc-zoom2-objs :=3D zoom2.o
>  snd-soc-igep0020-objs :=3D igep0020.o
> =

>  obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-n810.o
> +obj-$(CONFIG_SND_OMAP_SOC_RX51) +=3D snd-soc-rx51.o
>  obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) +=3D snd-soc-ams-delta.o
>  obj-$(CONFIG_SND_OMAP_SOC_OSK5912) +=3D snd-soc-osk5912.o
>  obj-$(CONFIG_SND_OMAP_SOC_OVERO) +=3D snd-soc-overo.o
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> new file mode 100644
> index 0000000..425362b
> --- /dev/null
> +++ b/sound/soc/omap/rx51.c
> @@ -0,0 +1,305 @@
> +/*
> + * rx51.c  --  SoC audio for Nokia RX-51
> + *
> + * Copyright (C) 2008 - 2009 Nokia Corporation
> + *
> + * Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> + *          Eduardo Valentin <eduardo.valentin@nokia.com>
> + *          Jarkko Nikula <jhnikula@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include <asm/mach-types.h>
> +
> +#include "omap-mcbsp.h"
> +#include "omap-pcm.h"
> +#include "../codecs/tlv320aic3x.h"
> +
> +#define RX51_CODEC_RESET_GPIO          60
> +/*
> + * REVISIT: TWL4030 GPIO base in RX-51. Now statically defined to 192.
> This + * gpio is reserved in arch/arm/mach-omap2/board-rx51-peripherals.c
> + */
> +#define RX51_SPEAKER_AMP_TWL_GPIO      (192 + 7)
> +
> +static int rx51_spk_func;
> +static int rx51_dmic_func;
> +
> +static void rx51_ext_control(struct snd_soc_codec *codec)
> +{
> +       if (rx51_spk_func)
> +               snd_soc_dapm_enable_pin(codec, "Ext Spk");
> +       else
> +               snd_soc_dapm_disable_pin(codec, "Ext Spk");
> +       if (rx51_dmic_func)
> +               snd_soc_dapm_enable_pin(codec, "DMic");
> +       else
> +               snd_soc_dapm_disable_pin(codec, "DMic");
> +
> +       snd_soc_dapm_sync(codec);
> +}
> +
> +static int rx51_startup(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime =3D substream->runtime;
> +       struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +       struct snd_soc_codec *codec =3D rtd->socdev->card->codec;
> +
> +       snd_pcm_hw_constraint_minmax(runtime,
> +                                    SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
> +       rx51_ext_control(codec);
> +
> +       return 0;
> +}
> +
> +static int rx51_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +       struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
> +       struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> +       int err;
> +
> +       /* Set codec DAI configuration */
> +       err =3D snd_soc_dai_set_fmt(codec_dai,
> +                                 SND_SOC_DAIFMT_DSP_A |
> +                                 SND_SOC_DAIFMT_IB_NF |
> +                                 SND_SOC_DAIFMT_CBM_CFM);
> +       if (err < 0)
> +               return err;
> +
> +       /* Set cpu DAI configuration */
> +       err =3D snd_soc_dai_set_fmt(cpu_dai,
> +                                 SND_SOC_DAIFMT_DSP_A |
> +                                 SND_SOC_DAIFMT_IB_NF |
> +                                 SND_SOC_DAIFMT_CBM_CFM);
> +       if (err < 0)
> +               return err;
> +
> +       /* Set the codec system clock for DAC and ADC */
> +       return snd_soc_dai_set_sysclk(codec_dai, 0, 19200000,
> +                                     SND_SOC_CLOCK_IN);
> +}
> +
> +static struct snd_soc_ops rx51_ops =3D {
> +       .startup =3D rx51_startup,
> +       .hw_params =3D rx51_hw_params,
> +};
> +
> +static int rx51_get_spk(struct snd_kcontrol *kcontrol,
> +                       struct snd_ctl_elem_value *ucontrol)
> +{
> +       ucontrol->value.integer.value[0] =3D rx51_spk_func;
> +
> +       return 0;
> +}
> +
> +static int rx51_set_spk(struct snd_kcontrol *kcontrol,
> +                       struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +
> +       if (rx51_spk_func =3D=3D ucontrol->value.integer.value[0])
> +               return 0;
> +
> +       rx51_spk_func =3D ucontrol->value.integer.value[0];
> +       rx51_ext_control(codec);
> +
> +       return 1;
> +}
> +
> +static int rx51_spk_event(struct snd_soc_dapm_widget *w,
> +                         struct snd_kcontrol *k, int event)
> +{
> +       if (SND_SOC_DAPM_EVENT_ON(event))
> +               gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 1);
> +       else
> +               gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 0);
> +
> +       return 0;
> +}
> +
> +static int rx51_get_input(struct snd_kcontrol *kcontrol,
> +                         struct snd_ctl_elem_value *ucontrol)
> +{
> +       ucontrol->value.integer.value[0] =3D rx51_dmic_func;
> +
> +       return 0;
> +}
> +
> +static int rx51_set_input(struct snd_kcontrol *kcontrol,
> +                         struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +
> +       if (rx51_dmic_func =3D=3D ucontrol->value.integer.value[0])
> +               return 0;
> +
> +       rx51_dmic_func =3D ucontrol->value.integer.value[0];
> +       rx51_ext_control(codec);
> +
> +       return 1;
> +}
> +
> +static const struct snd_soc_dapm_widget aic34_dapm_widgets[] =3D {
> +       SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
> +       SND_SOC_DAPM_MIC("DMic", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route audio_map[] =3D {
> +       {"Ext Spk", NULL, "HPLOUT"},
> +       {"Ext Spk", NULL, "HPROUT"},
> +
> +       {"DMic Rate 64", NULL, "Mic Bias 2V"},
> +       {"Mic Bias 2V", NULL, "DMic"},
> +};
> +
> +static const char *spk_function[] =3D {"Off", "On"};
> +static const char *input_function[] =3D {"ADC", "Digital Mic"};
> +
> +static const struct soc_enum rx51_enum[] =3D {
> +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
> +       SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(input_function), input_function),
> +};
> +
> +static const struct snd_kcontrol_new aic34_rx51_controls[] =3D {
> +       SOC_ENUM_EXT("Speaker Function", rx51_enum[0],
> +                    rx51_get_spk, rx51_set_spk),
> +       SOC_ENUM_EXT("Input Select",  rx51_enum[1],
> +                    rx51_get_input, rx51_set_input),
> +};
> +
> +static int rx51_aic34_init(struct snd_soc_codec *codec)
> +{
> +       int err;
> +
> +       /* Set up NC codec pins */
> +       snd_soc_dapm_nc_pin(codec, "MIC3L");
> +       snd_soc_dapm_nc_pin(codec, "MIC3R");
> +       snd_soc_dapm_nc_pin(codec, "LINE1R");
> +
> +       /* Add RX-51 specific controls */
> +       err =3D snd_soc_add_controls(codec, aic34_rx51_controls,
> +                                  ARRAY_SIZE(aic34_rx51_controls));
> +       if (err < 0)
> +               return err;
> +
> +       /* Add RX-51 specific widgets */
> +       snd_soc_dapm_new_controls(codec, aic34_dapm_widgets,
> +                                 ARRAY_SIZE(aic34_dapm_widgets));
> +
> +       /* Set up RX-51 specific audio path audio_map */
> +       snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
> +
> +       snd_soc_dapm_sync(codec);
> +
> +       return 0;
> +}
> +
> +/* Digital audio interface glue - connects codec <--> CPU */
> +static struct snd_soc_dai_link rx51_dai[] =3D {
> +       {
> +               .name =3D "TLV320AIC34",
> +               .stream_name =3D "AIC34",
> +               .cpu_dai =3D &omap_mcbsp_dai[0],
> +               .codec_dai =3D &aic3x_dai,
> +               .init =3D rx51_aic34_init,
> +               .ops =3D &rx51_ops,
> +       },
> +};
> +
> +/* Audio private data */
> +static struct aic3x_setup_data rx51_aic34_setup =3D {
> +       .gpio_func[0] =3D AIC3X_GPIO1_FUNC_DISABLED,
> +       .gpio_func[1] =3D AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
> +};
> +
> +/* Audio card */
> +static struct snd_soc_card rx51_sound_card =3D {
> +       .name =3D "RX-51",
> +       .dai_link =3D rx51_dai,
> +       .num_links =3D ARRAY_SIZE(rx51_dai),
> +       .platform =3D &omap_soc_platform,
> +};
> +
> +/* Audio subsystem */
> +static struct snd_soc_device rx51_snd_devdata =3D {
> +       .card =3D &rx51_sound_card,
> +       .codec_dev =3D &soc_codec_dev_aic3x,
> +       .codec_data =3D &rx51_aic34_setup,
> +};
> +
> +static struct platform_device *rx51_snd_device;
> +
> +static int __init rx51_soc_init(void)
> +{
> +       int err;
> +
> +       if (!machine_is_nokia_rx51())
> +               return -ENODEV;
> +
> +       BUG_ON(gpio_request(RX51_CODEC_RESET_GPIO, NULL) < 0);
> +       gpio_direction_output(RX51_CODEC_RESET_GPIO, 0);
> +
> +       gpio_set_value(RX51_CODEC_RESET_GPIO, 0);

You don't really need to set the gpio to 0 again, sine the gpio_direction_o=
utput =

is set the output to 0 already.

> +       udelay(1);
> +       gpio_set_value(RX51_CODEC_RESET_GPIO, 1);
> +       msleep(1);

Another thing, which kind of bothers me is the handling of the reset GPIO f=
or =

the aic3x (this in fact a general problem with the codec driver IMHO)...

The datasheet states, that after power up (voltage enable) a reset sequence=
 is =

needed (keeping the RESET line low for 10ns) to make sure, that the codec i=
s =

properly initialized.
So I think this reset sequence need to be done in the codec driver instead =
of =

the machine.

Also, tlv320aic3x driver will try to set the defaults to the codec during t=
he =

i2c probing. I'm not sure, but if the reset line is low at that point it ma=
y =

cause problems (reset line is low, and the reset sequence has not been =

followed).
Than later in the machine driver the chip is taken out from reset, which mi=
ght =

means, that the chip will be in reset state, so the initial configuration d=
one =

by the codec driver might be lost.

I think it would be better to handle the reset GPIO within the codec driver=
 at =

the end for proper operation.

What do you think?

> +
> +       rx51_snd_device =3D platform_device_alloc("soc-audio", -1);
> +       if (!rx51_snd_device) {
> +               err =3D -ENOMEM;
> +               goto err1;
> +       }
> +
> +       platform_set_drvdata(rx51_snd_device, &rx51_snd_devdata);
> +       rx51_snd_devdata.dev =3D &rx51_snd_device->dev;
> +       *(unsigned int *)rx51_dai[0].cpu_dai->private_data =3D 1; /* McBS=
P2
> */ +
> +       err =3D platform_device_add(rx51_snd_device);
> +       if (err)
> +               goto err2;
> +
> +       return 0;
> +err2:
> +       platform_device_put(rx51_snd_device);
> +err1:
> +       gpio_free(RX51_CODEC_RESET_GPIO);
> +
> +       return err;
> +}
> +
> +static void __exit rx51_soc_exit(void)
> +{
> +       platform_device_unregister(rx51_snd_device);
> +       gpio_free(RX51_CODEC_RESET_GPIO);
> +}
> +
> +module_init(rx51_soc_init);
> +module_exit(rx51_soc_exit);
> +
> +MODULE_AUTHOR("Nokia Corporation");
> +MODULE_DESCRIPTION("ALSA SoC Nokia RX-51");
> +MODULE_LICENSE("GPL");
> --
> 1.7.0

-- =

P=E9ter
