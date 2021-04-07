Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C77C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 20:05:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF30261158
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 20:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF30261158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD97515F2;
	Wed,  7 Apr 2021 22:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD97515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617825903;
	bh=eRiPfks7egj5xWVw/L2TtLIoyYqfHCTvjPTFdj/sJsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jUhTw+JSzOMGW9KrYHVJz0DwjzqHcwLt1JU7zhi04TbxQJd6NAVBP2sLll7kCz1uM
	 QXH6ow1WAaOuIymPh6QKmHA4KHMSkHPlQFOiWw3lu+uW5unjnG+kEP1LETQrF6Uo/e
	 jvjHFDarI8NYT18fvONO86pjz2u0/zxGP83Sa9jQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 371C8F80168;
	Wed,  7 Apr 2021 22:04:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72DF6F8016A; Wed,  7 Apr 2021 22:04:11 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F400CF80162
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 22:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F400CF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rTK4oZGL"
Received: by mail-qk1-x72f.google.com with SMTP id 7so20066216qka.7
 for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2021 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wv0iYiG4REVzqgnIwZBM9s/eJPvMTmIRDQR+YGlN21Y=;
 b=rTK4oZGLqlj8eeElVHGhrmdnD7I1l3NqAsdBZznxNLkA0k7yYzOvFQDt2sED3FAGSR
 iTCyCsOLCYYTleR1UnK4wvZJ45p1piha1NrkhoZw74nYt1qqKMGLbbt5vvKPngqern25
 rn/ALMbbd+bvmwrKZ365LlnTsimv44skkMIeRbdtixTtxr9pRT95sfN0J0lI30OK1QNT
 hsQI1cLGuCkUjCdVe1yJnC2alrB1AFPQZhGGqgtA+cSDQIc8/Au3n44irqWIs2wUVWxT
 K3LTdybST7I8rfmmo8P4u32Q5vXFdOtbEwzILka+EeGeafnVLyHXta5e9RiKJCWBo0S/
 JzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wv0iYiG4REVzqgnIwZBM9s/eJPvMTmIRDQR+YGlN21Y=;
 b=sYWsI6DqjIJgSZJT8f1lwX0mhuNHwiiic3Zfz7CsaWJ/cihUQex8XpfJpilQ/Nij5s
 nkSkUaL+RNKeO9H8FA3EYaM+isHi4+yWbqmK+zZPrnQmeLVJy4xge2EPrqthGIW0EsRv
 YtM42x95zqbdm7t9ct4vH/2sBoPgfHXp80VlHwFWptd/87UQIwJHb6ifeRFkV8ktzk3N
 AzWHoRoGVFgCgOoDKERZgMmpqmcE0AWU4peJmP6b64+zosoScfFYiOBMzXrC3MBMIKor
 tsEiE+y2pHmi83Jh15bgR4Q7RGtW6ptHXhPcKn67YHSCTkiIVKLZjubTmeSc8z96blCi
 Fa3w==
X-Gm-Message-State: AOAM532TfacB0eQliF5xKfiCmWDZTkyWKfFX4rzsgpeeHhnEwFwkGhym
 A/jWxhNEAsJuegCokLy/owjm0pGPyuaOIl7CAaw=
X-Google-Smtp-Source: ABdhPJwxhPDX6H+Tc8xXfZ6TJ8nMDfZSJhVQ6IBV9Lf+0FkWKwNmFZMQJ2FfB+fcuTHRXlwnqL0uebv3qO5OKk3Ju+U=
X-Received: by 2002:a37:a38e:: with SMTP id m136mr4912126qke.250.1617825840420; 
 Wed, 07 Apr 2021 13:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXb3begced9GYCQ4a6qLOK2PrQR9gHeSvb3HAG29DVpZ+vwiQ@mail.gmail.com>
In-Reply-To: <CAHXb3begced9GYCQ4a6qLOK2PrQR9gHeSvb3HAG29DVpZ+vwiQ@mail.gmail.com>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Wed, 7 Apr 2021 17:08:41 -0300
Message-ID: <CAEsQvcu5freEXMFwBRH0aQsT9=ngvOY_SkA6dmfs_YVvMYYuJw@mail.gmail.com>
Subject: Re: Implicit feedback on BOSS GT-1, the saga continues...
To: Mike Oliphant <oliphant@nostatic.org>
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

Hey Mike, did you catch the latest patch by Takashi Iwai for capture quirky
devices?

You can find it here:
https://patchwork.kernel.org/project/alsa-devel/patch/20210406113837.32041-1-tiwai@suse.de/

Em Qua, 7 de abr de 2021 16:55, Mike Oliphant <oliphant@nostatic.org>
escreveu:

> I had thought that the recent implicit feedback changes were fully working
> on the BOSS GT-1, but it turns out that I just hadn't tested well enough.
>
> Audio playback and capture works, but with periodic dropouts. I get the
> exact same behavior as I did with the quirk to completely disable implicit
> feedback. Without the implicit feedback, you get dropouts from clock drift
> - how bad probably varies from card to card. On mine it is every second or
> so.
>
> If I switch playback feedback for the GT-1 to generic by doing
> "IMPLICIT_FB_GENERIC_DEV(0x0582, 0x01d6)", I get the previous old behavior,
> which is that playback completely fails to start.
>
> With generic playback feedback, and using my previous patch to endpoint.c
> to avoid playback waiting on capture mentioned here:
>
>
> https://mailman.alsa-project.org/pipermail/alsa-devel/2020-January/161951.html
>
> playback and capture work perfectly for me.
>
