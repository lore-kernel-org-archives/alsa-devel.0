Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E467CCD5BB1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:13:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23D126020D;
	Tue, 26 May 2026 17:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23D126020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808399;
	bh=OKfkpQ0NnBSMoIX3yZjPs7WX/VwicQJLrijB1e7OyJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZFXHe2d4+KgIfq+t5FNoIqmwbBtc4pSWb51dbnVV2D9QNVEOcAumhEVjOwUvS4Nld
	 SbwXKmGOSKnvdqiZQMA2FB5x/5kTgiNHwxkM6ZZz5opv7xreVCG6/08QxoYKXWwJbL
	 P173+qeteub3x4v/JTmyX+/4JKDY8fur87xtQk0c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4C5AF805F2; Tue, 26 May 2026 17:12:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 242B7F805F0;
	Tue, 26 May 2026 17:12:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3EFFF80557; Mon, 25 May 2026 10:03:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 73D77F8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:03:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73D77F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E+yuIoNz
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 48EB443477;
	Thu, 21 May 2026 11:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9021F000E9;
	Thu, 21 May 2026 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363791;
	bh=6exLDUNMJShJVw6ZjJRpJgvDUskVpNhcpmEurhYGDKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E+yuIoNzVnIUyez445DTnTp9HI9tsQ8Z1hfPvkMh88OvgOmooLJpUe9cZwU/yMKa0
	 DaWOLJMsObARGQfiKWcu6RJodcSv58/t7FTL8TIQC9QKjhxkaas4A4ba+MRGIeKANN
	 9GslTqdxFyDG/XjSjicNz1K06BZdufuBIYHokQlKe6lNPq29O8+4W6uyvLGBYQvCth
	 D89OUxyP8h+wajNhyJoDybnyOvu9KehEPMeQnBVMhScHSawLvQHk/qVFcQUPEX9s7u
	 lGdS9P0Q/fFP0FRH1kOmyspu95kHxrWfXxuWSIsY7eebvcrgGpIz7aJbBBDGlLvqJv
	 FXri71qWhShCA==
Message-ID: <2feeb837-ba7a-497b-be94-67756019b5cf@kernel.org>
Date: Thu, 21 May 2026 06:43:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ASoC: amd: acp7x: add system and runtime PM ops
Content-Language: en-US
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-6-Vijendar.Mukunda@amd.com>
 <905bfeff-ab78-4299-a2a4-45fb8f05e716@amd.com>
 <fe98d961-c02c-4794-868e-7911991f7321@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <fe98d961-c02c-4794-868e-7911991f7321@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: CO3ZTCIDLHSGYKWHRTVWM7MAT4ASV3IS
X-Message-ID-Hash: CO3ZTCIDLHSGYKWHRTVWM7MAT4ASV3IS
X-Mailman-Approved-At: Tue, 26 May 2026 15:12:39 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CO3ZTCIDLHSGYKWHRTVWM7MAT4ASV3IS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/21/26 06:41, Mukunda,Vijendar wrote:
> On 08/05/26 01:03, Mario Limonciello wrote:
>>
>>
>> On 5/7/26 13:11, Vijendar Mukunda wrote:
>>> Add ACP7.x PM callbacks and hook up system sleep and runtime PM ops for
>>> the PCI driver.
>>>
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> ---
>>>    sound/soc/amd/acp7x/acp7x-common.c | 43 ++++++++++++++++++++++++++++++
>>>    sound/soc/amd/acp7x/acp7x.h        |  3 +++
>>>    sound/soc/amd/acp7x/pci-acp7x.c    | 31 +++++++++++++++++++++
>>>    3 files changed, 77 insertions(+)
>>>
>>> diff --git a/sound/soc/amd/acp7x/acp7x-common.c
>>> b/sound/soc/amd/acp7x/acp7x-common.c
>>> index 68f9b47766c4..df94864a1693 100644
>>> --- a/sound/soc/amd/acp7x/acp7x-common.c
>>> +++ b/sound/soc/amd/acp7x/acp7x-common.c
>>> @@ -75,8 +75,51 @@ static int acp7x_deinit(void __iomem *acp_base, struct
>>> device *dev)
>>>        return 0;
>>>    }
>>>    +static int __maybe_unused snd_acp7x_suspend(struct device *dev)
>>> +{
>>> +    struct acp7x_dev_data *adata;
>>> +    int ret;
>>> +
>>> +    adata = dev_get_drvdata(dev);
>>> +    ret = acp_hw_deinit(adata, dev);
>>> +    if (ret)
>>> +        dev_err(dev, "ACP de-init failed\n");
>>> +    return ret;
>>> +}
>>> +
>>> +static int __maybe_unused snd_acp7x_runtime_resume(struct device *dev)
>>> +{
>>> +    struct acp7x_dev_data *adata;
>>> +    int ret;
>>> +
>>> +    adata = dev_get_drvdata(dev);
>>> +    ret = acp_hw_init(adata, dev);
>>> +    if (ret) {
>>> +        dev_err(dev, "ACP init failed\n");
>>> +        return ret;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int __maybe_unused snd_acp7x_resume(struct device *dev)
>>> +{
>>> +    struct acp7x_dev_data *adata;
>>> +    int ret;
>>> +
>>> +    adata = dev_get_drvdata(dev);
>>> +    ret = acp_hw_init(adata, dev);
>>> +    if (ret)
>>> +        dev_err(dev, "ACP init failed\n");
>>> +
>>> +    return ret;
>>> +}
>>
>> Both of snd_acp7x_runtime_resume and snd_acp7x_resume look identical. Will
>> there be later code (when machine driver and IO enablement come) that makes
>> them different?
> 
> Yes, when IO enablement code is updated, both the functions are going to be
> different.
> We need to keep it separately.
> 

Thanks, no concerns with the series then.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
