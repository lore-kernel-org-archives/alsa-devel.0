Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC791C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:11:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BFA64E9B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BFA64E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0B5F16C2;
	Mon,  1 Feb 2021 17:10:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0B5F16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612195879;
	bh=3PXIUgvVACRi7JQEmyPdS61RDV2tjZibAxZ0Qj7R2lA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9pG7NLE5paRW2jwIkz6nDiujc42v4toeNRP2PPHr2t3757cdwPpK8zf23kv4JbW5
	 6Q/vIoWThqEq2azw2zoCP7Cy2a2SKGf7dfnoQJHxhnFMEsQKyML7KFulCC+zhJCRpR
	 N9N7lN1N/lk1XLHu8hLRVpUff03zmvYaKfI+vOhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E6CBF80152;
	Mon,  1 Feb 2021 17:10:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0EC2F80153; Mon,  1 Feb 2021 17:10:26 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09A13F800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 17:10:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09A13F800E9
IronPort-SDR: GmQ9hAyU7DCeVSwjU0338ZdGXdZ9khhL+4MxwQbLiObBJTc+J/dl5vdQlrd9zb1DWkE5HU/oWF
 RyUow17/Da5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168389636"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; d="scan'208";a="168389636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 08:10:17 -0800
IronPort-SDR: Zi/rRVsm+yVybsbeIAuJoKP7AGQnuZJn/fLtJpA3eIf9FUoBQl+Z74ZDdZ3Zj+OCRMFv0OX11X
 a7P1TVJPrXFQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; d="scan'208";a="412472539"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61])
 ([10.212.126.61])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 08:10:16 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To: Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
Date: Mon, 1 Feb 2021 10:10:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201101414.GS2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com
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



On 2/1/21 4:14 AM, Vinod Koul wrote:
> On 21-01-21, 17:23, Srinivas Kandagatla wrote:
>>
>>
>> On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> currently we have
>>>>>> /sys/kernel/debug/soundwire/master-*
>>>>>>
>>>>>> Are you suggesting that we have something like this:
>>>>>>
>>>>>> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
>>>>>
>>>>> Yes this is what I was thinking about.
>>>>
>>>> Vinod/Pierre,
>>>>
>>>> One Question here,
>>>>
>>>> Why is link_id part of "struct sdw_bus", should it not be part of
>>>> "struct sdw_master_device " ?
>>>>
>>>> Given that "There is one Link per each Master"
>>>
>>> it's true that link == master == bus at the concept level.
>>>
>>> but we have an existing code base with different structures and we can't
>>> break too many things at once.
>>>
>>> In the existing flow, the 'bus' is created and setup first, the
>>> sdw_bus_master_add() routine takes a 'bus' argument, and the link_id is
>>> already set. This routine only creates a device and in the rest of the
>>> code we keep using the 'bus' pointer, so there's no real short-term
>>> scope for moving the information into the 'sdw_master_device' structure
>>> - that would be a lot of surgery when nothing is really broken.
>>
>> I totally agree!
>>
>> If I understand it correctly in Intel case there will be only one Link ID
>> per bus.
> 
> Yes IIUC there would be one link id per bus.
> 
> the ida approach gives us unique id for each master,bus I would like to
> propose using that everywhere

We have cases where link2 is not used but link0, 1 and 3 are.
Using the IDA would result in master-0,1,2 being shown, that would throw 
the integrator off. the link_id is related to hardware and can tolerate 
gaps, the IDA is typically always increasing and is across the system, 
not controller specific.

We can debate forever but both pieces of information are useful, so my 
recommendation is to use both:

snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);

