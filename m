From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] sound: atom: fix a missing check of
 snd_pcm_lib_malloc_pages
Date: Wed, 26 Dec 2018 11:57:47 -0600
Message-ID: <a684ebcb-7b7a-d5b5-8770-f87db0c5a480@linux.intel.com>
References: <20181226022950.71824-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181226022950.71824-1-kjlu@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 12/25/18 8:29 PM, Kangjie Lu wrote:
> snd_pcm_lib_malloc_pages() may fail, so let's check its status and
> return its error code upstream.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index afc559866095..91a2436ce952 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -399,7 +399,13 @@ static int sst_media_hw_params(struct snd_pcm_substream *substream,
>   				struct snd_pcm_hw_params *params,
>   				struct snd_soc_dai *dai)
>   {
> -	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> +	int ret;
> +
> +	ret =
> +		snd_pcm_lib_malloc_pages(substream,
> +				params_buffer_bytes(params));
> +	if (ret)
> +		return ret;
>   	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
>   	return 0;
>   }
