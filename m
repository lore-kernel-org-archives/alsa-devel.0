Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C8C32771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:50:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F992253D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZzqzCHwk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="vNx/xskW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F992253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37014166F;
	Wed, 22 Jan 2020 21:49:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37014166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579726246;
	bh=eJLVU5k1vJetPESVH/cFlcl6R54M3QQEy3V5H1vznak=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzqzCHwkY+inFnzPDQWL94B11I89BGmuQiHpnu9amcUS/hVUpFXMqQT6HTllq3b6k
	 6xGj6rESLV/DM85bdb9ZhtkRTasTaXjPQPkmOnnZgybdMKOCh0mtSazZpYoA01x6Fa
	 x6eJomQVfmRuh/QdKFX4PE9lWgr+z3YXw3c/ooJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6100F801D8;
	Wed, 22 Jan 2020 21:49:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8E75F8020C; Wed, 22 Jan 2020 21:49:53 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E36F3F800E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 21:49:50 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CD3B5A003F;
 Wed, 22 Jan 2020 21:49:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CD3B5A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1579726189; bh=P3Kp39KyT/Pvr8uGRVk6sasIqbfPwA+qafavKi1te/Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=vNx/xskWAXeLwGmtwdKeQQIopwF1We1BS2P6cka7AAFbUYD0ze3jUBHkeBHZnECNj
 zvGKO013YwARZXramFQyhBEaiXaMb86sk9Acv6NFlFpYlHgn6tpxspzklVqZxgE98p
 wzmviF8b69LqHbKNuhS0HP45Z2Pc0wVXOvH1abQA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 22 Jan 2020 21:49:40 +0100 (CET)
To: Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200122190752.3081016-1-perex@perex.cz>
 <26ae4dbd-b1b8-c640-0dc0-d8c2bbe666e2@linux.intel.com>
 <20200122202530.GG3833@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <045401f5-8d4c-cdc3-12fb-cf35148411e5@perex.cz>
Date: Wed, 22 Jan 2020 21:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200122202530.GG3833@sirena.org.uk>
Content-Language: en-US
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Sasha Levin <sashal@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: topology: fix
 soc_tplg_fe_link_create() - link->dobj initialization order
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

Dne 22. 01. 20 v 21:25 Mark Brown napsal(a):
> On Wed, Jan 22, 2020 at 01:28:57PM -0600, Pierre-Louis Bossart wrote:
>> On 1/22/20 1:07 PM, Jaroslav Kysela wrote:
> 
>>> The code which checks the return value for snd_soc_add_dai_link() call
>>> in soc_tplg_fe_link_create() moved the snd_soc_add_dai_link() call before
>>> link->dobj members initialization.
> 
>>> While it does not affect the latest kernels, the old soc-core.c code
>>> in the stable kernels is affected. The snd_soc_add_dai_link() function uses
>>> the link->dobj.type member to check, if the link structure is valid.
> 
>>> Reorder the link->dobj initialization to make things work again.
>>> It's harmless for the recent code (and the structure should be properly
>>> initialized before other calls anyway).
> 
>>> The problem is in stable linux-5.4.y since version 5.4.11 when the
>>> upstream commit 76d270364932 was applied.
> 
>> I am not following. Is this a fix for linux-5.4-y only, or is it needed on
>> Mark's tree? In the latter case, what is broken? We've been using Mark's
>> tree without issues, wondering what we missed?
> 
> He's saying it's a fix for stable but it's just a cleanup and robustness
> improvement in current kernels - when the patch 76d270364932 (ASoC:
> topology: Check return value for snd_soc_add_dai_link()) was backported
> by the bot the bot missed some other context which triggered bugs.

Exactly. It's because the commit 237d19080cd37e1ccf5462e63d8577d713f6da46 
("ASoC: soc-core: remove topology specific operation") removed the link->dobj 
checks, but this commit was not picked to the stable kernels.

The initialization reordering is fine for all kernels (and makes sense), so I 
would like to apply it everywhere.

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
