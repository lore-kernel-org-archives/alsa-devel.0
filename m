From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 3/5] ASoC multi-component support : core
Date: Sun, 27 Jun 2010 21:25:49 +0200
Message-ID: <4C27A5BD.8000302@metafoo.de>
References: <1277407482.3100.582.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id AC05E24457
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 21:26:20 +0200 (CEST)
In-Reply-To: <1277407482.3100.582.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi

Liam Girdwood wrote:
> This patch adds multi-component support to the ASoC core and
> reflects the new ASoC driver/device structure model defined in soc.h
> and soc-dai.h. i.e.
> 
>  struct snd_soc_codec    --->  struct snd_soc_codec (device data)
>                           +->  struct snd_soc_codec_driver (driver data)
> 
>  struct snd_soc_platform --->  struct snd_soc_platform (device data)
>                           +->  struct snd_soc_platform_driver (driver data)
> 
>  struct snd_soc_dai      --->  struct snd_soc_dai (device data)
>                           +->  struct snd_soc_dai_driver (driver data)
> 
>  struct snd_soc_device   --->  deleted
> 
> Other notable multi-component changes:-
> 
>  * Stream operations now de-reference less structures.
>  * close_delayed work() now runs on a DAI basis rather than looping all DAIs
>    in a card.
>  * PM suspend()/resume() operations can now handle N CODECs and Platforms
>    per sound card.
>  * Added soc_bind_dai_link() to bind the component devices to the sound card.
>  * Added soc_dai_link_probe() and soc_dai_link_remove() to probe and remove
>    DAI link components.
>  * sysfs entries can now be registered per component per card.
>  * snd_soc_new_pcms() functionailty rolled into dai_link_probe().
>  * snd_soc_register_codec() now does all the codec list and mutex init.
> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/soc-core.c | 1595 +++++++++++++++++++++++++++++---------------------
>  1 files changed, 914 insertions(+), 681 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 3deb226..280c2f0 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> [...]
> +static int soc_probe_dai_link(struct snd_soc_card *card, int num)
> +{
> [...]
> +	/* probe the CODEC */
> +	if (!codec->probed) {
> +		if (codec->driver->probe) {
> +			ret = codec->driver->probe(codec);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		/* Make sure all DAPM widgets are instantiated */
> +		snd_soc_dapm_new_widgets(codec);
> +
> +		/* mark codec as probed and add to card codec list */
> +		codec->probed = 1;
> +		list_add(&codec->card_list, &card->codec_dev_list);
> +
> +		/* add DAPM sysfs entries for this codec */
> +		ret = snd_soc_dapm_sys_add(codec->dev);
>  		if (ret < 0)
> -			goto cpu_dai_err;
> -	}
> -	codec = card->codec;
> +			printk(KERN_WARNING "asoc: failed to add codec dapm sysfs entries\n");
>  
> -	if (platform->probe) {
> -		ret = platform->probe(pdev);
> +		/* add codec sysfs entries */
> +		ret = device_create_file(codec->dev, &dev_attr_codec_reg);
>  		if (ret < 0)
> -			goto platform_err;
> +			printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
> +
> +		soc_init_codec_debugfs(codec);
>  	}
>  
> -	/* DAPM stream work */
> -	INIT_DELAYED_WORK(&card->delayed_work, close_delayed_work);
> -#ifdef CONFIG_PM
> -	/* deferred resume work */
> -	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
> -#endif
> +	/* probe the platform */
> +	if (!platform->probed) {
> +		if (platform->driver->probe) {
> +			ret = platform->driver->probe(platform);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		/* mark platform as probed and add to card platform list */
> +		platform->probed = 1;
> +		list_add(&platform->card_list, &card->platform_dev_list);
> +	}
>  
> -	for (i = 0; i < card->num_links; i++) {
> -		if (card->dai_link[i].init) {
> -			ret = card->dai_link[i].init(codec);
> -			if (ret < 0) {
> -				printk(KERN_ERR "asoc: failed to init %s\n",
> -					card->dai_link[i].stream_name);
> -				continue;
> -			}
> +	/* probe the CODEC DAI */
> +	if (!codec_dai->probed) {
> +		if (codec_dai->driver->probe) {
> +			ret = codec_dai->driver->probe(codec_dai);
> +			if (ret < 0)
> +				return ret;
>  		}
> -		if (card->dai_link[i].codec_dai->ac97_control)
> -			ac97 = 1;
> +
> +		/* mark cpu_dai as probed and add to card cpu_dai list */
> +		codec_dai->probed = 1;
> +		list_add(&codec_dai->card_list, &card->dai_dev_list);
>  	}
>  
> -	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
> -		 "%s",  card->name);
> -	snprintf(codec->card->longname, sizeof(codec->card->longname),
> -		 "%s (%s)", card->name, codec->name);
> +	/* DAPM dai link stream work */
> +	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
>  
> -	/* Make sure all DAPM widgets are instantiated */
> -	snd_soc_dapm_new_widgets(codec);
> +	/* now that all clients have probed, initialise the DAI link */
> +	if (dai_link->init) {
> +		ret = dai_link->init(rtd);
> +		if (ret < 0) {
> +			printk(KERN_ERR "asoc: failed to init %s\n", dai_link->stream_name);
> +			return ret;
> +		}
> +	}
>  
> [...]

Boards usually add board specific widgets and routes in their dai_link init callback.
In the multi-component branch those widgets don't have a debugfs entry nor are they
properly initialized. Thats because snd_soc_dapm_new_widgets used to get called after
the dai_link init callback had been called, now it is before.

- Lars
