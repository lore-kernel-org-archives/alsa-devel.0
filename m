Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4063C2BB1D
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754D9206BE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jze1EI1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754D9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A3E31843;
	Fri, 13 Mar 2020 18:29:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A3E31843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584120606;
	bh=ZxVGVG/Pch+2IsfKlu5StzVN2k7piMUTGz7rXDs5iQY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jze1EI1jCMVpFGUe3lmGmC+8Q/U81XAUeMevxhbdWieNvV0yMIJWFhDW2mccXOS9A
	 RHtu/BeUO0QMIy1yKRZZqc3DzcM8tAnaHthVLSeSQ27zHHh5YTvHzRmjzPaQjFnCUM
	 /cbDQCoaMxw8MGdrZfFjrxpQ5dqXwE/vPUQ+QCFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE444F801F8;
	Fri, 13 Mar 2020 18:28:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C85BF80249; Fri, 13 Mar 2020 18:28:25 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85BD4F801F8
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 18:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85BD4F801F8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 10:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; d="scan'208";a="237017108"
Received: from sblancoa-mobl.amr.corp.intel.com (HELO [10.251.232.239])
 ([10.251.232.239])
 by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 10:28:11 -0700
Subject: Re: [PATCH 01/10] ASoC: soc-acpi: expand description of _ADR-based
 devices
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
 <20200312193346.3264-2-pierre-louis.bossart@linux.intel.com>
 <6ea77c3e-2333-2876-7fa1-ea8a2a6f35e4@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6c6585b8-e359-2ca8-69e1-d17cd7dbc646@linux.intel.com>
Date: Fri, 13 Mar 2020 11:21:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6ea77c3e-2333-2876-7fa1-ea8a2a6f35e4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Mac Chiang <mac.chiang@intel.com>, srinivas.kandagatla@linaro.org,
 jank@cadence.com, Amery Song <chao.song@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Rander Wang <rander.wang@linux.intel.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>, broonie@kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Naveen Manohar <naveen.m@intel.com>, gregkh@linuxfoundation.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, slawomir.blauciak@intel.com
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


>>   static const struct snd_soc_acpi_link_adr icl_3_in_1_default[] = {
>>       {
>>           .mask = BIT(0),
>>           .num_adr = ARRAY_SIZE(rt711_0_adr),
>> -        .adr = rt711_0_adr,
>> +        .adr_d = rt711_0_adr,
>>       },
>>       {
>>           .mask = BIT(1),
>> -        .num_adr = ARRAY_SIZE(rt1308_1_adr),
>> -        .adr = rt1308_1_adr,
>> +        .num_adr = ARRAY_SIZE(rt1308_1_group1_adr),
>> +        .adr_d = rt1308_1_adr,
> 
> Is this right, you use different struct in ARRAY_SIZE and assignment?
> 
>>       },
>>       {
>>           .mask = BIT(2),
>> -        .num_adr = ARRAY_SIZE(rt1308_2_adr),
>> -        .adr = rt1308_2_adr,
>> +        .num_adr = ARRAY_SIZE(rt1308_2_group1_adr),
>> +        .adr_d = rt1308_2_adr,
> 
> Same here.

it's of course an editing issue, thanks for spotting this.
it should be the exact same things as the structure used for cml:

static const struct snd_soc_acpi_link_adr cml_3_in_1_default[] = {
	{
		.mask = BIT(0),
		.num_adr = ARRAY_SIZE(rt711_0_adr),
		.adr_d = rt711_0_adr,
	},
	{
		.mask = BIT(1),
		.num_adr = ARRAY_SIZE(rt1308_1_group1_adr),
		.adr_d = rt1308_1_group1_adr,
	},
	{
		.mask = BIT(2),
		.num_adr = ARRAY_SIZE(rt1308_2_group1_adr),
		.adr_d = rt1308_2_group1_adr,
	},
	{
		.mask = BIT(3),
		.num_adr = ARRAY_SIZE(rt715_3_adr),
l		.adr_d = rt715_3_adr,
	},
	{}
};
