From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH V2 1/1] ASoC: add a core API to share more
 product information with user space
Date: Wed, 30 Mar 2016 10:04:46 +0100
Message-ID: <1459328686.2559.43.camel@loki>
References: <1459327952-5313-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B42AC26692D
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 11:04:53 +0200 (CEST)
In-Reply-To: <1459327952-5313-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-03-30 at 16:52 +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
> 

Best to write $SUBJECT as ASoC: core: Add API for registering DMI card
names.

> Add a core API to share more machine/board information, for user space
> apps such as PA and UCM to distinguish various products.
> Previously on ASoC, the card short name, driver name and long name are
> all the same as the machine driver name.
> For example, on T100TA:
>   $ cat /proc/asound/cards
>     0 [bytcr-rt5640]: bytcr-rt5640 -  bytcr-rt5640
>                       bytcr-rt5640
> 
> The patch adds more board information:
>   card driver name --->  machine driver name
>   card short name  --->  DMI_PRODUCT_NAME or DMI_BOARD_NAME
>   card long name and
>   card component   --->  short name:driver name(:DMI_SYS_VENDOR if
>                          available)(:firmware name if available)
> For example, on T100TA:
>   $ cat /proc/asound/cards
>     0 [T100TA      ]: bytcr-rt5640 -  T100TA
>                       T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_
>   sst_0f28.bin
>   $ amixer -c0 info
>   Card hw:0 'T100TA'/'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_
>   sst_0f28.bin'
>     Mixer name    : ''
>     Components    : 'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_s
>   st_0f28.bin'
>     Controls      : 256
>     Simple ctrls  : 228
> 
> Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 02b4a21..4e80444 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -486,6 +486,9 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
>  int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  	unsigned int dai_fmt);
>  
> +int snd_soc_set_card_names(struct snd_soc_card *card, const char *board,
> +		const char *vendor, const char *firmware);
> +
>  /* Utility functions to get clock rates from various things */
>  int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>  int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 032a2e7..3162f3e 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -152,6 +152,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>  	{}
>  };
>  

The usage of the new API call in the bytcr_rt5640 should be a separate
follow up patch.

> +static struct snd_soc_card byt_rt5640_card;
> +
>  static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
>  {
>  	int ret;
> @@ -159,6 +161,19 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
>  	struct snd_soc_card *card = runtime->card;
>  	const struct snd_soc_dapm_route *custom_map;
>  	int num_routes;
> +	const char *board, *vendor;
> +	struct sst_acpi_mach *mach = byt_rt5640_card.dev->platform_data;
> +
> +	/* Add machine/board information for userspace */
> +	board = dmi_get_system_info(DMI_PRODUCT_NAME);
> +	if (!board)
> +		board = dmi_get_system_info(DMI_BOARD_NAME);
> +	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
> +	ret = snd_soc_set_card_names(card, board, vendor, mach->fw_filename);
> +	if (ret < 0) {
> +		dev_err(card->dev, "unable to set card names\n");
> +		return ret;
> +	}
>  
>  	card->dapm.idle_bias_off = true;
>  
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d2e62b15..ab8e7e3 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1828,6 +1828,58 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>  
> +/**
> + * snd_soc_set_card_names() - Set the shortname/drivername/longname/component
> + * of a ASoC card.
> + * @card: The card to set names
> + * @board: The board name or product name
> + * @vendor: The vendor name
> + * @firmware: The firmware name
> + *
> + * This function adds more information for the userspace to distinguish
> + * different products:
> + *   card driver name --->  machine driver name
> + *   card short name  --->  DMI_PRODUCT_NAME or DMI_BOARD_NAME
> + *   card long name and
> + *   card component   --->  short name:driver name(:DMI_SYS_VENDOR)
> + *                          (:firmware name)
> + *
> + * Returns 0 on success, otherwise a negative error code.
> + */
> +int snd_soc_set_card_names(struct snd_soc_card *card, const char *board,
> +		const char *vendor, const char *firmware)
> +{
> +	int ret = 0;
> +	char *name;
> +
> +	if (!board) {
> +		dev_err(card->dev, "ASoC: the board/product name is empty!\n");
> +		return -1;

return -EINVAL;

> +	}

newline ?

> +	/* card driver name */
> +	card->driver_name = card->name;
> +	/* card short name */
> +	card->name = board;
> +	/* card long name / card component */
> +	name = kstrdup(card->name, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +	strcat(name, ":");
> +	strcat(name, card->driver_name);
> +	strcat(name, ":");
> +	if (vendor)
> +		strcat(name, vendor);
> +	strcat(name, ":");
> +	if (firmware)
> +		strcat(name, firmware);
> +	ret = snd_component_add(card->snd_card, name);
> +	card->long_name = card->snd_card->components;
> +
> +	kfree(name);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_set_card_names);
> +
>  static int snd_soc_instantiate_card(struct snd_soc_card *card)
>  {
>  	struct snd_soc_codec *codec;

Liam
