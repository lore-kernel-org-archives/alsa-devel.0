Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D8AC11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:38:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40F42084E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TPwW8IMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40F42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 094481683;
	Mon, 24 Feb 2020 18:38:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 094481683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582565936;
	bh=I2xAJSjfL/W4aYxjja8oI8NnnDlTSbTgSDuFhUCzbms=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TPwW8IMdY+6Sh1IsyMlWQ76pZTaNFBb1JHG4YWhldbQnjEpyy4RW0eMg6j9+X7ada
	 RG8Ns36wWko5QQHy1xiXvqKrQIPlGyithWQamsrYNX/XTONuM+QDZNEeRC9qU+asj5
	 STS7+kuZqCuS2I5lx4qc3WFR+kyOGFJKogdAl1S8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 547B8F80090;
	Mon, 24 Feb 2020 18:38:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B66A5F8014E; Mon, 24 Feb 2020 18:38:02 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAD63F80090
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 18:37:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAD63F80090
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 09:37:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="226052282"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.154.74])
 ([10.249.154.74])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 24 Feb 2020 09:37:52 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix available clock counter
 incrementation
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200224125202.13784-1-amadeuszx.slawinski@linux.intel.com>
 <2ff5ef8e-8a95-14a3-b050-3dc974ffe22c@linux.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <143d2e17-c377-fe85-8ab2-879fdfdb25e6@linux.intel.com>
Date: Mon, 24 Feb 2020 18:37:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2ff5ef8e-8a95-14a3-b050-3dc974ffe22c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
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



On 2/24/2020 5:18 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 2/24/20 6:52 AM, Amadeusz Sławiński wrote:
>> Incrementation of avail_clk_cnt was incorrectly moved to error path. Put
>> it back to success path.
>>
>> Fixes: 6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference 
>> when unloading clk dev')
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/soc/intel/skylake/skl-ssp-clk.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c 
>> b/sound/soc/intel/skylake/skl-ssp-clk.c
>> index 1c0e5226cb5b..bd43885f3805 100644
>> --- a/sound/soc/intel/skylake/skl-ssp-clk.c
>> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
>> @@ -384,9 +384,11 @@ static int skl_clk_dev_probe(struct 
>> platform_device *pdev)
>>                   &clks[i], clk_pdata, i);
>>           if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>> -            ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>> +            ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
> 
> Are you sure?
> 
> If you start with avail_clk_cnt set to zero, the error handling will 
> decrement and access offset -1
> 

Yes, I'm sure as far as I know c it will first check the value and then 
decrement it, so it will be 0 while doing the "while" check and it won't 
enter the loop.

You can double check with simplified usecase:
#include <stdio.h>
int main() {
int i = 0;
while(i--)
printf("do something with i, while i = %d\n", i);
}

which seems to work fine to me, by not entering the loop.

Use case is as following:
we start with avail_clk_cnt = 0;
register clock at index 0; increment avail_clk_cnt to 1;
register clock at index 1; increment avail_clk_cnt to 2;
register clock at index 2; increment avail_clk_cnt to 3

now let's assume that there is no more clocks to register
so we do our stuff and then we need to free clocks

so we enter loop
3 evaluates to true, so we decrement it and release clock at index 2
2 evaluates to true, so we decrement it and release clock at index 1
1 evaluates to true, so we decrement it and release clock at index 0
0 evaluates to false, so wo don't enter loop

similar thing happens if we fail to register clock and do error handling

Amadeusz
