Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B98C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 15:40:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9E860FE7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 15:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F9E860FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 019361732;
	Wed, 28 Jul 2021 17:39:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 019361732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627486815;
	bh=6e/dbgI6JY7LNhmuyEW22Meylem9uAripeIP8ETbwlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3DaVm0i00J2Xk+u3wMG9fwChM1NUZl15HcA0xKt9/FsRJuUkkJFOfZcz4FudNX4h
	 3jjFOS6gtPSp0hvK+dsj3ybcyO1gswZzmFsmKOd7ddXhEuOvAnKCofZoqAckaTY5hE
	 ZX+qQ5V/OlNfvJbYH/b8GW8W9yNZnstGsFNiZgJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E4E4F80253;
	Wed, 28 Jul 2021 17:39:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5C26F80212; Wed, 28 Jul 2021 17:39:23 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2357F80212
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 17:39:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2357F80212
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1ML9ds-1mQqV44A54-00ICt0 for <alsa-devel@alsa-project.org>; Wed, 28 Jul
 2021 17:39:17 +0200
Received: by mail-wm1-f51.google.com with SMTP id u15so1732709wmj.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 08:39:16 -0700 (PDT)
X-Gm-Message-State: AOAM530KL/KKu7FFAoEe9Bl/r0khHjjs03zI9qMzVplRli3GstiJ3XIq
 oeVTl/4czvu/mpfhrz+9HqBQA7SHyBX284mQaY8=
X-Google-Smtp-Source: ABdhPJzKeIovwdN41FbqWmQ6JB1dQhy6AJoOlZzdylOj7h1f4vmz1OtXhkhE1pde4FrOtjwBaXG7NQfBb8lDECflPMY=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr9711706wmc.75.1627486756580; 
 Wed, 28 Jul 2021 08:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
 <CAK8P3a38tizZh1z=iJQotL3Tv3z8iK0qq2WCSy853M-nfwt4mQ@mail.gmail.com>
 <9cbc71be-17b0-4a88-c8a1-a1e800894a56@linux.intel.com>
 <CAK8P3a0CgD+gyjFTUXq8rN70bMUHd63iYVOCMvAVTR0X_noqNw@mail.gmail.com>
In-Reply-To: <CAK8P3a0CgD+gyjFTUXq8rN70bMUHd63iYVOCMvAVTR0X_noqNw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Jul 2021 17:39:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3CSMe6fE4O1pCUouDCwaOXgya=oLxx1en0=bWbrq4zEw@mail.gmail.com>
Message-ID: <CAK8P3a3CSMe6fE4O1pCUouDCwaOXgya=oLxx1en0=bWbrq4zEw@mail.gmail.com>
Subject: Re: [PATCH 0/7] ALSA/ASoC/SOF/SoundWire: fix Kconfig issues
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AlC3ccz+drY3SECy7yH4X+plbWhlAp9sHFqqrUCvYPg3yuy1pKB
 xJ5W44VaYZdJ6MnZrMUujEhPFXt+G9OOAEYIPcMSJM7PO1Tp6FSq0kpqOt2V+5uKdWDlX3Q
 g9LTUufJlPRkbhM/bmTA220t/+yFZAuFMDPL74jaKE6V+eiRbppeJeLDViCbYfCsWh/hcbI
 WNIcxQ9ap3H5mSPj6q5Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jK4K8Ka2h7c=:pC+mtYZeVRBOnJIUhwNDnE
 CcnZePBkkJw9vFmTkZff57wekwKJQLZHTnuHlgvtOQ3lHwk7kp71BN3rwi2X72+QFZ4dOVSHj
 +D5M+YX6exNgXnvSfDj/1hsU+ziqCY3etm+3oRJ4CC/fuwQYD3uqntFwY5oxOZACT7xXivB//
 Mm2O/ko0wf6p+c1VLLjuPRQzEj2uW2bYgmm2qUfKnG0cleAzRJKsANLcmnbIEhhzOd6MPCGBb
 NgKGqAdM2wjvK8T3951gDRIwN/RW5T5Kc9n5pR0xLPdpHUjvYpn5lmEEE6CoxtxZIPwWhAdHo
 tPGk7IcGII2dky01fH6Gz52U3vK2ihpGfvWVO/Fr0uYrQQF6csqHAeSQlYwbc2Evh1iXphX6E
 ika0WYUXqqQ7QXGbD39L6VRNO5vmWVG9lx0Z3QE/7nuwI1CPH7JLIOctqk83lXHGzH177DWyF
 85e4/Q5kR9uvp6BqY2p0RBoNZSstajpZzltFdAyofnld8+mLpCf8O/nI3pqS4iw0rQ0gB2YQg
 JcTdFNbwoM05vdIMJOO/hRvQZcQpcfQleWmUMRZXh2YMaVwzoHp7YkR/WCVlzla92fKHVO/Cl
 NpuH8YGVXnAhRPqjzlcjvdIDMHz0XR0wa4fJ8CdxGy1wXp9vLsUzPKv4CPHQuOsrEyR+ivIRg
 O8meVqV9Mwn6+X6BlYbqPe4BDofXRbydy1+mEMNcsR8Zp+v+QODOk4sMjBuns76L7vPRsnLnz
 P3OrS9SFESXK6f6jy/F9LNL0JpuqlloMXRCeQVE0bVK4h7rbs7WJDOl8+1hZz4w79jrD8mlpJ
 yfsRgU3ygBmb1l/yajq/KjIw+Cbgv2PhSbD6xcg2LiQiFO2Idbrd42+a3qpPcAPbX7hU5a3
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Mon, Jul 26, 2021 at 11:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 26, 2021 at 11:01 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> >
> > Thanks for this report Arnd.
> >
> > I can reproduce the problem, the changes made 6 months back don't make
> > too much sense to me any longer. I have really no idea why I moved the
> > INTEL_SOUNDWIRE config to a boolean, that was asking for trouble.
> >
> > I have a tentative fix being tested at
> > https://github.com/thesofproject/linux/pull/3066. I just moved the
> > select operations to a different option and reverted the INTEL_SOUNDWIRE
> > config to be an on/off switch from the user perspective, with
> > dependencies on built-in v. module checked inside.
>
> Ah, I'm glad you at least came up with a patch quickly, even if neither of
> us remembers what we were thinking then ;-)
>
> I've added this to my test tree, and will be able to at least verify that this
> doesn't break anything obvious over night.

Everything seems to be holding up so far, no new randconfig regressions
and the one I reported is fixed.

I did come across a completely unrelated problem in another patch
of yours though, see

https://github.com/thesofproject/linux/commit/7fc223e746faf72a7c0d04a7037d6a24ca7f8f0f#commitcomment-54095054

       Arnd
