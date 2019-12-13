Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C478C00454
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:21:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B523324692
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BmZbmMQe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1g6VNHxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B523324692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9952175C;
	Fri, 13 Dec 2019 12:17:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9952175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576235891;
	bh=dQ90D4BnsAnwXkYO8JdOAmybozAkuQCU2BrGjfPvems=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BmZbmMQe81GephWsaT+rJuEOgDrRPt5LCfKGYdt+39L7elY9aBrXZ66Me76fTSxKE
	 WuvbZ5KbTAi2jKWWGbWaqY9fXfiyGhAh2J0gTPDR//WXIJdv2QXCpx6KJXE4X6Of7U
	 a/xS7jV6GWQGZF2GhQiLNwAoWtTap8Dk1QruK8tM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6291CF8019B;
	Fri, 13 Dec 2019 12:17:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0FEAF801F4; Fri, 13 Dec 2019 12:17:18 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8F6CF800AB
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 12:17:15 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9D76DA003F;
 Fri, 13 Dec 2019 12:17:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9D76DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1576235834; bh=MmVlyHvVCcPYgRjOzSeGupfCfmXIMVzaIJb1kmDObU0=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=1g6VNHxcVqNDkNMJ/tLOMPWavMVGkcGAx9uqFA51dspAFQ7XjPf+oZO6upvlPmFXk
 cuBF2VDBRgOehtfCCFlL2bqNlTmkNIURqLXgITNwJXhmBbYTCHpxoMbf4c9MCDZBUF
 CLRIQsIN1tT64D96EEVAeAJy2aYeNqHmbYI5HERY=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 13 Dec 2019 12:17:12 +0100 (CET)
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20191201080449.GA408@workstation>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <b121b3eb-3bb8-7efc-d5e1-f470049899b7@perex.cz>
Date: Fri, 13 Dec 2019 12:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191201080449.GA408@workstation>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Restart alsa-gi project as alsa-gobject project
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

Dne 01. 12. 19 v 9:04 Takashi Sakamoto napsal(a):
> Hi Jaroslav,
> 
> Since Audio Mini Conference 2018, I continued to work for alsa-gi[1] in
> my local to integrate toward better I/O libraries. However I realized
> that its basic design includes some disadvantages to produce useful APIs.
> 
> I rethink the design and realize it better to wrap each of structures
> in <sound/asound.h> simply. Then, I restart it as alsa-gobject[2].
> At present, master branch includes a library, `libalsactl0` for the
> most of I/O features in ALSA control interface, which is compatible with
> GObject mechanism and GObject introspection.
> 
> Jaroslav, would you please delete the alsa-gi repository and fork
> the master branch from my alsa-gobject repository, then apply enough
> configurations to the new repository?

Hi Takashi,

I am sorry that it took so long but I was really busy with other things.
The alsa-gobject repository is set, synced with git.alsa-project.org now like 
other repos. The settings should be similar to alsa-gi, so you should have 
write permissions. If you hit any issue, just let me know.

The original alsa-gi repository was archived and I will remove it later.

There is only one difference - I did not clone this repo from yours via 
github. It might make sense, if you fork the alsa-project repo to your github 
repository and push your changes back (alsa-project/alsa-gobject -> 
takaswie/alsa-gobject), so the fork link system on github will be updated 
properly.

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
