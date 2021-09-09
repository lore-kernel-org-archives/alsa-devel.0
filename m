Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A61C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7990A61178
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7990A61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72E3B1675;
	Thu,  9 Sep 2021 05:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72E3B1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631158014;
	bh=3JEKQoqbgKbZQ4oB8NZb9IGsTf8Bz2Fa8sJ3CbuJECo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fdIPToGrcjg+jqtJs3IwT+VDQA3ApxQzYRgowU/CIwAV1kzNBuWZy64eSGmizTcWP
	 wZeDSBOyxHxcPfqqVUpjnFnKgDR36FkEOxKWCqgLZEP843tk/lMIAtxG8Yc06zjLLs
	 Gj0rzxCoBZAZRwtxyApVR5P8aa0MDo72edg6rOd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFAE6F80217;
	Thu,  9 Sep 2021 05:26:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A35FF80224; Thu,  9 Sep 2021 05:26:01 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2A21F800FC
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 05:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2A21F800FC
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220695036"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; d="scan'208";a="220695036"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2021 20:25:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; d="scan'208";a="513537696"
Received: from sgevirtz-mobl.amr.corp.intel.com (HELO [10.209.141.208])
 ([10.209.141.208])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2021 20:25:49 -0700
Subject: Re: [PATCH] ASoC: rt1011: add i2s reference control for rt1011
To: Jack Yu <jack.yu@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>, 
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>
References: <20210906101208.11585-1-jack.yu@realtek.com>
 <3062f5e5-d2d7-8150-ef89-989af3b4b1d6@linux.intel.com>
 <05e92a24b1c34daeb64e5b222a3ae337@realtek.com>
 <9f76a420-44c6-ad6d-4442-275ba4459b40@linux.intel.com>
 <a9d9074e52c941e8bddc34f4d364a1ae@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31627a4f-cfa3-39ab-7e6e-2578c99fc742@linux.intel.com>
Date: Wed, 8 Sep 2021 22:25:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a9d9074e52c941e8bddc34f4d364a1ae@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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




>>>>> +static const char * const rt1011_i2s_ref[] = {
>>>>> +	"None", "Left Channel", "Right Channel"
>>>>> +};
>>>>
>>>>> +enum {
>>>>> +	RT1011_I2S_REF_NONE,
>>>>> +	RT1011_I2S_REF_LEFT_CH,
>>>>> +	RT1011_I2S_REF_RIGHT_CH,
>>>>> +};
>>>>
>>>> is it possible to get Left-Right-mix (mixed on rt1011) and Left-Right
>>>> (two channels, with the application selecting what they want)?
>>>
>>> It's a mono amp, so there's no Left-Right-mix setting.
>>> And for the choice of Left-Right channel, it's already available with this
>> patch.
>>
>> So it's just to place a mono reference in either left or right channel of the I2S
>> link? Why not dual-mono as well then?
> 
> The patch is a specific control for two amps to send AEC data on single I2S data input pin by standard I2S protocol. 

That's really useful information and worthy of a comment.

What you are doing here is similar to selecting the slot for each amp
with set_tdm_slot(), but leaving the choice to userspace, isn't it?

> If there are two I2S input from SoC, we can add dual-mono mode for it, but so far there is no requirement regarding to this mode.

ok.

