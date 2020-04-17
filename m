Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904AC2BB1D
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:00:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1986C20644
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W3jMTonq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1986C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BFC515F2;
	Fri, 17 Apr 2020 09:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BFC515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587110410;
	bh=0fbyMNQa0VX6KvQyuZaChHRS3YGLUroPkrlih6iwLz4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3jMTonqSP657ay4wwIoJUaSgqpuCr9MbgzekE0Qm7c5r5lWDTFxmsGKOqk6z9wus
	 HzEw6a6rCe+tp/sFp0aNZkDqRYEj2dFlVJKlMgBseS08G9h1j9TITxH0c8w2/FyL2Y
	 yPuy+MRoOOlkZaqYi4FowEIfIcgoc9cX1xlNwqp8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAE3DF80229;
	Fri, 17 Apr 2020 09:59:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4202F80245; Fri, 17 Apr 2020 09:59:16 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3E37F8012E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 09:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3E37F8012E
IronPort-SDR: 5ilNKAREiePcmHYodNidiKIEwRF50C4HZ1vkbbd0SEWwyWE1oetQlZPwJpW4AM4frXuQpAEKsc
 fPwUZYnax/bw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 00:59:06 -0700
IronPort-SDR: CGPJrXmmq3ECcjShtzPW6vzAtxidCY36qeeTf6HCrzk4Vn/CjVw0j2WuzpQisWGCVq37CqdCIg
 M3co0DPSyWuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; d="scan'208";a="333120399"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.31.36])
 ([10.213.31.36])
 by orsmga001.jf.intel.com with ESMTP; 17 Apr 2020 00:59:02 -0700
Subject: Re: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
To: "Lu, Brent" <brent.lu@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
 <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
 <BN6PR1101MB21320F655CFC1C271CCA9CE097DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <4b9455cb-d0d2-f5d8-f04c-df6e5abb4441@linux.intel.com>
 <BN6PR1101MB2132BBB45C6683D6BE1FBCD897D90@BN6PR1101MB2132.namprd11.prod.outlook.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <95d0a64e-d2e9-7117-75c5-6c68b1426f93@intel.com>
Date: Fri, 17 Apr 2020 09:59:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2132BBB45C6683D6BE1FBCD897D90@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, "Chiang, Mac" <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>
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

On 2020-04-17 03:32, Lu, Brent wrote:
>>
>> It seems like a generic problem on all Broadwell devices so let's solve with
>> one a single patchset.
>>
>> Shouldn't we just add the 2ch constraints for broadwell.c and bdw-rt5677.c,
>> and the 2 or 4ch constraint for bdw-rt5650.c? Would this work for you?
>>
>> Thanks
>> -Pierre
> 
> Hi Pierre,
> 
> Are you saying submitting a new patch to add constraints to all three broadwell.c,
> bdw-rt5650.c, and bdw-rt5677.c?
> 
> 
> Regards,
> Brent
> 

What Pierre suggested is that you submit a series of patches instead - 
one for each of BDW machine boards. If the same problem exists on all of 
them, there is no reason to left other boards unattended.

Czarek
