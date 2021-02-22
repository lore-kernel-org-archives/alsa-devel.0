Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C250C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 16:46:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDAB64E2F
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 16:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDAB64E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B69231662;
	Mon, 22 Feb 2021 17:45:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B69231662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614012372;
	bh=DKy8ILl4SqYNKRTyOfaLGP0YUnJEXLOidkcI6dmWons=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+k+/r9dSa6KF5x5rJs6TodmQMqqxGTVdewofeoSZRCAhMVrssuqVje41TH8rwnV8
	 5sVSi6lwa+lboJB9goy7siTJ+CLHRBU4H9KRxW1K1YvW36NDOXnJPW8x+gmqQiDyN2
	 dRfevb/5DQy+FiqoqufmJB5Gra+GC/zKXk4wXxxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16401F8022D;
	Mon, 22 Feb 2021 17:45:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27E41F80234; Mon, 22 Feb 2021 17:45:21 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DAF8F80154
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 17:45:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DAF8F80154
IronPort-SDR: 78rY3oBfcEbXVKevXuMw1tuCfWgPKp3D+W1NCu3EKBswTsmYVpSQzcu918HdacMoUIzQlOxTg9
 Si3CgxOMUFlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="184619493"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="184619493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 08:45:12 -0800
IronPort-SDR: BMc60j2y8jmAY4dr57WxgffJjrSHJ3Coyd90y0UcnxVwDElgRVCfNZPwh13wnYjd5FI0owsoc1
 7UNKV83Z4WLQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="364072178"
Received: from cjmerril-mobl1.amr.corp.intel.com (HELO [10.212.252.139])
 ([10.212.252.139])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 08:45:12 -0800
Subject: Re: [PATCH 6/6] ASoC: samsung: tm2_wm5510: remove shadowing variable
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
 <20210219230918.5058-7-pierre-louis.bossart@linux.intel.com>
 <20210221111250.pkklcu26tt5ini2m@kozik-lap>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0ce00def-ed9e-3d49-55f2-7abfa3a77e29@linux.intel.com>
Date: Mon, 22 Feb 2021 09:36:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210221111250.pkklcu26tt5ini2m@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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



>> diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
>> index da6204248f82..b9c17fdd168d 100644
>> --- a/sound/soc/samsung/tm2_wm5110.c
>> +++ b/sound/soc/samsung/tm2_wm5110.c
>> @@ -549,7 +549,6 @@ static int tm2_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	for (i = 0; i < num_codecs; i++) {
>> -		struct of_phandle_args args;
> 
> I would prefer to have them more local, so:
> 1. Remove args in tm2_probe() scope.
> 2. Add args around line 588 in "if (num_codecs > 1) {" block.

Will change this in a v2.
