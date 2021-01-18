Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB9C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 16:34:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88C9223E8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 16:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88C9223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nostatic.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFBFC1835;
	Mon, 18 Jan 2021 17:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFBFC1835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610987686;
	bh=17cRLjvNUgBl04vv27zMIpJD/sjvgLGkfqCQVa1wBCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3B5tqgD/T+qLUbZyk/FV0k2O6gw01q5akCgLMwVaLrv8X2w6heVbDoIUE4gqHOHA
	 /f7ghLwnvnkG9KxqqGcPHAt+6vMKDIEYTk4g8b5iD9Khuv5yg3Fd1WD4v252SdjmGO
	 ppo8RNZIkyR5NjVKuoLqZUfhlwYMLXtpBd9aN8iQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DDE2F80166;
	Mon, 18 Jan 2021 17:33:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18ED0F8016E; Mon, 18 Jan 2021 17:33:54 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D0B1F800E7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 17:33:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D0B1F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nostatic-org.20150623.gappssmtp.com
 header.i=@nostatic-org.20150623.gappssmtp.com header.b="oOTXNRDe"
Received: by mail-yb1-xb2e.google.com with SMTP id p185so2020379ybg.8
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nostatic-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mknHcLRctKDY6AxxmcUt4tmkXxDl4bQMiIvU/KDjZag=;
 b=oOTXNRDegfMxsXJ8ejOmo3UrHuJFQ5tSP5LG3DzMbMxZyvS2pOpD9yqe/9i2i6CzNA
 8iG14/1I8qPhQyLEb9I1r4OeFrgutbm2PUMBrdlmultGGdCawySHEPqhluSCfG5C/cHw
 VHaOgISR2k72kCMdY/1pNJi7lI2b4kEYwQZTA1UJ1CUHh8nEYo4FONQAPuXrZhF89gQX
 uEy+6bYWn7VSt262H4qpnlot8xdR8hVgQXD6o+NNKKFnMAxcVV66GxI01oeQdOHbYNJG
 B980XlsmBm6ZUzKkafjD5UCkC85sW7zYQkWDF2tFMgLhfJchj9A/4fH43v6NtZW0TzUB
 RRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mknHcLRctKDY6AxxmcUt4tmkXxDl4bQMiIvU/KDjZag=;
 b=AtwArNA9N9NXfEIGvX6RgnVZzzb3Gwg1aFQAk5akulJMnJpLO8rOodV1buHaggITmQ
 XaztQfdFLWzsMKW403OMXRcuQQNm2qFFaU6rM9g9FRYofDmiQHpjQdZ+4R5Jn9Tp6VnT
 F7ZWH3gueXq65xkwHSe+J/yc5zd3UW55XPGyHpnISgMcdWSx1RzZfy4cVqFualXOuZ2Z
 /SHbv6EN2rEvR3HcxF0xQUWKACkXd4cua1ZjVAipwYLiMfgJaR1w4DX2xVTbBLdXsBex
 ha1aUHDY/u9LLg9cNe1udtMG0vzxNPmoUPUc7KLt0rfXsoYUO7RkTwiMmqCoTDiVDfaQ
 kCtg==
X-Gm-Message-State: AOAM533mlBr2Gj7Vgw14k+pGulgJ53+3EabRjbkYFs8sP+EaE/+3nhYe
 dXBm0EPDCn5oRaynJyVAxRvy7m5Tbne8K/QePZHGNw==
X-Google-Smtp-Source: ABdhPJz2e3A4OsxhxeX8WezUM1gE/fsNRvPL6FtiVDPc8ligSMrl8leY7nW68+SZavEfGN+tjfc/ckn8ysf6iospFyI=
X-Received: by 2002:a25:1d5:: with SMTP id 204mr29442538ybb.417.1610987624078; 
 Mon, 18 Jan 2021 08:33:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHXb3bdk71ivJUp9HBRccDvd8SD2F1uFdsC_FxUjhh5zpcQobQ@mail.gmail.com>
 <s5hr1mik7vu.wl-tiwai@suse.de>
In-Reply-To: <s5hr1mik7vu.wl-tiwai@suse.de>
From: Mike Oliphant <oliphant@nostatic.org>
Date: Mon, 18 Jan 2021 08:33:35 -0800
Message-ID: <CAHXb3bdt6mgUcZ0+MH1i7QeYF03MSwx=kad-YBBNeVjqoH=KhA@mail.gmail.com>
Subject: Re: Support for NUX MG-300 USB interface
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
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

Thanks for the response. I'm running a very recent build of the master
kernel tree (~ 5.11-rc2).

I'll give dyndbg a try.

Mike

On Sun, Jan 17, 2021 at 11:43 PM Takashi Iwai <tiwai@suse.de> wrote:

> On Sun, 17 Jan 2021 19:56:01 +0100,
> Mike Oliphant wrote:
> >
> > I recently got a NUX MG-300 USB guitar fx interface with high hopes that
> it
> > would work in Linux. It is supposed to be class-compliant, and works in
> iOS
> > and macOS without a driver.
> >
> > Unfortunately, while it is recognized as a USB audio device by Linux, it
> is
> > not working.
> >
> > The core issue seems to be that "stream0" reports no playback rates.
> dmesg
> > also shows errors, including "__uac_clock_find_source(): selector
> reported
> > illegal value".
> >
> > Any help identifying the issue would be much appreciated. I have some
> > experience troubleshooting the USB audio kernel code and am happy to try
> > doing so if I can get a nudge in the right direction.
> >
> > Output from "stream0", dmesg, and lsusb follows.
>
> Did you try the latest 5.11-rc kernel?  There have been lots of
> changes in USB-audio and this might work better there.
>
> If it still doesn't work with 5.11-rc, please try to enable the debug
> option, e.g. boot with snd_usb_audio.dyndbg=+p boot option, plug the
> device, and get the kernel logs (at plugging and during the audio
> operations).
>
>
> thanks,
>
> Takashi
>
