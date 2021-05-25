Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2BC47085
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 10:31:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A10610FC
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A10610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36895172C;
	Tue, 25 May 2021 12:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36895172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621938676;
	bh=Qg9dczt7puFDHipMcGUOqraklOdTHlE0GOMieHeUDB4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHG72zrUA8qxAsCdi5ZdfKHFIbPoCNuTzwQ+WOtXHOinXP10pjGLGvLg4vGhESAns
	 jNAXb8qMQItWA63MHzjLtgpMLJ4xAdp4faf5ZQ+3RgnokEnMuqZpMlYhIF7jY5v++0
	 KlPuZx9EbS3tctxDhORDoUAnYNDMGbj0rYDaHNsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACC4FF80113;
	Tue, 25 May 2021 12:30:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B9A0F801EB; Tue, 25 May 2021 12:30:23 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C9C0F80137
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 12:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C9C0F80137
IronPort-SDR: ClthdNk/AJix3ywRRlQYY6yWx8BYyte/rCfHNokl0AQKcWQGDOTWR0Lz28Rceh5aNHJC3XCGo6
 a0McdIqu4siw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189279539"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; d="scan'208";a="189279539"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 03:30:07 -0700
IronPort-SDR: uEVoL0cFaDTDTa2XPmnnBLS3Iwzi8jAtd+Z11EI8HoyKu/BA1be01AV7Ut/nzLpEd7fNLc4Yrk
 3xvcwOhBHEsQ==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; d="scan'208";a="476357082"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO [10.252.39.140])
 ([10.252.39.140])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 03:30:06 -0700
Subject: Re: [PATCH] ALSA: hda: Add Lenovo ThinkStation P340 to
 power_save_denylist
To: Takashi Iwai <tiwai@suse.de>, hui.wang@canonical.com
References: <20210524152533.7479-1-peter.ujfalusi@linux.intel.com>
 <s5hfsybe0vo.wl-tiwai@suse.de>
 <3e7428d2-2cfd-5835-33ef-72f3a2f43324@linux.intel.com>
 <s5h5yz7dxxj.wl-tiwai@suse.de>
 <2a2cc0cc-a7b4-9981-b463-06919ced72a8@linux.intel.com>
 <s5htumrcgsr.wl-tiwai@suse.de>
From: "Ujfalusi, Peter" <peter.ujfalusi@linux.intel.com>
Message-ID: <640e0b07-ff89-3a19-bbc8-507391f7b861@linux.intel.com>
Date: Tue, 25 May 2021 13:30:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <s5htumrcgsr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, kai.vehmanen@linux.intel.com
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



On 5/25/2021 12:18 PM, Takashi Iwai wrote:
> On Tue, 25 May 2021 11:04:14 +0200,
> Ujfalusi, Peter wrote:
>>
>>
>>
>> On 5/25/2021 11:23 AM, Takashi Iwai wrote:
>>>>> Let's check other possibilities
>>>>> at first, e.g. setting auto_mute_via_amp flag.  This can be achieved
>>>>> even via hints in an early patching specified via "patch" option of
>>>>> snd-hda-intel module (see Documentation/sound/hda/notes.rst for some
>>>>> information).
>>>>
>>>> Unfortunately the auto_mute_via_amp has no effect on the pop.
>>>> line_in_auto_switch and pin_amp_workaround have no effect either.
>>>
>>> How about applying alc_fixup_no_shutup() or alc_fixup_disable_aamix()?
>>
>> it looks like
>>
>> SND_PCI_QUIRK(0x17aa, 0x1048, "Lenovo ThinkStation P340",
>> ALC269_FIXUP_NO_SHUTUP),
>>
>> in alc269_fixup_tbl[]
>>
>> alone fixes the pop noise, I'll send a new patch to do this instead.
> 
> Good to hear.
> 
> But, there is already a quirk entry for this ID, so you'll need to put
> a chain there instead, I suppose.

Adding Hui Wang who added old fixup fir the mics.

Oh, I see.
It might be that the "ThinkCentre Station" is actually refers to
"ThinkStation P340" in that case I wonder if the plock/pop can be
observed by Hui Wang as well and confirm that it is the same model.

do you have any suggestion on naming the chain for the P340 headset-mic
and no-plop on lineout fixup enum/text/entry?

-- 
Péter
