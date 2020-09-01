Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5EBC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:06:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD03206A5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r0vyvzQN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVTmSw6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD03206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 775671768;
	Tue,  1 Sep 2020 12:05:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 775671768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598954771;
	bh=Ygn83r8E0NkmEJReZVCaI/x7jawNM2oE16dM8gm9NCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0vyvzQNqRFZpzvfHjD64ZSXFZPlxN7gG3Zk0FOEVnvjGUDwuh9HPgRRftae2zDGB
	 w0Rxqq6RKP7EN/ljiejDMNlUoyB7/WUMTAXaKxXKpM2sLjDdp8pE9TlVpRAa5Uln47
	 V3lMwwEaoI9oPyIsQrpMH8qeTpKovmc1Ejw2l2tc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C2BDF800BA;
	Tue,  1 Sep 2020 12:05:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4404F80217; Tue,  1 Sep 2020 12:05:19 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91867F800BA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 12:05:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91867F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cVTmSw6X"
Received: by mail-oi1-x242.google.com with SMTP id d189so627521oig.12
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
 b=cVTmSw6XX+UT6JUTH4rdPSJ9FNDlYkQZYUfvTr2XorsOE1gcdNjHOzTRgqjMvpA4Xy
 TsmOhTC0Xb1IGa6M2dfbBdowKCpxJ866AVZrI14hUdZEmiCll6cl3emPVLdxv6nSMdq2
 kqV0dP0hQxBQOU9KFPrbouWkY2RRe0sNwVjlm+Fi0S7vhwBaebaEb7gXqLl+HGDhJaOv
 Z893PplsVmLuxu4Qg5AghWQuMPM3Yki2X6UZhkcCMiAWTzre3QwjLxDhUhIXwTDMYo57
 TjPtLbMB6+ljoKyyBzxOv7VO7jk6WxlGmym/CuGp432h8bnzpkLQOQNCWDR8/zgVa858
 cQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
 b=ppQ3L/vzSMBn/b7hyz22yuZ2zs2S/YNwixmZWm3l8Ujx5BMiGgCxDafU4lfQMIYi0F
 XYGUJ66RB96YDd4eladvZMoQu6twhFhFshzzPSfxodp7fTMZ7+gxF/nmWfKeKUWWOfu6
 /R4UU31ej6YIN1APae99jsRBB0iaN/+ZI00mquI+zfmiHN/aSG0DUqvp8MdFNGM5fof2
 XNiJGnrvUWxIcGrqW5sUd63jsDU9jD3gOFdDxljpEVHuWU3rZweJAIJDJy3lurZ4O5Jo
 o9409TqoOgd2EP9ItsT7WbAByovxXqXWf8jxyx/+EsLypjPe085x6y2TQy45g0o9mA0M
 AS8Q==
X-Gm-Message-State: AOAM532LGuGQSPZ1H3sqHTaGexqNPq+vZhJEgdMAkc1jeWZd8N8Nw0Kh
 7KSINn00e1lWvIz34n5ErlI6MhI6w1wQELhM7gU=
X-Google-Smtp-Source: ABdhPJye06bcGhAWcYxufpzsaAsoo5AYygMhxy14Mms95Z97Cmb8t1iCi6Fk2wDJAHKUVMTHJ8UVPQHQTR7OYPMT4tY=
X-Received: by 2002:aca:4c09:: with SMTP id z9mr72588oia.175.1598954704359;
 Tue, 01 Sep 2020 03:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de> <20200818104432.GB5337@sirena.org.uk>
 <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
 <20200819111605.GC5441@sirena.org.uk> <s5h4koyj2no.wl-tiwai@suse.de>
In-Reply-To: <s5h4koyj2no.wl-tiwai@suse.de>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 1 Sep 2020 15:34:53 +0530
Message-ID: <CAOMdWSJ2VKhbnRDTNVuTKSL12k0qhryO7yznstAk8k_nBGp2=Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>,
 timur@kernel.org, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
 tiwai@suse.com, nicoleotsuka@gmail.com, Allen Pais <allen.cryptic@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
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

Takashi,
> > > > These patches which I wasn't CCed on and which need their subject lines
> > > > fixing :( .  With the subject lines fixed I guess so so
> >
> > > Extremely sorry. I thought I had it covered. How would you like it
> > > worded?
> >
> > ASoC:
>
> To be more exact, "ASoC:" prefix is for sound/soc/*, and for the rest
> sound/*, use "ALSA:" prefix please.

I could not get the generic API accepted upstream. We would stick to
from_tasklet()
or container_of(). Could I go ahead and send out V2 using
from_tasklet() with subject line fixed?

Thanks,
-- 
       - Allen
