Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DEAR_SOMETHING,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC1C1975A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 03:31:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5121B20724
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 03:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oNU1YufG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5121B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C51E1749;
	Wed, 18 Mar 2020 04:31:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C51E1749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584502310;
	bh=KDGT/OuHvuaUkK/Mm4zzKtSDLw54M5uSS7OfhDrwIGs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oNU1YufGSkFwY8O7CTgquJRFuzCChLrtqawRvE6HPL0zJ9QYfCvkZx4WEqC7Ecx+Y
	 3WynjNY9SSDOb0hLLpLbkdQcq/vKoprPSNycXBwwfQ2rVpZ+WJ3zwY6gpBNWfvBPKl
	 A6XvXeI5MnsWzWKeFIp+G78mw5dM9FCM7RMEKy1g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF64BF80132;
	Wed, 18 Mar 2020 04:30:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 086F0F80139; Wed, 18 Mar 2020 04:30:58 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28DE1F80058
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 04:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28DE1F80058
IronPort-SDR: 5f9/aDOFJmD8mV8LSMakpDtRc2xxxjyFDa+DY5a7Vsyb7JYmIjxdbjlkt9ql0R4DjGpBx4v3sv
 m6yEjxmDEtlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 20:30:49 -0700
IronPort-SDR: nqJ9ABbm71eXP28O/wH6VKB/Gnnpqr5ALQrUlHD02xEtYJLj4g7/NQ3VQQrmT5y4VK4HHpcKsU
 QymWaENUzaBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="324043994"
Received: from hwang33-mobl.ccr.corp.intel.com (HELO [10.254.210.239])
 ([10.254.210.239])
 by orsmga001.jf.intel.com with ESMTP; 17 Mar 2020 20:30:44 -0700
Subject: Re: [PATCH 1/2] ASoC: rt5682: fix the random recording noise of
 headset
To: Albert Chen <albertchen@realtek.com>, =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqY?=
 =?UTF-8?Q?=5d?= <shumingf@realtek.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>
References: <20200317073308.11572-1-shumingf@realtek.com>
 <ac2e133b-b68c-025e-cb42-8e061abf9744@linux.intel.com>
 <ca4f69fee72243c9a1b0ac55247cbdb7@realtek.com>
From: Keyon Jie <yang.jie@linux.intel.com>
Message-ID: <2dc0887c-b86f-0f76-2107-bd7978e7a204@linux.intel.com>
Date: Wed, 18 Mar 2020 11:31:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca4f69fee72243c9a1b0ac55247cbdb7@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


On 3/18/20 11:06 AM, Albert Chen wrote:
> Dear Sir,
> 
> Inline.
> 
> Thanks,
> Albert
> 
> -----Original Message-----
> From: Keyon Jie <yang.jie@linux.intel.com>
> Sent: Wednesday, March 18, 2020 10:32 AM
> To: Shuming [范書銘] <shumingf@realtek.com>; broonie@kernel.org; lgirdwood@gmail.com
> Cc: Oder Chiou <oder_chiou@realtek.com>; Jack Yu <jack.yu@realtek.com>; alsa-devel@alsa-project.org; lars@metafoo.de; Albert Chen <albertchen@realtek.com>; Derek [方德義] <derek.fang@realtek.com>; sathya.prakash.m.r@intel.com; Flove(HsinFu) <flove@realtek.com>
> Subject: Re: [PATCH 1/2] ASoC: rt5682: fix the random recording noise of headset
> 
> On 3/17/20 3:33 PM, shumingf@realtek.com wrote:
>> From: Shuming Fan <shumingf@realtek.com>
>>
>> The cycle time of FIFO clock should increase 2 times to avoid the
>> random recording noise issue.
>> This setting could apply to all known situations in i2s mode.
> 
> Thanks for fixing this Shuming.
> 
> Just try to understand what has happened.
> 
> Can you help share more details about it, e.g.
> 1. the recording noise happened on headset mic or dmic?
> <Albert> Headset Mic
> 2. will this change impact the microphone sampling clock, or the BCLK that of the I2S bclk pin?
> <Albert> No.
> 3. without this change, why the clk is wrong, some example?
> <Albert> Only adjust FIFO buffer setting.

Where is the FIFO buffer you mentioned located? Is it included in the 
path "headset mic ADC--(loopback)-->ADC headphone"?

The issue was reported to Intel also, that's why I am querying this here.

 From previous feedback, Shuming shared that the loopback path mentioned 
above don't have this random noise issue.

Thanks,
~Keyon

> 
> Thanks,
> ~Keyon
> 
>>
>> Signed-off-by: Shuming Fan <shumingf@realtek.com>
>> ---
>>    sound/soc/codecs/rt5682.c | 2 ++
>>    sound/soc/codecs/rt5682.h | 2 ++
>>    2 files changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
>> index 7ca02a5e52e9..023bc672274b 100644
>> --- a/sound/soc/codecs/rt5682.c
>> +++ b/sound/soc/codecs/rt5682.c
>> @@ -3643,6 +3643,8 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
>>    			RT5682_CP_CLK_HP_MASK, RT5682_CP_CLK_HP_300KHZ);
>>    	regmap_update_bits(rt5682->regmap, RT5682_HP_CHARGE_PUMP_1,
>>    			RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
>> +	regmap_update_bits(rt5682->regmap, RT5682_DMIC_CTRL_1,
>> +			RT5682_FIFO_CLK_DIV_MASK, RT5682_FIFO_CLK_DIV_2);
>>    
>>    	INIT_DELAYED_WORK(&rt5682->jack_detect_work,
>>    				rt5682_jack_detect_handler);
>> diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
>> index 43de6e802309..0baeece84ec4 100644
>> --- a/sound/soc/codecs/rt5682.h
>> +++ b/sound/soc/codecs/rt5682.h
>> @@ -657,6 +657,8 @@
>>    #define RT5682_DMIC_1_EN_SFT			15
>>    #define RT5682_DMIC_1_DIS			(0x0 << 15)
>>    #define RT5682_DMIC_1_EN			(0x1 << 15)
>> +#define RT5682_FIFO_CLK_DIV_MASK		(0x7 << 12)
>> +#define RT5682_FIFO_CLK_DIV_2			(0x1 << 12)
>>    #define RT5682_DMIC_1_DP_MASK			(0x3 << 4)
>>    #define RT5682_DMIC_1_DP_SFT			4
>>    #define RT5682_DMIC_1_DP_GPIO2			(0x0 << 4)
>>
> 
> ------Please consider the environment before printing this e-mail.
> 
