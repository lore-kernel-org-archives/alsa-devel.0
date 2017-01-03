From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Tue, 03 Jan 2017 14:40:17 +0000
Message-ID: <1483454417.4555.2.camel@loki>
References: <cover.1483418875.git.mengdong.lin@linux.intel.com>
 <0827a46b8200cc3e053f8fc6b3b428eac90a3618.1483418875.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EB19266ED4
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 15:40:21 +0100 (CET)
In-Reply-To: <0827a46b8200cc3e053f8fc6b3b428eac90a3618.1483418875.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-01-03 at 12:58 +0800, mengdong.lin@linux.intel.com wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Intel DSP platform drivers are used by many different devices but are
> difficult for userspace to differentiate. This patch adds an API to allow
> the DMI name to be used in the sound card long name, thereby helping
> userspace load the correct UCM configuration. Usually machine drivers
> uses their own name as the sound card name (short name), and leave the
> long name and driver name blank. This API will use the DMI info like
> vendor, product and board to make up the card long name. If the machine
> driver has already explicitly set the long name, this API will do nothing.
> 
> This patch also allows for further differentiation as many devices that
> share the same DMI name i.e. Minnowboards, UP boards may be configured
> with different codecs or firmwares. The API supports flavoring the DMI
> name into the card longname to provide the extra differentiation required
> for these devices.
> 
> For Use Case Manager (UCM) in the user space, changing card long name by
> this API is backward compatible, since the card name does not change. For
> a given sound card, even if there is no device-specific UCM configuration
> file that uses the card long name, UCM will fall back to load the default
> configuration file that uses the card name.
> 
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 795e6c4..e4f1844 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -497,6 +497,8 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
>  int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  	unsigned int dai_fmt);
>  
> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
> +
>  /* Utility functions to get clock rates from various things */
>  int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>  int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
> @@ -1094,6 +1096,8 @@ struct snd_soc_card {
>  	const char *name;
>  	const char *long_name;
>  	const char *driver_name;
> +	char dmi_longname[80];
> +
>  	struct device *dev;
>  	struct snd_card *snd_card;
>  	struct module *owner;
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index aaab26a..3dbb5aa 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/ctype.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/dmi.h>
>  #include <sound/core.h>
>  #include <sound/jack.h>
>  #include <sound/pcm.h>
> @@ -1886,6 +1887,104 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>  
> +
> +/* Only keep number and alphabet characters and a few separator characters.
> + * DMI info often has SPACE and we must trim them, since Use Case Manager in
> + * the user space expects the device-specific configuration files/directories
> + * use the same name as the card long name but Autoconf cannot support SPACE
> + * in file or directory name.
> + */
> +static void trim_special_characters(char *name)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; name[i]; i++) {
> +		if (isalnum(name[i]) || (name[i] == '.')
> +		    || (name[i] == '-') || (name[i] == '_'))
> +			name[j++] = name[i];
> +	}
> +
> +	name[j] = '\0';
> +}
> +
> +/**
> + * snd_soc_set_dmi_name() - Register DMI names to card
> + * @card: The card to register DMI names
> + * @flavour: The flavour "differentiator" for the card amongst its peers.
> + *
> + * Intel DSP platform drivers are used by many different devices but are
> + * difficult for userspace to differentiate, since machine drivers ususally
> + * use their own name as the card name (short name) and leave the card long
> + * name blank. This function will allow DMI info to be used as the sound
> + * card long name, thereby helping userspace load the correct UCM (Use Case
> + * Manager) configuration. Character '.' are used to separate different DMI
> + * fields like "vendor.product.board".
> + *
> + * Possible card long names may be:
> + * DellInc..XPS139343.0310JH
> + * IntelCorp..BroadwellClientPlatform.WilsonBeachSDS
> + * ASUSTeKCOMPUTERINC..T100TA.T100TA
> + * Circuitco.MinnowboardMaxD0PLATFORM.MinnowBoardMAX
> + * (Please note DMI info can also include '.' after some abbreviation like
> + * "Inc." so you may see double '.' sometimes)
> + *
> + * This function also supports flavoring the card longname to provide
> + * the extra differentiation, like "vendor.product.board.flavor".

I dont think we need vendor (it just makes it too long). The product or
board name should be unique enough for us to load the correct files.

Liam

> + *
> + * We only keep number and alphabet characters and a few separator characters
> + * in the card long name since UCM in the user space uses the card long names
> + * as card configuration directory names and AudoConf cannot support special
> + * charactors like SPACE.
> + *
> + * Returns 0 on success, otherwise a negative error code.
> + */
> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
> +{
> +	const char *vendor, *product, *board;
> +	char dmi_longname[80];
> +
> +	if (card->long_name)
> +		return 0; /* long name already set by driver or from DMI */
> +
> +	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	if (!vendor) {
> +		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
> +		return 0;
> +	}
> +
> +	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> +	board = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (!board && !product) {
> +		/* fall back to using legacy name */
> +		dev_warn(card->dev, "ASoC: no DMI board/product name!\n");
> +		return 0;
> +	}
> +
> +	/* make up dmi long name as: vendor.product.board */
> +	if (product && board)
> +		snprintf(dmi_longname, sizeof(card->snd_card->longname),
> +			 "%s.%s.%s", vendor, product, board);
> +	else
> +		snprintf(dmi_longname, sizeof(card->snd_card->longname),
> +			 "%s.%s", vendor, product ? product : board);
> +
> +	/* Add flavour to dmi long name */
> +	if (flavour)
> +		snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
> +			 "%s.%s", dmi_longname, flavour);
> +	else
> +		strncpy(card->dmi_longname, dmi_longname,
> +			sizeof(card->snd_card->longname) - 1);
> +
> +	trim_special_characters(card->dmi_longname);
> +
> +	/* set long name */
> +	card->long_name = card->dmi_longname;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
> +
>  static int snd_soc_instantiate_card(struct snd_soc_card *card)
>  {
>  	struct snd_soc_codec *codec;
