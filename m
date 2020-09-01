Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6DC433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A5F206EB
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TBmy67wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A5F206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED7B517A4;
	Tue,  1 Sep 2020 15:38:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED7B517A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598967582;
	bh=HA9Y/X6b9DYrpBnJNb+x5rbgWdF4ZJXqf0hTw1C34bM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBmy67wn17OKjQAQuOvTxQ+LLk+W10+35GcrXazmrOw/LQyIiIWTDg/1XmAp0h5Pj
	 K6a/MP8XMZXjuKYuCvwAyKtAEeO3Jg1G4dgOn9sMClnqyfr13n+NbXOkK0gG40Uzmf
	 DpJqYwqaFEjtCU26AeTOSb8oWUsMWgkhnY1Vn5v4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87ECEF8020D;
	Tue,  1 Sep 2020 15:38:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A455FF80217; Tue,  1 Sep 2020 15:38:49 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2598AF801EB
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 15:38:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2598AF801EB
IronPort-SDR: spcKHF3YSJgcuVFcEXXdd6xbgOPQoU48tOU4AXw8NQP4uccdKkr0Ntc8lVSU8U5fc+X1Nm7H+c
 J/7LVYNp+KOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="218715910"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="218715910"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 06:38:37 -0700
IronPort-SDR: yNhtrgOLMNvmYBtp45aX8XSIe8tZzA4NHPsI6Q7bsWau1VxNvWxyHKhv/Gl2nf4pztgiDthoke
 HF+B5mLWsG6w==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="446130143"
Received: from dlabricc-mobl.amr.corp.intel.com (HELO [10.212.239.51])
 ([10.212.239.51])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 06:38:36 -0700
Subject: Re: [bug report] 'ASoC: Intel: haswell: Power transition refactor'
 and PulseAudio
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Christian Bundy <christianbundy@fraction.io>
References: <9bc5b3ac-87a0-4d7c-abfd-2407db90d310@www.fastmail.com>
 <28ee99bc-fe27-9111-893b-1cb000067a7c@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c5e8615d-5c8c-3aba-7ec6-6349ef4edbce@linux.intel.com>
Date: Tue, 1 Sep 2020 08:38:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <28ee99bc-fe27-9111-893b-1cb000067a7c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: liam.r.girdwood@linux.intel.com, zwisler@google.com,
 alsa-devel@alsa-project.org, broonie@kernel.org, yang.jie@linux.intel.com
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



On 9/1/20 6:33 AM, Cezary Rojewski wrote:
> On 2020-08-31 11:55 PM, Christian Bundy wrote:
>> After upgrading to Linux 5.8 I discovered an audio issue on my device 
>> that was introduced in 8ec7d6043263ecf250b9b7c0dd8ade899487538a [0]. I 
>> used 'git bisect' to identify the commit that introduced the bug and 
>> have confirmed that reverting the commit resolves the problem
>>
>> Reproduction:
>>
>> 1. Play any audio via PulseAudio.
>> 2. Observe that the audio output is fuzzy and choppy.
>>
>> I can use programs like mpv to play audio without PulseAudio, and the 
>> audio is fine, but as soon as I open a process that uses PulseAudio it 
>> will ruin the audio output for all processes (including mpv) until I 
>> reboot.
>>
>> I'm using a 2015 Chromebook Pixel ("Samus") and have confirmed this 
>> problem with a friend who has the same device.
>>
>> Is there anything I can do to help debug this instead of sending a 
>> patch to revert the commit?
>>
> 
> Hello Christian,
> 
> Thank you for report! Issue is a known one to us and has already been 
> addressed by:
> 
>      [PATCH v4 00/13] ASoC: Intel: Catpt - Lynx and Wildcat point
>      https://www.spinics.net/lists/alsa-devel/msg113762.html
> 
> waiting for final dependency to be merged (Andy's resource-API changes, 
> as Mark already added the SPI ones) so v5 with review changes can be 
> provided. Shouldn't be long before this gets merged. As consequence, 
> /haswell/ ceases to exist.

That leaves people with no working sound for 5.8 and 5.9.

> Basically, once power-cycle (D0 -> D3 -> D0 transition flow) had been 
> fixed, more - previously hidden - problems arisen. Instead of sending 
> 70+ patches to Mark refactoring existing code to recommended flow (+ 
> readability and performance improvements), replacement is provided along 
> with old code being removed entirely.
> 
> For now, if there's a possibility for you to modify your kernel, said 
> patch can be safely removed from your local repo. Note: following is the 
> outcome:
> - DMA init may occasionally fail on early boot (audio card won't be 
> present at all, requires reboot)
> - D0/D3 flow doesn't follow recommended sequence and thus power-saving 
> may be limited or non-existent
> Probably still better than permanently fuzzied audio..

Doesn't this mean that a revert is needed and applied to -stable for 5.8 
and 5.9?

