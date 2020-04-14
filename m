Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524BC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960C02078B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U9O/OKst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960C02078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E05001692;
	Tue, 14 Apr 2020 14:36:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E05001692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586867819;
	bh=1qnucUooKOW6N9bOY4US2FDcMx6LlZXgyg1vmYC+oZ0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U9O/OKst1rr5O8LZzDgEAV04KDhn9/2/OJLXgN10BwR7IGSoMD/lo2KeZNUu3HWxs
	 05Db5a2AOaG9OyU8MLONJWPujUwUVbwvqdk5IBrcRtq3FWLhUOUJ2w/2uslzcfb0K2
	 kDNbv4Y0NmfuVS0iaDr46WlH99o4pqHyHh3bTSPw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65979F800F5;
	Tue, 14 Apr 2020 14:36:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4BFEF8013D; Tue, 14 Apr 2020 14:36:05 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2503F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 14:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2503F800B9
Received: from [222.130.141.248] (helo=[192.168.2.104])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jOKnG-0001mp-8m; Tue, 14 Apr 2020 12:35:58 +0000
Subject: Re: [PATCH] ALSA: hda: enable the runtime_pm for non-vgaswitcheroo
 hda controllers
To: Takashi Iwai <tiwai@suse.de>
References: <20200414101405.6992-1-hui.wang@canonical.com>
 <s5hmu7ejra2.wl-tiwai@suse.de>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <121237cf-8ef9-2a21-8ee3-6c6954e846e2@canonical.com>
Date: Tue, 14 Apr 2020 20:35:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hmu7ejra2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2020/4/14 下午6:27, Takashi Iwai wrote:
> On Tue, 14 Apr 2020 12:14:05 +0200,
> Hui Wang wrote:
>> Before the pci_driver->probe() is called, the pci subsystem calls
>> runtime_forbib() and runtime_get_sync() on this pci dev, so only call
>> runtime_put_autosuspend() is not enough to enable the runtime_pm on
>> this device.
>>
>> For controllers with vgaswitcheroo feature, the pci/quirks.c will call
>> runtime_allow() for this dev, then the controllers could enter
>> rt_idle/suspend/resume, but for non-vgaswitcheroo controllers like
>> Intel hda controllers, the runtime_pm is not enabled even it calls
>> put_autosuspend(). Need to call runtime_allow() for those controllers
>> in the hda driver.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Was this behavior changed from the earlier kernels?  I thought this
> was left untouched because it's supposed to be set via udev rules or
> such.

Oh, I don't know that,  according to my test with ubuntu rootfs, the 
runtime pm is not enabled on Intel's hda controllers. But with the sof 
driver, the controller driver calls runtime_allow() 
(soc/sof/sof-pci-dev.c), so I sent this patch.

Regards,

Hui.

> OTOH, enabling the runtime PM is almost mandatory for modern systems,
> and I'm fine to apply this kind of forcible enablement.
>
>
> thanks,
>
> Takashi
>
>
>> ---
>>   sound/pci/hda/hda_intel.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 8519051a426e..779705bef88b 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -2356,6 +2356,8 @@ static int azx_probe_continue(struct azx *chip)
>>   
>>   	if (azx_has_pm_runtime(chip)) {
>>   		pm_runtime_use_autosuspend(&pci->dev);
>> +		if (!use_vga_switcheroo(chip))
>> +			pm_runtime_allow(&pci->dev);
>>   		pm_runtime_put_autosuspend(&pci->dev);
>>   	}
>>   
>> -- 
>> 2.17.1
>>
