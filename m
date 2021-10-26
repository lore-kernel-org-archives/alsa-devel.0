Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B92C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 17:36:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E2B604AC
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 17:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37E2B604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9C0A16E4;
	Tue, 26 Oct 2021 19:35:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9C0A16E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635269805;
	bh=8G90VkeaDPiAGI2EVghzZlWYOMng4YH/GgZS4T6pWd8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVZ0mPC30yXoYK9SwjEug/LeEabSO1rGacNqvb1akiRwpf+MFxA54ZGIPkvmLRQDy
	 K6c8HXbrE4aDfoWq6ELKfKoXVQaTX749nAYt1MII7SpRhNQaktneaR9FkPo1Md+I8J
	 Tsb3mD54oXCj7foKbjVsQyKn5xA/Tic3wLhKh3rs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A378F80269;
	Tue, 26 Oct 2021 19:35:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2E0AF802C8; Tue, 26 Oct 2021 19:35:53 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9383EF8010A
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 19:35:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9383EF8010A
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210054410"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="210054410"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 10:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="494313830"
Received: from irmercad-mobl.amr.corp.intel.com (HELO [10.212.65.151])
 ([10.212.65.151])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 10:35:36 -0700
Subject: Re: [PATCH 1/3] ASoC: nau8825: add set_jack coponment support
To: David Lin <CTLIN0@nuvoton.com>, broonie@kernel.org
References: <20211026093828.4188145-1-CTLIN0@nuvoton.com>
 <20211026093828.4188145-2-CTLIN0@nuvoton.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55937591-e1f1-9f1e-2355-e7680026f05d@linux.intel.com>
Date: Tue, 26 Oct 2021 12:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026093828.4188145-2-CTLIN0@nuvoton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com,
 mac.chiang@intel.com
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



On 10/26/21 4:38 AM, David Lin wrote:
> Use set_jack ops to set jack for new machine drivers. Meanwhile,
> the old machine drivers can still call previous export function
> "nau8825_enable_jack_detect".
> 
> Co-Developed-by: Mac Chiang <mac.chiang@intel.com>

if you use the Co-developed-by: tag (no capital letter after 'C'), you
still need to provide your Signed-off-by: tag

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

same comment for the 2 other patches in this series.

> Signed-off-by: David Lin <CTLIN0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 67de0e49ccf4..c845f19b7c41 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -2416,6 +2416,12 @@ static int __maybe_unused nau8825_resume(struct snd_soc_component *component)
>  	return 0;
>  }
>  
> +static int nau8825_set_jack(struct snd_soc_component *component,
> +			    struct snd_soc_jack *jack, void *data)
> +{
> +	return nau8825_enable_jack_detect(component, jack);
> +}
> +
>  static const struct snd_soc_component_driver nau8825_component_driver = {
>  	.probe			= nau8825_component_probe,
>  	.remove			= nau8825_component_remove,
> @@ -2430,6 +2436,7 @@ static const struct snd_soc_component_driver nau8825_component_driver = {
>  	.num_dapm_widgets	= ARRAY_SIZE(nau8825_dapm_widgets),
>  	.dapm_routes		= nau8825_dapm_routes,
>  	.num_dapm_routes	= ARRAY_SIZE(nau8825_dapm_routes),
> +	.set_jack		= nau8825_set_jack,
>  	.suspend_bias_off	= 1,
>  	.idle_bias_on		= 1,
>  	.use_pmdown_time	= 1,
> 
