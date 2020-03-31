Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1DC43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:19:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F325A20578
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T5Iq7ApH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94AFD1607;
	Tue, 31 Mar 2020 15:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94AFD1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585660776;
	bh=0/pzuXErb+0KkvBO+E2ZTaoF5Zls9Ls0iUiUcCffoMI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T5Iq7ApHDBzoCZqeyIrzlfegSLnDwZsw2nYNudM8m59ZFPB8Iv0KReDPzVMvUn75q
	 EzNdNYnD1hkvnIwJOi8STo2BNdhe6R91DfESM2Ry6sewdzSPEPbjc/iPrtkEvm0q3p
	 qWUqbmbh9TZya2m1typj9+/r3mlUqB0W4JI0n8KQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 138AFF80140;
	Tue, 31 Mar 2020 15:18:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 874B6F80146; Tue, 31 Mar 2020 15:18:44 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 395A7F800AA
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 15:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 395A7F800AA
Received: from [222.130.137.59] (helo=[192.168.2.112])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jJGmp-0002G4-HN; Tue, 31 Mar 2020 13:18:36 +0000
Subject: Re: [PATCH] ALSA: hda/realtek - a fake key event is triggered by
 running shutup
To: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.de, stable@vger.kernel.org
References: <20200329080642.20287-1-hui.wang@canonical.com>
 <20200331131130.0A72620757@mail.kernel.org>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <67aedfb4-a7c0-7127-b468-99e302863053@canonical.com>
Date: Tue, 31 Mar 2020 21:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331131130.0A72620757@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: Kailang Yang <kailang@realtek.com>
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


On 2020/3/31 下午9:11, Sasha Levin wrote:
> Hi
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag
> fixing commit: 78def224f59c ("ALSA: hda/realtek - Add Headset Mic supported").
>
> The bot has tested the following trees: v5.5.13, v5.4.28, v4.19.113.
>
> v5.5.13: Build OK!
> v5.4.28: Build OK!
> v4.19.113: Failed to apply! Possible dependencies:
>      10f5b1b85ed1 ("ALSA: hda/realtek - Fixed Headset Mic JD not stable")
>      2b3b6497c38d ("ALSA: hda/realtek - Add more codec supported Headset Button")
>      8983eb602af5 ("ALSA: hda/realtek - Move to ACT_INIT state")
>      c8a9afa632f0 ("ALSA: hda/realtek: merge alc_fixup_headset_jack to alc295_fixup_chromebook")
>      d3ba58bb8959 ("ALSA: hda/realtek - Support low power consumption for ALC295")
>      e854747d7593 ("ALSA: hda/realtek - Enable headset button support for new codec")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?

Please apply this patch to v5.5.13 and v5.4.28. Drop this patch from 
v4.19.113.

thanks.

Hui.

>
