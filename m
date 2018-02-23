From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 5/9] ALSA: hda - split snd_hda_codec_new
	function
Date: Fri, 23 Feb 2018 10:50:19 -0600
Message-ID: <96204f32-54ea-baaa-c3ed-94774f7728c5@linux.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-6-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D00D26790E
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 17:50:23 +0100 (CET)
In-Reply-To: <1519373550-2545-6-git-send-email-rakesh.a.ughreja@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 2/23/18 2:12 AM, Rakesh Ughreja wrote:
> Split snd_hda_codec_new into two separate functions.
> snd_hda_codec_device_init allocates memory and registers with bus.
> snd_hda_codec_device_new initialializes the fields and performs
> snd_device_new. This enables reuse of legacy HDA codec drivers as ASoC
> codec drivers.
> 
> In addition mark some functions with EXPORT_SYMBOL_GPL so that it can be
> called by ASoC codec drivers.

I don't get the commit message.
You first say that we can now reuse legacy HDaudio codec drivers in an 
ASoC framework, then say that there will be additional ASoC codec 
drivers? Why would we do this, it seems like a contradicting goal?

> 
> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> ---
>   sound/pci/hda/hda_codec.c | 67 +++++++++++++++++++++++++++++++++++------------
>   sound/pci/hda/hda_codec.h |  2 ++
>   2 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 5bc3a74..c487411 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -856,6 +856,38 @@ static void snd_hda_codec_dev_release(struct device *dev)
>   	kfree(codec);
>   }
>   
> +static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
> +			unsigned int codec_addr, struct hda_codec **codecp)
> +{
> +	int err;
> +	char component[31];

looks like magic number?

> +	struct hda_codec *codec;

reverse x-mas tree order?

> +
> +	dev_dbg(card->dev, "%s: entry\n", __func__);
> +
> +	if (snd_BUG_ON(!bus))
> +		return -EINVAL;
> +	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
> +		return -EINVAL;
> +
> +	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
> +	if (!codec)
> +		return -ENOMEM;
> +
> +	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
> +	err = snd_hdac_device_init(&codec->core, &bus->core, component,
> +				   codec_addr);
> +	if (err < 0) {
> +		kfree(codec);
> +		return err;
> +	}
> +
> +	codec->core.type = HDA_DEV_LEGACY;
> +	*codecp = codec;
> +
> +	return err;
> +}
> +
>   /**
>    * snd_hda_codec_new - create a HDA codec
>    * @bus: the bus to assign
> @@ -867,7 +899,19 @@ static void snd_hda_codec_dev_release(struct device *dev)
>   int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
>   		      unsigned int codec_addr, struct hda_codec **codecp)
>   {
> -	struct hda_codec *codec;
> +	int ret;
> +
> +	ret = snd_hda_codec_device_init(bus, card, codec_addr, codecp);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snd_hda_codec_device_new(bus, card, codec_addr, *codecp);
> +}
> +EXPORT_SYMBOL_GPL(snd_hda_codec_new);
> +
> +int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
> +			unsigned int codec_addr, struct hda_codec *codec)
> +{
>   	char component[31];
>   	hda_nid_t fg;
>   	int err;
> @@ -877,25 +921,14 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
>   		.dev_free = snd_hda_codec_dev_free,
>   	};
>   
> +	dev_dbg(card->dev, "%s: entry\n", __func__);
> +
>   	if (snd_BUG_ON(!bus))
>   		return -EINVAL;
>   	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
>   		return -EINVAL;
>   
> -	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
> -	if (!codec)
> -		return -ENOMEM;
> -
> -	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
> -	err = snd_hdac_device_init(&codec->core, &bus->core, component,
> -				   codec_addr);
> -	if (err < 0) {
> -		kfree(codec);
> -		return err;
> -	}
> -
>   	codec->core.dev.release = snd_hda_codec_dev_release;
> -	codec->core.type = HDA_DEV_LEGACY;
>   	codec->core.exec_verb = codec_exec_verb;
>   
>   	codec->bus = bus;
> @@ -955,15 +988,13 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
>   	if (err < 0)
>   		goto error;
>   
> -	if (codecp)
> -		*codecp = codec;
>   	return 0;
>   
>    error:
>   	put_device(hda_codec_dev(codec));
>   	return err;
>   }
> -EXPORT_SYMBOL_GPL(snd_hda_codec_new);
> +EXPORT_SYMBOL_GPL(snd_hda_codec_device_new);
>   
>   /**
>    * snd_hda_codec_update_widgets - Refresh widget caps and pin defaults
> @@ -2979,6 +3010,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
>   	sync_power_up_states(codec);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(snd_hda_codec_build_controls);
>   
>   /*
>    * PCM stuff
> @@ -3184,6 +3216,7 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(snd_hda_codec_parse_pcms);
>   
>   /* assign all PCMs of the given codec */
>   int snd_hda_codec_build_pcms(struct hda_codec *codec)
> diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> index 681c360..8bbedf7 100644
> --- a/sound/pci/hda/hda_codec.h
> +++ b/sound/pci/hda/hda_codec.h
> @@ -307,6 +307,8 @@ struct hda_codec {
>    */
>   int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
>   		      unsigned int codec_addr, struct hda_codec **codecp);
> +int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
> +		      unsigned int codec_addr, struct hda_codec *codec);
>   int snd_hda_codec_configure(struct hda_codec *codec);
>   int snd_hda_codec_update_widgets(struct hda_codec *codec);
>   
> 
