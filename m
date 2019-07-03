From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 30/30] sound/soc: Use kmemdup rather than duplicating its
 implementation
Date: Wed, 3 Jul 2019 14:55:03 +0100
Message-ID: <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
References: <20190703131842.26082-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703131842.26082-1-huangfq.daxian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/07/19 14:18, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   sound/soc/codecs/wm0010.c             | 4 +---
>   sound/soc/intel/atom/sst/sst_loader.c | 3 +--

Should be one patch per file as the drivers are not related to each
other at all, and if one needed a revert you couldn't revert this
patch because it would revert both drivers.

But apart from that, for wm0010.c:
Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>

>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 727d6703c905..807826f30f58 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
>   
>   	/* Copy to local buffer first as vmalloc causes problems for dma */
> -	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
>   	if (!img) {
>   		ret = -ENOMEM;
>   		goto abort2;
> @@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   		goto abort1;
>   	}
>   
> -	memcpy(img, &fw->data[0], fw->size);
> -
>   	spi_message_init(&m);
>   	memset(&t, 0, sizeof(t));
>   	t.rx_buf = out;
> diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
> index ce11c36848c4..cc95af35c060 100644
> --- a/sound/soc/intel/atom/sst/sst_loader.c
> +++ b/sound/soc/intel/atom/sst/sst_loader.c
> @@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_sst_drv *sst,
>   {
>   	int retval = 0;
>   
> -	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
> +	sst->fw_in_mem = kmemdup(fw->data, fw->size, GFP_KERNEL);
>   	if (!sst->fw_in_mem) {
>   		retval = -ENOMEM;
>   		goto end_release;
>   	}
>   	dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
>   	dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
> -	memcpy(sst->fw_in_mem, fw->data, fw->size);
>   	retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
>   	if (retval) {
>   		dev_err(sst->dev, "Failed to parse fw\n");
> 
