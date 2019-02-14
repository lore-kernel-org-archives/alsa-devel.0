From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date: Thu, 14 Feb 2019 15:32:38 +0100
Message-ID: <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
        <20190214093747.2414-10-s.nawrocki@samsung.com>
        <20190214130747.GA11988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190214130747.GA11988@sirena.org.uk>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/14/19 14:07, Mark Brown wrote:
> On Thu, Feb 14, 2019 at 10:37:43AM +0100, Sylwester Nawrocki wrote:
> 
>>  	u32 maxburst;
>>  	unsigned int slave_id;
>>  	void *filter_data;
>> -	const char *chan_name;
>>  	unsigned int fifo_size;
>>  	unsigned int flags;
> 
> This fails to build:
> 
>   CC      sound/core/pcm_dmaengine.o
> sound/arm/pxa2xx-pcm-lib.c: In function ‘pxa2xx_pcm_open’:
> sound/arm/pxa2xx-pcm-lib.c:128:22: error: ‘struct snd_dmaengine_dai_dma_data’ has no member named ‘chan_name’
>             dma_params->chan_name));
>                       ^~
> sound/arm/pxa2xx-pcm-lib.c:129:1: warning: control reaches end of non-void function [-Wreturn-type]
>  }
>  ^

Hm, looks like we need still to keep that data structure field, but 
remaining part of the patch could be applied. Do you want me to 
resend it with chan_name removal part dropped?
The $subject patch is optional so we could also skip it and apply remaining
patches so there is no another resend.
