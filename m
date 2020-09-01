Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D6C433E7
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:17:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F14207BC
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hT4m8mHN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4VSDHzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F14207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AB321793;
	Tue,  1 Sep 2020 14:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AB321793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598962661;
	bh=+CaTzSnNzg6gLEQcn+eSEK6GyqsSw709vChuTdIxb14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hT4m8mHNE2H+2aVfU0K+P0oD85Yx7yBLyBaa8x0p4C7jX7Upi5Oh+CaYBuiJ9NmET
	 Bsg0XN4DjeBjChyEnuwR+T6tYFNZ1v/OBp2pZlMeIN400Y/AE/8IQ1ejP2REpq8MCj
	 7nAAAZ1m+iabRfZAke3bEEIC6AYENJF34HgtljfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB5CDF8020D;
	Tue,  1 Sep 2020 14:16:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 224BFF80217; Tue,  1 Sep 2020 14:16:48 +0200 (CEST)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2F28F801DA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 14:16:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2F28F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="B4VSDHzs"
Received: by mail-lf1-x141.google.com with SMTP id d2so647713lfj.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vp2v4JbUh7qcxgfYFlgQakIncyjTSb0yTOWzsVE4DE0=;
 b=B4VSDHzs0e0zyeqh5mspuUDjtxOe25+xX3BNX9MaFb+mFukd/sBPLVJPEdIMwK6jPL
 xs1msKWwfdsxTAT6x6HegS2UORR4Jg96HBYyTyZOrHv4IrwC1tfjD59i1aqS9Y+2Agnk
 3zy2W/R8Ww/PXR82YWnVtM4r8Ulx3s88ZZRMy3fR+/t3n+8ZZ0i+7V1ryZwiLHSNKkGH
 oKLemyrApvdGtJk6bmVDJFdV6SRxnUaJW6KzrLGep8tBAQO/cmhuRSsm93T9Y4svY7HC
 iq0gCH0/vRuy0XjauCOqm8GzzIPKNacG46Za24d2fNqAyEiqpk1UsbP/vbmngH+IlQ11
 M/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vp2v4JbUh7qcxgfYFlgQakIncyjTSb0yTOWzsVE4DE0=;
 b=gAWKvfIFzpNdaviPDAmOJWgHH23vJHz5O27RjVVNud4hSobhFtetTdB/avh6tuHyoP
 Bc2l3mV79r1T/fiFSEXsnlA1kg/5xRzPyKxGHTzCtNriYhsIpQsfMhhAp710DlKRfShU
 +jVQ/hK7+UNa5z71jdcELLvaBnIu62PqPbvcTu9A8jSLWId8tuUMVFdCnGmDAjrM6FmK
 VlpHpeSWMYE9gFJGVM+s75//ZP0jc40lPAS3W43sInI++GY6CcfNeFiqowySwOsljyE/
 l3VZVeuywkLKRbyLp0U+iZb3dgORAqr5xkcX9WqaFKoWU3gSj1FMriPh49bIAtPOCfuN
 F0XA==
X-Gm-Message-State: AOAM533Ht6G5XPKvxMlmz5wd9AgKXj75oWLzrmlpm4CHpcIS9P3hh96Y
 DszDcJ5XjA+MR63kCrqc30ZsboDboylhlkdW3X0=
X-Google-Smtp-Source: ABdhPJxoFyWaRfnsytczCGvJ7IQ82jpNtM+x3RdBJXdblhKML6ppcq16oaRvc65mc2KxmGRRwNVn6mZs1IteS64LFqc=
X-Received: by 2002:ac2:420d:: with SMTP id y13mr457937lfh.69.1598962595957;
 Tue, 01 Sep 2020 05:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000971bc005ae3db23d@google.com>
In-Reply-To: <000000000000971bc005ae3db23d@google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 1 Sep 2020 09:16:24 -0300
Message-ID: <CAOMZO5Cw919kMk2t2SwTpGkij+r3L3sBhWEuAgMVooPbrnQ6rg@mail.gmail.com>
Subject: Re: WARNING in snd_pcm_plugin_build_mulaw
To: syzbot <syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>, syzkaller-bugs@googlegroups.com,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
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

On Tue, Sep 1, 2020 at 7:08 AM syzbot
<syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1268efb1900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> dashboard link: https://syzkaller.appspot.com/bug?extid=23b22dc2e0b81cbfcc95
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a95f41900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a452f2900000
>
> The issue was bisected to:
>
> commit f3ca3f5b0966cfc2737178cca8a7a65b09991898
> Author: Fabio Estevam <festevam@gmail.com>
> Date:   Fri Mar 27 15:57:21 2020 +0000
>
>     dt-bindings: sound: cs42l51: Remove unneeded I2C unit name
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15395f41900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17395f41900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13395f41900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com
> Fixes: f3ca3f5b0966 ("dt-bindings: sound: cs42l51: Remove unneeded I2C unit name")

The conclusion that this commit caused the problem is strange, since
this commit is just a yaml documentation fix.
