Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F1C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:43:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B562075E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UWTz3l93";
	dkim=pass (1024-bit key) header.d=spliet.org header.i=@spliet.org header.b="HR+y+pH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B562075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=spliet.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78D3D16B8;
	Tue, 14 Apr 2020 14:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78D3D16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586868196;
	bh=wv6N5D6nTDg1cVva3xtaKLw7EHItp/5BIVutBNjdKcs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWTz3l9303ZcjkosFjaB/OVrBRPMPtXWwgKsPfwaT8aD47j3G8ERzjfVdQLSFUwyU
	 0g42ulIm1CdU1FO4i9D7NbsEvHvrguh6/hQndTcrhiHiAO+or9309nbr5qmzRCUwdE
	 32lhI+vVkfIQU4U4CbqtBswipXlpIpfrYQPnGSik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45ACDF80278;
	Tue, 14 Apr 2020 14:42:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EF28F8027C; Tue, 14 Apr 2020 14:42:21 +0200 (CEST)
Received: from mupuf.org (mupuf.org [167.71.42.210])
 by alsa1.perex.cz (Postfix) with ESMTP id B377FF800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 14:42:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B377FF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=spliet.org header.i=@spliet.org
 header.b="HR+y+pH9"
Received: from [10.42.0.61] (unknown [131.111.247.158])
 by Neelix.spliet.org (Postfix) with ESMTPSA id E57E86004C;
 Tue, 14 Apr 2020 13:42:12 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org E57E86004C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
 s=default; t=1586868133;
 bh=9j5UjyDny1EtSu/yxxSd7Vo42egHBK42P9sJh5L+UW0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HR+y+pH9zuIKHg1jm9iCqy/tMXLEFomxaOX4Ayym/Yv2O1xtauc5rxsRSAyr8YqkU
 k4jve4RLtGAEPlTvmJ/JIKaGde+y915+uPJXUFQUQWlOyHmmwEOrpRzjOXc8rm1ecT
 9CAmaa1cuEclOTyqB8+coi42gG0MT3Y7oe2Uwuks=
Subject: Re: [PATCH] ALSA: hda: enable the runtime_pm for non-vgaswitcheroo
 hda controllers
To: Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>
References: <20200414101405.6992-1-hui.wang@canonical.com>
 <s5hmu7ejra2.wl-tiwai@suse.de>
 <121237cf-8ef9-2a21-8ee3-6c6954e846e2@canonical.com>
From: Roy Spliet <nouveau@spliet.org>
Message-ID: <d73a3c02-360b-12d9-6e4b-fff60f819cd6@spliet.org>
Date: Tue, 14 Apr 2020 13:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <121237cf-8ef9-2a21-8ee3-6c6954e846e2@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.2 at Neelix
X-Virus-Status: Clean
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

Dear Hui, Takashi,

Op 14-04-2020 om 13:35 schreef Hui Wang:
> 
> On 2020/4/14 下午6:27, Takashi Iwai wrote:
>> On Tue, 14 Apr 2020 12:14:05 +0200,
>> Hui Wang wrote:
>>> Before the pci_driver->probe() is called, the pci subsystem calls
>>> runtime_forbib() and runtime_get_sync() on this pci dev, so only call
>>> runtime_put_autosuspend() is not enough to enable the runtime_pm on
>>> this device.
>>>
>>> For controllers with vgaswitcheroo feature, the pci/quirks.c will call
>>> runtime_allow() for this dev, then the controllers could enter
>>> rt_idle/suspend/resume, but for non-vgaswitcheroo controllers like
>>> Intel hda controllers, the runtime_pm is not enabled even it calls
>>> put_autosuspend(). Need to call runtime_allow() for those controllers
>>> in the hda driver.

 From what I can tell there are no ill effects of calling 
runtime_allow() twice. Technically, the check against 
use_vga_switcheroo() is thus redundant.
Is there a good reason why runtime_allow() is called in the pci quirks 
rather than in hda_intel? Is it a suggestion to perform this call in 
hda_intel regardless of whether it's a switcheroo-device or not, and 
removing calls to runtime_allow() from the PCI quirks?
Thanks. Best,

Roy
>>>
>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> Was this behavior changed from the earlier kernels?  I thought this
>> was left untouched because it's supposed to be set via udev rules or
>> such.
> 
> Oh, I don't know that,  according to my test with ubuntu rootfs, the 
> runtime pm is not enabled on Intel's hda controllers. But with the sof 
> driver, the controller driver calls runtime_allow() 
> (soc/sof/sof-pci-dev.c), so I sent this patch.
> 
> Regards,
> 
> Hui.
> 
>> OTOH, enabling the runtime PM is almost mandatory for modern systems,
>> and I'm fine to apply this kind of forcible enablement.
>>
>>
>> thanks,
>>
>> Takashi
>>
>>
>>> ---
>>>   sound/pci/hda/hda_intel.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>>> index 8519051a426e..779705bef88b 100644
>>> --- a/sound/pci/hda/hda_intel.c
>>> +++ b/sound/pci/hda/hda_intel.c
>>> @@ -2356,6 +2356,8 @@ static int azx_probe_continue(struct azx *chip)
>>>       if (azx_has_pm_runtime(chip)) {
>>>           pm_runtime_use_autosuspend(&pci->dev);
>>> +        if (!use_vga_switcheroo(chip))
>>> +            pm_runtime_allow(&pci->dev);
>>>           pm_runtime_put_autosuspend(&pci->dev);
>>>       }
>>> -- 
>>> 2.17.1
>>>
