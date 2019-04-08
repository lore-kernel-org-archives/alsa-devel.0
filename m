From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl: fix wrong number of
 channels
Date: Mon, 8 Apr 2019 08:03:59 -0500
Message-ID: <61ad5ab7-ffa9-c22b-6152-0c6908a13d29@linux.intel.com>
References: <20190408090858.261269-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7573AF89618
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 15:04:02 +0200 (CEST)
In-Reply-To: <20190408090858.261269-1-tzungbi@google.com>
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
To: Tzung-Bi Shih <tzungbi@google.com>, broonie@kernel.org
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org



On 4/8/19 4:08 AM, Tzung-Bi Shih wrote:
> Fix wrong setting on number of channels.  The context wants to set
> constraint to 2 channels instead of 4.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 7044d8c2b187..879f14257a3e 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -405,7 +405,7 @@ static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
>   };
>   
>   static const unsigned int dmic_2ch[] = {
> -	4,
> +	2,
>   };
>   
>   static const struct snd_pcm_hw_constraint_list constraints_dmic_2ch = {
> 
