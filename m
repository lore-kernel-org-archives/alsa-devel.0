Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37714C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Oct 2022 13:00:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F99271CE;
	Mon, 17 Oct 2022 14:59:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F99271CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666011614;
	bh=Dyes0SMhxukq/E9mP7x94jSy4icieiupZFlAfb6OeOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O24Ia8MjcKu4NysAOGINfDu/kBuTHKii29R/dOUDGUUg4C/yJbFFn5StDX7HGOd5S
	 wcFNttkz21H5F0Xwf0VMeb5jzYKVczjjjhBBUcY0vrG3LuIdEONh9inaVH3n18Y1kZ
	 F8iPMQu8W9m+8EuEksuOMN22RRW4FYtb0093ynVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E7DEF8025A;
	Mon, 17 Oct 2022 14:59:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E2DFF80496; Mon, 17 Oct 2022 14:59:22 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9082EF800E5
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 14:59:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9082EF800E5
Received: by mail-qt1-f169.google.com with SMTP id g16so2767622qtu.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 05:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYUtPYFB9C+7Trxy7xCpZPLfeVdftlC1KSkxlxw2jX0=;
 b=ev2puhvlqE7fLD2tVV6T398JkGJW4uGULsKNoWkX/1oF4RlTHIvS/R63V+8tWLKSKX
 Mu5H9fh/Ql12XSj5Ssf3Or1Qk1YhxCybUNW9va0MmJRxmU7Pxp4u0fFX+1cpKAtzp14e
 TeNg4bDKW9uyhI+yXvUNzff2IeRfOX9cY+gnHygzEVh9U68r+1go35s3+oNyBNx6mx21
 en3pl+G5EyOeTxN/hxnXrv65Z92qK9F35A7azNfsys7lzrLqNp6ve2ThTRmo1J9uZ8KI
 hJHAqoAyT41IC0JV45aFxDXdry7dgO41JwdVhn03G6XFx95qIeMuPAnO4crA9OncCb9Z
 /ILw==
X-Gm-Message-State: ACrzQf3dZc7xHblEexhli4F9zFAItGI8pJtwidTNVVDD+nCnGm7FRbSz
 5WvBDlmmGLXZHEYvxfg3D5CEzXaoTMDmRA==
X-Google-Smtp-Source: AMsMyM5PE+sVfRSObXeknRRVcXWhwEHhEKeSksfOZge53ymHJkIuUIrPm1sMyNmWtOAVFVtpsQGdhQ==
X-Received: by 2002:a05:622a:10f:b0:39c:cd6a:ee2f with SMTP id
 u15-20020a05622a010f00b0039ccd6aee2fmr8664057qtw.388.1666011554661; 
 Mon, 17 Oct 2022 05:59:14 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180]) by smtp.gmail.com with ESMTPSA id
 q6-20020a05620a0d8600b006cf9084f7d0sm9374119qkl.4.2022.10.17.05.59.13
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 81so13154792ybf.7
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id
 129-20020a250687000000b006c22b0c026emr9082996ybg.202.1666011553081; 
 Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
 <Y00+N/2eE+GSrQqh@sirena.org.uk>
In-Reply-To: <Y00+N/2eE+GSrQqh@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Oct 2022 14:59:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-yGhWMBF9zUXaHmU4rhkdZiHktDLXb=9bK2bYqaDhyQ@mail.gmail.com>
Message-ID: <CAMuHMdU-yGhWMBF9zUXaHmU4rhkdZiHktDLXb=9bK2bYqaDhyQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in
 __exit_p()
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Ricard Wanderlof <ricardw@axis.com>
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

Hi Mark,

On Mon, Oct 17, 2022 at 1:36 PM Mark Brown <broonie@kernel.org> wrote:
> On Sun, Oct 16, 2022 at 10:33:50AM +0200, Geert Uytterhoeven wrote:
> > If CONFIG_SND_SOC_TLV320ADC3XXX=y:
> >
> >     `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
> >
> > Fix this by wrapping the adc3xxx_i2c_remove() pointer in __exit_p().
>
> Why does this driver need this but most others don't?

Because most drivers don't annotate .remove() functions with __exit?
An alternative would be to drop the __exit annotation, at the expense
of a slightly larger kernel in the built-in case.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
