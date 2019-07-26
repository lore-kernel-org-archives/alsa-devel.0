From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 1/1] ASoC: Intel: Skylake: Remove static
 table index when parsing topology
Date: Fri, 26 Jul 2019 10:47:08 -0500
Message-ID: <99dcace6-8b46-4ecf-03e5-b48a219640ae@linux.intel.com>
References: <20190726090929.27946-1-amadeuszx.slawinski@linux.intel.com>
 <20190726090929.27946-2-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726090929.27946-2-amadeuszx.slawinski@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 4:09 AM, Amadeusz Sławiński wrote:
> Currently when we remove and reload driver we use previous ref_count
> value to start iterating over skl->modules which leads to out of table
> access. To fix this just inline the function and calculate indexes
> everytime we parse UUID token.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/skylake/skl-topology.c | 34 +++++++++-----------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 118866cd5075..c1c37ce759bd 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3333,25 +3333,6 @@ static int skl_tplg_get_int_tkn(struct device *dev,
>   	return tkn_count;
>   }
>   
> -static int skl_tplg_get_manifest_uuid(struct device *dev,
> -				struct skl_dev *skl,
> -				struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
> -{
> -	static int ref_count;
> -	struct skl_module *mod;
> -
> -	if (uuid_tkn->token == SKL_TKN_UUID) {
> -		mod = skl->modules[ref_count];
> -		guid_copy(&mod->uuid, (guid_t *)&uuid_tkn->uuid);
> -		ref_count++;
> -	} else {
> -		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * Fill the manifest structure by parsing the tokens based on the
>    * type.
> @@ -3362,6 +3343,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
>   {
>   	int tkn_count = 0, ret;
>   	int off = 0, tuple_size = 0;
> +	u8 uuid_index = 0;
>   	struct snd_soc_tplg_vendor_array *array;
>   	struct snd_soc_tplg_vendor_value_elem *tkn_elem;
>   
> @@ -3384,9 +3366,17 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
>   			continue;
>   
>   		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
> -			ret = skl_tplg_get_manifest_uuid(dev, skl, array->uuid);
> -			if (ret < 0)
> -				return ret;
> +			if (array->uuid->token != SKL_TKN_UUID) {
> +				dev_err(dev, "Not an UUID token: %d\n",
> +					array->uuid->token);
> +				return -EINVAL;
> +			}
> +			if (uuid_index >= skl->nr_modules) {
> +				dev_err(dev, "Too many UUID tokens\n");
> +				return -EINVAL;
> +			}
> +			guid_copy(&skl->modules[uuid_index++]->uuid,
> +				  (guid_t *)&array->uuid->uuid);
>   
>   			tuple_size += sizeof(*array->uuid);
>   			continue;
> 
