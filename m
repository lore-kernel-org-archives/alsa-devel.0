Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64226C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 09:39:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BE5206FA
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 09:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1BAB1707;
	Wed, 20 Jan 2021 10:38:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1BAB1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611135586;
	bh=l5Knx/9HNMrNtZZjksG1PMtWMeS8BA2FctWqwadgNh4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qvv7BSg5NH5Wcg9pDMfj0rZp6sCVNxHWggxn7qBowxqMlgNNz5QynMCdYZrEgslCt
	 3mcZFLAEujOVMeazlvFkl8OY3mqHkGhM/k4YkkyamPmDQ+7IhYbRY/8s4Oh5ry1dko
	 X7p/NYoxQqJKPCWnBWC+WdHsYQShYEqBVO6yxAkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E33F80164;
	Wed, 20 Jan 2021 10:38:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B49CDF8016E; Wed, 20 Jan 2021 10:38:53 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE194F8012C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 10:38:41 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 96A56A003F;
 Wed, 20 Jan 2021 10:38:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 96A56A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1611135519; bh=rDfRGOGZxQMBEHSK7LEWJdURvFgrmt3piBwXiIuMqBQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FAXhobHpMYPmtrmAaMj4knn5y3N20YFZ3Oz8xDg42fkREbkrbYFad0N30GKHfQ4uY
 ogk5BBGrP6BqO9OJXl8FfyDf0zRlx/MbPIa2BXUrkeI278Sac+88Ym78L/HbCte4hm
 kA7GH25bYC19l/ZZTig9J727gguUcbz1d8ZLzpkk=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 20 Jan 2021 10:38:36 +0100 (CET)
Subject: Re: [PATCH] ALSA: control: remove limitation on the number of
 user-defined control element set per card
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20210120085541.28607-1-o-takashi@sakamocchi.jp>
 <s5hwnw8dkkw.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <0fbe411d-0fbe-b337-c93e-d8788ee6b67a@perex.cz>
Date: Wed, 20 Jan 2021 10:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <s5hwnw8dkkw.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 20. 01. 21 v 10:27 Takashi Iwai napsal(a):
> On Wed, 20 Jan 2021 09:55:41 +0100,
> Takashi Sakamoto wrote:
>>
>> ALSA control core allows usespace application to register control element
>> set by call of ioctl(2) with SNDRV_CTL_IOCTL_ELEM_ADD request. The added
>> control element set is called as 'user-defined'. Currently sound card has
>> limitation on the number of the user-defined control element set up
>> to 32.
>>
>> The limitation is inconvenient to drivers in ALSA firewire stack since
>> the drivers expect userspace applications to implement function to
>> control device functionalities such as mixing and routing. As the
>> userspace application, snd-firewire-ctl-services project starts:
>> https://github.com/alsa-project/snd-firewire-ctl-services/
>>
>> The project supports many devices supported by ALSA firewire stack. The
>> limitation is mostly good since routing and mixing controls can be
>> represented by control element set, which includes control element with
>> the same parameters. Nevertheless, it's actually inconvenient to device
>> which has many varied functionalities. For example, plugin effect such as
>> channel strip and reverb has many parameters. For the case, many control
>> elements are required to configure the parameters and control element set
>> cannot aggregates controls for the parameters. At present, below models
>> are implemented with the control elements and actually add control element
>> sets over 32:
>>
>>  * Apogee Emsemble (snd-bebob-ctl-service)
>>  * TC Electronic Konnekt 24d (snd-dice-ctl-service)
>>  * TC Electronic Studio Konnekt 48 (snd-dice-ctl-service)
>>  * TC Electronic Konnekt Live (snd-dice-ctl-service)
>>  * TC Electronic Impact Twin (snd-dice-ctl-service)
>>
>> It could be investigated to increase the number; e.g. quadruple to the
>> current (=128), however it's hard to find criteria about the number for
>> existent sound card. This commit just removes the limitation for the
>> reason. ALSA control core uses UINT_MAX as the maximum number of control
>> elements added to a sound card. It's limitation for both in-kernel driver
>> and userspace application.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> I'm still worried by the unlimited number of possible additions.
> Did you check what would happen if you run a test program to add
> user-space ctls (with the max count) in a loop repeatedly?  If that
> doesn't blow up too much, it might be OK.  Otherwise we have to add
> some practical limits.
> 
> So, let's prove that it's absolutely safe to release the limit at
> first.

I agree. The UINT_MAX limit is really big in my eyes. The condition was added
to check for the insane allocations. I basically agree to increase this limit
(512, 1024?), but it should not be UINT_MAX.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
