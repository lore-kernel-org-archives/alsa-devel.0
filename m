Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCFC4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:26:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0E120848
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lz6P+14L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0E120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05AA4191A;
	Thu,  1 Oct 2020 18:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05AA4191A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601569613;
	bh=/fMO4oXuWMM8yYzPx8EWp68S7t83S4CHxZMLZz8QaM0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lz6P+14LCNlSg14OHGrGm4fxjqTtiEM8IIeLZkPfjkQ+z282bNJV0KzKCCRa8bA78
	 8J9zLJYOmWHvLnKp0MMMUmyaQsJcrt4ZYETTvMGAIF7mMP9HWb7OaldI+fFfhamZtf
	 RaaU6OU6w2Zo1jQ7lu0x2DMZEGiRTAdTAYJXtMhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89588F801DB;
	Thu,  1 Oct 2020 18:26:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2364DF801F5; Thu,  1 Oct 2020 18:26:01 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9397F80105
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 18:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9397F80105
IronPort-SDR: JgAestnppbc3a2eMZurTN/OVKK9e3TmgWDYBHjhXyjM2M4xxgk8IGmOG7YzrlyPqtUCQozr7ke
 v29KJ6B7PtCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160182548"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="160182548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 09:25:49 -0700
IronPort-SDR: aCA/D+/HoRuOkPtytZFfI+m5+cBlm7dZhfRqPuqynepklomGxY+ZjgYi7GF8YrpCb3jtLVK4LD
 0CLf8CTFSC5w==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="416125515"
Received: from myounan-mobl1.amr.corp.intel.com (HELO [10.251.131.17])
 ([10.251.131.17])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 09:25:48 -0700
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
To: Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <CGME20200929084051epcas2p35fb2228ed1bdfce6a7ddf5b37c944823@epcas2p3.samsung.com>
 <000001d6963c$3cc53690$b64fa3b0$@samsung.com> <s5heemlklo0.wl-tiwai@suse.de>
 <20201001102938.GU2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2bf52360-bd11-b4cd-b255-8a5610b4aa5f@linux.intel.com>
Date: Thu, 1 Oct 2020 10:28:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001102938.GU2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, kimty@samsung.com,
 s47.kang@samsung.com, lgirdwood@gmail.com, tiwai@suse.com, hmseo@samsung.com,
 Gyeongtaek Lee <gt82.lee@samsung.com>, pilsun.jang@samsung.com,
 tkjung@samsung.com
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




>>>> Hrm, this resulted in rather more complex changes than the original
>>>> patch.  It shows that introducing yet another state is no good idea
>>>> for this particular case.
>>>>
>>>> Since the possible application's behavior after this pause is as same
>>>> as the normal pause (i.e. either resuming pause or dropping), I find
>>>> it OK to take the original approach.
>>> Thank you for the review.
>>> I think that I should resend the original patch.
>>
>> Let's wait a bit for other opinions.  We may add rather a new flag
>> instead of introducing a new state, too, for example.
> 
> I was out for a week, back now ;-)
> 
> So bigger question is if kernel should handle this change or we ask
> userspace to handle this. Userland knows that bit rate is less so small
> buffer can be for longer duration so instead of sending dumb X bytes,
> should it not scale the buffer based on bit rate?

what about variable bit-rate? or cases where you have a 'bit reservoir' 
in previous frames?

You really cannot in general translate bytes to time with compressed 
data, which is the reason we introduced the API in the first place...

Userspace *may* know the duration for specific formats or based on 
metadata, but in some cases the only way to know is actually to decode 
the data.

I suggest we keep the compressed API based on bytes and non-periodic 
events when the bytes were consumed/generated.
