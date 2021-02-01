Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B9C433E6
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 18:15:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B262764DDE
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 18:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B262764DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E0091772;
	Mon,  1 Feb 2021 19:14:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E0091772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612203335;
	bh=6YqcShrPAG9LbTIGkJzC7Cvca8t+vGju8mf2q9GQcCQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UY1fJYgo/NMykUhl+1vtYCOgPGfP5KKYSIPnZ00MH9winfy+luVqt28BFNb39uImo
	 SzkVfzKecsb490Jdz4pU76xXYxBXR0KWk++N/2m9fgFxZcIL4pK2jxLpAK1P10c6t6
	 MRY2k2w3EPDyW+m0Xlw7oYX30cL+Dqh8dA03LvBI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48ED3F80246;
	Mon,  1 Feb 2021 19:13:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 034E2F80156; Mon,  1 Feb 2021 19:13:37 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0697F80154
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 19:13:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0697F80154
IronPort-SDR: qOYHmydatX/+Mqi1nwwsKb3V2k8jFnLsOWJTrUdAxTdba7NdyvBDgUpyyBtlxEwtFQ7aMfQtpw
 t+q0MsVqhGHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833507"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="167833507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:13:26 -0800
IronPort-SDR: t1ZT0Rp5UgHO5+G+Rjs+nf9ceH3biy6QpJfLCdyVByIjGwykT8kUnywRnfCd8mRgTlYb3D1yWN
 G12Cit0zw+Rg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="412516924"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61])
 ([10.212.126.61])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:13:25 -0800
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
 <29eb1b75-d92f-9641-8181-1fe250b189ec@linux.intel.com>
 <3c801cef-0089-721d-d916-bf3eed060c6c@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fbfd11e5-eab8-f070-15b1-98559dac9214@linux.intel.com>
Date: Mon, 1 Feb 2021 10:33:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c801cef-0089-721d-d916-bf3eed060c6c@linaro.org>
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


>>>   struct qcom_swrm_port_config {
>>>       u8 si;
>>>       u8 off1;
>>>       u8 off2;
>>>       u8 bp_mode;
>>> +    u8 hstart;
>>> +    u8 hstop;
>>> +    u8 word_length;
>>> +    u8 bgp_count;
>>
>> I couldn't figure out what 'bgp' was and had to search. Not sure how 
>> you came up with this abbreviation of "qcom,ports-block-group-count". 
>> Adding a comment wouldn't hurt.
> 
> I will rename this to blk_group_count which makes more sense!

sounds good.


>>
>>> +    u8 lane_control;
>>
>> Are you able to use lane_control != 0 ? I thought we were missing 
>> stuff at the bus.c level?
> Am not sure what is missing in bus.c but we do use lane_control for RX 
> slave on WCD938x codec. This uses datalane 1 for HPH and lane0 for 
> Compander/Class-H and other ports.
> 
> And it works!

Ah, good to know, thanks for the pointer.
