Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65961C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 14:42:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390B460F55
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 14:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 390B460F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 452FB1714;
	Wed, 11 Aug 2021 16:41:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 452FB1714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628692938;
	bh=rBzHqrC3WsqfxZq4Uf6XjabcF6mAOmXbHokLBoPGwHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HH8vxh1EHeMgDW3WSr7aDXDwpQ5bkFshy5SXGglxVBbkOG+be0WjLEJhtuRcdykCu
	 ZNRIHCOAcPi0mP7gkNbZqDMpgCREJyZuoaWYCva1jZzeK3n95ISx96UzHXOmYNsLi2
	 T7S0XtZ7zj2cX3HcbCbeX6XhPKACTBvZS0Vy83FA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF7DCF8020D;
	Wed, 11 Aug 2021 16:41:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79774F802D2; Wed, 11 Aug 2021 16:41:26 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CD4FF800F4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 16:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CD4FF800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="E1ueDDxs"
Received: by mail-qt1-x829.google.com with SMTP id z24so2230995qtn.8
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=woz6rh43vQuyI5ixWRzgN4oCrQUNRAIALrBLaN/K7qo=;
 b=E1ueDDxsTSx2qzVSyxsOzrux23LFqyPTmzNUp59VgAkT5ipHwksITT5ySPwBN3j5jI
 Ky8NehEabNtPsqMTK3UmCumvjNVMWPQf8JXDOvVTV9v7VUeDF4c2UwkC/MPtAhddyuZF
 NMQDhdBHWJR0+eRzEyhkNCGxvsbPMV0/yD36s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=woz6rh43vQuyI5ixWRzgN4oCrQUNRAIALrBLaN/K7qo=;
 b=rC4TJrUDjnHXScPnKO1NF1ohNRvOwZo36OtAOdWXlJKxIYnOYFDp/fBAudf+l3VSyQ
 2vW9wRt90N/K7J1E7M5Hug/udxlH1mRY4z6z+VFgBv1FBgzHZgrbSb4M8toLNvERfTSL
 IZDW0fbHxL7yJBK67BlmPPH4bZrj29k6RORH3pGCyCl5ypQcKchTD1jYLBBSagtHxcnt
 Yg/jir4AsPg9dy1ZBJGWh15Ze3/Dge1SrCo1sEpjhZ0dcqwsvLzMbsxKntBZ5RqUpz6n
 xn2FhUlEtUhAUhmdkqprgI2fLVz/UxIi7BaWxh92A4RjQFZ0nQLjduORw+C3a/f1ew0n
 93rg==
X-Gm-Message-State: AOAM5313BpJxKOlXP99WIQ8cvjgnUab9rtghsqSwRu18j5R4gMkNVwjP
 78i76PQA0ygfWNoxGX3R2Tla/QlRSe82qA==
X-Google-Smtp-Source: ABdhPJy8qWjzk9T4k9uJ+h14Zd9AdGHa/eoNtge+prvxaNSPysiahHZnkpgKa0gEHcvtxdX/ywWmYA==
X-Received: by 2002:ac8:5f4f:: with SMTP id y15mr6913309qta.62.1628692873418; 
 Wed, 11 Aug 2021 07:41:13 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176])
 by smtp.gmail.com with ESMTPSA id d129sm12826354qkf.136.2021.08.11.07.41.11
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y16so5216749yby.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
X-Received: by 2002:a25:ba44:: with SMTP id z4mr44332481ybj.476.1628692871281; 
 Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
 <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
In-Reply-To: <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Aug 2021 07:40:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
Message-ID: <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
To: Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Oder Chiou <oder_chiou@realtek.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Bard Liao <bardliao@realtek.com>
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

Hi,

On Tue, Aug 10, 2021 at 9:24 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > @@ -156,6 +163,10 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
> >                 dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
> >                 return ret;
> >         }
>
> Nit: Add newline here.

How strongly do you feel about it? I purposely left the newline off to
try to tie the devm_add_action_or_reset() more closely to the
devm_regulator_bulk_get(). I wanted to make it more obvious that the
two of them were "together" and shouldn't be split up. That being
said, it's no skin off my teeth to add a newline if everyone likes it
better. ;-)

> > +       ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
> > +                                      rt5682);
> > +       if (ret)
> > +               return ret;
