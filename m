Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CDBC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:36:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B7820753
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dRo/oZaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B7820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43D9A83B;
	Wed, 18 Mar 2020 18:35:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43D9A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584552977;
	bh=KFhuJtRvtdU441wVfsF8ZpGRllhgGNxxsCJQS0vU5z4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRo/oZaN2RKAkL9XLiIZJgZ1MnnExI7M2jfPPxOH3qba+YTU0iPB0jFPDx9povImk
	 TzwzUOmXZSgRWIa8ye3ulRWq7z3SJQR2Znt4PpDIw1gPWN/wjn9WFrWJ+9QNdPL/kI
	 1/G4LgCsTLngkYbW4kc5ZLugeh+BZPx+29/KR1aI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3F05F80132;
	Wed, 18 Mar 2020 18:35:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4006AF800C0; Wed, 18 Mar 2020 18:35:25 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5C59F800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 18:35:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5C59F800C0
IronPort-SDR: iWN9btCaZAkyqafZv2rJPhapJ8r7UC78De0Le7t//pqgP8zeV7Vxi/wOGKBZrmfkYWu7lJzf5j
 QB63co3dWQBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 10:35:18 -0700
IronPort-SDR: eJivAF03MtxgvsTXnASYh8F1xz/kOR7FSU4Cp2MrlO1F/UdHlJ1Rn5TNDLMm6PfeXMMUGb+vQc
 3YtylSxZg9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; d="scan'208";a="238253292"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222])
 ([10.249.155.222])
 by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 10:35:14 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
 <20200318171912.GA6203@light.dominikbrodowski.net>
 <ea09e20f-d7d3-fde2-2c52-07c554d78e5e@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4cd918e3-bf1a-8345-2fd6-cdcb08fd82cc@intel.com>
Date: Wed, 18 Mar 2020 18:35:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ea09e20f-d7d3-fde2-2c52-07c554d78e5e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, curtis@malainey.com,
 Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com,
 linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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


On 2020-03-18 18:29, Pierre-Louis Bossart wrote:
> 
> 
> On 3/18/20 12:19 PM, Dominik Brodowski wrote:
>> On Wed, Mar 18, 2020 at 12:08:24PM -0500, Pierre-Louis Bossart wrote:
>>> On 3/18/20 11:20 AM, Dominik Brodowski wrote:
>>>> On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
>>>>>
>>>>>
>>>>>>>> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) 
>>>>>>>> causes me
>>>>>>>> some sound-related trouble: after boot, the sound works fine -- 
>>>>>>>> but once I
>>>>>>>> suspend and resume my broadwell-based XPS13, I need to switch to 
>>>>>>>> headphone
>>>>>>>> and back to speaker to hear something. But what I hear isn't 
>>>>>>>> music but
>>>>>>>> garbled output.
>>>>>
>>>>> It's my understanding that the use of the haswell driver is opt-in 
>>>>> for Dell
>>>>> XPS13 9343. When we run the SOF driver on this device, we have to 
>>>>> explicitly
>>>>> bypass an ACPI quirk that forces HDAudio to be used:
>>>>>
>>>>> https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd 
>>>>>
>>>>>
>>>>> Have you tried to run in plain vanilla HDAudio mode?
>>>>
>>>> I had (see 18d78b64fddc), but not any more in years (and I'd like to 
>>>> keep
>>>> using I2S, which has worked flawlessly in these years).
>>>
>>> ok. I don't think Intel folks have this device available, or it's 
>>> used for
>>> other things, but if you want to bisect on you may want to use [1] to 
>>> solve
>>> DRM issues. I used it to make Broadwell/Samus work again with SOF.
>>>
>>> [1] 
>>> https://gitlab.freedesktop.org/drm/intel/uploads/ef10c6c27fdc53d114f827bb72b078aa/0001-drm-i915-psr-Force-PSR-probe-only-after-full-initial.patch.txt 
>>>
>>>
>>> An alternate path would be to switch to SOF. It's still viewed as a
>>> developer option but Broadwell/Samus work reliably for me and we have a
>>> Broadwell-rt286 platform used for CI.
>>
>> What do you mean with SOF? And no other ideas on the root cause than a
>> tedious bisect?
> 
> Sound Open Firmware (SOF) [1]. You can build your own audio firmware for 
> Broadwell and the driver is supported in the mainline (you'd need to 
> disable the legacy driver [2]).
> 
> I can't think of any changes to that haswell/broadwell legacy driver, 
> apart from Takashi's buffer management changes 3f93b1ed4ac1e2.
> 
> But there were multiple changes to the ASoC core, so it's possible that 
> they impact suspend/resume. Just a blind guess.
> 
> [1] https://thesofproject.github.io/latest/index.html
> [2] 
> https://github.com/thesofproject/kconfig/blob/023cc25cd0b26a9757592d0bbbbe719825dd728d/sof-dev-defconfig#L20 
> 
> 

Please refrain from advertising SOF as a solution for this problem.

There were plenty changes done to dmaengine and ASoC during that time. 
Right now we are digging through the code.

While we might not have Dell XPS 13 available currently on our site, 
issue reproduces on our RVPs.

Regards,
Czarek
