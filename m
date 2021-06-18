Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C16C48BE8
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 11:31:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B35610CA
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 11:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B35610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B5C41717;
	Fri, 18 Jun 2021 13:30:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B5C41717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624015899;
	bh=AZ+r+5g/h0QiQnxqCNJOFNxx9lw8K/tHdSqIoXCEzxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pK2U7wfWUe5n8j4AWdSAnVkC7e9kudOPUEnE6y7AyM6dV3hgV1VweyjGd4dM3KNk2
	 onSO/HCuvSE3tZ8+Z9oEj+jqvnncByQqA4ZoJ14sDvLTc8xlVJ2Iu6UAtrMZuY4Dko
	 zB8Sa0+RmyDueLCmtnFP2U3z2gFpq/zFQthepUtU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A36DAF802E8;
	Fri, 18 Jun 2021 13:30:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EEB1F8032D; Fri, 18 Jun 2021 13:30:47 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E533F80084
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 13:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E533F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ChROJdee"
Received: by mail-qv1-xf2b.google.com with SMTP id c10so3345590qvo.9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
 b=ChROJdeeybN0A0GyVkUZ00DaA0/sv6VhnbBXNK5g+iSZ80gDcQcWfnGzAg4JZ0MVq6
 liR6c2q0zDZH/VmK0Jf73O2BFdCmlWAem8bKGNKceXlXhxkBsdiVv4gXoGG3Dr6nYIb6
 Cp/xouNPB//YGH+e+nqXTO1NY7BF9X6W1uQKwP/GabccnUbgUAX1LtkAySQudBsfap1B
 Hb1wV/CrH+QDRAZe4LUvZdbDQfn++afNzGEkhE7PZxNYIXOWmn6geLdRiQx1HPQWl1G1
 8ltVdJKhKXCHLEx2zElEI/Awa1OT68GUYJYpBOZ0LRGZ0OTwzg5c2Bi7iN6s8VDyP4+C
 ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
 b=OwPA6mHrESDDaU8lYW0Vg+t7JPllX5y/dddjnKOxItgH/00k9wB6xsv+75v5X85ZxN
 qgjwuakBABqpOiCrJRpnz4z6dhiBysz+I4yyVDElxVvJPrahEK4Iege7jZrSgOA9NFiI
 kTLLTwC7HLszT355+XWCBfP+mNHBRXqoTlFiNU4LAJVbkTz4T4c3ATzwT2NzJPqTDvqP
 l8LyZXqZtwAyax7/QCmnJo9mfTbKxr0c78lAN0uBUd0wTq9odA9GOoJY1TLB5hx80f6U
 RAf2KwA3BjR4r6jnBDCksa38BD8fy14BAvZJNgnkeDA8D+z3dmVzBJNh85s0hpP1U2lL
 2RRA==
X-Gm-Message-State: AOAM5337Xs5DUUGIjYvdDxGwiav2PZPOmOg007nP242ySwYk/s+dkVh3
 MwGdVIR0JboOgGECFlxNUxv1tYMySfcTEf2eO90=
X-Google-Smtp-Source: ABdhPJw+VBKBbMWiTjprq1OpB940uynK7mBEANOGQm1YOzX7yGaE4oP+e5A8DcDG6tW5eqdyQLtI1iFpklMBWiD25Bs=
X-Received: by 2002:ad4:576c:: with SMTP id r12mr5209117qvx.28.1624015836116; 
 Fri, 18 Jun 2021 04:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 18 Jun 2021 19:30:25 +0800
Message-ID: <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
To: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi Fabio

On Fri, Jun 18, 2021 at 7:21 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Fri, Jun 18, 2021 at 7:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > There is an unhandled interrupt after suspend, which cause endless
> > interrupt when system resume, so system may hang.
> >
> > Disable all interrupts in runtime suspend callback to avoid above
> > issue.
>
> Fixe tag?

ok, I will add it.

>
> > +       ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> > +                                FSL_XCVR_IRQ_EARC_ALL, 0);
> > +       if (ret < 0)
> > +               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> > +
>
> The operations in _suspend() are usually balanced with the ones in _resume().
>
> Shouldn't you enable the interrupts in resume() then?

No,  as you said below, the interrupts are enabled in fsl_xcvr_prepare().
so this change should not block anything.

>
> I see that the interrupts are currently enabled inside fsl_xcvr_prepare().
