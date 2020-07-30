Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B77CC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:11:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17DB2173E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i5//ixKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17DB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 625B41661;
	Thu, 30 Jul 2020 22:10:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 625B41661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596139907;
	bh=5uHNhBkZWgYekfKa23laKIay9YsGOf4fvz/Nx0FToUo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5//ixKzLh8ap414YcaVEi9UpZeDHvbaQAhC/ipB3mb4z/7ttSirAfKbqKFpZ7WiO
	 nhn+Ig56vMnvnwfrI9T7FSKocDkMV0Tebsq8AkWP03rUyIVnhHfonv3WVCbo3YhPh/
	 ziO+gUkClYxpUVal8+2+3QDtnnUUSSRBLTw4RjXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F23B2F8021C;
	Thu, 30 Jul 2020 22:10:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1501BF8021E; Thu, 30 Jul 2020 22:10:55 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 761FAF80111
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 22:10:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 761FAF80111
IronPort-SDR: 8VguudHxcw2CJs9psc9/h5KDXFSGnRxonI9n7UunZlIWBcGiG1sV4+v3cP2bjJuOKfvEHHf3HT
 ixKo+NIi1ywQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151654176"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; d="scan'208";a="151654176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 13:10:47 -0700
IronPort-SDR: ffTAhcBLyy1asaRTayTkCnFox+co+yl6zX8UtkZTokriuQ9Hi88jOrvrPiwM3XJvEyfy7HwJMB
 zrRF3pxPYdPg==
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; d="scan'208";a="286971482"
Received: from jrwang2-mobl.amr.corp.intel.com (HELO [10.212.82.25])
 ([10.212.82.25])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 13:10:46 -0700
Subject: Re: [PATCH v2] ASoC: Intel: boards: eve: Fix DMIC records zero
To: "N, Harshapriya" <harshapriya.n@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>
References: <1596129988-304-1-git-send-email-harshapriya.n@intel.com>
 <2788f0fd-adaa-c56d-6801-503432ba7ee6@linux.intel.com>
 <BY5PR11MB4307932CDA8DD4C0F594BCA2FD710@BY5PR11MB4307.namprd11.prod.outlook.com>
 <8cd83872-c6d3-faf2-bd1a-963af90d7d2a@linux.intel.com>
 <BY5PR11MB43079D50776444A1C0FBAD57FD710@BY5PR11MB4307.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4773a165-ac6d-36a0-2105-169e2d79a327@linux.intel.com>
Date: Thu, 30 Jul 2020 15:10:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR11MB43079D50776444A1C0FBAD57FD710@BY5PR11MB4307.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "Lu, Brent" <brent.lu@intel.com>, "Gopal,
 Vamshi Krishna" <vamshi.krishna.gopal@intel.com>
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



>>>>>     	case SND_SOC_DAPM_POST_PMD:
>>>>> -		clk_disable_unprepare(priv->mclk);
>>>>> -		clk_disable_unprepare(priv->sclk);
>>>>> +		if (__clk_is_enabled(priv->mclk))
>>>>> +			clk_disable_unprepare(priv->mclk);
>>>>> +
>>>>
>>>> [1] this seems wrong in case you have two SSPs working, and stop one.
>>>> This would turn off the mclk while one of the two SSPs is still working.
>>> For this platform we use either headset or dmic.
>>> There is no way we can record simultaneously using different devices.
>>> So disabling mclk might not be harmful here. But this case will always be true
>> too :).
>>
>> Maybe CRAS prevents you from recording on two inputs, but it looks like you
>> have independent front-ends so in theory couldn't you record at the alsa hw:
>> device level? Is this really mutually exclusive at the hardware level?
> True. Its not mutually exclusive at hardware level. the following might be safe
> if (!__clk_is_enabled(priv->sclk0)) &&  (!__clk_is_enabled(priv->sclk1))
> 	clk_disable_unprepare(priv->mclk);

I don't understand DAPM well-enough to know if these independent 
platform clock control routines are serialized by design or if this 
could be racy?

