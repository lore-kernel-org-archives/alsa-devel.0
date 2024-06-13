Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62B7C27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:11:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55352E69;
	Thu, 13 Jun 2024 13:11:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55352E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718277083;
	bh=7uq/Fw+OV5n0LPS9W3NvyyAT4Rlpf4BZ9H0W/4B5Evg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mwPsD3UJUWb2asBEqJwHATXq4ASgk/p1YJWJkH6ZQ00LqVAKxvrs9oZP2HD39ajCN
	 u4vpmnowlcGWaET5v0S68K1TVopqSLh0yxi2yuTUepwdXvHX5KtDAJC3nuB6Imiwh5
	 43fWyZM8hl8W8mjZ+JA9axn2oSIC859c8wtY7Hk0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88E7CF8059F; Thu, 13 Jun 2024 13:10:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 167EDF805BD;
	Thu, 13 Jun 2024 13:10:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B23F7F8057A; Thu, 13 Jun 2024 13:10:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F631F800D0
	for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2024 13:10:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F631F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=M8Lrp9TO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718277039; x=1749813039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7uq/Fw+OV5n0LPS9W3NvyyAT4Rlpf4BZ9H0W/4B5Evg=;
  b=M8Lrp9TOFiO/i/pDH6dgHS0EgZ9OoydIMlj2nltk7MI8dwdVGibJf/6r
   KIEWv0TXnA8Ihyg+RSFLzy/9Z5rYBiEUJhETAV3jshyuxlrfJXpgYjKhB
   iPATRD9rfXJFNXYe5Za79w60Wq76WMKq8rLrXPjczWXhcH8DUJ9cmwr6D
   S/7lnd6B8MMj55BwQ/7bfFopHvDGJegFwP5Da3aspLGNbdOhr9pOaAaGj
   nRs0oM1Nsied0R9rDRAcLsvkh5ZJ9cmFvyYHpR3p1ZkJzuG+f8q25Nl0x
   yz5YTfymI4Xl2wEuActUuC+rbxJeYm7wQ39RbwwcemCF+enzRMgBd5lCV
   w==;
X-CSE-ConnectionGUID: qeSEJ8mxTP+twzaGhZG00g==
X-CSE-MsgGUID: h3GmaUwfTUWIKYz2ypOROw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25766211"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000";
   d="scan'208";a="25766211"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 04:10:36 -0700
X-CSE-ConnectionGUID: ErkRo2aIQ/OhwWGzmTLeQg==
X-CSE-MsgGUID: UhJkB7AASbi4PeMY5deyPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000";
   d="scan'208";a="40746649"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.34])
 ([10.245.244.34])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 04:10:35 -0700
Message-ID: <0fdbae0e-e540-4c35-a555-5b2607526115@linux.intel.com>
Date: Thu, 13 Jun 2024 14:11:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: topology: Fix route memory corruption
To: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai
 <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
References: <20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LRPLOIROV7RRS6NX4ZS56JKGZGMZXMVA
X-Message-ID-Hash: LRPLOIROV7RRS6NX4ZS56JKGZGMZXMVA
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LRPLOIROV7RRS6NX4ZS56JKGZGMZXMVA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 13/06/2024 12:01, Amadeusz Sławiński wrote:
> It was reported that recent fix for memory corruption during topology
> load, causes corruption in other cases. Instead of being overeager with
> checking topology, assume that it is properly formatted and just
> duplicate strings.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
> Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/soc-topology.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 0225bc5fc425a..4b166294602fa 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>  			break;
>  		}
>  
> -		route->source = devm_kmemdup(tplg->dev, elem->source,
> -					     min(strlen(elem->source), maxlen),
> -					     GFP_KERNEL);
> -		route->sink = devm_kmemdup(tplg->dev, elem->sink,
> -					   min(strlen(elem->sink), maxlen),
> -					   GFP_KERNEL);
> +		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
> +		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
>  		if (!route->source || !route->sink) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
>  		if (strnlen(elem->control, maxlen) != 0) {
> -			route->control = devm_kmemdup(tplg->dev, elem->control,
> -						      min(strlen(elem->control), maxlen),
> -						      GFP_KERNEL);
> +			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
>  			if (!route->control) {
>  				ret = -ENOMEM;
>  				break;

-- 
Péter
