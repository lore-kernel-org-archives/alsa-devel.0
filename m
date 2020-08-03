Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0147C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3956B20775
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VkgTC0hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3956B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E0721657;
	Mon,  3 Aug 2020 18:31:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E0721657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596472312;
	bh=N2ZDW8LMxrPDr1WJxjGvlJQe13R2N4zANX/LGUfHh4g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkgTC0hLyOA2WbmKi/f1f5HZNcoww0fnMNh8b5YOgRg5lsIrvEVCpBJL9efvKBQAJ
	 WP/MJxGcM3hk10HQU00XOlkTZ7akW05kyRq3XIvbmHf4DJBPtpr4jq+PR2XYW/783a
	 VyQx0czyiayF3ZgihhSjdxF9wFTW2d4U30avkfdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 140E5F80148;
	Mon,  3 Aug 2020 18:31:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B882F80234; Mon,  3 Aug 2020 18:30:59 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A5B2F80148
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 18:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A5B2F80148
IronPort-SDR: w336Ebf8JPJQAshlMsfDm/Yk55HtUgKHZ5/i+5MvTQN9LwYPLI34wc83HqHjq/Na3uUTnWxQyX
 qDQh3/YGCwwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="140078771"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="140078771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 09:30:41 -0700
IronPort-SDR: HYIrMYEm8lBMNO8V4ckOAoQA8pQWSmFdA/9ZOER3Om2htaswTIXrYE6n0X7b83p99gu4U0XKGj
 4qS1E0oGdiww==
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="274054331"
Received: from ksramesh-mobl.amr.corp.intel.com (HELO [10.252.128.191])
 ([10.252.128.191])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 09:30:38 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To: "Lu, Brent" <brent.lu@intel.com>, Takashi Iwai <tiwai@suse.de>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de>
 <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hd04a90o4.wl-tiwai@suse.de>
 <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
Date: Mon, 3 Aug 2020 10:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Stuart <daniel.stuart14@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Damian van Soelen <dj.vsoelen@gmail.com>
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



On 8/3/20 8:00 AM, Lu, Brent wrote:
>>>>
>>>> Again, is this fixed 240 is a must?  Or is this also an alignment issue?
>>> Hi Takashi,
>>>
>>> I think it's a must for Chromebooks. Google found this value works
>>> best with their CRAS server running on their BSW products. They
>>> offered this patch for their own Chromebooks.
>>
>> Hrm, but it's likely a worse choice on other sound backends.
>>
>> Please double-check whether this fixed small period is a must, or it's an
>> alignment issue.
> Hi Takashi,
> 
> I've double checked with google. It's a must for Chromebooks due to low
> latency use case.

I wonder if there's a misunderstanding here?

I believe Takashi's question was "is this a must to ONLY accept 240 
samples for the period size", there was no pushback on the value itself. 
Are those boards broken with e.g. 960 samples?
