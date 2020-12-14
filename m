Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA9C4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 16:45:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A88D22286
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 16:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A88D22286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3B901765;
	Mon, 14 Dec 2020 17:44:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3B901765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607964339;
	bh=oUyPcP9szBSPMXT69szPwq3nFG4uraX/NjY/grnLJ8E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbxIL/cUXHNPhUrsi/dEN9Pu7uSgkvLoq5NFCEcyreZLMoG0TnfUKoKf2DA6DbdaV
	 p3DhZm5+IUf+QNVH3k/4BNLbBwvulZQo72ON1NaQ41PWuxxadq5OWVq0i41lDbULw1
	 LadIRiVQLZ0ggRLGMQgc5qKOQfF2FxzlVS/t3+KU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78AD4F80121;
	Mon, 14 Dec 2020 17:44:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74D30F801F7; Mon, 14 Dec 2020 17:44:48 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A60D8F80121
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2020 17:44:42 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 88C6FA0042;
 Mon, 14 Dec 2020 17:44:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 88C6FA0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607964279; bh=abrWwR7NzCbm+8lS71M58hnBihw7p48+OxUvkGbKKi8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=t4y7xgrRPrrhMBWgVub5lVBqtdGj4w+AjWNd8swnDvh8uqL4Mb6R9bVKdSASl0Q7n
 5fujIrSohsP6WgcMVyEgRfdUYQt2nGD/EWJun7KWFMRMLeA9vNgYgSm/cLf0uDgyZ3
 5S6OJnGaSK1EraRB+WwgIGTM1xj/GCMcx9rOqaPE=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 14 Dec 2020 17:44:27 +0100 (CET)
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume control
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com,
 Takashi Iwai <tiwai@suse.de>
References: <20201214064903.2746-1-jack.yu@realtek.com>
 <8eeddc8c-91cb-e62d-6114-547117d4d83e@perex.cz>
 <0096059b-de76-d9a3-2446-b4c3becabce8@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <0b0afd81-0595-c661-ec1e-e81b7e8f8fec@perex.cz>
Date: Mon, 14 Dec 2020 17:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0096059b-de76-d9a3-2446-b4c3becabce8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 derek.fang@realtek.com, flove@realtek.com, shumingf@realtek.com,
 bard.liao@intel.com
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

Dne 14. 12. 20 v 16:07 Pierre-Louis Bossart napsal(a):
> 
> 
> On 12/14/20 1:35 AM, Jaroslav Kysela wrote:
>> Dne 14. 12. 20 v 7:49 jack.yu@realtek.com napsal(a):
>>> From: Jack Yu <jack.yu@realtek.com>
>>>
>>> Add main capture switch and main capture volume for callback to be in
>>> single operation.
>>
>> Could you be more verbose, what you're trying to do in the patch description?

I see that it's just additional volume coupling functionality (one control,
set all four output volume/switch registers, right?).

Some points:

1) the separate volume controls don't send change events back to the user
space when the coupled capture settings is applied and versa vice - no sync
2) we have already virtual master API - sound/core/vmaster.c which should
cover this requirement
3) I don't see the purpose for this coupling (the capture direction)

>>> +	 * "Main Capture Volume" looks the same as "ADC 07 Capture Volume",
>>
>> I would just use "Capture Volume" and "Capture Switch" here without the Main
>> prefix to follow other drivers.
> 
> It's similar to the 'Master Capture Switch' used in HDaudio, what other 
> drivers were you referring to?

HDAudio is using just 'Capture Switch' and 'Capture Volume' for the root
capture controls plus the input selector (enum). The Master prefix is used
only for the playback direction. And the word master is not prohibited for the
audio context, is it?

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
