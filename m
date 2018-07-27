From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Fri, 27 Jul 2018 10:09:08 -0500
Message-ID: <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

On 7/27/18 5:13 AM, Akshu Agrawal wrote:
> There are cases where a pointer function populates
> runtime->delay, such as:
> ./sound/pci/hda/hda_controller.c
> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
> 
> Also, in some cases cpu dai used is generic and the pcm
> driver needs to set delay.
> 
> This delay was getting lost and was overwritten by delays
> from codec or cpu dai delay function if exposed.

Humm, yes the runtime->delay set in the .pointer function would be lost 
without this change, but the delay would still be provided in the 
followup call to .delay.
With your change, the same delay will be accounted for twice?

> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>   sound/soc/soc-pcm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 98be04b..b1a2bc2 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>   	snd_pcm_sframes_t codec_delay = 0;
>   	int i;
>   
> +	/* clearing the previous delay */
> +	runtime->delay = 0;
> +
>   	for_each_rtdcom(rtd, rtdcom) {
>   		component = rtdcom->component;
>   
> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>   	}
>   	delay += codec_delay;
>   
> -	runtime->delay = delay;
> +	runtime->delay += delay;
>   
>   	return offset;
>   }
> 
