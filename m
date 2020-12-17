Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D5C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 08:04:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B075223877
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 08:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B075223877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73CF61791;
	Thu, 17 Dec 2020 09:03:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73CF61791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608192260;
	bh=t7d9ytGkdbZhh+xi/2JKeQ2+OY977trd8KTfyDPHGog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8ESJtQMGEqLeaR0tfP4SIn/bi3jsU/A4HlnLK1nUaLhdGcCk0IBkQ8f3kSO+Jngj
	 U6R1N9qB6dwaiSJezNKO+swcUGAf+co7z34yVCgJxJ8gtPVUGtgczNRPR+FwK6wFof
	 Y7/+D4gz6fDKfrw4iWWIECle3NoZ4Pl/pCaoFDpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B7CFF80259;
	Thu, 17 Dec 2020 09:03:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D138FF80260; Thu, 17 Dec 2020 09:03:27 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4288F8014B
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 09:03:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4288F8014B
Received: by mail-ot1-f46.google.com with SMTP id j12so26421255ota.7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 00:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NSD2wclYK59UiaUMg6aUSWKdSnGArdnajTQMeFkHmOQ=;
 b=jDj3Rhhs+T8qqQ1JiFPFQVygz59EY4TtvBB6DWvtCJA8Dlpw0Z1eOCtJVZQsXXGMr7
 VKK5lbrqnYXwysPesZju21ChYKXCC8UH0m5S2d3CkW9q8NGPAjRVdnQhYP7kpxNfMcyB
 LvF03qOQtO+cWiT8PMMgJAZPiBaT4JMzYJyb7wrn8/QkwK+2cQTHV01z8WTHFV7q5gH3
 1SuOhRxBpGrc6b5E6wb2yNSjjnWW63ezJfCal7GArxWlgnih2gfSx1g0nbzV+bBNuNPU
 w3LzCE8Oon7UdCMtAFk9dTTjrK+O3jyoB5LEsYY0Og4GD+odc/1RItqx1ew/IlDmqTKL
 KG5Q==
X-Gm-Message-State: AOAM533ScO4Ymo2tguAUe16iye0Is2stFab4dWUywHJRTMQ5MFYNPcyh
 OsDpcJZ4a+Se89lArCcnRxV4mEujzCVAh7tFxCU=
X-Google-Smtp-Source: ABdhPJyUmv8MBXZ3pYhMBC2xoc5NVrlM1tV/Ibx4/KOXseNwQqtQrFBEK6pFb7qhl/Qxa6ADgieRe+uz2JSOPIWTR90=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr28594510ota.107.1608192198387; 
 Thu, 17 Dec 2020 00:03:18 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdWvB+p=2JqTsO7bR8uJqKqO5A2XgXFXsVAjHk3hcxgcTw@mail.gmail.com>
 <87v9d4gcqt.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdVMcjJempYDUA+AJiXWe=OgKAkGAyZDOS6R2Xp8_Xum2Q@mail.gmail.com>
 <87ft45gug9.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ft45gug9.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Dec 2020 09:03:07 +0100
Message-ID: <CAMuHMdUETVb2Dk4vmTu4T=QdnMkiBXJpfPKXuZuU2qs6_tBNjg@mail.gmail.com>
Subject: Re: [PATCH][RFC] ASoC: rsnd: don't call clk_disable_unprepare() if
 can't use
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Thu, Dec 17, 2020 at 1:20 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Feel free to use geert+renesas@glider.be instead ;-)
>
> OK, will do
>
> > The patch looks good to me, but I also cannot trigger the issue at will.
> > I went through my old boot logs, and found 2 other occurrences, also
> > on Ebisu.  In all cases, it happened while a lot of output was printed to
> > the serial console (either a WARN() splat, or DEBUG_PINCTRL output).
> > My guess is that console output or disabling interrupts too long is
> > triggering a race condition or other issue in the i2c driver (clk 1 is the
> > cs2000 clock generator, controlled through i2c).
>
> OK, Thanks, nice to know.
> It was rare case issue, difficult to find :)
>
> > >                 } else {
> > > -                       clk_disable_unprepare(clk);
> > > +                       if (adg->clk_rate[i])
> > > +                               clk_disable_unprepare(clk);
> >
> > As pointed out by Mark, you may want to clear adg->clk_rate[i] here?
>
> I thought we can re-get clock if we could get clock once.

Indeed. If a clock worked before, it should keep on working.
However, the failing clock was the cs2000 clock, which can fail to enable
if something goes wrong with i2c.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
