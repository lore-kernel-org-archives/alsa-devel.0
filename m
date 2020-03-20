Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D826FC43332
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:37:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6848120767
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SjSoq1Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6848120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA28341;
	Fri, 20 Mar 2020 17:36:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA28341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584722247;
	bh=3xK3S9SyPELoF0bIY7oM8yHPmFVwzW3vWsWhIQ4dBaI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjSoq1RpUQ03tH6Lc0Bu7YKLpbLfseN67Z2UQHHc0yV7hkd8ZJMyrnExrEEhOLk8+
	 UcBGC7j9n+4u/1BBBkaPa8v46arJpkY1Pd3V+wN5HB2bFjcKYQF3EbN+Y1PuL1TLVS
	 +Lywu3R4Neic7tZm6Bg+IaZ7WY4XC/PXhiB1kEPg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6010CF800C0;
	Fri, 20 Mar 2020 17:36:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 845C7F8015B; Fri, 20 Mar 2020 17:36:35 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7455CF800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 17:36:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7455CF800C0
IronPort-SDR: EzikAXejZHaH2HA0YjpfhY4VCkFWVmzItmv33FQkBedwalRDnuAwS0hyP80Eos2ztu4tLUPtmo
 Ep3CkHui4OFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 09:36:29 -0700
IronPort-SDR: OxQvFv6Y9TtecqmiOWaWSvgFu6JCPAAdXBFe2Vfj0jidcVYUlllK7JFot1VBJp3OQXFtagmHg7
 JRVZ/iRQHfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="392204315"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12])
 ([10.255.34.12])
 by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 09:36:26 -0700
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
To: Vinod Koul <vkoul@kernel.org>
References: <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
 <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
 <20200314094904.GP4885@vkoul-mobl>
 <3c32830c-cd12-867f-a763-7c3e385cb1e9@linux.intel.com>
 <20200320153334.GJ4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <70d6e0cb-22a6-5ada-83a8-b605974bdd84@linux.intel.com>
Date: Fri, 20 Mar 2020 11:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320153334.GJ4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



On 3/20/20 10:33 AM, Vinod Koul wrote:
> On 16-03-20, 14:15, Pierre-Louis Bossart wrote:
>>
>>
>>>> It's really down to your objection to the use of 'struct driver'... For ASoC
>>>> support we only need the .name and .pm_ops, so there's really no possible
>>>> path forward otherwise.
>>>
>>> It means that we cannot have a solution which is Intel specific into
>>> core. If you has a standalone controller you do not need this.
>>
>> A 'struct driver' is not Intel-specific, sorry.
> 
> We are discussing 'struct sdw_master_driver'. Please be very specific in
> you replies and do not use incorrect terminology which confuses people.
> 
> Sorry a 'struct sdw_master_driver' IMHO is. As I have said it is not
> needed if you have standalone controller even in Intel case, and rest of
> the world.

You're splitting hair without providing a solution.

Please see the series [PATCH 0/5] soundwire: add sdw_master_device 
support on Qualcomm platforms

This solution was tested on Qualcomm platforms, that doesn't require 
this sdw_master_driver to be used, so your objections are now invalid.
