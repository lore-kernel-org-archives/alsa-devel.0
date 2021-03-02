Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA3C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 15:39:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471C461494
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 15:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471C461494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B70D8174B;
	Tue,  2 Mar 2021 16:38:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B70D8174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614699553;
	bh=TjslZVJ1WgKqNAqXZUFlfCRKXCy1fV7H7lVR35vtaqM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u45+dgsSiNpMvFKWOcKfxuBtI04vw8X4m3ETAYnNzr8rlQU3fqZ4sHAYdPPqfkigV
	 VXuA85iWw12Ruq7FCK+oV7rHb3TFm+zPrL+hx2ZU6VOOvdnVSTZDc9RABwBu1WUQi/
	 FxWrZz9OhOGhwLlbyzsDvl+ma2zO0DY9cKpfcus4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CB38F80269;
	Tue,  2 Mar 2021 16:38:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D94ACF80277; Tue,  2 Mar 2021 16:38:21 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3399F8025B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 16:38:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3399F8025B
IronPort-SDR: 92hiKnCNnkEs6g+yUlwVceJsXeFgK/SrY3qejH7rnzl3MKlrMtInNnTY83BU2IPQc5v6ZQJkbV
 us6yxZKZz4Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166091268"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="166091268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 07:38:14 -0800
IronPort-SDR: pd0hx9i9OFPb+eSE5RBvDAfkiQOAmym7xU9WtdTxfu5sfHJ5wAHS2J8HlY7DJb8AkdvcJ5oQJH
 NfIfu93nSH+w==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406768940"
Received: from bgrewell-mobl3.amr.corp.intel.com (HELO [10.212.242.206])
 ([10.212.242.206])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 07:38:13 -0800
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
 <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
 <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
Date: Tue, 2 Mar 2021 08:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
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


>>>       for (i = 0; i < nports; i++) {
>>>           ctrl->pconfig[i].si = si[i];
>>>           ctrl->pconfig[i].off1 = off1[i];
>>>           ctrl->pconfig[i].off2 = off2[i];
>>>           ctrl->pconfig[i].bp_mode = bp_mode[i];
>>> +        ctrl->pconfig[i].hstart = hstart[i];
>>> +        ctrl->pconfig[i].hstop = hstop[i];
>>> +        ctrl->pconfig[i].word_length = word_length[i];
>>> +        ctrl->pconfig[i].blk_group_count = blk_group_count[i];
>>> +        ctrl->pconfig[i].lane_control = lane_control[i];
>>>       }
>>
>> I don't get why you test the values parsed from DT before writing the 
>> registers. Why do test them here? if some values are incorrect it's 
>> much better to provide an error log instead of writing a partially 
>> valid setup to hardware, no?
> 
> from DT we pass parameters for all the master ports, however some of 
> these parameters are not really applicable for some of the ports! so the 
> way we handle this is by marking them as 0xFF which means these values 
> are not applicable for those ports! Having said that I think I should 
> probably redefine SWR_INVALID_PARAM to QCOM_SWR_PARAM_NA or something on 
> those lines!

Humm, do you have an example here? It's a bit odd to define DT 
properties that may or may not be valid. If this is intentional and 
desired, this should still be captured somehow, e.g. in the bindings 
documentation or in the code with a comment, no?
