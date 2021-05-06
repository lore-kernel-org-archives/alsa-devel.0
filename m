Return-Path: <SRS0=TimU=KB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A87C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 07:25:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F6C61168
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 07:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F6C61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8C44847;
	Thu,  6 May 2021 09:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8C44847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620285910;
	bh=aVCLl+Kda4SFywsWUe9J/bdji+fXiA+fIYTAV5NUlB8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uhPJemnbK391jlE8Ts0qc7iVx8RlH/6h0I64GvBiI8M3bYGSf60sTX8eSc2AjPvLs
	 fV2bv+q/iyS0J8fGqIkQDtxaYOHmpz63fSAd1C8/FoiRITGhVvRvRYLqfAXf/ON9hk
	 1FZ1xtU5wzqPzWYnoxg6rPvt3UWZ+Xyph0fbC874=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 586E5F801F7;
	Thu,  6 May 2021 09:24:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B372F80139; Thu,  6 May 2021 09:24:19 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECD28F80139
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 09:24:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECD28F80139
Received: from [123.112.70.57] (helo=[192.168.0.107])
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <hui.wang@canonical.com>)
 id 1leYMf-00055e-Tx; Thu, 06 May 2021 07:24:06 +0000
Subject: Re: [PATCH] ALSA: hda: generic: change the DAC ctl name for LO+SPK or
 LO+HP
To: Takashi Iwai <tiwai@suse.de>
References: <20210504073917.22406-1-hui.wang@canonical.com>
 <s5ha6parjdd.wl-tiwai@suse.de>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <071c1076-e66d-e93e-ffe1-13a6c095fd13@canonical.com>
Date: Thu, 6 May 2021 15:23:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <s5ha6parjdd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
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


On 5/4/21 4:30 PM, Takashi Iwai wrote:
> On Tue, 04 May 2021 09:39:17 +0200,
> Hui Wang wrote:
>> Without this change, the DAC ctl's name could be changed only when
>> the machine has both Speaker and Headphone, but we met some machines
>> which only has Lineout and Headhpone, and the Lineout and Headphone
>> share the Audio Mixer0 and DAC0, the ctl's name is set to "Front".
>>
>> On most of machines, the "Front" is used for Speaker only or Lineout
>> only, but on this machine it is shared by Lineout and Headphone,
>> This introduces an issue in the pipewire and pulseaudio, suppose users
>> want the Headphone to be on and the Speaker/Lineout to be off, they
>> could turn off the "Front", this works on most of the machines, but on
>> this machine, the "Front" couldn't be turned off otherwise the
>> headphone will be off too. Here we do some change to let the ctl's
>> name change to "Headphone+LO" on this machine, and pipewire and
>> pulseaudio already could handle "Headphone+LO" and "Speaker+LO".
>> (https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/747)
>>
>> BugLink: http://bugs.launchpad.net/bugs/804178
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> I'm fine to take the change, but wouldn't this break anything else in
> PA?  Once when I get a positive answer, I'll apply it.

I think this change is safe to PA, both "Headphone+LO" and "Speaker+LO" 
are already in the analog-output-*.conf of PA. And I raised the 
regression concern in the 
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/747, all 
participants of the discussion on that issue don't express objection on 
this change so far.

Thanks,

Hui.

>
> thanks,
>
> Takashi
>
>> ---
>>   sound/pci/hda/hda_generic.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
