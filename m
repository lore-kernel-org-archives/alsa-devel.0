Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143ABC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:04:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CB420772
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AXRemayR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CB420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEF9015F2;
	Mon, 10 Aug 2020 17:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEF9015F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597071852;
	bh=0bOVDpB9qt+zETAUkQt4qvXmsPCSDq4X20UTZdguKZU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXRemayRTDOu3gExLZT35u6HnwVxXxenIC1BgP6PTzIorbcxx2RVVLLmB8wqrw5/N
	 iylXf9EoI6AkukKdZJdPH+/umdqExuk+j63VH8sMsl4hKPUo/ijApBEL1Y55+oApg3
	 jGSvVofBh2/ZsceI7KKdv4+iqSXBLNlEnXc5sNZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C89AF801DB;
	Mon, 10 Aug 2020 17:03:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 897A8F8022B; Mon, 10 Aug 2020 17:03:19 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92C2CF800CE
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 17:03:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92C2CF800CE
IronPort-SDR: 3QHo/JABmSpS/NkEb4Kuz7sV2FN0qsyiSYheldTSQwrV3pxc9FlApy0FXOKXWpU/zTP9AkrWU3
 W55uxWOsx9fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="171585776"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; d="scan'208";a="171585776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 08:03:09 -0700
IronPort-SDR: 12GPmA8BCeQKGz3X7oWrHdalm2jYaMpo7RLVvb4zhfL6Ek6UshgXWdDmlDGRZyMjLYfytOv4Ny
 v8l1ys7ZGACg==
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; d="scan'208";a="438722426"
Received: from schen8-mobl.amr.corp.intel.com (HELO [10.212.235.58])
 ([10.212.235.58])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 08:03:07 -0700
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
 <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
 <DM6PR11MB3642D9BE1E5DAAB8B78B84B0974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hpn873by6.wl-tiwai@suse.de>
 <DM6PR11MB36423A9D28134811AD5A911F974A0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com>
 <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
Date: Mon, 10 Aug 2020 10:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Stuart <daniel.stuart14@gmail.com>,
 "yuhsuan@google.com" <yuhsuan@google.com>, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
 Damian van Soelen <dj.vsoelen@gmail.com>
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



On 8/6/20 11:41 AM, Lu, Brent wrote:
>>
>> I don't get this. If the platform driver already stated 240 and 960 samples why
>> would 432 be chosen? Doesn't this mean the constraint is not applied?
> 
> Hi Pierre,
> 
> Sorry for late reply. I used following constraints in V3 patch so any period which
> aligns 1ms would be accepted.
> 
> +	/*
> +	 * Make sure the period to be multiple of 1ms to align the
> +	 * design of firmware. Apply same rule to buffer size to make
> +	 * sure alsa could always find a value for period size
> +	 * regardless the buffer size given by user space.
> +	 */
> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> +			   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 48);
> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> +			   SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 48);

432 samples is 9ms, I don't have a clue why/how CRAS might ask for this 
value.

It'd be a bit odd to add constraints just for the purpose of letting 
userspace select a sensible value.
