Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2624CC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 08:15:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA75610A2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 08:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BA75610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29D0917A1;
	Mon,  2 Aug 2021 10:14:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29D0917A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627892122;
	bh=1PBlwGj0B0Pt9VZDngw8DEZATUTgrM3sxNTYwIyHoCs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EaDE0o6aaTvFrE4lAAdYxY0CbI5vNL+55yU5BAdtA/EJ0f8B9jLx9saCjRmWTWHTx
	 6iQgGlwzjnqluDSnG3lfHlwoRB9Rnss4/ZRMYaR1H28YTXR/px0XmbPBgA/tiib/sN
	 fjULHVJ+GFPIC2x6zNn4PAL2x9KmRGqrCy1l6nrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD7AFF8025F;
	Mon,  2 Aug 2021 10:14:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87A3BF8025F; Mon,  2 Aug 2021 10:14:30 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24921F8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 10:14:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24921F8014D
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="200613326"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; d="scan'208";a="200613326"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 01:14:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; d="scan'208";a="509972316"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.13.140])
 ([10.213.13.140])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 01:14:15 -0700
Subject: Re: [PATCH 2/5] ASoC: intel: atom: Fix reference to PCM buffer address
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20210728112353.6675-1-tiwai@suse.de>
 <20210728112353.6675-3-tiwai@suse.de>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <558118ee-f581-f4ae-5066-5e67a416666f@intel.com>
Date: Mon, 2 Aug 2021 10:14:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728112353.6675-3-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org
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

On 2021-07-28 1:23 PM, Takashi Iwai wrote:
> PCM buffers might be allocated dynamically when the buffer
> preallocation failed or a larger buffer is requested, and it's not
> guaranteed that substream->dma_buffer points to the actually used
> buffer.  The address should be retrieved from runtime->dma_addr,
> instead of substream->dma_buffer (and shouldn't use virt_to_phys).
> 
> Also, remove the line overriding runtime->dma_area superfluously,
> which was already set up at the PCM buffer allocation.
> 
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 4124aa2fc247..5db2f4865bbb 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -127,7 +127,7 @@ static void sst_fill_alloc_params(struct snd_pcm_substream *substream,
>   	snd_pcm_uframes_t period_size;
>   	ssize_t periodbytes;
>   	ssize_t buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
> -	u32 buffer_addr = virt_to_phys(substream->dma_buffer.area);
> +	u32 buffer_addr = substream->runtime->dma_addr;
>   
>   	channels = substream->runtime->channels;
>   	period_size = substream->runtime->period_size;
> @@ -233,7 +233,6 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
>   	/* set codec params and inform SST driver the same */
>   	sst_fill_pcm_params(substream, &param);
>   	sst_fill_alloc_params(substream, &alloc_params);
> -	substream->runtime->dma_area = substream->dma_buffer.area;
>   	str_params.sparams = param;
>   	str_params.aparams = alloc_params;
>   	str_params.codec = SST_CODEC_TYPE_PCM;
> 

Hello,

Changes look good. Can't verify these due to lack of test vehicles, 
unfortunately.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
