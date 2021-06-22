Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4CC4743C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 09:18:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017CA6044F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 09:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017CA6044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6FC8847;
	Wed, 23 Jun 2021 11:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6FC8847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624439924;
	bh=5BrXIDMPgnfI3NyEf2fJcoSJ2qyI4oTr/ww6Q0JZSwk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sb7lLIo0CfxOgRbx4Ul+V81I7l3Rh6MKsyo4W6xlJX+9i4vGY6Tb19VcRLUjxU8k9
	 eJ+pBb5sa+HryFadAmgEnLU+p1CLGVJOiEfh7UV6/3TlWO6dC4pvT2A2x6y6CNsBTV
	 eW+NrzeDuNhMsW7WrQXqkJndaoK+f1rp34ZgW76Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D0A7F80137;
	Wed, 23 Jun 2021 11:17:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44ECFF80268; Tue, 22 Jun 2021 09:07:30 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D1AFF800E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 09:07:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D1AFF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="m3qWEbwE"
Received: by mail-lf1-x12e.google.com with SMTP id i1so7266179lfe.6
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vApCbbfexLL48plA5IDGd/vCKl9w5fkXkC+HXj5vIm8=;
 b=m3qWEbwE5qpjQMloL6da+bEmOW197CsGm7Jx2RKRZxJVMydXmjeNeo+9yUNrFvV2bZ
 NRfZv4GaINtnn/OZPvEw3O9f0JHb9SSTtA6zx5odicA5xJXYShGDXOgg8+fOcVCcwWm5
 Ynp2qMg6MOfdSgGsp0OMX7l32Jdt6OY3/oBvbSvt2aaxrZpENWXAL0+VRwAtfSEy/oKl
 zJORFhr5+sCWoTDf23nu5XJqo0WrUwIx+fw2cS4E0txNatqZIgzPgwFWYilfe0bPQLu9
 spMVwNsCPg9fpJY95Ug5J2XhPCoNA0QdMmRvUFXmw6sJEswr1XOLmKbSmbKgl0ocBz0B
 qhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vApCbbfexLL48plA5IDGd/vCKl9w5fkXkC+HXj5vIm8=;
 b=nU69I5wJaitbHsJFIuti7Yvt0DBzBdHws/x0jzFPCOjqifGpCd8zko0Bix3RMw0KDp
 z0/kgOcFzEDuEOZ1tTbFfDRPmNwi011HALBoZ5Y1VbxYuwxWykzm8Xfq3EW9bW+erV1x
 TTf1jT1/cpBH+LC1DQV+UeBfUDGkfll5D8bgGTkSQd5QvjrUJdfEgtKkad8JnfbBIHga
 NNV358N9cHqnPxRhH9nV2yPILL7c0Vl+aYcpD7GM1K9L9EUK/BFFF1uMlG4mixbdvDv1
 uz4W44fAAcEu2ZAIluqIbFEizv8lGL+02NC3lSTEwBrhGlMdiaFhNEu0n3c4CQfJGTsj
 +g7w==
X-Gm-Message-State: AOAM531NWatSoDATOBSyDQuRUB/L69sM0F2ZwDtqQvBn933ALeThMGZO
 rwerDlo+TS7j5R/jIR4E32w=
X-Google-Smtp-Source: ABdhPJwKHPiKd41iFbsWpaG+KQvuP4Ie44IOvNSSN0fp6PwKKB/bbtfC8gULkvsIafmDsYoo1ROMBA==
X-Received: by 2002:a05:6512:368a:: with SMTP id
 d10mr113565lfs.502.1624345641181; 
 Tue, 22 Jun 2021 00:07:21 -0700 (PDT)
Received: from [192.168.0.101] (xskernel.org. [109.195.85.176])
 by smtp.googlemail.com with ESMTPSA id r82sm988876lff.99.2021.06.22.00.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 00:07:20 -0700 (PDT)
Subject: Re: [PATCH 16/31] ALSA: usb-audio: scarlett2: Add Gen 3 mixer support
To: Takashi Iwai <tiwai@suse.de>, "Geoffrey D. Bennett" <g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
 <fc4bb1e8cfb3019b1033afeed59badb904990115.1624294591.git.g@b4.vu>
 <s5hh7hqs7ss.wl-tiwai@suse.de>
From: Vladimir Sadovnikov <sadko4u@gmail.com>
Message-ID: <0b00f3a5-fe31-0ad5-c723-d354dc724e58@gmail.com>
Date: Tue, 22 Jun 2021 10:07:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <s5hh7hqs7ss.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailman-Approved-At: Wed, 23 Jun 2021 11:17:52 +0200
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, alsa-devel@alsa-project.org
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

Hello Takashi!

Since Focusrite devices are too advanced in settings, the overall amount of 256 
controls is not enough for these devices (like 18i20).
I would like also to extend this constant up to 1024 or even more since adding 
support of software configuration of the device also
can exceed the amount of 512 control elements.

Let's assume we have a mute switch for each mixer gain setting. For the 18i20 
device this will give:
12 inputs * 25 outputs = 300 mute switches.

So I think this constant should be increased rapidly up to 1024 or even to 2048.

Best,
Vladimir

22.06.2021 10:00, Takashi Iwai пишет:
> On Mon, 21 Jun 2021 20:09:48 +0200,
> Geoffrey D. Bennett wrote:
>> Add mixer support for the Focusrite Scarlett 4i4, 8i6, 18i8, and 18i20
>> Gen 3 devices.
>>
>> Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
>> ---
>>   sound/usb/mixer.c               |   2 +-
>>   sound/usb/mixer_quirks.c        |   4 +
>>   sound/usb/mixer_scarlett_gen2.c | 260 +++++++++++++++++++++++++++++---
>>   3 files changed, 246 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 428d581f988f..ba4aa1eacb04 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -50,7 +50,7 @@
>>   #include "mixer_quirks.h"
>>   #include "power.h"
>>   
>> -#define MAX_ID_ELEMS	256
>> +#define MAX_ID_ELEMS	512
> This change requires the explanation.
> Usually the unit id is a byte per definition, so it can't be over
> 256.
>
>
> thanks,
>
> Takashi


