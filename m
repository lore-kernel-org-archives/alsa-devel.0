Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9CC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:32:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E146127C
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E146127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61FBA1777;
	Thu, 15 Jul 2021 10:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61FBA1777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337955;
	bh=5qlio5MVW6miFSyh7Ou9LBMSyeD2LJIHLWApElkJ1X0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hn8j31rnVVIC+IhlqM/c/UEx6diH8UysPAfIK+GsJ1aLD3ZC7AGCFv3meJO0iog7O
	 UfdQEsY/6dj3n7iLD2ec4BRh2NdM5EAAmwTtV8TqfwnjQzC0u4xOOuvyx4ATuiohCz
	 xIgVFzob1rGvIcO8sRVTwp0MOQg16YJrS1GXz4uk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AC82F80240;
	Thu, 15 Jul 2021 10:07:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29F4CF804E6; Thu, 15 Jul 2021 10:07:44 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D11AF80240
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D11AF80240
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210547022"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="210547022"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 01:07:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="495208166"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO [10.252.59.202])
 ([10.252.59.202])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 01:07:27 -0700
Subject: Re: [PATCH 0/2] ALSA: compress: Cleanup and a potential fix
To: Takashi Iwai <tiwai@suse.de>
References: <20210714162424.4412-1-tiwai@suse.de> <YO+uAyrdT1xzLFIa@matsya>
 <74151b06-a1cd-3a6b-ef1e-8db03eb815ad@gmail.com>
 <2ac2e847-9c14-658e-8d75-0b93a8ddd0d6@linux.intel.com>
 <s5hpmvkxaub.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Message-ID: <1920c5d7-4721-9587-29f2-fed7f2715604@linux.intel.com>
Date: Thu, 15 Jul 2021 11:07:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hpmvkxaub.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 P9ter Ujfalusi <peter.ujfalusi@gmail.com>, alsa-devel@alsa-project.org
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



On 7/15/2021 11:03, Takashi Iwai wrote:
> On Thu, 15 Jul 2021 09:56:59 +0200,
> Ujfalusi, Peter wrote:
>>
>>
>>
>> On 7/15/2021 10:51, Péter Ujfalusi wrote:
>>>
>>>
>>> On 15/07/2021 06:39, Vinod Koul wrote:
>>>> On 14-07-21, 18:24, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> this series contains a couple of patches for compress-offload API, one
>>>>> for a cleanup of unused API functions and another for the proper mutex
>>>>> initialization.  I stumbled on the second while doing the first.
>>>>
>>>> Thanks for the cleanup. We never have a compress only device and it is a
>>>> mix of PCM and compress FEs mostly :)
>>>
>>> Actually I'm working on a series where a card would only contain nothing
>>> else but a compr, no PCMs...
>>
>> and I should have replied from here ;)
>>
>> I'm preparing to split up the SOF into IPC clients [1] and the probes
>> support (which is using compress API) is going to be moved as a separate
>> client, creating it's own sound card with the single comprCxD0 (and the
>> controlCx).
>>
>> Is this cleanup going to prevent this?
> 
> Unless you use snd_compress_register() function, nothing can break.
> And if you were to use the function together with ASoC, it must be
> very wrong :)

Yes, I just checked the patch ;)

and since I just did that:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Thank you,
Péter
