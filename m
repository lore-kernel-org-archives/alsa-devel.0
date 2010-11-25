From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Thu, 25 Nov 2010 19:18:23 +0000
Message-ID: <1290712703.3302.41.camel@odin>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE86F103817
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 20:18:26 +0100 (CET)
Received: by wyi11 with SMTP id 11so1189710wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:18:26 -0800 (PST)
In-Reply-To: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Jarkko,

Sorry, didn't get a chance to discuss on IRC but I have some comments
below :-

On Thu, 2010-11-25 at 17:47 +0200, Jarkko Nikula wrote:
> This makes possible to register auxiliary dailess codecs in a machine
> driver. Term dailess is used here for amplifiers and codecs without DAI or
> DAI being unused.
> 
> Dailess auxiliary codecs are kept in struct snd_soc_aux_dev and those codecs
> are probed after initializing the DAI links. There are no major differences
> between DAI link codecs and dailess codecs in ASoC core point of view. DAPM
> handles them equally and sysfs and debugfs directories for dailess codecs
> are similar except the pmdown_time node is not created.
> 
> Only suspend and resume functions are modified to traverse all probed codecs
> instead of DAI link codecs.
> 
> Example below shows a dailess codec registration.
> 
> struct snd_soc_aux_dev foo_aux_dev[] = {
> 	{
> 		.name = "Amp",
> 		.codec_name = "codec.2",
> 		.init = foo_init2,
> 	},
> };
> 
> static struct snd_soc_card card = {
> 	...
> 	.aux_dev = foo_aux_dev,
> 	.num_aux_devs = ARRAY_SIZE(foo_aux_dev),
> };
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Idea sharing version, not to be applied. Needs at least cross-device DAPM
> to be usuful and e.g. soc_probe_dai_link and soc_probe_aux_dev share a lot
> of same code.
> 
> I'm not entirely sure of reusing struct snd_soc_pcm_runtime but having some
> common struct on top of it for registering the sysfs nodes and passing to
> snd_soc_dapm_sys_add didn't sound clear either.
> Anyway suspend/resume is working with this version and doesn't need any other
> modifications to soc_suspend/soc_resume than traversing through the registered
> codecs instead of doing bunch of rtd->dailess etc hacks there.
> ---
>  include/sound/soc.h  |   17 ++++++
>  sound/soc/soc-core.c |  155 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 166 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 346c59e..c62225e 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -583,6 +583,14 @@ struct snd_soc_prefix_map {
>  	const char *name_prefix;
>  };
>  
> +struct snd_soc_aux_dev {
> +	const char *name;		/* Codec name */
> +	const char *codec_name;		/* for multi-codec */
> +
> +	/* codec/machine specific init - e.g. add machine controls */
> +	int (*init)(struct snd_soc_dapm_context *dapm);
> +};
> +
>  /* SoC card */
>  struct snd_soc_card {
>  	const char *name;
> @@ -624,6 +632,15 @@ struct snd_soc_card {
>  	struct snd_soc_prefix_map *prefix_map;
>  	int num_prefixes;
>  
> +	/*
> +	 * optional auxiliary devices such as amplifiers or codecs with DAI
> +	 * link unused
> +	 */
> +	struct snd_soc_aux_dev *aux_dev;
> +	int num_aux_devs;
> +	struct snd_soc_pcm_runtime *rtd_aux;
> +	int num_aux_rtd;
> +

Could we not just make this a new component type and have a list of aux
devices ?

>  
>  	/* lists of probed devices belonging to this card */
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b0e1aea..d7fc3a6 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -986,6 +986,7 @@ static int soc_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec;
>  	int i;
>  
>  	/* If the initialization of this soc device failed, there is no codec
> @@ -1064,8 +1065,7 @@ static int soc_suspend(struct device *dev)
>  	}
>  
>  	/* suspend all CODECs */
> -	for (i = 0; i < card->num_rtd; i++) {
> -		struct snd_soc_codec *codec = card->rtd[i].codec;
> +	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
>  		/* If there are paths active then the CODEC will be held with
>  		 * bias _ON and should not be suspended. */
>  		if (!codec->suspended && codec->driver->suspend) {
> @@ -1106,6 +1106,7 @@ static void soc_resume_deferred(struct work_struct *work)
>  	struct snd_soc_card *card =
>  			container_of(work, struct snd_soc_card, deferred_resume_work);
>  	struct platform_device *pdev = to_platform_device(card->dev);
> +	struct snd_soc_codec *codec;
>  	int i;
>  
>  	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
> @@ -1131,8 +1132,7 @@ static void soc_resume_deferred(struct work_struct *work)
>  			cpu_dai->driver->resume(cpu_dai);
>  	}
>  
> -	for (i = 0; i < card->num_rtd; i++) {
> -		struct snd_soc_codec *codec = card->rtd[i].codec;
> +	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
>  		/* If the CODEC was idle over suspend then it will have been
>  		 * left with bias OFF or STANDBY and suspended so we must now
>  		 * resume.  Otherwise the suspend was suppressed.
> @@ -1604,6 +1604,130 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
>  }
>  #endif
>  
> +static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
> +{
> +	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
> +	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
> +	struct snd_soc_codec *codec;
> +	const char *temp;
> +	int ret = 0;
> +
> +	/* find CODEC from registered CODECs*/
> +	list_for_each_entry(codec, &codec_list, list) {
> +		if (!strcmp(codec->name, aux_dev->codec_name)) {
> +			if (codec->probed) {
> +				dev_err(codec->dev,
> +					"asoc: codec already probed");
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +			break;
> +		}
> +	}
> +

Why do aux devices need to be coupled with CODECs here ? 

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
