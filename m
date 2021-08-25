Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90446C432BE
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 18:35:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0EA610C8
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 18:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A0EA610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35C481654;
	Wed, 25 Aug 2021 20:34:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35C481654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629916524;
	bh=IKkkPN/ZRnDRlxbIPSHVCrNeRzlOdrQgAAEYgrgcoAg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYzihgx8o++BNlnkB928jOBZN89Ix6YVq0HlLt6x5DX057YEJam4lovNezCofq/S2
	 ZKefAcOH0hplYk8aDKyHbqdL9KC+NWxVcH5aqUAJMEjU1giUCOVQbE+FGkaOUG9jOY
	 TQijTeDgZFA6x+zXgrBdWvPjZVuP+rX3zlE0kDXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7B9CF80171;
	Wed, 25 Aug 2021 20:34:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26E0EF8020C; Wed, 25 Aug 2021 20:34:31 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 916EAF800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 20:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 916EAF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Q35Zf+Hh"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17PEu41q018363; 
 Wed, 25 Aug 2021 13:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=PODMain02222019;
 bh=tMFuP5qPU2NBg+yul2x1jPMb7f2OziontOI+BTc0520=;
 b=Q35Zf+Hhf70bPuHqwZkNHrvyYA4MjLe5wOIvI5S7ZkujN/BKQzXV6eF3HmZOcPldX4Ye
 qI/nCwkAbD9Zuo3TmaVc4ozKnq6QyQfH6Vo5eODhcmbYZzRBPqODeFVBByAh+J3WTQvM
 UMG7W0nMgkl/LhjkY+8h8PVBknQFzqqW2hvPZl0v0sjhtG33VX0LGAQtBfuX/lNlAHzv
 D+3hp45iexnvQAEDXIHyAitDGSwbIivCd8p3u07kDOJJlg+zCRh6haG0Q8GwG2LKld7H
 Qu7bzgb99fSO6XfdrdV1Njh7fIAZCNtgXrCr0jEcJqbEK26RulOLH8w9fIAErpcTDYB7 MA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3anr2erad9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 Aug 2021 13:34:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 19:04:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Wed, 25 Aug 2021 19:04:12 +0100
Received: from [198.90.238.186] (unknown [198.90.238.186])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3838B2A9;
 Wed, 25 Aug 2021 18:04:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] ALSA: hda/cs8409: Prevent pops and clicks during
 reboot
To: Takashi Iwai <tiwai@suse.de>
References: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
 <20210812183433.6330-2-vitalyr@opensource.cirrus.com>
 <s5h1r6xlvrs.wl-tiwai@suse.de> <s5hczqgil3v.wl-tiwai@suse.de>
 <6595e87d-1dae-b536-c17b-eafa07d04bbe@opensource.cirrus.com>
 <s5hpmuce05m.wl-tiwai@suse.de>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <e3df5f97-bf43-7eb8-e15d-4ab11dbae7ef@opensource.cirrus.com>
Date: Wed, 25 Aug 2021 19:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hpmuce05m.wl-tiwai@suse.de>
Content-Language: en-US
X-Proofpoint-GUID: SCiNZZHWgBQ8YJMzkt_f3_6P_z4duHnP
X-Proofpoint-ORIG-GUID: SCiNZZHWgBQ8YJMzkt_f3_6P_z4duHnP
X-Proofpoint-Spam-Reason: safe
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Stefan Binding <sbinding@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

On 17/08/2021 1:16 pm, Takashi Iwai wrote:
> On Tue, 17 Aug 2021 13:28:21 +0200,
> Vitaly Rodionov wrote:
>> On 14/08/2021 7:41 am, Takashi Iwai wrote:
>>> On Fri, 13 Aug 2021 08:10:47 +0200,
>>> Takashi Iwai wrote:
>>>> On Thu, 12 Aug 2021 20:34:33 +0200,
>>>> Vitaly Rodionov wrote:
>>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>>>
>>>>> During reboot, when the CS42L42 powers down, pops and clicks
>>>>> may occur due to the codec not being shutdown gracefully.
>>>>> This can be fixed by going through the suspend sequence,
>>>>> which shuts down the codec cleanly inside the reboot_notify
>>>>> hook, which is called on reboot.
>>>>>
>>>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>>>>> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>>>> I hold this one for now, as there is a fix series that deprecates the
>>>> reboot_notify callback of HD-audio by forcibly doing runtime-suspend
>>>> at shutdown.  Please check the three patches in
>>>>     https://bugzilla.kernel.org/show_bug.cgi?id=214045
>>>>
>>>> I'm going to submit those soon in anyway.
>> Hi Takashi,
>>
>> Thanks for letting us know. We have tested against for-next branch and
>> we have an issue.
>>
>> Loud pops on reboot. It looks like suspend have never been called on
>> reboot or shutdown for us.
> OK, we need to track down the cause.
>
> Does the noise persist if the codec has been runtime-suspended
> beforehand?  You can check the status in sysfs.

Hi Takashi,

Sorry for the delay. We just wanted to get as much information as 
possible. Now we can see what causing pops on reboot.

Actually when codec is suspended and we do reboot from UI, then 
sometimes we see suspend() calls in kernel log and no pops, but sometimes

we still have no suspend() on reboot and we hear pops. But when we do 
reboot from command line: > sudo reboot  then we always have pops and no 
suspend() called.

Then we have added extra logging and we can see that on reboot codec 
somehow getting resume() call and we run jack detect on resume that 
causing pops.

We were thinking about possible solution for that and we would propose 
some changes in generic code hda_bind.c:

static void hda_codec_driver_shutdown(struct device *dev) { +   if 
(codec->patch_ops.suspend) +      codec->patch_ops.suspend(codec);    
snd_hda_codec_shutdown(dev_to_hda_codec(dev)); +  
hda_codec_driver_remove(dev_to_hda_codec(dev)); }

This have been tested on all our platforms without regression and it 
fixes pops issue on dolphin HW

as well for reboot from UI and > sudo reboot. We always getting 
suspend() calls

on reboot.

Thanks,

Vitaly

>
>
> thanks,
>
> Takashi

