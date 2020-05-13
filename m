Return-Path: <SRS0=BSyU=63=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864CECA90AF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 12:00:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFCC206CC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D++N6Jbn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ISrIrAZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFCC206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F3821655;
	Wed, 13 May 2020 13:59:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F3821655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589371239;
	bh=qwTLuT1N/CEDg6AheJLnftsK9KLFfVf11BgIFuU6cuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D++N6Jbnv5eXdKj0wZzfv8YLSUEM1ZL6MSCKelIPW7hnfOwG1FSjClv1gjAmNN6FN
	 cP8ipXBHYhEnIijGSTIeFeWnKdmsWuymc+b65JZhHBdo/j01IziTPvq6bLGdwAbnsN
	 eBQEjcNyY86pLhhmYcegcB//EAZNP1Ej6QrAKslE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97036F8022D;
	Wed, 13 May 2020 13:59:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AD61F80247; Wed, 13 May 2020 13:58:31 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93B69F800E3
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2020 13:58:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93B69F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ISrIrAZr"
Received: by mail-io1-xd41.google.com with SMTP id e18so4841877iog.9
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2020 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M+yjaeld2PBj1DS6qWHzYu9fpGryCbzHIvMWkAYrCUk=;
 b=ISrIrAZrYHnzqsnWSvHoYupqOCrNT0K+dNdpbHtAtPdZMtxvyF5i6pYN2by/dpPPrE
 A4Kpx2isHY7i8fnq/djtg9R8qvBzz7diOVPL9IQxIiZm6UD2Bnhk5VANNDqv3oWv3GSW
 c2Vv4N/hXEv+ECiegDxRSRPqMp1snKiasE86DSIYqWf920nkypUZuTisswlLOYRFunuj
 EY9nMmY0/v28GymMqxdu6KbHg1Lgbff05777hmxVrOzu4o0icOxMueY/aisxZfRG8Rpv
 xa+5c1Rpynqtl/Tu/c9uY5pf78M0d8vzuuULavsUyGICWp9Eb1oBadfjHnoPF5Mf03LZ
 efgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M+yjaeld2PBj1DS6qWHzYu9fpGryCbzHIvMWkAYrCUk=;
 b=bCiZhXQj9pXXPOlbC90Irti4c2NyInPVc5PiW/24wP8B74KCssbn99Ib3SmdyPjA3U
 uqYMWkEXKHoKiMwu23jkubc9GU2vlBDHamXfElmuUd4lVck398PanRX2ZmD7eFtuIZuy
 38OauRUiexxTIVL4kVAGK2QzhLp8DIW0yU+7X/iUaW007+Opo9OjCMa24yt6PUhRUxSR
 Xwor1+QVyG9yM3Vmhb+R9SmEogJtpXAISyg5EtJBVmymuQzc60obqZ19T90zQiwSYSd8
 zi4HlB1BqMR5gTSXxumjtihOWObKgU1UKTQV2I1CuPzLeSw05P7I0p+VIROynb0OT7qx
 N2Zg==
X-Gm-Message-State: AGi0PuYwOWrNAlRBa2FiAt5Ah2HuqTooWzkNOteBLXuvp1/Wa+4gSovd
 QDO9bTcBIf5HRl4W0iFmgXXpftO9V6Ph+HKCEF48Og==
X-Google-Smtp-Source: APiQypKW1Wrr93d3GpImjL4KvoIYV1trrA9n192ffeYzbo2d8Rmdcp9R+EASNUQYTNJQBz4Ewjmp5YiOdrQ97lsBC5Y=
X-Received: by 2002:a02:860e:: with SMTP id e14mr24559308jai.109.1589371103852; 
 Wed, 13 May 2020 04:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
 <20200513105144.GC4803@sirena.org.uk>
In-Reply-To: <20200513105144.GC4803@sirena.org.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 13 May 2020 19:58:12 +0800
Message-ID: <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: jack.yu@realtek.com, ALSA development <alsa-devel@alsa-project.org>,
 ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
 ryans.lee@maximintegrated.com, Steve Lee <steves.lee.maxim@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, geert@linux-m68k.org,
 dmurphy@ti.com,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 steves.lee@maximintegrated.com, nuno.sa@analog.com,
 rf@opensource.wolfsonmicro.com
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

On Wed, May 13, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:
>
> > Changes since V2:
> >       * Removed warn massage in max98390_dsm_calib_get func
> >         and add comment.
>
> The problem isn't the warning, the problem is that you have an empty
> operation.  You should either implement the function (eg, by caching the
> value written) or remove it and fix whatever problems you were running
> into further up the stack when it's missing.

The purpose for the mixer control is: to signal max98390 to start to
calibrate from userspace.
Thus,
max98390_dsm_calib_get() -> do nothing.
max98390_dsm_calib_put() -> call max98390_dsm_calibrate().
