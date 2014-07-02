From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4] ALSA: pcm_dmaengine: Use the available wrapper to
 get physical width
Date: Wed, 02 Jul 2014 13:46:46 +0200
Message-ID: <53B3F126.5060709@metafoo.de>
References: <1404300570-14082-1-git-send-email-peter.ujfalusi@ti.com> <1404300570-14082-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404300570-14082-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, dan.j.williams@intel.com, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/02/2014 01:29 PM, Peter Ujfalusi wrote:
> params_physical_width() is available via pcm_params.h
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   sound/core/pcm_dmaengine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 76cbb9ec953a..d5611ec80381 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -65,7 +65,7 @@ int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
>   	enum dma_slave_buswidth buswidth;
>   	int bits;
>
> -	bits = snd_pcm_format_physical_width(params_format(params));
> +	bits = params_physical_width(params);
>   	if (bits < 8 || bits > 64)
>   		return -EINVAL;
>   	else if (bits == 8)
>
