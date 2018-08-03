From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: bxt: Use refcap device for
 mono recording
Date: Thu, 2 Aug 2018 22:08:55 -0700
Message-ID: <24fa2f1b-c2f9-2739-2970-e35de5b02a35@linux.intel.com>
References: <1533143039-5428-1-git-send-email-yong.zhi@intel.com>
 <1533252091-31918-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF0A2677D8
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 07:08:58 +0200 (CEST)
In-Reply-To: <1533252091-31918-1-git-send-email-yong.zhi@intel.com>
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
To: Yong Zhi <yong.zhi@intel.com>, broonie@kernel.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org, jenny.tc@intel.com
List-Id: alsa-devel@alsa-project.org

On 8/2/18 4:21 PM, Yong Zhi wrote:
> The refcap capture device supports mono recording only, this patch
> adds the channel constraints.
> 
> Signed-off-by: Yong Zhi <yong.zhi@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> Changes since v1:
> - Remove renaming of "Refcap".
> - Add Reviewed-by tag.

LGTM, thanks.

> 
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index be6e4b40bf03..6f052fc8d1e2 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -324,8 +324,22 @@ static const struct snd_pcm_hw_constraint_list constraints_16000 = {
>   	.list  = rates_16000,
>   };
>   
> +static const unsigned int ch_mono[] = {
> +	1,
> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_refcap = {
> +	.count = ARRAY_SIZE(ch_mono),
> +	.list  = ch_mono,
> +};
> +
>   static int broxton_refcap_startup(struct snd_pcm_substream *substream)
>   {
> +	substream->runtime->hw.channels_max = 1;
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_CHANNELS,
> +				   &constraints_refcap);
> +
>   	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>   			SNDRV_PCM_HW_PARAM_RATE,
>   			&constraints_16000);
> 
