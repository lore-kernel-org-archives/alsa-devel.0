From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: Ensoniq SoundScape VIVO90
Date: Fri, 14 Sep 2007 16:42:55 +0200
Message-ID: <8c74410a0709140742u19bf40bchaaf5b8ff1952dd21@mail.gmail.com>
References: <8c74410a0709140112s444692bcib146298c05fa1918@mail.gmail.com>
	<46EA9BF6.4010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id D7CCF2435D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 16:42:58 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so674154nzf
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 07:42:56 -0700 (PDT)
In-Reply-To: <46EA9BF6.4010603@gmail.com>
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
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Chris Rankin <rankincj@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the answer.

I found also this:
http://contents.driverguide.com/content.php?id=19870&path=ENSONIQ.INF

This is an INF file for the Windows driver of the card with ENS3081
id. It is called "SoundScape PnP". It also gives ranges of io ports
and irqs possible to use for the driver (search for IOConfig).
They are the same as for the VIVO card I have which means they are
incorrect in the
sscape driver.

I would like to hear something from Cris Rankin. Maybe he tested it on
the non-PnP card
and the PnP part is untested yet.

Regards,
Krzysztof

On 9/14/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 09/14/2007 10:12 AM, Krzysztof Helt wrote:
>
> > I acquired Ensoniq VIVO90 card. I tried sscape driver but it does not
> > work. I quickly looked at the oss driver in the kernel and it works
> > completely different (uses different pnp resources for codec and mpu).
>
> Also looked at that in response to a list question a while ago and posted a
> very basic driver for the codec part only:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000716.html
>
> Also attached again. Haven't looked at it anymore since then.
>
> > I want to ask if somebody tested this driver and if so what was the
> > Ensoniq card model. If it worked only for non-pnp models I would
> > integrate at least for VIVO cards.
>
> It supposedly worked for the original author (Chris Rankin, CCed) with that
> ENS3081 card that's listed. I suppose you also have the 4081 as both I and
> Cody did?
>
> (I do also have an old non-pnp soundscape lying about, but I haven't gotten
> around to testing that yet).
>
> Rene.
>
>
> commit f52cdda56fd648315fcc276d701760e9183939b3
> Author: Rene Herman <rene.herman@gmail.com>
> Date:   Tue May 8 20:25:17 2007 +0200
>
>     [ALSA] snd-vivo
>
> diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
> index cf3803c..9567090 100644
> --- a/sound/isa/Kconfig
> +++ b/sound/isa/Kconfig
> @@ -397,6 +397,18 @@ config SND_SSCAPE
>           To compile this driver as a module, choose M here: the module
>           will be called snd-sscape.
>
> +config SND_VIVO
> +       tristate "Ensoniq Soundscape VIVO(90) Driver"
> +       depends on SND
> +       select SND_MPU401_UART
> +       select SND_CS4231_LIB
> +       help
> +         Say Y here to include support for Ensoniq Soundscape VIVO(90)
> +         soundcards.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called snd-vivo.
> +
>  config SND_WAVEFRONT
>         tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
>         depends on SND
> diff --git a/sound/isa/Makefile b/sound/isa/Makefile
> index bb317cc..8f246af 100644
> --- a/sound/isa/Makefile
> +++ b/sound/isa/Makefile
> @@ -12,6 +12,7 @@ snd-es18xx-objs := es18xx.o
>  snd-opl3sa2-objs := opl3sa2.o
>  snd-sgalaxy-objs := sgalaxy.o
>  snd-sscape-objs := sscape.o
> +snd-vivo-objs := vivo.o
>
>  # Toplevel Module Dependency
>  obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
> @@ -23,6 +24,7 @@ obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
>  obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
>  obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
>  obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
> +obj-$(CONFIG_SND_VIVO) += snd-vivo.o
>
>  obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
>                      sb/ wavefront/
> diff --git a/sound/isa/vivo.c b/sound/isa/vivo.c
> new file mode 100644
> index 0000000..fd2c774
> --- /dev/null
> +++ b/sound/isa/vivo.c
> @@ -0,0 +1,148 @@
> +/*
> + * Ensoniq Soundscape VIVO(90) Driver
> + */
> +
> +#include <sound/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pnp.h>
> +#include <linux/delay.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/mpu401.h>
> +#include <sound/cs4231.h>
> +
> +#define CRD_NAME "Ensoniq Soundscape VIVO(90)"
> +#define DRV_NAME "VIVO"
> +#define DEV_NAME "vivo"
> +
> +MODULE_DESCRIPTION(CRD_NAME);
> +MODULE_AUTHOR("Rene Herman");
> +MODULE_LICENSE("GPL");
> +
> +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
> +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
> +static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
> +
> +module_param_array(index, int, NULL, 0444);
> +MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard");
> +module_param_array(id, charp, NULL, 0444);
> +MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard");
> +module_param_array(enable, bool, NULL, 0444);
> +MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard");
> +
> +static struct pnp_card_device_id snd_vivo_pnpids[] = {
> +       { .id = "ENS4081", .devs = { { "ENS1011" } } },
> +       { .id = "" }
> +};
> +
> +MODULE_DEVICE_TABLE(pnp_card, snd_vivo_pnpids);
> +
> +static int snd_vivo_error __devinitdata = -ENODEV;
> +
> +static int __devinit snd_vivo_probe(struct pnp_card_link *pcard,
> +                                   const struct pnp_card_device_id *pid)
> +{
> +       static int card_num;
> +
> +       struct pnp_dev    *pdev;
> +       struct snd_card   *card;
> +       struct snd_cs4231 *chip;
> +
> +       int num, error;
> +
> +       if (card_num == SNDRV_CARDS)
> +               return -ENODEV;
> +
> +       num = card_num++;
> +       if (!enable[num])
> +               return -ENODEV;
> +
> +       pdev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
> +       if (!pdev || pnp_activate_dev(pdev) < 0)
> +               return -ENODEV;
> +
> +       card = snd_card_new(index[num], id[num], THIS_MODULE, 0);
> +       if (!card)
> +               return -EINVAL;
> +
> +       snd_card_set_dev(card, &pdev->dev);
> +
> +       strcpy(card->driver, DRV_NAME);
> +       strcpy(card->shortname, DRV_NAME);
> +       strcpy(card->longname, CRD_NAME);
> +
> +       error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
> +                                   pnp_port_start(pdev, 0), 0,
> +                                   pnp_irq(pdev, 1), 0, NULL);
> +       if (error < 0)
> +               goto out;
> +
> +       msleep(500);
> +
> +       error = snd_cs4231_create(card, pnp_port_start(pdev, 1) + 4, -1,
> +                                 pnp_irq(pdev, 0), pnp_dma(pdev, 0),
> +                                 pnp_dma(pdev, 1), CS4231_HW_DETECT,
> +                                 0, &chip);
> +       if (error < 0)
> +               goto out;
> +
> +       error = snd_cs4231_pcm(chip, 0, NULL);
> +       if (error < 0)
> +               goto out;
> +
> +       error = snd_cs4231_mixer(chip);
> +       if (error < 0)
> +               goto out;
> +
> +       error = snd_cs4231_timer(chip, 0, NULL);
> +       if (error < 0)
> +               goto out;
> +
> +       error = snd_card_register(card);
> +       if (error < 0)
> +               goto out;
> +
> +       pnp_set_card_drvdata(pcard, card);
> +       return (snd_vivo_error = 0);
> +
> +out:   snd_card_free(card);
> +       return error;
> +}
> +
> +static void __devexit snd_vivo_remove(struct pnp_card_link *pcard)
> +{
> +       snd_card_free(pnp_get_card_drvdata(pcard));
> +       pnp_set_card_drvdata(pcard, NULL);
> +}
> +
> +static struct pnp_card_driver snd_vivo_driver = {
> +       .flags          = PNP_DRIVER_RES_DISABLE,
> +       .name           = DEV_NAME,
> +       .id_table       = snd_vivo_pnpids,
> +       .probe          = snd_vivo_probe,
> +       .remove         = __devexit_p(snd_vivo_remove)
> +};
> +
> +static int __init alsa_card_vivo_init(void)
> +{
> +       int error;
> +
> +       error = pnp_register_card_driver(&snd_vivo_driver);
> +       if (error < 0)
> +               goto out;
> +
> +       error = snd_vivo_error;
> +       if (error < 0)
> +               pnp_unregister_card_driver(&snd_vivo_driver);
> +
> +out:   return error;
> +}
> +
> +static void __exit alsa_card_vivo_exit(void)
> +{
> +       pnp_unregister_card_driver(&snd_vivo_driver);
> +}
> +
> +module_init(alsa_card_vivo_init);
> +module_exit(alsa_card_vivo_exit);
>
>
