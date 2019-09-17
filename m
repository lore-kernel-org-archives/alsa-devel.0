Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B83C4CECD
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:34:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2219214AF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MdEVzAyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2219214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19C101660;
	Tue, 17 Sep 2019 16:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19C101660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568730872;
	bh=3k9TeKO++IQ317DVXW6ps15OApryWGZYMRh+CHx8+B8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MdEVzAyXn+WuHo84EuLlzWfJXxL00hi/vDbNjBeqowoBNnjjjjyUTsOBGR2R+a2Xh
	 AYWyLhOoB5yNOR2M9sDJMV1eU/IG+e3mAM0B5eW/Dj7DhE1GQSYj3ty/baDm2M8PcK
	 9wT04EPGDuX/k/7EKShg/SIHpefPjex8i1f+3fZw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B09BCF80307;
	Tue, 17 Sep 2019 16:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B12B8F801DA; Tue, 17 Sep 2019 16:33:40 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0483F801DA
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 16:33:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0483F801DA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 07:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; d="scan'208";a="211513163"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2019 07:33:23 -0700
Received: from pbossart-mac01.local (unknown [10.251.11.91])
 by linux.intel.com (Postfix) with ESMTP id 35E61580258;
 Tue, 17 Sep 2019 07:33:23 -0700 (PDT)
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org,
 tiwai@suse.de
References: <20190916210353.6318-1-yung-chuan.liao@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb36ffa8-2d8c-6077-82f3-e8bb505399b7@linux.intel.com>
Date: Tue, 17 Sep 2019 09:33:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916210353.6318-1-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 bard.liao@intel.com
Subject: Re: [alsa-devel] [PATCH] ASoC: core: delete component->card_list in
 soc_remove_component only
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 9/16/19 4:03 PM, Bard liao wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> We add component->card_list in the end of soc_probe_component(). In
> other words, component->card_list will not be added if there is an
> error in the soc_probe_component() function. So we can't delete
> component->card_list in the error handling of soc_probe_component().
> 
> Fixes: 22d1423187e5 ("ASoC: soc-core: add soc_cleanup_component()")
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I wish we had a way to do this on the SOF GitHub, it's painful that 
prior reviews and approvals are not tracked automagically.


> ---
>   sound/soc/soc-core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 35f48e9c5ead..aff4b4bf4d07 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -978,7 +978,6 @@ static void soc_cleanup_component(struct snd_soc_component *component)
>   	/* For framework level robustness */
>   	snd_soc_component_set_jack(component, NULL, NULL);
>   
> -	list_del(&component->card_list);
>   	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
>   	soc_cleanup_component_debugfs(component);
>   	component->card = NULL;
> @@ -991,7 +990,7 @@ static void soc_remove_component(struct snd_soc_component *component)
>   		return;
>   
>   	snd_soc_component_remove(component);
> -
> +	list_del(&component->card_list);
>   	soc_cleanup_component(component);
>   }
>   
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
