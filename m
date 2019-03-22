From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_free_kcontrol
Date: Fri, 22 Mar 2019 09:43:39 -0500
Message-ID: <44b4ca5a-c76b-e2ae-0f57-294198a37b25@linux.intel.com>
References: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 3/22/19 7:30 AM, Pankaj Bharadiya wrote:
> w_text_param can be NULL and it is being dereferenced without checking.
> Add the missing sanity check to prevent  NULL pointer dereference.
> 
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> ---
>   sound/soc/soc-dapm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 1ec06ef..67b032c 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3957,6 +3957,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
>   	int count;
>   
>   	devm_kfree(card->dev, (void *)*private_value);
> +
> +	if (!w_param_text)
> +		return;

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

next time, try using git format-patch -v2 to signal it's an updated 
version, it helps reviewers. Thanks!

> +
>   	for (count = 0 ; count < num_params; count++)
>   		devm_kfree(card->dev, (void *)w_param_text[count]);
>   	devm_kfree(card->dev, w_param_text);
> 
