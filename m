From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] ASoC: core: Add API to use DMI
 name in sound card long name
Date: Fri, 16 Dec 2016 17:48:31 +0800
Message-ID: <5853B86F.4080602@linux.intel.com>
References: <cover.1481856472.git.mengdong.lin@linux.intel.com>
 <895e6e34fdf601cea514f6a205711cba85bfcdce.1481856472.git.mengdong.lin@linux.intel.com>
 <1481877598.14684.202.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 509E026751F
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 10:46:00 +0100 (CET)
In-Reply-To: <1481877598.14684.202.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


On 12/16/2016 04:39 PM, Liam Girdwood wrote:
> On Fri, 2016-12-16 at 10:51 +0800, mengdong.lin@linux.intel.com wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> Intel DSP platform drivers are used by many different devices but are
>> difficult for userspace to differentiate. This patch adds an API to allow
>> the DMI name to be used in the sound card long name, thereby helping
>> userspace load the correct UCM configuration. Usually machine drivers
>> uses their own name as the sound card name (short name), and leave the
>> long name and driver name blank. This API will generate DMI name from the
>> DMI vendor, product and board info, and then make up a unique card long
>> name from the short name and DMI name. If the machine driver has already
>> explicitly set the long name, although not observed, this API will do
>> nothing.
>>
>> This patch also allows for further differentiation as many devices that
>> share the same DMI name i.e. Minnowboards, UP boards may be configured
>> with different codecs or firmwares. The API supports flavoring the DMI
>> name into the card longname to provide the extra differentiation required
>> for these devices.
>>
>> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 795e6c4..b84648f 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -497,6 +497,8 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
>>   int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>   	unsigned int dai_fmt);
>>
>> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
>> +
>>   /* Utility functions to get clock rates from various things */
>>   int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>>   int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
>> @@ -1094,6 +1096,9 @@ struct snd_soc_card {
>>   	const char *name;
>>   	const char *long_name;
>>   	const char *driver_name;
>> +	char dmi_longname[80];
>> +	char board_name[80];
>> +
>>   	struct device *dev;
>>   	struct snd_card *snd_card;
>>   	struct module *owner;
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index aaab26a..bb6a23a 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/ctype.h>
>>   #include <linux/slab.h>
>>   #include <linux/of.h>
>> +#include <linux/dmi.h>
>>   #include <sound/core.h>
>>   #include <sound/jack.h>
>>   #include <sound/pcm.h>
>> @@ -1886,6 +1887,139 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>   }
>>   EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>>
>> +/* Move the DMI stuff below to a new file soc-dmi.c? */
>> +struct snd_soc_dmi_name  {
>> +	const char *vendor;
>> +	const char *product;
>> +	const char *board;
>> +	const char *name;
>> +};
>> +
>> +#define SOC_DMI_ENTRY(_vendor, _product, _board, _name) \
>> +	{ .vendor = (_vendor), .board = (_board), \
>> +	  .product = (_product), .name = (_name) }
>> +
>> +/* DMI names. The matched DMI name will be appended to the card short name
>> + * to make up the card long name. Machine drivers ususally use their own name
>> + * as the card short name, and leave the long name empty. Machine driver may
>> + * call API snd_soc_set_dmi_name() to get a unique long name. In user space,
>> + * Use Case Manager (UCM) will try to find the best configuration file by
>> + * matching the card long name at first, and if unavailable, match the short
>> + * name as a fallback.
>> + * For example, for a Boradwell-based Dell XPS 13-2015(9343), the card short
>> + * name is "broadwell-rt286" and the DMI name is "DELL-XPS", so the long name
>> + * will be "broadwell-rt286-Dell-XPS". For a new Skylake-based Dell XPS 13/15,
>> + * if the short name is "skl-xyz" and DMI name is "Dell-XPS", the long name
>> + * will be "skl-xyz-Dell-XPS".In user space, Use Case Manager (UCM) will try
>> + * to find the best configuration file by matching the card long name (e.g.
>> + * broadwell-rt286-Dell-XPS), and if unavailable, fallback to the default
>> + * configuration file by matching the short name (e.g. broadwell-rt286).
>> + */
>> +static struct snd_soc_dmi_name dmi_names[]  = {
>> +	SOC_DMI_ENTRY("Intel Corp.", "Broadwell Client platform",
>> +		      "Wilson Beach SDS", "Intel-Wilson-Beach"),
>> +	SOC_DMI_ENTRY("Dell Inc.", "XPS 13 9343", "0310JH", "Dell-XPS"),
>> +	SOC_DMI_ENTRY("ASUSTeK COMPUTER INC.", "T100TA", "T100TA",
>> +		      "ASUS-T100"),
>> +	{}	/* terminator */
>> +};
>
>
> We cant have any tables here or add new data for each machine. The
> intention is that the long name should be made from the DMI name (just a
> verbatim copy really). That way we dont need to do any new driver
> updates for a new machine, we just read the DMI name.
>
> UCM will then try and find a config for the long name first, then will
> revert to the current short/driver name to load the existing configs.
> This way we dont break legacy or current users.
>
> Liam

Hi Liam,

It seems different OEMs may have different flavor to define their DMI 
info. Directly using verbatim copy may result in too many different long 
names even for a product series that may share the same config.
So I use the table here for a product family to share a single 
configuration file, which is not the default one with the same name as 
the card short name/driver name.

Take Dell XPS family for example, there are Boradwell based XPS 13/15 in 
2014 and 2015, their product name can be different like:
XPS-13-xxxx, XPS-15-xxxx, and xxxx numbers are different for different 
years. And its board name could also change. I hope they can share the 
same card long name "broadwell-rt286-Dell-XPS" and the same UCM 
configuration file. Since XPS 13 and 15 only differ in screen size and 
GFX, only in audio HW. And xxxx does not matter here.

Although Dell XPS family may always revert to the short name/driver name 
to use the default UCM configuration file "broadwell-rt286" or 
"skl-xxx". But there may be other OEM machine family that can share a 
same UCM config file but not the default one. And I hope when users 
write a UCM configuration file, the file name could be more user 
friendly than a pure number.

And actually, the table is an option. If user don't want to define an 
entry for a specific machine, this function will to the verbatim copy to 
make the long name in the code below.

>> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
>> +{
>> +	const char *vendor, *product, *board, *name;
>> +	char *spos;
>> +
>> +	if (card->long_name)
>> +		return 0; /* already set long name by driver or from DMI */
>> +
>> +	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
>> +	if (!vendor) {
>> +		dev_warn(card->dev, "ASoC: the DMI vendor name is empty!\n");
>> +		return 0;
>> +	}
>> +
>> +	product = dmi_get_system_info(DMI_PRODUCT_NAME);
>> +	board = dmi_get_system_info(DMI_BOARD_NAME);
>> +	if (!board && !product) {
>> +		/* fall back to using legacy name */
>> +		dev_warn(card->dev, "ASoC: both board/product name are empty!\n");
>> +		return 0;
>> +	}
>> +
>> +	name = find_dmi_name(vendor, product, board);
>> +	if (name)
>> +		snprintf(card->board_name, sizeof(card->board_name),
>> +			"%s-%s", card->name, name);
>> +	else
>> +		snprintf(card->board_name, sizeof(card->snd_card->longname),
>> +			"%s-%s-%s-%s", card->name, vendor, product, board);
>> +

Here, if we cannot find a predefined DMI model in the able, we'll do the 
verbatim copy to make a long name automatically as 
"shortname-verdor-product-board".

Thanks
Mengdong
