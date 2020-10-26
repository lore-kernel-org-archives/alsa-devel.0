Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E2C388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:08:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B9D20724
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kgf5NGYN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqyMc1kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B9D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0213167D;
	Wed, 28 Oct 2020 09:07:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0213167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603872494;
	bh=qwnoRCo1R4RfJLgUjcT/fdMEYl7CJRbP6ocAzrkNLc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kgf5NGYNqFjS4XGcmK0iuBC4Z8qHRviYSF2qxxswafYDL4mkFQ7BN9IA9yXNIeCqz
	 R+vpyxhH9NC5ngDZygYJsYqxER9aRqQEh2kdhtfKtO0My48kas+R0FmSGk+l061HQe
	 XRMuUNjv4HWFMHtWcP+LixWQX1/gEuaDZTl5F3O4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50385F8026D;
	Wed, 28 Oct 2020 09:06:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 358A1F80212; Mon, 26 Oct 2020 20:04:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2282F801D5
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 20:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2282F801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yqyMc1kh"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3B2120720
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603739036;
 bh=qwnoRCo1R4RfJLgUjcT/fdMEYl7CJRbP6ocAzrkNLc8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=yqyMc1khYO6ap4udmnatIQsPNHWic4GWJYd9rqedjVyxmMCI+0sWXLnojS66ANixx
 jkkOria1ybrxdVoRk24YkM7bVjMwADPt+I8ab7KDQrF2JElUqbZVDygw94439GaKQg
 FYEhfi0XcFNS14L71xkDswKmVgAnJCTz6RtGuvi8=
Received: by mail-qk1-f172.google.com with SMTP id h140so9429222qke.7
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 12:03:56 -0700 (PDT)
X-Gm-Message-State: AOAM532Er7QYNZj81aJ0qs4g206qsCj5avX/GlCUu4uINpdfdId4l6R+
 EmUaANMRUJnE/QV79KGpGuYPThUpm8N+0h5DUfM=
X-Google-Smtp-Source: ABdhPJw6BBoPGjGlIDtQwuPEhCx7xKTVaToDIWOa6kzLyFFyrrXvnTRFloxWvctqCe7Wkj7ht0lbN1hIjBMZuLAo7ok=
X-Received: by 2002:a05:620a:22c9:: with SMTP id
 o9mr2593705qki.286.1603739035860; 
 Mon, 26 Oct 2020 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026165715.3723704-1-arnd@kernel.org>
 <s5h4kmg537s.wl-tiwai@suse.de>
In-Reply-To: <s5h4kmg537s.wl-tiwai@suse.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 26 Oct 2020 20:03:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kdNuipus=_Jr=Scd5_E+68LDi4zxPLqrT05ffXzD7Xg@mail.gmail.com>
Message-ID: <CAK8P3a2kdNuipus=_Jr=Scd5_E+68LDi4zxPLqrT05ffXzD7Xg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: make snd_kcontrol_new name a normal string
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Oct 2020 09:06:29 +0100
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>
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

On Mon, Oct 26, 2020 at 6:03 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 26 Oct 2020 17:52:18 +0100,
> Arnd Bergmann wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When building with W=2, there are lots of warnings about the
> > snd_kcontrol_new name field being an array of 'unsigned char'
> > but initialized to a string:
> >
> > include/sound/soc.h:93:48: warning: pointer targets in initialization of 'const unsigned char *' from 'char *' differ in signedness [-Wpointer-sign]
> >
> > Make it a regular 'char *' to avoid flooding the build log with this.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm fine to apply this, but I thought we agreed to ignore pointer
> signedness intentionally?  There are lots of such places and we were
> fed up in the past when gcc complained a lot about those...

I'm only sending fixes for the ones in headers that get included in
a lot of places. There are good reasons for building being able to
build specific drivers or directories with W=2, but it's less helpful
if there are many identical warnings.

       Arnd
