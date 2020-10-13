Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21906C433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:56:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD442078A
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hTBWcrjr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUUZ4fqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD442078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 778B31671;
	Tue, 13 Oct 2020 03:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 778B31671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602554212;
	bh=osSvnPiZ+I6VFE3NFUc8F90q2WyLZCfUcYQNt5BxQ7c=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hTBWcrjru/lYWatEoJ2D0CfWck6wYCeKUE+I+9RC9Wv4qAuctFWipKKjdLUYjAgKJ
	 /1/iaqOFupYR56IU14SvcpVxexRkaG/QHROzUCX0jb2KOQBzw5bBWUXJq9qCy//9bl
	 YiQoE5Q3Z/E0ymS6jpaHp6mUgkhYuo3od3Rh9CBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0236EF8016F;
	Tue, 13 Oct 2020 03:56:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53D1AF801A3; Tue, 13 Oct 2020 03:56:00 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4860DF800F6
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 03:55:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4860DF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="XUUZ4fqA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=XZ4PnfNtwakIDlRRmh47GHVxqUjiVpoW6RClzSLlVzI=; b=XUUZ4fqAb9ywdL3Jx1BwPY9nJF
 iKs2Te4/mNvPSrju67WdoJ/QCbrAFA+clkdxX64WQg3c+9bKiPnFI4f5asilYqfKGH72XDZmnsqHp
 Kvf8wcF8HS0BqzRGycWfFdmw1R1G4GortaEEZClVb8nq/w8TkUFKDWsQvpbdXoSqaUmvkp6kk4Ukb
 XLrm32/BBTILt0MJIXpqmIa+UaafcrPp5akacLOp8c8Vku9Gxk35K++Xry7n+lss9nHpm33DdNQ2M
 KPniw/AZ7n0euRWQxfHH0JfzNia/dNHs2P0FhVbA5ZzXV+2E8NyXBCrwI2YygAduTJka4X+rvPPTf
 9b6QTkQg==;
Received: from [2601:1c0:6280:3f0::507c]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS9X2-0003p6-DD; Tue, 13 Oct 2020 01:55:16 +0000
Subject: Re: [PATCH v2 2/6] ASoC: SOF: Introduce descriptors for SOF client
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>, alsa-devel@alsa-project.org
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-3-david.m.ertman@intel.com>
 <076a0c53-0738-270e-845f-0ac968a4ea78@infradead.org>
 <d9f062ee-a5f0-b41c-c8f6-b81b374754fa@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ef98f33-a0d3-579d-26e0-6046dd593eef@infradead.org>
Date: Mon, 12 Oct 2020 18:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d9f062ee-a5f0-b41c-c8f6-b81b374754fa@linux.intel.com>
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

On 10/12/20 6:31 PM, Pierre-Louis Bossart wrote:
> 
>>> +config SND_SOC_SOF_CLIENT
>>> +    tristate
>>> +    select ANCILLARY_BUS
>>> +    help
>>> +      This option is not user-selectable but automagically handled by
>>> +      'select' statements at a higher level
>>> +
>>> +config SND_SOC_SOF_CLIENT_SUPPORT
>>> +    bool "SOF enable clients"
>>
>> Tell users what "SOF" means.
> 
> This option can only be reached if the user already selected the topic-level option. From there on the SOF acronym is used. Is this not enough?

Yes, that's enough. I didn't see it. Sorry about that.

> config SND_SOC_SOF_TOPLEVEL
>     bool "Sound Open Firmware Support"
>     help
>       This adds support for Sound Open Firmware (SOF). SOF is a free and
>       generic open source audio DSP firmware for multiple devices.
>       Say Y if you have such a device that is supported by SOF.
> 
>>
>>> +    depends on SND_SOC_SOF
>>> +    help
>>> +      This adds support for ancillary client devices to separate out the debug
>>> +      functionality for IPC tests, probes etc. into separate devices. This
>>> +      option would also allow adding client devices based on DSP FW
>>
>> spell out firmware
> 
> agree on this one.
> 
>>
>>> +      capabilities and ACPI/OF device information.
>>> +      Say Y if you want to enable clients with SOF.
>>> +      If unsure select "N".
>>> +
>>
>>

thanks.
-- 
~Randy

