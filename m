Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C499C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 14:01:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6080C23AC6
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6080C23AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0D6916EC;
	Tue,  8 Dec 2020 15:00:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0D6916EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607436080;
	bh=VxfVF4pIbAHtlOXParXAg+yNiyPOyX91410pg5Rias0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tB/I8h+iY5oRHfKQKlt6Rh8/H3oxvaJ/Fu/BhoOeeG/gBsUbkakIzscSkBYrA2ES6
	 MaZrXyAyiqn/hPRScAXxh6XLzjXQhsCS3fC6kbnfTtNUFQv8e5EA02vx2FGivZbfDt
	 /cY5Cn/QvaJdp7RD1Zy0z0ErBzvHHyFr5CBaq4PM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3384FF80164;
	Tue,  8 Dec 2020 15:00:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E6AAF8019D; Tue,  8 Dec 2020 15:00:28 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A84FF800E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 15:00:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A84FF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de
 header.b="T8dxJfTt"
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 374C516005F
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 15:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1607436020; bh=VxfVF4pIbAHtlOXParXAg+yNiyPOyX91410pg5Rias0=;
 h=Date:From:To:Subject:From;
 b=T8dxJfTt2ttC9UxXh2RjwiCTg5ZZeG7OT7de5Sn276KQ1jQv1SByF499c7rQgAQ7/
 d7vFl7AVKZ2b3UYt/7qE8/5qcP6FgMMVc+nfxk6+63l8l8TJ5h7qjUTvNw5SA4jq3z
 g/mc87mCSMIO/xUBDrCbDV9yZCiwtGpSeX4gU8SEK8HvD8H6jdHT0t/8lxFJMjZA4t
 WRhKuN7ctjbKqvr7M5Xkd6jntGNEaftuRgQ/5bHdnfW+HtWZA24sBC05fpvP42pEuk
 4r/+FJrq8hA/swmMIEq7w38u+C+ojJlOWPRiW8O+Fj/nrch4uQfaCTXZvqrxjf9wY7
 ilOhyWP+kV6jA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Cr1z738Dpz6tmZ
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 15:00:19 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Dec 2020 15:00:19 +0100
From: meschi@posteo.de
To: Alsa devel <alsa-devel@alsa-project.org>
Subject: Re: Steinberg UR22 Crackling and Clicks
Message-ID: <728dfc14a17bde2b0a7442ea071d386f@posteo.de>
X-Sender: meschi@posteo.de
User-Agent: Posteo Webmail
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



-------- Originalnachricht --------
Betreff: Re: Steinberg UR22 Crackling and Clicks
Datum: 08.12.2020 14:58
Von: meschi@posteo.de
An: Takashi Iwai <tiwai@suse.de>

> It's likely the issues with the implicit feedback.
> 
> The latest development tree (either linux-next tree or
> topic/usb-audio-refactoring branch of my sound.git tree) contains the
> improvements of the implicit feedback mode.
> 
> 
> Takashi

I've compiled a kernel from 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
uname -a is "Linux meschi-Precision-WorkStation-T5500 
5.10.0-rc7-next-20201208 #1 SMP PREEMPT Tue Dec 8 12:28:39 CET 2020 
x86_64 x86_64 x86_64 GNU/Linux"
The problem is still there. Is it possible to fallback to explicit 
feedback mode for the device from user space?
I'd like to learn more about these feedback modes, is there a place 
where this is explained?
I'm curious how this device is working on another machine. I'm not quite 
proficient with the alsa kernel subsystem to debug this myself,
but I would be happy to test patches and learn along the way if somebody 
is interested in debugging this.
