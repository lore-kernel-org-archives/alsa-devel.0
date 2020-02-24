Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C26C11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A367120838
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cSou8fsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A367120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D85531683;
	Mon, 24 Feb 2020 18:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D85531683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582566229;
	bh=cx4mGPVnKORT1HZdcmBHoYbdEcwTsW4nzzydki8CiKM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cSou8fsWlIZnt+7z0d0XtXPHWRXPlGRYKWfWYDVs1REYgP1physKZ7U6FgidbIXsZ
	 3OCnBY0CE6L8k5U6i5gzDCu3Sw9N27ysRvaiLs/daiwqsfmXZ1QH3yvWCV6JfJYv4q
	 HpjEtlRscuP1YvmncqI8C/g5Whj+UeJQ/tqU0+P4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 386D9F8014D;
	Mon, 24 Feb 2020 18:42:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EC4DF8014E; Mon, 24 Feb 2020 18:42:57 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE376F800C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 18:42:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE376F800C6
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 09:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="230725208"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.15.88])
 ([10.252.15.88])
 by orsmga008.jf.intel.com with ESMTP; 24 Feb 2020 09:42:47 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix available clock counter
 incrementation
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200224125202.13784-1-amadeuszx.slawinski@linux.intel.com>
 <2ff5ef8e-8a95-14a3-b050-3dc974ffe22c@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <dd5cdb01-eaac-7536-e587-3caf13132e9b@intel.com>
Date: Mon, 24 Feb 2020 18:42:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2ff5ef8e-8a95-14a3-b050-3dc974ffe22c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
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

On 2020-02-24 17:18, Pierre-Louis Bossart wrote:
> On 2/24/20 6:52 AM, Amadeusz Sławiński wrote:
>> Incrementation of avail_clk_cnt was incorrectly moved to error path. Put
>> it back to success path.
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
> static void unregister_src_clk(struct skl_clk_data *dclk)
> {
>       while (dclk->avail_clk_cnt--)
>           clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup); <<< oob 
> access with offset -1
> }
> 

Decrementation will occur after while's check evaluation - loop will 
exit, decrementation happens regardless.
