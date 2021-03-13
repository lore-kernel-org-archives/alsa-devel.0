Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B8C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 15:57:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714B364F1A
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 15:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714B364F1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DEE517F1;
	Sat, 13 Mar 2021 16:56:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DEE517F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615651043;
	bh=lSU/4VEL+T/SWQn20Ol4Kr9+hKB+bpgt7Rct+Ea11gI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XXlF3vAyF92oRZZICxSR9TbLU42mpREPiM8JN+QzHQNXQqnHmh1PQaZ19VCrYvaOU
	 cYn3m6l6b9/L0s+jyrgROJb+/d8m8m4AiMQ6rsm/d4XU0EP8SEoMcqESVovo5rbnsy
	 vqLgI9sTBQFOqh8tekDdMzb/8/Md/79BDm8dtxt8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0278F80154;
	Sat, 13 Mar 2021 16:56:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8766BF80227; Sat, 13 Mar 2021 16:56:31 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55871F8012A
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 16:56:25 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3B8C0A003F;
 Sat, 13 Mar 2021 16:56:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3B8C0A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1615650985; bh=TmIRSHZYzf5LZMz6aOoRTEFjFOVbK0UOhcZ10QhomiI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hYDOO+YR0SkAkRo1XVEutpa1PBqXVsV4+KzTIbrDwwAODwwDIYQltDL81tNaECzgF
 0hfNAko0bhC+EmAl1sxFtSZtkFMUw6KQcg6SlfvWwGHI1w/kfjegFtHb9goWJ4NeUz
 Tl4NjaD1l/7MULUfLc2niuk9wRB77Z2jLzWWJ3Yw=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 13 Mar 2021 16:56:20 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf 1/2] codecs/rt5672: Move +12dB input boost
 from 'STO1 ADC Boost Gain' to 'ADC Capture Volume'
To: Hans de Goede <hdegoede@redhat.com>
References: <20210217143436.74209-1-hdegoede@redhat.com>
 <2f424984-ae8f-7393-94f8-fc18e5100e58@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e3357efb-75fa-1f47-159e-0b4472e9361a@perex.cz>
Date: Sat, 13 Mar 2021 16:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2f424984-ae8f-7393-94f8-fc18e5100e58@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

Dne 13. 03. 21 v 16:47 Hans de Goede napsal(a):
> Hi,
> 
> On 2/17/21 3:34 PM, Hans de Goede wrote:
>> Both the 'STO1 ADC Boost Gain' and the 'ADC Capture Volume' controls are
>> digital and the 'ADC Capture Volume' control goes up to +30dB.
>>
>> When adding hw-volume-control support adding the +12dB boost gain on to of
>> the max +30dB of 'ADC Capture Volume' is a bit too much.
>>
>> So move the +12dB from the 'STO1 ADC Boost Gain' control to the
>> 'ADC Capture Volume' control.
>>
>> This way we keep the same setting for userspace which does not support
>> hw-volume-control, while getting a better range when we start using
>> 'ADC Capture Volume' as hw-volume-control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Ping? This series seems to have fallen through the cracks, AFAIK
> there is nothing blocking this series from getting merged.

Yep, it was somehow lost on my side. It's merged now. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
