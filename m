Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080ACC47080
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:37:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3256124B
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3256124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B39B846;
	Mon, 31 May 2021 12:36:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B39B846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622457420;
	bh=yth6MZtd9tgFP8SX+x7YTxaD7JjwoMnAIUht0QjZ9Bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T4btWhCjf5aIZDmTQyacTEEFrxPpMNBt40CG6jsUQAFpMMgl/4ByNYReRoR40c/7H
	 tKE5SOJYawRXI7Dr2p8LpA49gIncZpf37LIhGuxlFrA5dnwOP9Q/o2FcYKEi989sQa
	 HjxaXfZFE+nUmMrY7wrDXOzgbOo0jz2YwdssQ4gU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 942E0F80273;
	Mon, 31 May 2021 12:36:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D19BF802E2; Mon, 31 May 2021 12:36:07 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A25A4F80161
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 12:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A25A4F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Zf7mcTnY"
Received: by mail-ej1-x62b.google.com with SMTP id qq22so7717385ejb.9
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9r9VRf/fh7JhFL3DqDJ/NjbEIHDh6XFA5801Gx2Ynyk=;
 b=Zf7mcTnY272iyzHvBsmzRMda+V+cFit5Eo1vUf7LL0dzyhGgf2Ysm+3S/tH3z4xSqe
 tWXibCER7qDiHqXPJbFJE9OUOzwwSIAP7vBjT9ugqlCujV843ItIudURxruALsJi2BFf
 yfMkP32S02tt3bEcbFlNlw9FNMQ0OPshwfcwIjeXXWquSqM0mbSoEQiBoK8nPbZhs57k
 DJtgJLakDBrBWglE5zYV4g82L95RvNpXVyNVDnry6Uj42+48HFDFvymL0QmOcYRBDCgJ
 uBIdnwRrPsIoHZquAG/zT3tHl3I5d6qRL1RYhm1bmbRecXmv2X4HfO5txcYCttlixvax
 1ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9r9VRf/fh7JhFL3DqDJ/NjbEIHDh6XFA5801Gx2Ynyk=;
 b=svd59mJCyPjCwIAly9ku2NL5WAyXUPaVlQNCSnGwbdKToMESFVL4oiAJp7qaUFiCaD
 Jooj3uJEPnfJasRndsb/deeyGCota18Nrbueigp2ajHNhI1/tkC0qhJ6iD2TbsM6ACvm
 zjE6GHpP5qJFdfP5+BN8jHq80zatRrLrmL/ig7uvRO2qfBg643XCwuuoYuY3gSY9Q5gG
 gL9YwVpkgZtB7cwluL85MCseiJ1J9iK93+y7GMSfoQSHvSWg3IUSVHHYGwLN9QVRFwLL
 qIctm2qGwkUYoiGwKCwpmjxXFo/iJeDQLp5Ke0RoLq8SC5lKvzJjYamBmP5Bt3zmmrS9
 YdSA==
X-Gm-Message-State: AOAM531wjjC2nxIlY9D7f6ChoCNq09rcdxN81sQz4sEUSmmR7h4A1LWB
 F+kaMSFgU3qkKUT7mPc6q2+ZW4aG9kEh49rTXDM=
X-Google-Smtp-Source: ABdhPJyKjq9jnfbGqJEu4tSP4G16v/ZoRcbJ/3fwt8Idm7VIY/oPi23f1tRxmZELIAzodGmnz9aa6rrAQL63pv+smm0=
X-Received: by 2002:a17:906:3c44:: with SMTP id
 i4mr4648872ejg.135.1622457360124; 
 Mon, 31 May 2021 03:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210528140500.GS24442@kadam>
 <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam>
 <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam>
 <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
 <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com>
 <20210531084613.GX24442@kadam>
 <CAD-N9QVAdaitDcM6BGfwvNR=gMf7G6DK00n0Ev6ucXc6xNFFpw@mail.gmail.com>
 <20210531093817.GY24442@kadam>
In-Reply-To: <20210531093817.GY24442@kadam>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 31 May 2021 18:35:33 +0800
Message-ID: <CAD-N9QUTZ49CvrhW76pTUDOp8y=29JXxR45Z_W53qVz0PJHVLw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To: Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Cc: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com
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

On Mon, May 31, 2021 at 5:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, May 31, 2021 at 05:10:49PM +0800, Dongliang Mu wrote:
> > Hi Dan,
> >
> > I wonder if we shall split the current patch into two patches, one
> > patch for each memory leak. It is better to satisfy the rule - "one
> > patch only fixes one issue".
> >
> > We should absolutely fix all these memory leaks. But one patch for two
> > different bugs with different objects and different paths is not very
> > suitable.
> >
>
> I would just send one patch, because I only see it as one bug.  But you
> do what you think is best.

If you think they are the same bug, that's great. Just send and apply
only one patch as it is. I will not send version v2.

BTW, could you please show me the syzbot link for the bug you tried to
resolve? If it is not from syzbot dashboard, can you please show the
bug report?

>
> regards,
> dan carpenter
>
>
