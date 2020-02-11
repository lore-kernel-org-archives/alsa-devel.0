Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE9C35242
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:09:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA1C206DB
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TEyBUWC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA1C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5570C846;
	Tue, 11 Feb 2020 19:08:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5570C846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581444583;
	bh=sgnN+7OhrQAI3IGzSOhzXoWnEeSLqimkRNqRSbob9YU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TEyBUWC54zGRf19IDaU88s/FVAlwdIqefZf6Zq1De+NpSMwz72yqp86UyYyYo9Co3
	 d/Y0a2B3uyq7IRL95JD5eShAULDJRh8qVjkIlSZorPZBvvl1RQOl6pw59Rtv2/P6OG
	 Q8PnCPOOeek0WiSadt74d8LuclE0NqZoked659ac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAE15F8013E;
	Tue, 11 Feb 2020 19:08:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F1CCF80145; Tue, 11 Feb 2020 19:08:51 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 747C0F800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 19:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 747C0F800E7
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 10:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="222014389"
Received: from mahaling-mobl.amr.corp.intel.com (HELO [10.254.185.201])
 ([10.254.185.201])
 by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 10:08:34 -0800
To: "Lu, Brent" <brent.lu@intel.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
Date: Tue, 11 Feb 2020 10:30:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Support Opensource <Support.Opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, "Chiang, Mac" <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 "cychiang@google.com" <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
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


>> Could ensure? This change seems specific to Intel DSP based systems, at
>> least from the description. Having looked through the core, the trigger code
>> for a codec is seemingly always called before the trigger for the CPU. How will
>> this work for other platforms, assuming their clocks are enabled in the CPU
>> DAI trigger function by default?
>>
>> Can we always guarantee the CPU side isn't going to send anything other
>> than 0s until after SRM has locked?

Not with the default mode for the SSP, all clocks are enabled at trigger 
time.
We can enable the MCLK and BCLK ahead of time (which would require a 
change in firmware). But if we want to enable the FSYNC (word-clock), 
then we have to trigger DMA transfers with pretend-buffers, this is a 
lot more invasive.

So just to be clear, which of the MCLK, BCLK, FSYNC do you need enabled?

> I think the patch is for those systems which enable I2S clocks in pcm_start instead
> of pcm_prepare. It has no effect on systems already be able to turn on clocks in
> supply widgets or set_bias_level() function.
> 
> If the trigger type in the DAI link is TRIGGER_PRE, then the trigger function of FE port
> (component or CPU DAI) will be called before codec driver's trigger function. In this
> case we will be able to turn on the clock in time. However, if the trigger type is
> TRIGGER_POST, then the patch does not help because just like what you said, codec
> driver's trigger function is called first.

IIRC we recently did a change to deal with underflows. Ranjani, can you 
remind us what the issue was?
Thanks
-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
