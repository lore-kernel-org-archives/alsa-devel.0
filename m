Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B1C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 08:52:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36CD610CC
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 08:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D36CD610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87936184C;
	Fri, 13 Aug 2021 10:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87936184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628844743;
	bh=Uqwt4Q9L5x+M9THC59RJEIFGR1XoNby5gjlUe2bGqjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxaoegqX2rEH+0d0u8KpszF4UkZ+IU1VgG4th0JGfKDNHNH+SgtvKrKVsEo5/OB/9
	 gtDpU3InIlJYc0v0QbaUv2Uk94jZjDM+XfYAXQLuVQBkrCuoHROX4vytOV2TVay8Uw
	 etzipz9Bg9yYXjltysSYlNyDn+yCcMDdOyTJwZ9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C3A2F8020D;
	Fri, 13 Aug 2021 10:51:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44754F802D2; Wed, 11 Aug 2021 14:43:21 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96253F800F4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 14:43:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96253F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DB0iYLXu"
Received: by mail-pj1-x102e.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so9297659pjn.4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cOANcQIs9Ar+QX5NpzQhxFpOziOhNrP1h0WDxrVgheI=;
 b=DB0iYLXuIEwwm5YwvrLlw2MuD58mpbtrBTT8ScPyeqA+ndPVqYjWjTu46Vb6KTsQfX
 M2SzvhdudAbsDyDA5/Ypc2FPxYoIVMetI+Sea/k6YS8DwFOerjNCiqNDs8TT23D5eNt9
 pR6atqyaxThOIZzQphBTlEStmrXxsIM9iaqDkC4mDpO7wivkMibNKsPWnZiwitbZymQ/
 rb2+IFGn8boRShsJtljymlmZlCtG8jl5ehL+pyEEA9a6+3j6JcHtTe6abGEIqd5vx0h2
 hCUAdWGG1Gi8MRNN+gwXCdtdAzhw/hSjQQmR9JlAKSNKzbRcf7Ikt0NFl4DZQ0JG0U6m
 M/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cOANcQIs9Ar+QX5NpzQhxFpOziOhNrP1h0WDxrVgheI=;
 b=EItVbGxYjfRTulpEXOSI+NgdAX8BB0bokrNEV8gPT9U7PU8LUBcF5scKIpI8FzyIaq
 KSW0HtxTBUqjYnmbaEhkFlRQhyej3w/BjNdlJKE1Ct6+5mYpDVFiZrzF2aKDPmfdukE0
 JWL8DF2xn17sjIiys6aU9L50zrsSIbZ9YFrE5gEFlOcpdfrMDwfy/UJsUXYz3C8Zx5Rw
 WUmCc2s2VUxTcPcoxCnaO8mIt8ffp0tcSM5z35sxGVtreuNIzA7nBqs1685bSnhwZV8g
 UBVtkWWvNREoYEIeFh2oBMrtL1cM5+YgZNR781IjcsJb7Ue5gsEdk/RWSj5IulVtU7S6
 kSSA==
X-Gm-Message-State: AOAM533DvmfiM2/stSKnTBhnzyw7rMTjvVn3msKSTS3miuxfmWyKyxtW
 HJ0sYF0mdUJwLvwtDvu3Te+PePvgh7TKZ0ADT/s=
X-Google-Smtp-Source: ABdhPJzE+sjikp72XXtYUufc1yc4N1KgY8GbaXGkC4mCJEVBVocoKSkuZVKRJaYTGwwYcOAX87vqLop4x4M/mfSNUKU=
X-Received: by 2002:a17:90a:2c05:: with SMTP id
 m5mr37855025pjd.32.1628685795924; 
 Wed, 11 Aug 2021 05:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
In-Reply-To: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
From: vishnu <vardhanraj4143@gmail.com>
Date: Wed, 11 Aug 2021 18:13:04 +0530
Message-ID: <CACk2A5ZOhZwvoLR-+m8LMpmC5stFhAvcxLuZZ+7ad47gaiVfkg@mail.gmail.com>
Subject: Re: USB-Audio: Device or resource busy (strace log)
To: Muni Sekhar <munisekharrms@gmail.com>
X-Mailman-Approved-At: Fri, 13 Aug 2021 10:51:31 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
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

can you paste output of
arecord -l (list of capture devices).
Which device you are using and os.
Does this instance is already open by default? like any video playing or
something like that?

On Wed, Aug 11, 2021 at 6:06 PM Muni Sekhar <munisekharrms@gmail.com> wrote:

> Hi All,
>
> $ cat /proc/asound/cards
>  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
>                       Plantronics Plantronics .Audio 628 USB at
> usb-0000:00:14.0-2, full speed
>
> I am using a Plantronics USB Audio headset.
>
> $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz x.wav
> arecord: main:722: audio open error: Device or resource busy
>
>
> 'arecord' command always fails the first time after system boot in my
> system. But subsequent execution of the 'arecord' command runs fine.
>
>
> I've attached the strace log for the "audio open error: Device or
> resource busy" failure. Is there any fix available for this issue?
>
> --
> Thanks,
> Sekhar
>
