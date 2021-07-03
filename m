Return-Path: <SRS0=DqXu=L3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF4C07E97
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Jul 2021 12:07:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2745E6192B
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Jul 2021 12:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2745E6192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marcan.st
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3415169B;
	Sat,  3 Jul 2021 14:06:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3415169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625314065;
	bh=drMSmAx2jGYSy6pKW4kJh7azC/G3EVjxtSdNZPgViKY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gOQN9RUzsSPCZ3owo1wtCj/H4TPY9NlocyjY9Mupf9uxD04bWlSFrSb0PujdjEaYu
	 kxX2HgjXt97TNnUZRhbTXcHcIlb/frq2+sbqIKZ8PeV77tLilSzW5Vkp/VUMzHIK5p
	 8DNoRyVo4LoqmDh8Z9/5+FLjcJRrimmJqjEBmlVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B2DCF8003A;
	Sat,  3 Jul 2021 14:06:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57D4FF802D2; Sat,  3 Jul 2021 14:06:53 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C88FF8003A
 for <alsa-devel@alsa-project.org>; Sat,  3 Jul 2021 14:06:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C88FF8003A
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 127C1425EA;
 Sat,  3 Jul 2021 12:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <s5hbl7li0fe.wl-tiwai@suse.de>
 <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
 <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
 <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
 <YOAF+EnvdBvSeZnR@workstation> <s5hh7hbakzk.wl-tiwai@suse.de>
From: Hector Martin <marcan@marcan.st>
Message-ID: <6adcc9cd-d916-5a50-5a14-8f3b82f60ef6@marcan.st>
Date: Sat, 3 Jul 2021 21:06:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hh7hbakzk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On 03/07/2021 16.56, Takashi Iwai wrote:
> Unfortunately I can't test much right now in my side as I'm traveling
> (until the next Tuesday).  So, Linus, Hector, please let me know if
> this works.  Once when it's confirmed to work, I'll prepare the new PR
> including the fix later in today.

Works for me on top of the for-next branch that was previously 
deadlocking. I can't get it to crash any more.

Tested-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
