Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B3C07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 14:54:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4585061283
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 14:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4585061283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86B6F825;
	Thu,  8 Jul 2021 16:53:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86B6F825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625756073;
	bh=rpsXE9AJLSqA8Kv/HQrm10YwdRvBtb3W8EuH96A9sRY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFG0Hka9HmejuIGt1AlJ7aTBphmuSqnGeoFIM27ItS7u88i/To2XnOzvE3Twq4AS0
	 5R1pvLvY3KbLgLPfvym0JCNR7JKKcLMPZNwR4mRnQlIi9XslBaKdV4Z13hcu/syoYL
	 9vDo0Ht7OjQkxTL1KLNENM8bAVv/969AZiSg2iMU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F3BF80246;
	Thu,  8 Jul 2021 16:53:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23CECF80249; Thu,  8 Jul 2021 16:53:42 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEC63F8012F
 for <alsa-devel@alsa-project.org>; Thu,  8 Jul 2021 16:53:31 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E7812A003F;
 Thu,  8 Jul 2021 16:53:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E7812A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1625756009; bh=50Pcd5aTX9wikvo2sIBF0vJ6IcrjySrof/14/tpqP8k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=phgeDJEeL3CJ2C+r+weBuDGCtGDMtCBf8XucknY8xtRV+9n1UxbGse81CzdL9m7Ru
 AntvgEqAMSaowOfV+vTJPwyqirFmSYAYpmlhCPFRLL4DZVRlhH4VHxn85oxOFgnFsJ
 gt6H/bNUob/HValmw35d8rWFyLg9tbCG5ViZFM0Q=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu,  8 Jul 2021 16:53:20 +0200 (CEST)
Subject: Re: [Patch v2] ALSA: compress: allow to leave draining state when
 pausing in draining
To: Robert Lee <lerobert@google.com>, Takashi Iwai <tiwai@suse.de>
References: <20210708020815.3489365-1-lerobert@google.com>
 <s5ho8bd59q4.wl-tiwai@suse.de>
 <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e2705267-4400-bb7f-e96a-9b103872c0a1@perex.cz>
Date: Thu, 8 Jul 2021 16:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, zxinhui@google.com, carterhsu@google.com,
 tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 bubblefang@google.com
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

On 08. 07. 21 15:47, Robert Lee wrote:
> Hi Takashi,
> 
> It is a little complex to describe the design in detail, but try to
> explain simply
> what issue we meet.
> 
> If w/o the change,  after user resumes from the pause, our system would call
> snd_compr_drain() or snd_compr_partial_drain() again after it returns from
> previous drain (when EOF reaches). Then it will block in this drain and no one
> wake it up because EOF has already reached. I add this change to return from
> the previous drain.

It looks like that the driver does not call snd_compr_drain_notify() so the
state is not updated to SETUP on EOF.

> Actually, I am wondering how the pause-during-drain can keep the state in
> DRAINING. It should have a different design. :)

I already proposed to add a new state (because it's a new state), but the
conservative way was elected to avoid user space changes.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
