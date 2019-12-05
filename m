Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C040C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:22:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09C724651
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GZjPDJi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C724651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2712B165F;
	Thu,  5 Dec 2019 10:22:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2712B165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575537777;
	bh=HBljXcy4P2uyYiGql/m/Xi9g4xo8ib8xIH5LanEvTeY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GZjPDJi4Tkib2PB1ePA2pCj4TOJuemKFq95UHfvD9ZYSwl5sukvI9zlwjcmpAuYFF
	 zUADZUG5/y1677F4fZHPjfaOoZLIrEI0DavUj8URbhVceS4IwKJ5wKCCmJV5GWORSk
	 0hw8RY208+N49f+ZH/yTY0YiNlHFvbUwjj6bHDyc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACF82F800B4;
	Thu,  5 Dec 2019 10:21:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C39EF80249; Thu,  5 Dec 2019 10:21:23 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id 34907F80240
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 10:21:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34907F80240
Received: from [10.10.222.226] (unknown [194.162.236.226])
 by mail.bugwerft.de (Postfix) with ESMTPSA id E5E362E4FA3;
 Thu,  5 Dec 2019 09:15:10 +0000 (UTC)
To: Takashi Iwai <tiwai@suse.de>
References: <20191205081428.611572-1-daniel@zonque.org>
 <s5h4kyfdvr7.wl-tiwai@suse.de>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <e3ecf1c3-e45b-79ed-4e0f-32be757bbcc5@zonque.org>
Date: Thu, 5 Dec 2019 10:21:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <s5h4kyfdvr7.wl-tiwai@suse.de>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: core: add
	snd_pcm_format_by_name()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 12/5/19 9:25 AM, Takashi Iwai wrote:
>> +snd_pcm_format_t snd_pcm_format_by_name(const char *name)
>> +{
> 
> Could you give the proper document in kernel-doc style?
> We try to provide some documentation at least for public API
> functions.
> 
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(snd_pcm_format_names); i++)
>> +		if (strcasecmp(name, snd_pcm_format_names[i]) == 0)
>> +			return i;
>> +
>> +	return -ENOENT;
> 
> snd_pcm_format_t is with __bitwise, hence this would lead to some
> warning for sparse, I guess.

Ah, right. Thanks for the review!

v2 coming up.


Thanks,
Daniel
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
