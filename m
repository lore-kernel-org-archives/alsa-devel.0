Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4179C10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:52:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C7620724
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g3+D3w5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C7620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CD3716F2;
	Tue, 17 Mar 2020 15:51:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CD3716F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584456739;
	bh=H2FIh7V6ls53yOmkttHk73tuwoPbceMq3jxqxybGx44=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3+D3w5XgQXJcoAtEJyArXShbGoz2Pi1TJiGBVezXJkN/w/kGkq/0UJPufvnpV95h
	 dxTH5vpft3uQ/Zz7sXBAt7QVD9esWWN0DAIpcXrlwmo4yJLzK7NlnKURHJIa128Ija
	 rrcI1hQZyel7Cwcb23gEQprxgBm3pVd3Lyk1U0z4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 177C9F80058;
	Tue, 17 Mar 2020 15:51:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EA98F80232; Tue, 17 Mar 2020 15:51:26 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC3ADF800C0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 15:51:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC3ADF800C0
IronPort-SDR: 50DPN60ond7gaS68VFpt6ryKdWWdYhRWWireK8quDNU5+OgJ+6mWNUsDKCtFNDAbYkIJoi9Ukk
 NcQbtljSZ7fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 07:51:20 -0700
IronPort-SDR: 3bDhTrTyDC5wJrlBx4sXHoDNrLBiFCiqxYUjfPga8x6BEmvK5pFafzX3g1fV3thMvtumwmA0ie
 salfbJsk/DBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; d="scan'208";a="247842488"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148])
 ([10.255.35.148])
 by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 07:51:19 -0700
Subject: Re: [PATCH 1/6] ASoC: soc-core: Merge CPU/Codec DAIs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87y2s0olg6.wl-kuninori.morimoto.gx@renesas.com>
 <87wo7kolfa.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <57284491-aaa4-6b8f-184b-2219b6c3572c@linux.intel.com>
Date: Tue, 17 Mar 2020 09:40:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87wo7kolfa.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 4e0f55555e37..511f6b0cb2e0 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -475,22 +475,22 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
>   	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
>   
>   	/*
> -	 * for rtd->codec_dais
> +	 * for rtd->dais
>   	 */
> -	rtd->codec_dais = devm_kcalloc(dev, dai_link->num_codecs,
> +	rtd->dais = devm_kcalloc(dev, dai_link->num_cpus + dai_link->num_codecs,
>   					sizeof(struct snd_soc_dai *),
>   					GFP_KERNEL);

nit-pick: alignment?
