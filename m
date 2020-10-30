Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9DC00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD6D20797
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rlw1OHUu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpSa0e4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD6D20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1D871616;
	Fri, 30 Oct 2020 20:07:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1D871616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604084903;
	bh=FZdbpClxsRyUuE6wMTeJCUlw39OSlxpqqTa10hHBjvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlw1OHUu4s/b0Vse7uEGKG9dP4IL9+er9W3eBRia4TzWKWkPJWd5isGbmFsBXdv7Y
	 IRJhnQFMN3n7dsci0h1zUh6R6GFlLCJIJH7iouBtD4BxgwYyOL+Wgn/14sZIcm7Mrg
	 yLumpCpnPmb8C7SZQs9rLo4Fvsm/pLoT2MDNGkVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57468F801D5;
	Fri, 30 Oct 2020 20:07:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45394F80212; Fri, 30 Oct 2020 20:07:32 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC541F801D5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 20:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC541F801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SpSa0e4N"
Received: by mail-io1-xd42.google.com with SMTP id y20so8644890iod.5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kRnMiBAqbQrnQNWoGObw/GN72MYVN3PVOyPP/xbkSv4=;
 b=SpSa0e4NexLm00Kgmenuq9+x90MS+prPInmNNlAj0OlEmSIi5GYyIJzEg/BLwp0pOn
 bCD0nJO4bx+7KsyO1p9X2YaaZrPZmvBJl60VjVWxZce/4fElgFD87VfGS42oeZ9YwCCG
 Zj3mlct0tQags16wHsGZTCijv+dUaTOd5yR7ToFvcXHBAZgBHqJh0lAQ/2gbIsC3tii4
 XemUJFlPUAecRWF5nZUOhFlWkfnaTMlKGruZv6q4IAiz7+H7z1ZhpBA6KANL8eMs0Hyy
 ToFM4o52BcClrMjo0uztS67L6EI+lVqNshUPM+wC+fne1XKGHSH+uPE4EeCB4UrnG8Sk
 gsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kRnMiBAqbQrnQNWoGObw/GN72MYVN3PVOyPP/xbkSv4=;
 b=QSU/t6YMLeDXB6a508UTUHAbv6yquQkeDLt9ZsSTe+5A/gGN87PEGYXuy4fgaDXebc
 5tsROicgqHOcLmgTJKe27dO5SThybnirZDYTtMA62+252B9s/DHDwPkX1ZKhZzNpGZQC
 FRXGhca2lDqq9I6ojouBppE32NRjyQ0qxCERuGk4msXLvNfBH7UB/TJbEwYB1A9Kb/N7
 iIyzfwVfh/wRrIcAvhU4XZ6pGtf4lGlZ+k4hNGK7CnKsSy9Aw2vNf10DArWVpL3kygrC
 3RGKVMfeokAMDOjleNI5SM1Ld5XQLZaKHHTe3dg4kVrbThUwI41pDQ/qzDyxGN/us154
 r0cg==
X-Gm-Message-State: AOAM5317nzCNTmnpcvXGuJfK+OjL8qbeVI5geyvpqqt5j1zhnS7Gdg4k
 0ZIdzh+vdzRcNwlfyQ7iKMpE1n9IUgSctwdq2kM=
X-Google-Smtp-Source: ABdhPJyHHJZwON07JsYGXD+WzKKqSo4WezgeeFyNNwPtTNagJNoLm+UN3ag55BdCObIQ1+1dmhE4aXc+492+h8Di5G4=
X-Received: by 2002:a02:5b09:: with SMTP id g9mr3051607jab.89.1604084842581;
 Fri, 30 Oct 2020 12:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030144648.397824-1-peron.clem@gmail.com>
 <20201030144648.397824-2-peron.clem@gmail.com>
 <20201030161131.dlzzpy3atiiddx4n@gilmour.lan>
In-Reply-To: <20201030161131.dlzzpy3atiiddx4n@gilmour.lan>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Fri, 30 Oct 2020 20:07:11 +0100
Message-ID: <CAJiuCceRyRie_3sp7dZsFeHWCV+CFXX8R206kmMwq4_EHvfK=w@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ASoC: sun4i-i2s: Fix lrck_period computation
 for I2S justified mode
To: Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Hi Maxime,

On Fri, 30 Oct 2020 at 17:11, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Oct 30, 2020 at 03:46:34PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Left and Right justified mode are computed using the same formula
> > as DSP_A and DSP_B mode.
> > Which is wrong and the user manual explicitly says:
> >
> > LRCK_PERDIOD:
> > PCM Mode: Number of BCLKs within (Left + Right) channel width.
> > I2S/Left-Justified/Right-Justified Mode: Number of BCLKs within each
> > individual channel width(Left or Right)
> >
> > Fix this by using the same formula as the I2S mode.
> >
> > Fixes: 7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
Thanks for the ACK

just noticed that the case was not properly sorted.

Do you agree that sorting like this is better ?
        case SND_SOC_DAIFMT_I2S:
+       case SND_SOC_DAIFMT_LEFT_J:
+       case SND_SOC_DAIFMT_RIGHT_J:

If I have to push a new series I will fix it

Regards,
Clement

> Thanks!
> Maxime
