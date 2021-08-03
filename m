Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C3C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 09:47:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B16D60F92
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 09:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B16D60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04FCD16FC;
	Tue,  3 Aug 2021 11:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04FCD16FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627984064;
	bh=q0G5yavVXIJ42De8DLkeuFG8rONqzaKnCU6UsZxOgm4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qe+Mxt9XV4EFykFlJPNlcvyFsKxrQ7UwMBpUbjEGhZdwi8bFyX18hfuHl/RGZrIjV
	 av7OzoJWu133uinqt3VZwChZMDy9Huj+ASms6MvAoYhYvhJEW7p/O4gaASTd4AYBZz
	 M8mpgNjAkU0/3SS3kmDdemx3fJxpUh6S+VAEd1Uw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EF22F8016D;
	Tue,  3 Aug 2021 11:46:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E69EFF802E8; Tue,  3 Aug 2021 11:46:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F69AF8014D
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 11:46:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F69AF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ekvzSotG"
Received: by mail-wm1-x32b.google.com with SMTP id
 e25-20020a05600c4b99b0290253418ba0fbso1739377wmp.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2021 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N654bATf0Rp/EECcLTy4gDSnhGedp2XduVMbEXVlJds=;
 b=ekvzSotG4xKe7IuA4N/lB1POu1koo3sumWoy5KoQ6CHrjIEaABopurzqFn69xZE/OD
 eSa3Q5nryIc30DB3u7AvtQa7zEiHgqdHRdTcU/bBRc/CWmiPgOt/uFiAAe4pz0lhlGvS
 b9xizRkjiRWtub+M6lZD3IlmU0uBrf1/0tgOdVW2Nwq/rtYDVV63cwf56A4BySS50ceZ
 ECqD8Ap4vcY79E4OKQnPOBDh9ZLLiSTtENnLj153fBx2YgKdnPATF3QQfGc9RbboAY98
 CtaqNkjhzhY92yEGgWXmUXshKtE1kxla2omLQcEbpyaKWvhkJk5n1Q8+jzmB0CTmtU1X
 KpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N654bATf0Rp/EECcLTy4gDSnhGedp2XduVMbEXVlJds=;
 b=NkRKCE4qIzRX3z/guCv/ZY/UOpzuLq7tkvewbdMCiYPe96rdQNo9i3xDSb2Xp+pPOo
 44WbkZrW9XZR1EofSGdYc2J2YqrVH5vegrlsx2i6rMeqFM8ED2EcxT4xL39d04bViRyX
 nuT5WDGCTHKOi4G1UrfywoTpAhB70bbVnAIpd3++wjA5WbCEHCF9DEiFYioZcsBrqyBu
 5le/U8y/+HXfnxlmivA9NKQmF1WNqntgRbD6PAN6TmuP3kRGJ2n1Z4H0w+fNBqrbmfIm
 y0NK/P732QClpAtwc/EU0fhbqjif7z1QbhTaUMIOQlRx16N9WUpuR9BCK9I3XU8DNs9h
 SJ8g==
X-Gm-Message-State: AOAM5300BuUj08/PxIfnWc0NKwfHzg7/WNS2xzmvQrZ/bOcXy1E7ssCf
 trIgVH+pz6uZJyQ3woi/rezMRw==
X-Google-Smtp-Source: ABdhPJysFQSt0Wz1kiE2wqikObhUpEQ6lRgdMQQtBiOlXb0s0AkcjbJj9RDx/W1CwHt4wjkpn/LgDw==
X-Received: by 2002:a05:600c:293:: with SMTP id
 19mr20767117wmk.179.1627984002645; 
 Tue, 03 Aug 2021 02:46:42 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id q7sm12725310wmq.33.2021.08.03.02.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 02:46:42 -0700 (PDT)
Subject: Re: [PATCH 14/15] ASoC: qcom: qdsp6: Use managed buffer allocation
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20210802072815.13551-1-tiwai@suse.de>
 <20210802072815.13551-15-tiwai@suse.de>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0857baf8-733b-beab-5dbc-7e5045b441c4@linaro.org>
Date: Tue, 3 Aug 2021 10:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802072815.13551-15-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 02/08/2021 08:28, Takashi Iwai wrote:
> This patch simplifies the buffer pre-allocation code of qcom qdsp6
> driver with the standard managed buffer helper.  It uses the newly
> introduced fixed-size buffer allocation helper.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested this on DragonBoard DB845c with WSA Playback

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 63 ++------------------------------
>   1 file changed, 3 insertions(+), 60 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 5ff56a735419..46f365528d50 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -429,8 +429,6 @@ static int q6asm_dai_open(struct snd_soc_component *component,
>   	else
>   		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
>   
> -	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> -
>   	return 0;
>   }
>   
> @@ -470,18 +468,6 @@ static snd_pcm_uframes_t q6asm_dai_pointer(struct snd_soc_component *component,
>   	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
>   }
>   
> -static int q6asm_dai_mmap(struct snd_soc_component *component,
> -			  struct snd_pcm_substream *substream,
> -			  struct vm_area_struct *vma)
> -{
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> -	struct device *dev = component->dev;
> -
> -	return dma_mmap_coherent(dev, vma,
> -			runtime->dma_area, runtime->dma_addr,
> -			runtime->dma_bytes);
> -}
> -
>   static int q6asm_dai_hw_params(struct snd_soc_component *component,
>   			       struct snd_pcm_substream *substream,
>   			       struct snd_pcm_hw_params *params)
> @@ -1185,52 +1171,11 @@ static const struct snd_compress_ops q6asm_dai_compress_ops = {
>   static int q6asm_dai_pcm_new(struct snd_soc_component *component,
>   			     struct snd_soc_pcm_runtime *rtd)
>   {
> -	struct snd_pcm_substream *psubstream, *csubstream;
>   	struct snd_pcm *pcm = rtd->pcm;
> -	struct device *dev;
> -	int size, ret;
> -
> -	dev = component->dev;
> -	size = q6asm_dai_hardware_playback.buffer_bytes_max;
> -	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> -	if (psubstream) {
> -		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> -					  &psubstream->dma_buffer);
> -		if (ret) {
> -			dev_err(dev, "Cannot allocate buffer(s)\n");
> -			return ret;
> -		}
> -	}
> +	size_t size = q6asm_dai_hardware_playback.buffer_bytes_max;
>   
> -	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
> -	if (csubstream) {
> -		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> -					  &csubstream->dma_buffer);
> -		if (ret) {
> -			dev_err(dev, "Cannot allocate buffer(s)\n");
> -			if (psubstream)
> -				snd_dma_free_pages(&psubstream->dma_buffer);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void q6asm_dai_pcm_free(struct snd_soc_component *component,
> -			       struct snd_pcm *pcm)
> -{
> -	struct snd_pcm_substream *substream;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
> -		substream = pcm->streams[i].substream;
> -		if (substream) {
> -			snd_dma_free_pages(&substream->dma_buffer);
> -			substream->dma_buffer.area = NULL;
> -			substream->dma_buffer.addr = 0;
> -		}
> -	}
> +	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
> +					    component->dev, size);
>   }
>   
>   static const struct snd_soc_dapm_widget q6asm_dapm_widgets[] = {
> @@ -1260,9 +1205,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
>   	.prepare	= q6asm_dai_prepare,
>   	.trigger	= q6asm_dai_trigger,
>   	.pointer	= q6asm_dai_pointer,
> -	.mmap		= q6asm_dai_mmap,
>   	.pcm_construct	= q6asm_dai_pcm_new,
> -	.pcm_destruct	= q6asm_dai_pcm_free,
>   	.compress_ops	= &q6asm_dai_compress_ops,
>   	.dapm_widgets	= q6asm_dapm_widgets,
>   	.num_dapm_widgets = ARRAY_SIZE(q6asm_dapm_widgets),
> 
