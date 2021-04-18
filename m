Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7123FC433ED
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 00:44:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43236120C
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 00:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43236120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C92010E;
	Sun, 18 Apr 2021 02:44:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C92010E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618706692;
	bh=uODSqnXRTf2ezPTWqMy2tu3BnTI+2eFeztFzDo4svdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s+zluwwGtb8jbESh7RSJH649WFAvRwo/QTOU15A+VzumRFRf5GthdqygaJnluG/jf
	 6HYR5p+YIIL+1OjHURbnnomuSFvDZcchQa2CsBfIdamwxDaKalRf+mxyhWc6/DN7gA
	 D/O9wV8imNVUuBQ7Ihr3ftOaqOysieUd5QY4Ecjw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E192CF8021D;
	Sun, 18 Apr 2021 02:44:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6BA8F8022B; Sun, 18 Apr 2021 02:43:59 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2FA0F80152
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 02:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2FA0F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZcvncsoW"
Received: by mail-qt1-x832.google.com with SMTP id z15so15606718qtj.7
 for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2021 17:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gl4OIrx8XklYNa6QQuF1EwiTnBlsGmkt5ftn8fo9Woc=;
 b=ZcvncsoW91G8m98EqRpniiOP74rwxAvPRZSGyc2NMh8bo9z3Zl9PfrDu06w36WELF6
 n0+vq3Fs6rrbi01Vivs8NUrdPg3KK/RDz/81LNmi2vna5IRbTOK9cQzcd36naeEAyHC8
 tXurykXJROZS/s1ZlEEek/URq6vAK+t/eKhz+2H8Z1X69CzvG4n+eeLlUiyqHBH/pr47
 Hr5lrDeDB5xJzOHRZxmI1abtmsyFjj8fdLaM36aLN+mE9GFBPnBdf04jrHZvB7/bjBB1
 rcolewL78ahI1/Nw5yRLpIcVmQ/+zdBgsMgkUYKAjgV8WF6Y4SkwP/v9w1VF2dyjquuG
 FPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gl4OIrx8XklYNa6QQuF1EwiTnBlsGmkt5ftn8fo9Woc=;
 b=Vi+HiYCkTzo3OqnFTEH5yyTs0pTbuWumzEtE+1yCn/tA0/pURn9k1JzcaunoYgIPFO
 zs+Lib57fq5L9+Fm/5WP+FDPfVHCqiuhscy6qFlyZCqsEIUUxhfoI0sMD8/qXr+D3fSU
 lDYqNq68Tk8wQ3bZBUNUZd5ifHWp/VzBbbphnVZrRUKLNLfSfuTd42kp5FF/QcjLMy7Z
 UL8v5jQ0nWYqtteImVkACX0paLZNH4kdwxKMGCVygGhbFcC/8t6xvD42deAkA1f7zLFl
 5xOIFzGlYEMVhvkJgEvOqp5XNcCPdf1JYpGAEsJfEEQFo8FfkGeDSvla8KXc3xfbvzZ6
 md2w==
X-Gm-Message-State: AOAM531xufwL8OGGDVpLm3EjHVCcHlGCxOyj1PUwlrmqb2fRhePy24cv
 0h/zcGy7rR4zMF0W071EJQT6MaJDLIl3lis9D3o=
X-Google-Smtp-Source: ABdhPJyrgHchN8h0dusN1bR4CcDskIgB0WQCF4uwLQTWCCuQy51dF6cyNpw5icbo5ZjE57wMytcJ/4CgH2H5M06s9UM=
X-Received: by 2002:ac8:7dc3:: with SMTP id c3mr5552266qte.229.1618706631078; 
 Sat, 17 Apr 2021 17:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvcs9LcciAYjoB64Kt_VaSww4EAW4-qN0ED5jDA0GeeTtDg@mail.gmail.com>
 <20210409110745.kbr5z2jinsaur2ac@base.nu> <s5ha6pygqfz.wl-tiwai@suse.de>
 <20210417222630.dpqju7bowvks5nnq@base.nu>
In-Reply-To: <20210417222630.dpqju7bowvks5nnq@base.nu>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Sat, 17 Apr 2021 21:48:35 -0300
Message-ID: <CAEsQvctdSUiJY_qgwOZjb-O-Vy6piwR8NaEETr-gZZaYXeHeSg@mail.gmail.com>
Subject: Re: [PATCH v2] Pioneer devices: engage implicit feedback sync for
 playback
To: Olivia Mackintosh <livvy@base.nu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

Sorry to hear that, Olivia.

I have to ask, though, is capture working for your device? If not, then it
might be related.

Em S=C3=A1b, 17 de abr de 2021 19:28, Olivia Mackintosh <livvy@base.nu> esc=
reveu:

> > Which kernel version have you tested?  There have been quite a few
> > development about USB-audio recently, so something might be missing or
> > conflicting?  Let's see.
>
> I have just tested d86f43b17ed4cd751f73d890ea63f818ffa5ef3d with and
> without the patch:
>
>   - Without the patch, everything works fine.
>   - With the patch, speaker-test times out. I'll try to collect some more
>     infomation from dyndb and try to have a look to see what the problem
>     is.
>
> There's no obvious mistakes in the patch as far as I can tell.
>
> Olivia
>
