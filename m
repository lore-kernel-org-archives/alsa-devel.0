From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
Date: Mon, 15 Apr 2019 14:35:17 -0500
Message-ID: <52a533e5-f106-db5f-35f7-2dd85672f541@embeddedor.com>
References: <20190326183202.GA17285@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326183202.GA17285@embeddedor>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Friendly ping:

Who can take this?

Thanks
--
Gustavo

On 3/26/19 1:32 PM, Gustavo A. R. Silva wrote:
> header->number and i are indirectly controlled by user-space, hence leading
> to a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> sound/isa/wavefront/wavefront_synth.c:792 wavefront_send_patch() warn: potential spectre issue 'dev->patch_status' [w] (local cap)
> sound/isa/wavefront/wavefront_synth.c:819 wavefront_send_program() warn: potential spectre issue 'dev->prog_status' [w] (local cap)
> sound/isa/wavefront/wavefront_synth.c:1197 wavefront_send_alias() warn: potential spectre issue 'dev->sample_status' [w]
> sound/isa/wavefront/wavefront_synth.c:1248 wavefront_send_multisample() warn: potential spectre issue 'dev->sample_status' [w]
> sound/isa/wavefront/wavefront_synth.c:1548 wavefront_synth_control() warn: potential spectre issue 'dev->sample_status' [r] (local cap)
> 
> Fix this by sanitizing header->number and i before using them to index
> dev->patch_status, dev->prog_status, dev->sample_status.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  sound/isa/wavefront/wavefront_synth.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
> index 0b1e4b34b299..a78e125dfdf9 100644
> --- a/sound/isa/wavefront/wavefront_synth.c
> +++ b/sound/isa/wavefront/wavefront_synth.c
> @@ -31,6 +31,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <sound/core.h>
>  #include <sound/snd_wavefront.h>
>  #include <sound/initval.h>
> @@ -788,6 +789,8 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
>  
>  	if (header->number >= ARRAY_SIZE(dev->patch_status))
>  		return -EINVAL;
> +	header->number = array_index_nospec(header->number,
> +					    ARRAY_SIZE(dev->patch_status));
>  
>  	dev->patch_status[header->number] |= WF_SLOT_FILLED;
>  
> @@ -815,6 +818,8 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
>  
>  	if (header->number >= ARRAY_SIZE(dev->prog_status))
>  		return -EINVAL;
> +	header->number = array_index_nospec(header->number,
> +					    ARRAY_SIZE(dev->prog_status));
>  
>  	dev->prog_status[header->number] = WF_SLOT_USED;
>  
> @@ -1194,6 +1199,11 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
>  		return -EIO;
>  	}
>  
> +	if (header->number >= ARRAY_SIZE(dev->sample_status))
> +		return -EINVAL;
> +	header->number = array_index_nospec(header->number,
> +					    ARRAY_SIZE(dev->sample_status));
> +
>  	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_ALIAS);
>  
>  	return (0);
> @@ -1245,6 +1255,12 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
>  		return -EIO;
>  	}
>  
> +	if (header->number >= ARRAY_SIZE(dev->sample_status)) {
> +		kfree(msample_hdr);
> +		return -EINVAL;
> +	}
> +	header->number = array_index_nospec(header->number,
> +					    ARRAY_SIZE(dev->sample_status));
>  	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_MULTISAMPLE);
>  
>  	kfree(msample_hdr);
> @@ -1545,6 +1561,7 @@ wavefront_synth_control (snd_wavefront_card_t *acard,
>  			wc->status = EINVAL;
>  			return -EINVAL;
>  		}
> +		i = array_index_nospec(i, WF_MAX_SAMPLE);
>  		wc->rbuf[0] = dev->sample_status[i];
>  		wc->status = 0;
>  		return 0;
> 
