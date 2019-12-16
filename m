Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68189C43603
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95C3206EC
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WB0IN31k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95C3206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C67715E0;
	Mon, 16 Dec 2019 18:08:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C67715E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576516143;
	bh=vlys4ctXmmTB8F0TaAuPAAVQonfFAKtkVIi61/LEM2M=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WB0IN31kFdld/vBDcEEWlrUHxPLo5Ah6j3Mzws/5PjmF+PAeFBJYbmwZikyRdbzop
	 gZjyPCgejQnu+owQAaBhFvjRb11ZGa7i0u5cMQAIVGpSoZ/Zg8A6009lFiz1TiHuof
	 JbsmudnVYGaqKCHUrJM4GuO/hvGyVjV6P5QGnL7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC71F800AD;
	Mon, 16 Dec 2019 18:08:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4287FF80255; Mon, 16 Dec 2019 18:08:10 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A63CF800B2
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 18:08:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A63CF800B2
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 09:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; d="scan'208";a="247105417"
Received: from andresma-mobl.amr.corp.intel.com (HELO [10.252.132.232])
 ([10.252.132.232])
 by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2019 09:07:59 -0800
To: Greg KH <gregkh@linuxfoundation.org>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
 <20191214082742.GA3318534@kroah.com>
 <e9d77c58-e0bd-010c-bbc8-b54c82f065fd@linux.intel.com>
 <20191216162517.GA2258618@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8dfb12c-2394-3dfe-571d-dcc5fadb8dc2@linux.intel.com>
Date: Mon, 16 Dec 2019 11:07:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216162517.GA2258618@kroah.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial
 definitions for sdw_master_device
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


>>>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>>>> index 76a5c52b12b4..5bad8422887e 100644
>>>> --- a/drivers/soundwire/Makefile
>>>> +++ b/drivers/soundwire/Makefile
>>>> @@ -7,9 +7,11 @@ ccflags-y += -DDEBUG
>>>>    #Bus Objs
>>>>    soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o
>>>> stream.o
>>>>    obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>>>> +ccflags-$(CONFIG_SOUNDWIRE) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
>>>>
>>>>    soundwire-generic-allocation-objs := generic_bandwidth_allocation.o
>>>>    obj-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
>>>> soundwire-generic-allocation.o
>>>> +ccflags-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
>>>> -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
>>>
>>> Don't use ccflags, just use the correct MODULE_EXPORT_NS() tag instead.
>>
>> The documentation [1] states
>>
>> "
>> Defining namespaces for all symbols of a subsystem can be very verbose and
>> may become hard to maintain. Therefore a default define
>> (DEFAULT_SYMBOL_NAMESPACE) is been provided, that, if set, will become the
>> default for all EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() macro expansions
>> that do not specify a namespace.
>> "
>>
>> If the ccflags option is not supported or no longer desired, it'd be worth
>> updating the documentation for dummies like me. I took the wording as a hint
>> to avoid using MODULE_EXPORT_NS.
> 
> It's supported, and works just fine.  It's just that you really don't
> have a ton of exports, right?  What's wrong with manually marking them?

I don't see a MODULE_EXPORT_NS so we'd have to change every single 
EXPORT_SYMBOL to EXPORT_SYMBOL_NS.

If we are talking about adding the namespaces just about the top-level 
functions used by Intel, yes we have less than 10 and since they were 
renamed it's no big deal.

But if we want to use this namespace for lower-level components of the 
SoundWire code, we have 17 exports in cadence_master.c and more than 27 
for the core parts. With the Makefile changes shared last week you'd 
have 3 changes, I find it more manageable but it's true that the 
information would be split with the IMPORT_NS in the code and the 
namespace definition in the Makefile.


>>> And "SDW_CORE" is odd, "SOUNDWIRE" instead?
>>
>> 'sdw' is the prefix used everywhere for SoundWire symbols.
> 
> Ok, I guess that ship has sailed :(

we can still use SOUNDWIRE for the namespaces, that'd be fine. you're 
right to call us on acronyms, it's a bad habit.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
