Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD45C43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFDA20772
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XpXMigoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFDA20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45F64166F;
	Wed, 25 Mar 2020 13:22:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45F64166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585138986;
	bh=20tdVehHuoRonXG6/me6sMtsK1GLkGoIsaWGRUNJJj8=;
	h=From:Subject:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpXMigoMqLJ/4Xk7P8Yf1w5O6DHWG8cMOF9iw5cZN6RE4EhmoxDZU4PlYPjXj1/fb
	 +Og43UCJE4rIpN8CnCj3kqIYCnriimpkVdw+r5DIi27VwcU9Tjfn1CqnGo3pydzVEV
	 a9gAMDIM5GXnWvLfXQZZC1RsJQ9YYRgqPIdob77k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0082F80255;
	Wed, 25 Mar 2020 13:21:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97F27F80158; Wed, 25 Mar 2020 13:21:18 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69AB4F80147
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 13:21:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69AB4F80147
IronPort-SDR: feRtkO4kOikR42HmZPB98U3P4QeTM4aytqj9vzxp5JDM/wj4Vw+UfyPaHgkTIkMcyTE+wQhWSy
 sPRWJbfVD+jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 05:21:08 -0700
IronPort-SDR: R6uk86ZTR/7dd6sYVQA85fPQTqTwLnrq7mHhPNAh5v+Pvzeb+dJbCnxwCo7jN5nNmkNPnXXjv/
 umUVNzKfrZ+g==
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="270783383"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.254.66.157])
 ([10.254.66.157])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 05:21:07 -0700
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Subject: Re: [PATCH] ucm2: hdadsp: add basic ucm config
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
References: <20200306113031.713-1-mateusz.gorski@linux.intel.com>
 <4e2e3345-81d0-c698-d589-d4db5faff288@perex.cz>
 <8cd9195d-6104-88ed-22ed-c3151334ee76@linux.intel.com>
 <1bd9d86c-e19f-183c-5355-5b7359c6e4c0@perex.cz>
 <7a44ec22-ed38-5ddd-0f04-097b2befd796@linux.intel.com>
 <9adc9d91-4227-9558-067f-40a9aa3fb561@perex.cz>
 <fc031fee-4f5d-18bb-b411-2d97f57a0c95@linux.intel.com>
Message-ID: <f78927e6-c35c-5b86-9759-1447a8298d85@linux.intel.com>
Date: Wed, 25 Mar 2020 13:21:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fc031fee-4f5d-18bb-b411-2d97f57a0c95@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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

>
>>>>>>> Basic UCM configuration for HDA DSP generic enabling codec playback
>>>>>>> and
>>>>>>> capture on both HDA codec and DMIC ports.
>>>>>>
>>>>>> Could you describe for what Linux driver (source code) is this
>>>>>> configuration?
>>>>>
>>>>>
>>>>> This file is for Intel Skylake SST driver. Information added in v2.
>>>>
>>>> Ok, do we have this code in the vanilla linux kernel? Which .c file?
>>>> The driver name 'hdadsp' looks suspicious. We usually have a delimiter
>>>> in the driver name (like sof-hda-dsp).
>>>
>>>
>>> Yes, it is a part of Skylake driver, "hdadsp" is the name of sound card
>>> created on machine when using HDA generic machine driver. This machine
>>> driver is made of 2 .c files:
>>>
>>>       - skl_hda_dsp_common.c
>>>       - skl_hda_dsp_generic.c
>>>
>>> both are located in: sound/soc/intel/boards/
>>>
>>> Example on production laptop:
>>>
>>> test@test-Swift-SF515-51T:/proc/asound$ cat cards
>>>    0 [hdadsp         ]: hda-dsp - hda-dsp
>>>                         WL-SwiftSF515_51T-V1.02-Guinness_WL
>>
>> Ok, I see now. The 'hdadsp' is the user configurable card 
>> identification (alias to the card number) not the driver name. The 
>> UCM should be in 'hda-dsp' directory. If the UCM validator works for 
>> you, it should be corrected.
>>
>> Could you point me to the alsa-info.sh output for this hardware?
>>
>
> Thank you for the explanation, adjustments are coming in v4. Still, I 
> was able to test ucm's on DUT using "alsaucm -c hdadsp" command and it 
> worked..
>
> I had some problems uploading the output automatically, so done it 
> manually, here's the link:
>
> http://www.alsa-project.org/db/?f=986bf4515b2af1de75d42f2df2f812664fb7ec6e 
>
>
>
> I also sent a patch adding output to configs subtree in alsa-tests repo.
>
> V4 was tested with ucm-validator, no errors.
>
>
>> Thank you,
>>                 Jaroslav
>>
>
> Thanks,
> Mateusz
>

Is there anything else I could do regarding this change? I think all of 
the issues/hints were adressed.

Thanks,
Mateusz

