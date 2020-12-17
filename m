Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A5CC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 17:59:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1C9238EF
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 17:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1C9238EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 014F416F9;
	Thu, 17 Dec 2020 18:58:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 014F416F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608227970;
	bh=5I5D/h+YpGwPFmmNClanZRaSvSyEH+nTmMnqEY0zLww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFDZ6kYmQARfzPIYeM3ULhIPg/6Ng6vsTY/fmi48hauLQWpwVq6vkHo7pDL8z3uc+
	 9iv3J7TnK3voyfrjcm8lTqUroebGE1qqxx/7QMOF1hYFAKp6G9qj5vDXcVZhZ7nG4M
	 ve5rRO7Eum2yYgF001iE94vRzv7WtBF96sYvb9aE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 865D8F8014B;
	Thu, 17 Dec 2020 18:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 679E8F80260; Thu, 17 Dec 2020 18:58:38 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EAAFF8014B
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 18:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EAAFF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZWHmreiH"
Received: by mail-io1-xd30.google.com with SMTP id m23so13584675ioy.2
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jy9Wo6K2J/ZSSCkdeQ2xq3mmopXJVycRBgl/dvb3y3M=;
 b=ZWHmreiH5rqp0TCgo6Tc0AUX6gwk++F5zyVRI2cszk+zlJBORCLTYuPAP1EaF5Ws+J
 t1/87AfU+EwrH7w2NFaRQMGrNTmzc1GBXhOFzSCU1SzTUd/H7qJEEZPicbDYG+FE1BiB
 rfCUhlHFH9+cTlKreuUCB9pzkCIcOyUAHoINRYsEmWSuoNh2XLnz0yOKgXGinmEbjFHw
 6nz38TBwwuhGK2H9ueOUyJsWIWRR1gDwsiP8SYZcLDR/rD+LQXGtYfezzSqfwqPovsL2
 2LPXLq7Spblx2sCfdJaJqwCKSicmgi/wbkYDY50dO8WsF8pC+h6oTcE9UVeMJt2jz2Q8
 BWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jy9Wo6K2J/ZSSCkdeQ2xq3mmopXJVycRBgl/dvb3y3M=;
 b=fh6LazmAgje002pWsJq0LSX/yHlBPzouofnavTCQ4KvGvcluVyOd7Cj6a1LM6v/eVE
 m5T3h5ajg6SaHp9Q3zFWmzj6+ZdnTTKQuaLkALJGBK2n/dE2HrNtts6MGgfOkXe0of0a
 EUgZWq57wk2DsRDhuqVgNDzS9oW2nbWjBvmIQAWVtRE4oEHOTiyTI1qvsiSa775nmEpK
 /6lY0t0vx6uBjk5uOoXLIXxxT2b/JCHWgdm+OeqBQnhUVf9kWNQwmJUg4fVeR4yX0For
 nZqcLIIOT1NuzBIekNMdAimtk7Iak3FupOyPxZUtNEgijLkGAsXhvUkPkcLqnUS31JNA
 jD+g==
X-Gm-Message-State: AOAM533I+XRJsDOqXYRGH4JJ8qnW7eLLHU+WLK7HF3Uxs5LHFsxDJV/E
 ZnzJk981Mk6iDp5FgBJ01bUlnDqml7CzFIfA58Y=
X-Google-Smtp-Source: ABdhPJxdAlerYP+JuD9biEEY39A4kN8rW0oldiaXIBGS0l5gLJQZoPQTKREgpdu4SWSftFhfVFo5D82LYpvmLPxAnkE=
X-Received: by 2002:a6b:f401:: with SMTP id i1mr261498iog.142.1608227903009;
 Thu, 17 Dec 2020 09:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20201213183759.223246-1-aford173@gmail.com>
 <20201213183759.223246-7-aford173@gmail.com>
 <CAMuHMdU+d7SZc9gh_3WS+bqd4EhXYh=kv0XvYrgUUckdQ7o5jw@mail.gmail.com>
 <CAHCN7xJf2T3uFLDtJxvjFYzCksWq02+CUY51_WmnU44YDJKy9Q@mail.gmail.com>
In-Reply-To: <CAHCN7xJf2T3uFLDtJxvjFYzCksWq02+CUY51_WmnU44YDJKy9Q@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 17 Dec 2020 11:58:11 -0600
Message-ID: <CAHCN7xKdVv==YLtSa3n2hQk2T+f+FkLqKDNTYkP_3ynnY+xRCg@mail.gmail.com>
Subject: Re: [PATCH 06/18] arm64: dts: renesas: beacon: Configure Audio CODEC
 clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Magnus Damm <magnus.damm@gmail.com>, Adam Ford-BE <aford@beaconembedded.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>
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

On Thu, Dec 17, 2020 at 7:33 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Dec 17, 2020 at 5:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Adam,
> >
> > CC alsa-devel
> >
> > On Sun, Dec 13, 2020 at 7:38 PM Adam Ford <aford173@gmail.com> wrote:
> > > With the newly added configurable clock options, the audio CODEC can
> > > configure the mclk automatically.  Add the reference to the versaclock.
> > > Since the devices on I2C5 can communicate at 400KHz, let's also increase
> > > that too
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > @@ -424,13 +424,15 @@ &i2c0 {
> > >
> > >  &i2c5 {
> > >         status = "okay";
> > > -       clock-frequency = <100000>;
> > > +       clock-frequency = <400000>;
> > >         pinctrl-0 = <&i2c5_pins>;
> > >         pinctrl-names = "default";
> > >
> > >         codec: wm8962@1a {
> > >                 compatible = "wlf,wm8962";
> > >                 reg = <0x1a>;
> > > +               clocks = <&versaclock6_bb 3>;
> > > +               clock-names = "mclk";
> >
> > While the driver does get the (nameless) clock, the DT bindings lack any
> > mention of a clocks property.  It would be good to update the bindings.
>
> Agreed.  I'll push an update to add the clocks property.
>

I pushed a change to add the optional clock information to the
bindings txt file [1].
> >
> > Note that arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi and
> > arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi (both by your
> > hand) use "xclk" instead of "mclk"?
>
> On the schematics for the two imx boards, it's labeled as xclk, so it
> was named as such.  For this board, the schematic names it mclk. The
> driver doesn't care about the clock-names property, so I'll just
> remove them.

I pushed patches to remove these nodes from the other boards [2].
I'll remove them if V2 of the patch series for the Renesas board.

adam
[1] - https://patchwork.kernel.org/project/alsa-devel/patch/20201217162740.1452000-1-aford173@gmail.com/
[2] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=403739

>
> adam
> >
> > >                 DCVDD-supply = <&reg_audio>;
> > >                 DBVDD-supply = <&reg_audio>;
> > >                 AVDD-supply = <&reg_audio>;
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
