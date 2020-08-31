Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587FC433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:40:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4140207DA
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ckl1FdgE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ow6IQKyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4140207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 500141756;
	Mon, 31 Aug 2020 20:39:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 500141756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598899234;
	bh=WC+dX2WoAbia/Vtx2i2sWGLUVTRR0l1DH72hve5SIIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ckl1FdgELLWUKH+B8RQDiY1v++arK/2tMDX3JWNUxCo7sh1fGK2nqYUgUJhzj1ivX
	 osAaBZBcN4g6h2QCUnaSaIdETBFAuP0nisyDPVCyaOwEoTSTBixoTagWmWrCGpgSl4
	 W7UcUl4Uf+R98nz9hASCSxqWXJQFbowwF/wODm90=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C77D9F80096;
	Mon, 31 Aug 2020 20:39:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63643F80212; Mon, 31 Aug 2020 20:39:42 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF0DCF80096
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 20:39:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF0DCF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="ow6IQKyI"
Received: by mail-pl1-x643.google.com with SMTP id v16so3524940plo.1
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PJN4MJCj6Pjg+uwt4f3ml6KYFLqzh8Jk41iwpyLU3Mw=;
 b=ow6IQKyIJLSJBzYpYXZ3p2h21/2zo0rNu+6BgSyrmsI+fkPkNnxcT2qqDeEMWA3gEJ
 bWdsNeSXqko14vOuPfPN5c/O0as/itCxlhZl/PM8jJIlJrq3eG1JDVEZ2L7dSXFiBiX5
 tehKF4C/NjFYOHKqfekO7WTGk9GcLmpINDZMVerWZXNYmH6DR2UZ/m+N9HVsXdjZj+cx
 7ybAZRXR77kKkbnhQPt0ixU154RY5Mw4QjWxjPinBYdBvIXrklkVRgDcuTFchalWrE/7
 aVRYQ+w9RiUq6exwI8Pq+fLZ3V9GMMKSaL0H+ggLvtNqEG4lAYV5fZk5H/G20QrxQaIO
 VnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PJN4MJCj6Pjg+uwt4f3ml6KYFLqzh8Jk41iwpyLU3Mw=;
 b=iE19cYuCGyC19ytESeQ3F7IP6GYOFLGYDEXoAFgOvcZ+yhdJ1quuSgzl32SAWl3Fd4
 gMKUtT7rDR8/hT9yYX6Te6ZZ8kEe087EIs0hlERVwOh3WJmfbIC/1dTVb86Nd33jzyJG
 m6wcgvjyAzgubpMxqbhMx5MUkcLH+tiDRziobP0WsUczHflEzvdGYvbTNGf6IK1j9fFy
 7VOFyaLPkIA8bkhDdWyncYraSGdDvOrBNzCH5xiMLWVU/C5GR4Xh/UMzu+RG8w1k4yBE
 cGTcjndTCZdXN1r7qrVuzPf7vOUZuaboCecf6Vaxhb+iSAE29UlSQV3dwDMjF7KxBqm8
 hWTg==
X-Gm-Message-State: AOAM532Q4pI4ZagiXwRqebDGXYTlGlBzhOmtq4RuvhAM0gTbzS5wmMsM
 wOu1AeeqfQRr5yZufvy82czGks8T2niq5LsVGlQ+xQ==
X-Google-Smtp-Source: ABdhPJx8jmeDuqI3ddtnIQ73j4Oysz/hWduc1h6iUSovGQYoe4WKdkmXDjPKBpZrfy3a2DbH8pbnYy2olWyUgVeJezs=
X-Received: by 2002:a17:90a:fc98:: with SMTP id
 ci24mr600333pjb.101.1598899165891; 
 Mon, 31 Aug 2020 11:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200829153515.3840-1-trix@redhat.com>
 <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
 <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
 <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
In-Reply-To: <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 31 Aug 2020 11:39:14 -0700
Message-ID: <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix error handling
To: Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Vinod Koul <vkoul@kernel.org>, shreyas.nc@intel.com,
 Nathan Chancellor <natechancellor@gmail.com>, yung-chuan.liao@linux.intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>
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

On Mon, Aug 31, 2020 at 11:20 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 8/31/20 10:48 AM, Nick Desaulniers wrote:
> > On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
> >>> From: Tom Rix <trix@redhat.com>
> >>>
> >>> clang static analysis flags this problem
> > Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
> > CC our mailing list; clang-built-linux@googlegroups.com.
>
> gcc is still doing the building, so it this appropriate ?
>
> Asking because i have been sed-ing clang-build-linux out.

ah, right, you can use `--use-cc=clang` for analyses of builds with
clang.  It doesn't hurt to include our mailing list, since we'd like
to know if issues get reported with the analyzer itself.
-- 
Thanks,
~Nick Desaulniers
