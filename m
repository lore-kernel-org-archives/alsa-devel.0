From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
 UUID API
Date: Wed, 19 Jun 2019 17:46:34 +0200
Message-ID: <a987bd54-5364-f046-a928-44a97ed0307f@linux.intel.com>
References: <20190619150213.87691-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94953F80C87
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 17:46:40 +0200 (CEST)
In-Reply-To: <20190619150213.87691-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/19/19 5:02 PM, Andy Shevchenko wrote:
> Switch the driver to use modern UUID API, i.e. guid_t type and
> accompanying functions, such as guid_equal().
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me - couple of nit-picks below on unrelated indentation 
changes.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> @@ -247,7 +241,6 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>   	struct adsp_fw_hdr *adsp_hdr;
>   	struct adsp_module_entry *mod_entry;
>   	int i, num_entry, size;
> -	uuid_le *uuid_bin;
>   	const char *buf;
>   	struct skl_sst *skl = ctx->thread_context;
>   	struct uuid_module *module;
> @@ -279,8 +272,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>   		return -EINVAL;
>   	}
>   
> -	mod_entry = (struct adsp_module_entry *)
> -		(buf + offset + adsp_hdr->len);
> +	mod_entry = (struct adsp_module_entry *)(buf + offset + adsp_hdr->len);

this really has nothing to do with the guid change, could be a separate 
patch in a perfect world.

> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 5951bbdf1f1a..13c636dece56 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -420,11 +420,9 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
>   	struct skl_module_table *module_entry = NULL;
>   	int ret = 0;
>   	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
> -	uuid_le *uuid_mod;
>   
> -	uuid_mod = (uuid_le *)guid;
>   	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
> -				"intel/dsp_fw_", uuid_mod, ".bin");
> +					     "intel/dsp_fw_", guid, ".bin");

indentation looks off, not sure if this is a diff effect.
