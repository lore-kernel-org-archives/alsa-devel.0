Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD7C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:08:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEB220774
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q7Eyysn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEB220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8C2915F2;
	Mon, 30 Mar 2020 22:07:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8C2915F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585598880;
	bh=FN/9KN25r+MqUa1xSiF07Q7Pn6aoOA9D/INmLPIDbx4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q7Eyysn81uTfHJKsJ55Z31/Zo4BqAZzWZIkCG3zo34Pq60v113L29xd+qZu4r0ZSY
	 spyNLwqHLIqXneKoW9XRZyp8iOncyRmtOrR8X+vt1gbZ8ThhSVDzSGhyzPhT5/hFTX
	 Rf3yH0+nj55At1XSNj9R83C/OWFg6hi7qfyBNibA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 376FCF80145;
	Mon, 30 Mar 2020 22:07:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6945BF8014A; Mon, 30 Mar 2020 22:07:07 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17139F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 22:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17139F800EB
IronPort-SDR: 0F4GHM3hFFYIXEdc6w5o1N2+NFSKNC0MYjORiUv4HF6OrdXQElUrtPmg4STVNb7Yi3BLHjp6l0
 QPA1viOXZoFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 13:06:58 -0700
IronPort-SDR: dKd5npGNGD+oyT0z5BbnKesc606wf9jDkxdC1b20RSimKisMGaiDG/njSNnJaGy8Zk0okuaD/r
 VkLnnV5Zd3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="248816597"
Received: from unknown (HELO [10.134.63.32]) ([10.134.63.32])
 by orsmga003.jf.intel.com with ESMTP; 30 Mar 2020 13:06:57 -0700
Subject: Re: [PATCH v2 3/6] ASoC: topology: Check return value of
 soc_tplg_*_create
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20200327204729.397-1-amadeuszx.slawinski@linux.intel.com>
 <20200327204729.397-4-amadeuszx.slawinski@linux.intel.com>
 <ea618248-5c0c-24f2-b1fb-2b5aecb16049@linux.intel.com>
 <41ce872f-7fa5-74cd-396b-9bfae989e91c@linux.intel.com>
 <8e03a294-3562-7e26-6654-a5b0f7970060@linux.intel.com>
 <521f1ccc-2c7c-aa9d-cb15-16ee16831e71@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2be95aa5-ebde-e29a-4d90-bbc71b160677@linux.intel.com>
Date: Mon, 30 Mar 2020 11:36:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <521f1ccc-2c7c-aa9d-cb15-16ee16831e71@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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



On 3/30/20 11:10 AM, Amadeusz Sławiński wrote:
> 
>>>> Sounds good, but this happens in a loop, so would all the memory 
>>>> previously allocated by denum/dbytes/dmixer_create leak, or is it 
>>>> freed automatically somewhere else?
>>>>
>>>
>>> Well, now that error is propagated, snd_soc_tplg_component_remove() 
>>> should be called by snd_soc_tplg_component_load() in case of errors 
>>> while parsing. From quick look it seems like it should be able to 
>>> free it up correctly by calling remove_enum/bytes/mixer.
>>
>> I am not sure what you meant by 'should be called', if it's a 
>> recommendation for a future change or a description of the existing 
>> behavior.
>> Just to be clear, are you saying the existing code will take care of 
>> this error flow or that a new patch is needed?
> 
> Existing code should handle this properly.
> No new code is needed.

Sounds good, thanks.
