From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Re: [PATCH 4/5] ASoC: sst_platform: fix the
	pulseaudio	error
Date: Tue, 15 Feb 2011 14:46:41 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F4703CC4477@irsmsx501.ger.corp.intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
	<1297774735-32184-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 93DEC1037FC
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 15:46:48 +0100 (CET)
In-Reply-To: <1297774735-32184-5-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Harsha,
	Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

> 
> +static int sst_platform_pcm_hw_params(struct snd_pcm_substream
> *substream,
> +		struct snd_pcm_hw_params *params)
> +{
> +	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> +	memset(substream->runtime->dma_area, 0,
> params_buffer_bytes(params));
> +
> +	return 0;
> +}
> 
>  static struct snd_pcm_ops sst_platform_ops = {
>  	.open = sst_platform_open,
> @@ -373,6 +381,7 @@ static struct snd_pcm_ops sst_platform_ops = {
>  	.prepare = sst_platform_pcm_prepare,
>  	.trigger = sst_platform_pcm_trigger,
>  	.pointer = sst_platform_pcm_pointer,
> +	.hw_params = sst_platform_pcm_hw_params,
>  };

Hi Vinod,

The sst_soc_platform_drv provides also .pcm_new callback which pre-allocates 
the DMA memory for the PCM Streams. Is the pcm_new callback required?

Selma.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
