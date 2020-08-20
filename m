Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359ADC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30452078B
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z9y3pt3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30452078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 392B8167C;
	Thu, 20 Aug 2020 03:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 392B8167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597887839;
	bh=MbufvYMZMcNYenH7FdO/pLwyvXQIQ0QaL53Cz7Bu2pE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9y3pt3CScDmM3yw8cyrItRPFIYSF2GBxd4Wessr0hScGnIm8LE8SDZeSI+VNgx24
	 RZGduOlTWz7ykStDtXcfNzdT0K4RKROybdFP4/UqEEj/G9shVl1L0AxR/6C0Jn1yG+
	 6repDTOLOsPdjEKKbpAHUN0jG8PjFpZC58vg73TU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9497F801F9;
	Thu, 20 Aug 2020 03:43:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD5AFF80228; Thu, 20 Aug 2020 03:43:06 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03FB1F800C0
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 03:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03FB1F800C0
Received: from [111.196.79.150] (helo=[192.168.0.103])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k8ZbU-0006l0-8l; Thu, 20 Aug 2020 01:42:56 +0000
Subject: Re: [PATCH] ALSA: usb-audio: Add prevent wakeup from s3 state trig by
 Lenovo ThinkCentre TI024Gen3 USB-audio
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Takashi Iwai <tiwai@suse.de>
References: <20200819115757.23168-1-penghao@uniontech.com>
 <s5h364ih7vd.wl-tiwai@suse.de>
 <74B3A9AD-8B49-4E5F-BE9F-BF88865304B7@canonical.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <fdd0d029-d7b5-ff43-5f84-9d73de867bca@canonical.com>
Date: Thu, 20 Aug 2020 09:42:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <74B3A9AD-8B49-4E5F-BE9F-BF88865304B7@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 penghao <penghao@uniontech.com>, linux-kernel@vger.kernel.org,
 crwulff@gmail.com, gustavoars@kernel.org, alexander@tsoy.me,
 Mark Pearson <mpearson@lenovo.com>, dan.carpenter@oracle.com
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


On 2020/8/20 上午2:10, Kai-Heng Feng wrote:
>
>> On Aug 20, 2020, at 01:18, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> [ Adding a few more relevant people to Cc. ]
>>
>> On Wed, 19 Aug 2020 13:57:57 +0200,
>> penghao wrote:
>>> TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
>>> enter sleep mode, USB-audio will disconnect from USB bus port,
>>> wakup form s3 state
>>>
>>> Signed-off-by: penghao <penghao@uniontech.com>
>>> ---
>>> sound/usb/card.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 696e788c5d31..6bdbb34009b3 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -658,6 +658,12 @@ static int usb_audio_probe(struct usb_interface *intf,
>>> 	}
>>>
>>> 	dev_set_drvdata(&dev->dev, chip);
>>> +	/*
>>> +	 *ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo
>>> +	 *ThinkCentre TI024Gen3 usb-audio
>>> +	 */
>>> +	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
>>> +		device_set_wakeup_enable(＆dev->dev, 0);
>> Here it's no proper ASCII letter, and this must be broken.
>> Please check the actual patch before submitting.
>>
>> In anyway, before going further, I'd like to hear from other people
>> whether this is really mandatory and appropriate.  And whether it's
>> specific to that device, too (not other Lenovo devices?)
> If USB remote wakeup on this device is broken then we need to fix it in USB core instead of USB audio.
> We need USB and xHCI logs to understand the real problem here, the commit message doesn't contain enough information.
>
> Kai-Heng

I checked with our QA, we didn't enable this machine before.  And I 
tried 2 different usb audio cards, neither of them has wakeup 
capability. it is weird that your usb sound card (maybe a built-in usb 
sound card) has wakeup capability.

You could file a bug to 
https://bugs.launchpad.net/ubuntu/+source/linux/+filebug, then upload 
the needed logs,  Kai-Heng and I will help investigate this issue.

Thanks,

Hui.

>>
>> thanks,
>>
>> Takashi
