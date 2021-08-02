Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84EEC432BE
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 19:28:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DD9610FB
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 19:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9DD9610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8615C1707;
	Mon,  2 Aug 2021 21:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8615C1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627932499;
	bh=0qldWUKxnozqb0QFkRWl7uDnM1senBAA5Z7f4UzWOGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vREC3pZyuN5QwXwPpbyZ+eqAJdY2griss/7G7Ayh66L1ltUmFDH6vt7/+nBmsHhTy
	 vIW/bauG5cKKr17FQZNNuFMuRHFwqwHdSfVAbHVhrVsfj5xovqUnTL92tc+UoKYHID
	 vkkOs+V+qwhLTxU+ltK+PUppBrBHoWuCxLO7L4fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B017F801F7;
	Mon,  2 Aug 2021 21:27:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86CC1F8025F; Mon,  2 Aug 2021 21:27:27 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C261F800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 21:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C261F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UJYtqIBG"
Received: by mail-qt1-x82f.google.com with SMTP id g11so12408548qts.11
 for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2021 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HW3njuGv1KDBuf2BFHE9VIv7j8uLAl3w93h1YDLX4MM=;
 b=UJYtqIBGary2sEHwTCasO1g38aBnU0od1jtTVKg+/YuutvSXiCUvZuEsUzkYj7ZR1G
 5phMk2MxhEXiWY2hcOuG/QpKcB2600lA03DjuKLOdpesDpAQpb8nOUAa+q7M9KKqXGsF
 lyVx/oBN4kWmq1s2U7ZUHC0h3mcOcjNBPR0prlDYoxzUwY1dgy9yd27AVeJZldKVPHX/
 tLIPT1uSrRbmbc7kc/nxUtqVWcjCjdTIyOKqKDg9UUB9vj/MM2dGzHKc3kwrNLUUV/zP
 L/Y4Yt4NgoP6pxMrN+0cF52PSSq4Hxcg3RAJ4f6naZtTmrS1Xauig8fk9WX1mwpbohKs
 zRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HW3njuGv1KDBuf2BFHE9VIv7j8uLAl3w93h1YDLX4MM=;
 b=hs9rL4XjscHIht7NTRs9wgILuBEj3DdZva1P0ilXwNacYJMZ1ynhaTd3zrwdfFQs7/
 ixoAu2qZDwtbsYm1vz/Jvw8uGCOm/8ObluCKZkBNZtSvCAx7g0uGilIVGXNy4xqBhtZ7
 rwuKl4I9rfWcBvSBcj/EPb+VPCdQ6j3oMgAHTLsZ+cBhUer71CFEQY6ROuMSPkzF0HpS
 mubhV/AwSZjIXKhOK9QoMWjurxmDjIiuiTfrG0L2/mlIKAQq342MLtLud9yun6bSQOUV
 ynNzhB273dLmcgnz7O7wgtvBRU/lqf/QhLulVt7R3rMfrJsiQmxy5hbeZS/sYRo3WX01
 QfrQ==
X-Gm-Message-State: AOAM5316IM/3tAVeQNf3JAMrCNjq3ggYgxdce8GxuriN9ynOv2C8Wbm8
 nlj1MQe+uG3RgxmTqnsD7mOupWXoi+vTjVuZM98=
X-Google-Smtp-Source: ABdhPJxY2ix9DZ0feo4442os4zftfFiOOj2fX7FixGlwtRMn7Fa2nI3vm3ArgIBtLTPyeYQiKoZAxWAw/q5D4zPiEI8=
X-Received: by 2002:ac8:7c54:: with SMTP id o20mr15633671qtv.142.1627932438078; 
 Mon, 02 Aug 2021 12:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <DB9P192MB132193EF1C0E9DFA5161A298C5EF9@DB9P192MB1321.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P192MB132193EF1C0E9DFA5161A298C5EF9@DB9P192MB1321.EURP192.PROD.OUTLOOK.COM>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Mon, 2 Aug 2021 16:27:09 +0000
Message-ID: <CAEsQvcvuWQ5FU4qGZb3Rw-BP_WNdtc7qAq69R2ZHLiA-WQmY5g@mail.gmail.com>
Subject: Re: dmix optimization
To: "Giuliano Zannetti - ART S.p.A." <giuliano.zannetti@artgroup-spa.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

Hello Giuliano,

My suggestion is to repost your question with Cc: to Jaroslav Kysela
and Takashi Iwai.

I *think* Takashi Iwai deals more with kernelspace and Jaroslav Kysela
is the one that can help you with alsa-lib.

This is a high volume list and sometimes mail will get ignored.

But Cc: the Maintainers and they will take notice and hopefully you'll
have your optimization feedback.

Thanks,
Geraldo Nascimento


On Mon, Aug 2, 2021 at 9:26 AM Giuliano Zannetti - ART S.p.A.
<giuliano.zannetti@artgroup-spa.com> wrote:
>
> Hi,
>
> I'm trying to optimize the dmix because I'm working with a big number of =
channels (up to 16) and in this case the dmix has not a negligible impact o=
n performance.
>
> I'm working with ALSA 1.1.9. I gave my first look to the generic_mix_area=
s_16_native function (https://github.com/alsa-project/alsa-lib/blob/v1.1.9/=
src/pcm/pcm_dmix_generic.c#L130).
>
> I would ask you if I can avoid to check, for each loop iteration, if the =
current dst sample is not 0.
>
>     for (;;) {
>         sample =3D *src;
>         if (! *dst) {
>             *sum =3D sample;
>             *dst =3D *src;
>         } else {
>             sample +=3D *sum;
>             *sum =3D sample;
>             if (sample > 0x7fff)
>                 sample =3D 0x7fff;
>             else if (sample < -0x8000)
>                 sample =3D -0x8000;
>             *dst =3D sample;
>         }
>         if (!--size)
>             return;
>         src =3D (signed short *) ((char *)src + src_step);
>         dst =3D (signed short *) ((char *)dst + dst_step);
>         sum =3D (signed int *)   ((char *)sum + sum_step);
>     }
>
> Could it be possible check for the first sample of the period only, as re=
ported in the code below? My assumption is that if dst[0] is 0 also dst[1] =
... dst[period-1] will be 0, and I don't need to check every time. This is =
already an optimization, but it could be also a starting point for other op=
timization based on my HW. But, first of all, I would ask to you if my assu=
mption is right.
>
>     if (! *dst) {
>         for (;;) {
>             sample =3D *src;
>             *sum =3D sample;
>             *dst =3D *src;
>
>             if (!--size)
>                 return;
>
>             src =3D (signed short *) ((char *)src + src_step);
>             dst =3D (signed short *) ((char *)dst + dst_step);
>             sum =3D (signed int *)   ((char *)sum + sum_step);
>         }
>
>     } else {
>         for (;;) {
>             sample =3D *src;
>             sample +=3D *sum;
>             *sum =3D sample;
>
>             if (sample > 0x7fff)
>                 sample =3D 0x7fff;
>             else if (sample < -0x8000)
>                 sample =3D -0x8000;
>             *dst =3D sample;
>
>             if (!--size)
>                 return;
>
>             src =3D (signed short *) ((char *)src + src_step);
>             dst =3D (signed short *) ((char *)dst + dst_step);
>             sum =3D (signed int *)   ((char *)sum + sum_step);
>         }
>     }
>
> Thank you!
>
> Best Regards,
> Giuliano
