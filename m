Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FEC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:36:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DAD207DA
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L8EdLoTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DAD207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99BA984D;
	Thu, 13 Aug 2020 16:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99BA984D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597329409;
	bh=v/T/I2MsTmE0JZ8ExeoTxecY+tJiFDaQqlxYSoadNWo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8EdLoTtHFjxzB1Hl1hO3VKcRvfOGUpx9aCR3J9jlan0ejW7Du/W9qaQri8imoxM/
	 G0vzswhic/8cjfKE0SOn0aXa5OOvsxvgCjVaOaHgJttqeSuem89eR98+FC5ZOuy/Zf
	 MSi3vPGQeLNI4hlU9YvoOwOnhlrbB+2WwWOWsMqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A92AF8014C;
	Thu, 13 Aug 2020 16:35:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F21DEF8015B; Thu, 13 Aug 2020 16:35:56 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0970BF800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 16:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0970BF800D3
IronPort-SDR: H1cqPAF6iFS1VPl0T3do9QAxBlVOFwEObghQBFv3XQb3aZTF0z0Dhg9w/SqvG3A8JmsmKfLIBw
 90ousNWt3ymg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="155348768"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; d="scan'208";a="155348768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 07:35:46 -0700
IronPort-SDR: sMiil9/2RLXm+J/PBnbkqew4A0wxJWaabcQ5kuwmyetPUk8ahLy6nNScw6BTLVFsiOXCl8bXIq
 4rEu3Nfby4cg==
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; d="scan'208";a="333124546"
Received: from jsdraege-mobl1.amr.corp.intel.com (HELO [10.209.128.166])
 ([10.209.128.166])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 07:35:45 -0700
Subject: Re: [PATCH] [v2] ASoC: intel: Fix memleak in sst_media_open
To: Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
References: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0add5326-d182-c456-0f8b-1d70bb67a2fc@linux.intel.com>
Date: Thu, 13 Aug 2020 07:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org,
 "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
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



On 8/13/20 3:41 AM, Dinghao Liu wrote:
> When power_up_sst() fails, stream needs to be freed
> just like when try_module_get() fails. However, current
> code is returning directly and ends up leaking memory.
> 
> Fixes: 0121327c1a68b ("ASoC: Intel: mfld-pcm: add control for powering up/down dsp")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for spotting this!

> ---
> 
> Changelog:
> 
> v2: - Add a new label 'out_power_up' to unify code style.
> ---
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 49b9f18472bc..b1cac7abdc0a 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -331,7 +331,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>   
>   	ret_val = power_up_sst(stream);
>   	if (ret_val < 0)
> -		return ret_val;
> +		goto out_power_up;
>   
>   	/* Make sure, that the period size is always even */
>   	snd_pcm_hw_constraint_step(substream->runtime, 0,
> @@ -340,8 +340,9 @@ static int sst_media_open(struct snd_pcm_substream *substream,
>   	return snd_pcm_hw_constraint_integer(runtime,
>   			 SNDRV_PCM_HW_PARAM_PERIODS);
>   out_ops:
> -	kfree(stream);
>   	mutex_unlock(&sst_lock);
> +out_power_up:
> +	kfree(stream);
>   	return ret_val;
>   }
>   
> 
