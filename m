From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/codecs: Add support for
	the	wm8727 DAC.
Date: Mon, 2 Nov 2009 12:09:42 +0000
Message-ID: <20091102120942.GI29351@sirena.org.uk>
References: <91f916b90911020354s7f22d0a8pba2ac82525663d8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 590D6103805
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 13:09:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <91f916b90911020354s7f22d0a8pba2ac82525663d8e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neiljay@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 11:54:15AM +0000, Neil Jones wrote:

Thanks for this - there's a few relatively minor issues below.

Please remember to CC maintainers on patches, this helps avoid them
getting missed on busy mailing lists.  

>  sound/soc/codecs/Makefile |    5 +-
>  sound/soc/codecs/wm8727.c |  120
> +++++++++++++++++++++++++++++++++++++++++++++

Your MUA has word wrapped your post - this is going to upset patch.
There are some hints on MUA configuration in Documentation/email-clients.txt
which might help.  If all else fails an attachment (without a copy of
the patch in the body of the mail) usually works.

> @@ -217,6 +221,6 @@ config SND_SOC_WM9712
>  config SND_SOC_WM9713
>      tristate
> 
> -# Amp
>  config SND_SOC_MAX9877
>      tristate
> +

This is an unrelated change which shouldn't be here (and will actually
generate a conflict with current code since there was another amplifier
driver added).

> @@ -44,7 +45,6 @@ snd-soc-wm9705-objs := wm9705.o
>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> -
>  # Amp
>  snd-soc-max9877-objs := max9877.o

Ditto, but no conflict this time.

> @@ -94,6 +95,6 @@ obj-$(CONFIG_SND_SOC_WM9705)    += snd-soc-wm9705.o
>  obj-$(CONFIG_SND_SOC_WM9712)    += snd-soc-wm9712.o
>  obj-$(CONFIG_SND_SOC_WM9713)    += snd-soc-wm9713.o
>  obj-$(CONFIG_SND_SOC_WM_HUBS)    += snd-soc-wm-hubs.o
> -
>  # Amp
>  obj-$(CONFIG_SND_SOC_MAX9877)    += snd-soc-max9877.o
> +

Ditto.

> +static int wm8727_soc_probe(struct platform_device *pdev)
> +{
> +    struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +    struct snd_soc_codec *codec;
> +    int ret = 0;
> +
> +    codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> +    if (codec == NULL)
> +        return -ENOMEM;

You might want to run your patch through scripts/checkpatch.pl - I think
there's some indentation issues (I'm not 100% sure that this isn't your
MUA mangling things, though).

> +static int __init wm8727_init(void)
> +{
> +    return snd_soc_register_dai(&wm8727_dai);
> +}
> +module_init(wm8727_init);
> +
> +static void __exit wm8727_exit(void)
> +{
> +    snd_soc_unregister_dai(&wm8727_dai);
> +}
> +module_exit(wm8727_exit);

This should be converted to register a platform driver for the device
and do the DAI registration.  Some older drivers don't do this but it
will be required going forward for newer framework features so it's
mandatory for new drivers.

See wm8350 for an example of registering off a platform driver probe,
it's just a case of calling the register/unregister functions from the
platform driver probe/remove functions and assigning dai->dev to be the
struct device for the platform driver before you register the DAI.
