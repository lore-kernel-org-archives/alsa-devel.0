Return-Path: <SRS0=HPKo=AB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D7DC433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Jun 2020 07:28:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F5B239D2
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Jun 2020 07:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LfFF6n5s";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="YghMBid9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F5B239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 719F71697;
	Sat, 20 Jun 2020 09:27:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 719F71697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592638088;
	bh=sQvEjRwvfzCFf6+rPfiE8uoy8UES2a++Xf5Mt33XrmY=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfFF6n5saP/C4JZVt+UNCoq6lDwbPVd7Yp90oKvVvVJvLRQCES9t5IDcv5gwtGybm
	 cL4dl7o2eziQvAe0Ib6xiRF5Au7Gkn+/FX3HYDMvQeTsqB5Dfkj+w83TtJHxczSc1n
	 WIQBMSugYYLOaGkq5J/BKwdO7JTVHTtA88+vvUgI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4683F80162;
	Sat, 20 Jun 2020 09:27:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EFDBF80171; Sat, 20 Jun 2020 09:27:17 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21D14F800B5
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2020 09:27:11 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D11C2A003F;
 Sat, 20 Jun 2020 09:27:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D11C2A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1592638030; bh=x57H9TPbS121OWadrl17W47+nIO6BZyBUIAU1JJNOTo=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=YghMBid902sNgw+zdvDbHfPmnGjtw+XDPlAweKy57w2/FPe494MfNN/RdM7zkisuS
 3fWrJkzKvTipoomRfKiUjDkE5y++JaNMT5Lv9zJrpN3A70W91IGLJc6zUEFd/JzZyc
 +2+J0s/+yd2yViBy8kdmNwuGManl/gFn6jxbHMFQ=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 20 Jun 2020 09:27:07 +0200 (CEST)
Subject: Re: How to populate required string as audio endpoint name in gnome
 audio devices tab
To: Hui Wang <hui.wang@canonical.com>,
 "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <7c9bdd7c-efe9-c37c-3fa6-a6f611c43fc3@amd.com>
 <ec8c1c5a-a169-8d9c-c897-2bd9ed6593d3@perex.cz>
 <d8224137-d778-32dc-7723-416d9d09822e@canonical.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <125a7962-829f-1b3c-b553-3caeb22d2f6b@perex.cz>
Date: Sat, 20 Jun 2020 09:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d8224137-d778-32dc-7723-416d9d09822e@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dne 20. 06. 20 v 6:18 Hui Wang napsal(a):
> 
> On 2020/6/17 下午7:21, Jaroslav Kysela wrote:
>> Dne 17. 06. 20 v 7:47 Mukunda,Vijendar napsal(a):
>>> Renoir platform has onboard dmic + south bridge HD Audio endpoint
>>> support.
>>> For onboard Dmic, Audio endpoint name is populated as "Analog Input"
>>> in Audio input devices.
>>> How can we populate name as "Internal Mic" or "Dmic" in audio input
>>> devices tab  in sound settings?
>>>
>>> Alsa info link: https://pastebin.ubuntu.com/p/4kprhDZYbg/
>>> Pluse audio info output: https://pastebin.ubuntu.com/p/sdx9Xs234C/
>>
>> It's question for pulseaudio. For the legacy ALSA code in PA, you need
>> to create profile, mixer path and udev rules. The probe mechanism used
>> in PA looks for the volume controls and path switches (kcontrol) API
>> to determine the device name. If not found, the generic name is used.
>>
>> It's better to finish the UCM support for this hardware:
>>
>> https://github.com/alsa-project/alsa-ucm-conf/issues/30
> 
> I just added a comment on the issues/30.
> 
> So far the biggest issue is how to make the ucm only apply to machines
> with renoir audio and let those ucm not affect other machines.

I know this. The latest alsa-lib can substitute $${CardIdByName:acp} and the 
result will be an empty string (double $$ means ignore errors), if the acp 
driver is not available. We can create a conditional configuration with this. 
If PA does not see defined any verbs, it skips the ucm probe and continue with 
the legacy probe.

The AMD should also create a patch to not create the acp sound card when the 
hardware platform does not have digital microphones. It seems that the dmic 
presence can be detected via the ACPI / _WOV table.

Thank you for your tests. I plan to finish the ACP specific config next week 
and move the common HDA parts to one place. There are also other things which 
I want to update for UCM configs.

					Jaroslav

> 

> Thanks,
> 
> Hui.
> 
>>
>>                      Jaroslav
>>
>>>
>>> Thanks,
>>> Vijendar
>>>
>>
>>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
