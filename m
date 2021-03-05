Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA4C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFCD6508B
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFCD6508B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 986B4178E;
	Fri,  5 Mar 2021 17:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 986B4178E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614960764;
	bh=9WUZQSrGAnaDQSmRpZLyU/6EwQdMBD9wH7FrhJGiqtk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOzu8vvGFAixkNpCtS8Knf1Zyf8iOAuIOrohnlHogZDyMF+nEFfnto6GdA84fwZ6a
	 ay2eP85x/GLFrngtG7dyNxkUAHfspLzKhdlto2fwOcrnUDe7GSud4uqgSf/9LZLybm
	 9F68Rgkecqu8II5cwF6IFavK9Nn1xhoyTiqPWVMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17DB7F80257;
	Fri,  5 Mar 2021 17:11:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 787F2F8025E; Fri,  5 Mar 2021 17:11:52 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A09A2F80121
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 17:11:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A09A2F80121
IronPort-SDR: VYR+5n3Jl9kDkmSDqonB0/xFGfSa/AsgBt0cqPQ++p6TVkRxlqMMPAfIW1j6rvFWT1mIPyBYES
 bt9PhvHJ5LAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="166935414"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="166935414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 08:11:39 -0800
IronPort-SDR: CcyWAX8OoiE2vHWcGTxxeQ5XVC4P8lZ4jG+PalVwFqRTwa3a+OgkdyglT5pPNI9ToYYo5pNTi2
 xFj/yQ8HjdUA==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="408373086"
Received: from unknown (HELO [10.212.58.88]) ([10.212.58.88])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 08:11:38 -0800
Subject: Re: [PATCH 3/8] ASoC: soc-pcm: direct copy at
 snd_soc_set_runtime_hwparams()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87tupqpg9x.wl-kuninori.morimoto.gx@renesas.com>
 <87pn0epg8r.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1993e30a-ea8c-8eba-dbad-8ab17380b2eb@linux.intel.com>
Date: Fri, 5 Mar 2021 10:11:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn0epg8r.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>
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



On 3/4/21 6:59 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_set_runtime_hwparams() is called from each driver
> to initialize hw parameters,
> but coping each parameters one-by-one.
> 
> Current code is not copying all parameters, but no big effect
> if we do it. This patch copies all parameters by simple code.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-pcm.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 60e688b103d8..6f2de27cf18f 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -300,15 +300,8 @@ bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
>   int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
>   	const struct snd_pcm_hardware *hw)
>   {
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> -	runtime->hw.info = hw->info;
> -	runtime->hw.formats = hw->formats;
> -	runtime->hw.period_bytes_min = hw->period_bytes_min;
> -	runtime->hw.period_bytes_max = hw->period_bytes_max;
> -	runtime->hw.periods_min = hw->periods_min;
> -	runtime->hw.periods_max = hw->periods_max;
> -	runtime->hw.buffer_bytes_max = hw->buffer_bytes_max;
> -	runtime->hw.fifo_size = hw->fifo_size;
> +	substream->runtime->hw = *hw;

This dates from commit db2a416556af0 in 2006 :-)

what was specifically excluded is the information on rates and channels.

Liam, any memories if this was intentional?
