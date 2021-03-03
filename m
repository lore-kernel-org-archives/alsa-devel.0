Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57164C433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 22:01:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B872464E67
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872464E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3968B1A9C;
	Wed,  3 Mar 2021 23:00:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3968B1A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614808867;
	bh=VJ7q0MZZUZeWZmwbfCm08F1YOvaS+DKjKMxjfHuAMQM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0b1EhCgNLs8Ksxx+cB7/32D9Z7iC2d7udssviLiU2O5xvewV8QoRlbGUQrZJPzgj
	 +UyY2RAPrKSRlr/lnyakueM/iJpS0RCVZp6QuoEwtBCUUxE6UL79MadEiGw7rVQkM3
	 9an38tObJ8CIMvYKkwIaYyifHnZUIGL8rtKIXdec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C760CF80275;
	Wed,  3 Mar 2021 22:59:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B95F6F8027D; Wed,  3 Mar 2021 22:59:26 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24F40F8012D
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 22:59:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24F40F8012D
IronPort-SDR: T8jI3lMj9stsv02B0ysEjIfu4q9d9hNYhNdcZj68S9C2VXJMQtWHhy8J+8tWW5Yy0Ft5bGUSX1
 JC6TIBoOnhww==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174405702"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="174405702"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:59:16 -0800
IronPort-SDR: 6dZauLo0rkIiwJ4EHv9A3wROd4/CtGYrMteQot/EYZlf/lmoBAzjGek5ybEj9M1pnTsQqx/R1z
 pNW2c6n6IvoA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="586487028"
Received: from srcook1-mobl1.amr.corp.intel.com (HELO [10.209.143.11])
 ([10.209.143.11])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:59:15 -0800
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
 <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
 <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c5fe182d-1769-73ed-0268-5353fd030521@linux.intel.com>
Date: Wed, 3 Mar 2021 10:35:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
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



On 3/3/21 3:38 AM, Srinivas Kandagatla wrote:
> 
> 
> On 02/03/2021 14:34, Pierre-Louis Bossart wrote:
>>
>>
>>>>> +        if (!val1 && !val2)
>>>>> +            break;
>>>>> +
>>>>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>>>>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>>>>> +            ((u64)buf1[0] << 40);
>>>>> +
>>>>> +        sdw_extract_slave_id(bus, addr, &id);
>>>>> +        /* Now compare with entries */
>>>>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>>>>> +            if (sdw_compare_devid(slave, id) == 0) {
>>>>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>>>>> +                if (status == SDW_SLAVE_ATTACHED) {
>>>>> +                    slave->dev_num = i;
>>>>> +                    mutex_lock(&bus->bus_lock);
>>>>> +                    set_bit(i, bus->assigned);
>>>>> +                    mutex_unlock(&bus->bus_lock);
>>>>> +
>>>>> +                }
>>>>
>>>> And that part is strange as well. The bus->assigned bit should be 
>>>> set even if the Slave is not in the list provided by platform 
>>>> firmware. It's really tracking the state of the hardware, and it 
>>>> should not be influenced by what software knows to manage.
>>>
>>> Am not 100% sure If I understand the concern here, but In normal (non 
>>> auto enum) cases this bit is set by the bus code while its doing 
>>> enumeration to assign a dev number from the assigned bitmap!
>>>
>>> However in this case where auto enumeration happens it makes sense to 
>>> set this here with matching dev number!
>>>
>>> AFAIU from code, each bit in this bitmap corresponds to slave dev 
>>> number!
>>
>> Yes, but the point was "why do you compare with information coming 
>> from platform firmware"? if the hardware reports the presence of 
>> devices on 
> 
> This is the logic that hardware IP document suggests to use to get get 
> the correct the device number associated with the slave!
> 
> 
>> the link, why not use the information as is?
>>
>> You recently added code that helps us deal with devices that are not 
>> listed in DT or ACPI tables, so why would we filter in this specific 
>> loop?

I don't think my point was understood, so let me try to explain it 
differently.

it's my understanding that the hardware reads the DevID registers and 
writes a Device Number - so that the entire enumeration sequence started 
by reading DevID0 and finished by a successful write to SCP_DevNum is 
handled in hardware.

The question is: what happens if that device is NOT described in the 
Device Tree data? The loop over bus->slaves will not find this device by 
comparing with known devID values, so the set_bit(i, bus->assigned) will 
not happen.


