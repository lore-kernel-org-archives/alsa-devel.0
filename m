Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE1C2D0A4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:37:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735621548
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GVGrYF5O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmdvQOQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A735621548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2B4916A1;
	Tue, 13 Oct 2020 21:36:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2B4916A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602617836;
	bh=nj0ImPmpJ4OD65HmLw+3KebBx/dcqYWvjc5y7W6Bnnk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVGrYF5OTWx1cMRDICi6j9t5kL/1pXbswjlo+F4eqKj0vJxnVEDEOBSDUnAdURXVM
	 3a7Z7d0x9+PdKyhzZMp5cDMPEqREUr3XKEzM/rTe7bgADaAKAaOKXVGeBWrV0K9juY
	 Rbg6LflMHk1xH9tqnWtvMGFY0NhO8yYPNgYLZC/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39244F8016F;
	Tue, 13 Oct 2020 21:36:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E837F801A3; Tue, 13 Oct 2020 21:36:24 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C59B2F800CE
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 21:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C59B2F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="lmdvQOQx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=/8br067d++YamcdmBjUCKygjOJnP8nv1KaYqcimhMro=; b=lmdvQOQx7pe0L2+mTdplGXQkDb
 3GUORaiFM95XhvSXSfEfS5dbmdOHpcLsE/27lckEJ7d618moCNCZ1OrcD78mkFIEOPo6KcWM+Shlo
 qd/ubudvq2AYY1ppmgDaAn2bct9+030ApeGwQEWxPJEMhYNZSR/mdYz1fzpJTrLw4zsBQqDausc1Y
 0XVXJInQU2RUGkvPdG8LQ4SeHVvD/THsekq7Q93G+nlpy3d4ANoiKRWtmLCsDi2swPtpRYEIerf5u
 UBlUZh/6Sfu55qqQjI8518BsV6U8jgAez+rD1ykcaOGpp6/1UUah7+lbO4zgGzo4XZwUsHZJ+Y1bN
 YhO7zBCQ==;
Received: from [2601:1c0:6280:3f0::507c]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSQ5K-00077m-1U; Tue, 13 Oct 2020 19:35:47 +0000
Subject: Re: [PATCH v2 2/6] ASoC: SOF: Introduce descriptors for SOF client
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>, alsa-devel@alsa-project.org
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-3-david.m.ertman@intel.com>
 <076a0c53-0738-270e-845f-0ac968a4ea78@infradead.org>
 <d9f062ee-a5f0-b41c-c8f6-b81b374754fa@linux.intel.com>
 <9ef98f33-a0d3-579d-26e0-6046dd593eef@infradead.org>
 <5b447b78-626d-2680-8a48-53493e2084a2@infradead.org>
 <7192373a-0347-2d2d-74fc-6544f738b195@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b07f6cbc-8e48-a4aa-bfcb-8a938fa00a38@infradead.org>
Date: Tue, 13 Oct 2020 12:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7192373a-0347-2d2d-74fc-6544f738b195@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: parav@mellanox.com, tiwai@suse.de, netdev@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, broonie@kernel.org,
 jgg@nvidia.com, gregkh@linuxfoundation.org, kuba@kernel.org,
 dan.j.williams@intel.com, shiraz.saleem@intel.com, davem@davemloft.net,
 kiran.patil@intel.com
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

On 10/13/20 8:08 AM, Pierre-Louis Bossart wrote:
> 
>>>>>> +config SND_SOC_SOF_CLIENT
>>>>>> +    tristate
>>>>>> +    select ANCILLARY_BUS
>>>>>> +    help
>>>>>> +      This option is not user-selectable but automagically handled by
>>>>>> +      'select' statements at a higher level
>>>>>> +
>>>>>> +config SND_SOC_SOF_CLIENT_SUPPORT
>>>>>> +    bool "SOF enable clients"
>>>>>
>>>>> Tell users what "SOF" means.
>>>>
>>>> This option can only be reached if the user already selected the topic-level option. From there on the SOF acronym is used. Is this not enough?
>>>
>>> Yes, that's enough. I didn't see it. Sorry about that.
>>
>> Huh. I still don't see that Kconfig option.
>> Which patch is it in?
>>
>> I only saw patches 1,2,3 on LKML.
> 
> The Sound Open Firmware (SOF) driver is upstream since 2019, see https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/Kconfig
> 
> What was shared in these patches is just an evolution to make the driver more modular to handle of 'subfunctions' with the auxiliary bus.
> 
> we'd love to hear your feedback if you think the help text can be improved. Thanks!
> 

OK, I looked at the SOF Kconfig files. They are mostly OK except for
missing '.' at the end of lots of sentences and a few other typos.

Do you want patches?

-- 
~Randy

