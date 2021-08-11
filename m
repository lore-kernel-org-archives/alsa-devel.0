Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFEC4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 08:53:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9BE6109E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 08:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A9BE6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58F3A18AA;
	Fri, 13 Aug 2021 10:52:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58F3A18AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628844794;
	bh=2ndTMbipHobjYNtrBHp6H9idoMFFOC4QrOuiwYE4+pY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i09cnt4unX9WdPZYdZbX6HQ10Uj5AKQ2AH/ZPF5ezcCEtP54v4KTNDph07D6IKCgl
	 S9kK4K7Z+06C/5UcpMkuzlHJSLqBwH5bs8ZbgCShVarpsmEvPlh0h6SmB81kaBnitj
	 ZgO1h6EsvgJ/exvdCN0pawY9A1/H7DEez+D8ZY2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2555F804B0;
	Fri, 13 Aug 2021 10:51:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22A13F802D2; Wed, 11 Aug 2021 14:49:49 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAC73F8016B
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 14:49:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAC73F8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YuTFQ0sU"
Received: by mail-pj1-x102a.google.com with SMTP id
 s22-20020a17090a1c16b0290177caeba067so9429997pjs.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CCg6b72chxVBjebD/TDjtg0ZtOgBtIrjTrxC5g87fgw=;
 b=YuTFQ0sU8vlk0i2jZMIsHWSC7ZUB8GMvPIcdezwJSWpuksAKVCFS4w0tjYpw032iOP
 eGQ13YuVwVSij9wCqaQVN5KisqMUA9+yp2J4BODm/ZBisE6J1RYcF5Ubs1KmynaUwZki
 LX73C+oUmWEpqa/lsQrZ/EWuEt1CRicv3toiUYor/bv++byqecH++FvfjlHFm9w8z+Z+
 Rt8Sb9V5oTtMIUT9dBuZmd0U0e2mpShl8kG4FvMSrM1EReSmzIoSukZPWE3UR5KrwN25
 2rnee5BmUUxOzNGEouh74Sd/isR2+n3GknOSD7jx+NnsuprndLH+PZCE9b+8SVoqeyer
 PCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CCg6b72chxVBjebD/TDjtg0ZtOgBtIrjTrxC5g87fgw=;
 b=U1GKCVGYPxH1HeV1shgfan1Hv8eLdbTQD8lWCHgHRJMh/XVHN/ukLwoDoZE5kWlflg
 rgGC3Kq5cA3yW6Kd0nvuiB9fveeVRKL/S47XWvvaVcPEgH7LI4TzMHgYnnhiSORryunJ
 uEFrpreQ28n90vLao3l/OavRQymp7jNH9QGaLBFjpYlureUAq9dyX55JiYsXz7KxLp1U
 iLVgIp2Kavi8OrZiFaJeJms+wkx5hMUj3pG2/bLe+8+JB/36AJHhElOBy2gSDUbJ1qtU
 PjPvdr380hDQ+Oj+0nQroewqgtYTLyGxuI/UNP64U/Euhiq9ninNa8dC3VwKTAKW5dZd
 YVlw==
X-Gm-Message-State: AOAM533MS1GoG+DrYjmp5bnFWi0anp5ffIy9NrJpQ//u1SDhGlf50ALe
 WasASBfHr6S75JrKlvp/ipnaDAfl+i0mJIXcZNI=
X-Google-Smtp-Source: ABdhPJwmjH0JW151nhZGLuy/36mDdns5k+lNGgzxHyEMST7nTNn5TOOSBXb6rGnBXDd9aIzuyV+lk+/FqpT6tAYp4bk=
X-Received: by 2002:a17:90a:6e41:: with SMTP id
 s1mr10600418pjm.109.1628686177884; 
 Wed, 11 Aug 2021 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
 <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz>
In-Reply-To: <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz>
From: vishnu <vardhanraj4143@gmail.com>
Date: Wed, 11 Aug 2021 18:19:26 +0530
Message-ID: <CACk2A5ZcrVTv4AVHdmRDh-xWkx=1BHi6SV8yYqX1Z2DzcDR8hA@mail.gmail.com>
Subject: Re: USB-Audio: Device or resource busy (strace log)
To: Jaroslav Kysela <perex@perex.cz>
X-Mailman-Approved-At: Fri, 13 Aug 2021 10:51:31 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
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

Yes you can stop pulse audio and try..

On Wed, Aug 11, 2021 at 6:17 PM Jaroslav Kysela <perex@perex.cz> wrote:

> On 11. 08. 21 14:36, Muni Sekhar wrote:
> > Hi All,
> >
> > $ cat /proc/asound/cards
> >  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
> >                       Plantronics Plantronics .Audio 628 USB at
> > usb-0000:00:14.0-2, full speed
> >
> > I am using a Plantronics USB Audio headset.
> >
> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz
> x.wav
> > arecord: main:722: audio open error: Device or resource busy
> >
> >
> > 'arecord' command always fails the first time after system boot in my
> > system. But subsequent execution of the 'arecord' command runs fine.
> >
> >
> > I've attached the strace log for the "audio open error: Device or
> > resource busy" failure. Is there any fix available for this issue?
>
> You may check which other task blocks the PCM device:
>
>   lsof /dev/snd/pcmC0D0c
>
> I guess that it will be pulseaudio (device enumeration).
>
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
