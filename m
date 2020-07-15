Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D8AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:23:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BEA2064B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sAK0eOXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BEA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 935C015E5;
	Wed, 15 Jul 2020 16:22:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 935C015E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594823021;
	bh=OtuWZyM7CQBYgeKBKyJV+Tvs1vC63St23k8DW7DDfiU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sAK0eOXLl5dlSA0dhHma+INcoFKgKIrbRvlEG0NejtX6L0m9dhqeOtMKvEU+8zj6Q
	 HX6eXDqcNwvEugdBmhCUhv0KWFH2n0+KKTgR4KcowVjwSCAyrKF80Dgbhbgf5i4025
	 tY3vD6r9MAibuF9226WdT3bb5mfVgZ23hvYdmyyw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AA0CF80217;
	Wed, 15 Jul 2020 16:22:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CA05F8021D; Wed, 15 Jul 2020 16:22:49 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2779FF8014E
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 16:22:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2779FF8014E
IronPort-SDR: pxPdVxHJxgrHIojDrx82OKNRml+nKN9gWXngQ3ROsUq0cHpcpXetixGcaTnIkoXDLfFMV4QhW+
 bpe48tJAfcDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="234008393"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="234008393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:22:34 -0700
IronPort-SDR: 80v3gF12OrUgc3oIBjWlwM2wEEYcTwJALfOy+mW5YqBibu2SxXytSH25abnfa12TbAfIiwqCna
 9SiWcSQ/Gm+Q==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="460106447"
Received: from sjeong-mobl.amr.corp.intel.com (HELO [10.255.231.101])
 ([10.255.231.101])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:22:32 -0700
Subject: Re: [PATCH 8/9] soundwire: intel: add wake interrupt support
To: Vinod Koul <vkoul@kernel.org>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
 <20200623173546.21870-9-yung-chuan.liao@linux.intel.com>
 <20200630165126.GT2599@vkoul-mobl>
 <a69aa5d0-613a-6ef6-9263-378b1e99770a@linux.intel.com>
 <20200701055654.GW2599@vkoul-mobl>
 <81a33798-0667-9a4f-9916-eb157ad5514d@linux.intel.com>
 <20200715045011.GO34333@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2832a0d0-dd19-9532-2c6e-814b796b4e20@linux.intel.com>
Date: Wed, 15 Jul 2020 09:22:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715045011.GO34333@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, slawomir.blauciak@intel.com,
 sanyog.r.kale@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



On 7/14/20 11:50 PM, Vinod Koul wrote:
> On 01-07-20, 10:25, Pierre-Louis Bossart wrote:
>>
>>>>>> +	 * wake up master and slave so that slave can notify master
>>>>>> +	 * the wakeen event and let codec driver check codec status
>>>>>> +	 */
>>>>>> +	list_for_each_entry(slave, &bus->slaves, node) {
>>>>>> +		/*
>>>>>> +		 * discard devices that are defined in ACPI tables but
>>>>>> +		 * not physically present and devices that cannot
>>>>>> +		 * generate wakes
>>>>>> +		 */
>>>>>> +		if (slave->dev_num_sticky && slave->prop.wake_capable)
>>>>>> +			pm_request_resume(&slave->dev);
>>>>>
>>>>> Hmmm, shouldn't slave do this? would it not make sense to notify the
>>>>> slave thru callback and then slave decides to resume or not..?
>>>>
>>>> In this mode, the bus is clock-stop mode, and events are detected with level
>>>> detector tied to PCI events. The master and slave devices are all in
>>>> pm_runtime suspended states. The codec cannot make any decisions on its own
>>>> since the bus is stopped, it needs to first resume, which assumes that the
>>>> master resumes first and the enumeration re-done before it can access any of
>>>> its registers.
>>>>
>>>> By looping through the list of devices that can generate events, you end-up
>>>> first forcing the master to resume, and then each slave resumes and can
>>>> check who generated the event and what happened while suspended. if the
>>>> codec didn't generate the event it will go back to suspended mode after the
>>>> usual timeout.
>>>>
>>>> We can add a callback but that callback would only be used for Intel
>>>> solutions, but internally it would only do a pm_request_resume() since the
>>>> codec cannot make any decisions before first resuming. In other words, it
>>>> would be an Intel-specific callback that is implemented using generic resume
>>>> operations. It's probably better to keep this in Intel-specific code, no?
>>>
>>> I do not like the idea that a device would be woken up, that kind of
>>> defeats the whole idea behind the runtime pm. Waking up a device to
>>> check the events is a generic sdw concept, I don't see that as Intel
>>> specific one.
>>
>> In this case, this in an Intel-specific mode that's beyond what MIPI
>> defined. This is not the traditional in-band SoundWire wake defined in the
>> SoundWire specification. The bus is completely down, the master IP is
>> powered-off and all context lost. There is still the ability for a Slave
>> device to throw a wake as defined by MIPI in clock-stop-mode1, but this is
>> handled with a separate level detector and the wake detection is handled by
>> the PCI subsystem. On a wake, the master IP needs to be powered-up, the
>> entire bus needs to be restarted and the Slave devices re-enumerated.
> 
> Right and I would expect that Slave device would do runtime_get_sync()
> first thing in the callback. That would ensure that the Master is
> powered up, Slave is powered up, all enumeration is complete. This is
> more standard way to deal with this, we expect devices to be so we
> low powered or off so cannot do read/write unless we resume.

As shared privately with you, we don't need to deal with device PM or 
add a callback, it's enough to resume the master, which will indirectly 
restart the bus and result in devices being resumed when they report 
their interrupt status. We'll share the update from [1] in the v2.

[1] https://github.com/thesofproject/linux/pull/2247

