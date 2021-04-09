Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CADC433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:23:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E16611CA
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E16611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 655661616;
	Fri,  9 Apr 2021 18:22:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 655661616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617985424;
	bh=jPtwCdjas7UcgJa3S63Vm71N+Er87zCsoCvLPFklp+M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uijtxm0vFRVqadw1NqCRRKt87J/75dY5FWbpJ+/Bi/2sGBITdtJHZ5TQDs/eSbV4i
	 QO4swSgmkBhWDVdrQwlMQPbWlN9vtjQ9djVD1VM+heUYFqYxAl2K6UO9fK69A8mob0
	 mbixxJnJJX3j26/Vd3xwFi0mxc36olyoa4PD8TVI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2FEFF80168;
	Fri,  9 Apr 2021 18:22:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9189CF80113; Fri,  9 Apr 2021 18:22:51 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DD7DF80113
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 18:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DD7DF80113
IronPort-SDR: GB/MPn5VOixWqsPvN/zV2Tdm8Pyu7fURSp3fc6WVfwgNB+dF0pasjP7zrfsFcEXRKc4rv2IzoH
 UP8Rljq3YagQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="173272829"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; d="scan'208";a="173272829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 09:22:32 -0700
IronPort-SDR: VaQNFTTlcncnSAeVCU4i7GQ4isH2oSsQWCJ8+4m2g35L4aaY6wP5VRPb3AEEXzkj49/rHGB66D
 F0UWNVjupBwA==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; d="scan'208";a="380705479"
Received: from ravikira-mobl1.amr.corp.intel.com (HELO [10.212.11.141])
 ([10.212.11.141])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 09:22:31 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: remove useless variable
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, cezary.rojewski@intel.com
References: <1617948506-84638-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ec10b000-34da-b4e8-8fa4-abb366557646@linux.intel.com>
Date: Fri, 9 Apr 2021 10:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1617948506-84638-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 yang.jie@linux.intel.com, tiwai@suse.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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



On 4/9/21 1:08 AM, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> sound/soc/intel/boards/bytcr_wm5102.c:216:40: warning:
> ‘byt_wm5102_dai_params’ defined but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks for the patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_wm5102.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index f38850e..fd584e3 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -213,14 +213,6 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
>   	return 0;
>   }
>   
> -static const struct snd_soc_pcm_stream byt_wm5102_dai_params = {
> -	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> -	.rate_min = 48000,
> -	.rate_max = 48000,
> -	.channels_min = 2,
> -	.channels_max = 2,
> -};
> -
>   static int byt_wm5102_codec_fixup(struct snd_soc_pcm_runtime *rtd,
>   				  struct snd_pcm_hw_params *params)
>   {
> 
