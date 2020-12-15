Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C2C2BB48
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 16:28:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4677C2078B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 16:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4677C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCCA517BC;
	Tue, 15 Dec 2020 17:27:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCCA517BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608049706;
	bh=FGVstbAHwZxXpBbZvIobFxHJXfjOPMeMswR3iSTb4FE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A/VLyqVli+gegWFWb8eCDL+r2DLNsJwwnJZgTLEcsSP8NYMtmzImKXT4lkFKGCp17
	 iSzY6Po74dynPgIaKBoeMDdQCGco3QTB6mclji04KI7bvSn7EXZvHytO+tmrSdnF4A
	 udHWBomM9Nh/3QGlm5UleKllV4T3l1UZeCVUvDxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E0B4F80259;
	Tue, 15 Dec 2020 17:27:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2B8CF80278; Tue, 15 Dec 2020 17:27:35 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98A60F80121
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 17:27:29 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 653AAA003F;
 Tue, 15 Dec 2020 17:27:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 653AAA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1608049648; bh=o1M3zd+HM0g1Tf8hbFMcNP4O3OEzmEmyvniMy4yFv0s=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lBUvbRYGI2jD289imc0/ckKXqit/5HNa8C/t9kkdWEEsN4vCy2Y4mO/8cn88eLsso
 0FfWRcJmy3qjxMIUcGU2t6MUHS4TD8P+g6l0tQiM5bLvX1ZYj5oH9O7NgZCNSxnxhh
 URZD2s97OmdqNGAeT4WEIQHG4IGlDqYmP5JwvtK0=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 15 Dec 2020 17:27:16 +0100 (CET)
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume control
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com,
 Takashi Iwai <tiwai@suse.de>
References: <20201214064903.2746-1-jack.yu@realtek.com>
 <8eeddc8c-91cb-e62d-6114-547117d4d83e@perex.cz>
 <0096059b-de76-d9a3-2446-b4c3becabce8@linux.intel.com>
 <0b0afd81-0595-c661-ec1e-e81b7e8f8fec@perex.cz>
 <7d74544f-77f2-db01-db3d-d1d8a56d576d@linux.intel.com>
 <cb07f528-6c2f-1357-db54-e3d062ad6dd3@perex.cz>
 <bcdc2aba-ab7e-08bf-7e25-02e38c9d660d@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <feb43fc8-39a3-9c50-1193-9115603c8fb8@perex.cz>
Date: Tue, 15 Dec 2020 17:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <bcdc2aba-ab7e-08bf-7e25-02e38c9d660d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 derek.fang@realtek.com, bard.liao@intel.com, shumingf@realtek.com,
 flove@realtek.com
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

Dne 15. 12. 20 v 17:00 Pierre-Louis Bossart napsal(a):
> 
> 
> 
>> My suggestions are (pick one):
>>
>> 1) create one multichannel control and remove the stereo controls when the
>> hardware is detected (no functionality dup)
> 
> we can't remove controls that existed before, this might break userspace 

It's not widely used, so it would be better to break things now than later.
But I see that others are a bit conservative.

> with older UCM files that touch those ADC07 and ADC27. That's why we 

The upstream UCM files don't refer to those controls.

> added a new one, to be backwards compatible with a user updates their 
> kernel.

Even if you don't remove the duplicate controls, the right abstraction is more
appropriate in my eyes (better than vmaster extension). The double stereo -> 4
channel array mapping is not fully correct (vmaster, proposed patch).

>> 2) create proper vmaster control like for HDA playback
> 
> That might be the better option. What was suggested in this patch is 
> essentially to introduce a layer that drives the actual controls, but it 
> was done 'manually' and may not follow the proper rules.
> 
> That said I know absolutely nothing about 'vmaster controls', pointers 
> to a typical example would be greatly appreciated.

sound/core/vmaster.c ; The ASoC core will probably require another layer to
support this?

>> 3) wait until UCM can describe this hardware and set the DAC values manually
>> to a sensible value via sequences (the specific hardware levels can be set
>> using the conditions in UCM)
> 
> Not an option, there are products that need to ship soon.

It's the easiest method for now. It's just about to change the UCM files
without any other changes in the kernel / user space. It's heavily used for
SST drivers, isn't?

The current UCM upstream modifies only SOF volume levels (PGA Master Capture).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
