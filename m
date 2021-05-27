Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94899C4707F
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 07:32:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57C661186
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 07:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57C661186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 870201705;
	Thu, 27 May 2021 09:31:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 870201705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622100718;
	bh=NQTtM3PIw+T/lGctSLInlizRejQb8wWPW31CQ0hoYyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pq3a0WsreVKbt9LFAaAHa0h0NINrkkc7Cf95pOwWTxkn2kqRDtnoJckkj44z/Jine
	 2HyOCXXhXZlLaydR+dDOML6g8pURUsR/+fZ4Zh8sd3H50bj2BsKhIFlAFjtN9ZkZvV
	 PVIVUq06L+xJX/MemJcNKTT5kjgzaOd8hkEC1ZzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D31FAF80116;
	Thu, 27 May 2021 09:31:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0978BF8012E; Thu, 27 May 2021 09:31:02 +0200 (CEST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1451AF8010C
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 09:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1451AF8010C
Received: by mail-ua1-f50.google.com with SMTP id w5so2272151uaq.9
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 00:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EvrU3N0dLKeUqogIkRKclMoApsA1KzYSSz1Wf5vnn0c=;
 b=rFtIVR7GRrEKO4Pk4Jr4jRoiJD4cLs+3cuEu41OjJo02TBdkMrG6NlHdEU0IVr11Rk
 vhjgZc8jJLoVpPDzQwSwSyutcrhLWfbVKuPUsYsKWG7zdad+GvpZmBpGtJyZqB4C0RQM
 pXRmcXBTYsMEngnOD461TvHorI/hac53EXnkbjISXJyiiSCBM8OFotT675uAJPSPt+Ir
 e1cPUHKhfF9feuzOmI+iOXJUXndAgFRjr6w9zpXji2lslamv6KgzVF9rRXhEpJi5UPLu
 TH9e9cbM9rx8bwCbzXwvufgOd46bBbsEZpC0dPJJnZ8lSi6EBtNnSHcgxbz9Tj6zuBzV
 qfYw==
X-Gm-Message-State: AOAM532BusjzbFwmPbaHT0DZxOVY6M7aIBZXsnZsCKQG4JxqOcJjQd2z
 0TO0OChjQ+qIEEZujEdRxJ/mUWfxlNz+eyMyWL8=
X-Google-Smtp-Source: ABdhPJxpPqoA3XiGadQBpZjcG0ZK1ngJike7pnf69xbSYNyq0SWXZ3O75cFr36NOa5aj/X2H8g9Ai5e/K0dW1/LEDpY=
X-Received: by 2002:ab0:6584:: with SMTP id v4mr1103280uam.100.1622100650604; 
 Thu, 27 May 2021 00:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <87y2c4oe3y.wl-kuninori.morimoto.gx@renesas.com>
 <87tumsoe2p.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdXLYvEBE0bVk=8D+GkuaHRUvdTayCQPqTYAkPJEaW8MDQ@mail.gmail.com>
 <87zgwimnuu.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdVhnKeztftOJEZhSg8bXArzUDXAmHSMPVfbMamV3ihw+g@mail.gmail.com>
 <87o8cxm9pg.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o8cxm9pg.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 May 2021 09:30:38 +0200
Message-ID: <CAMuHMdUxAOeceORSpmiPAc6Tg=jpm2FTaLjVBVt+oiyWd68wCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: rsnd: add null CLOCKIN support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

Hi Morimoto-san,

On Thu, May 27, 2021 at 12:06 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > Oh right, I missed the static clk_hw pointer.
> > What if you unload the snd-soc-rcar.ko module?
>
> Hmm.. indeed.
> It needs something..
> Thank you for poining it.
>
> >     #define for_each_rsnd_clk(pos, adg, i)          \
> >             for (i = 0; (pos) = adg->clk[i], i < CLKMAX; i++)            \
> >                     if (pos) {                      \
> >                             continue;               \
> >                     } else
>
> Wow!! I didn't know this technique.
> Indeed it can use NULL pointer.
>
> But, I want to avoid "if (pos) else" code as much as possible,
> and keep simple code.
> It can handle all clk case without thinking it if it has null_clk.
>
> Why you don't want null_clk ??

It adds a dummy object, which needs to be cleaned up.  Basically you
are trading a simple NULL pointer check for a zero clock rate check
deeper inside the driver, with the additional burden of needing to
take care of the dummy clock's life cycle.

Note that most clk_*() calls happily operate on a NULL pointer, and
just return success.  This includes clk_get_rate(), which returns
a zero rate.

Mark might have a different view, though, due to his experience with
dummy regulators?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
