Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3DC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:59:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6B023A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6B023A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55C8E177A;
	Fri, 18 Dec 2020 13:59:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55C8E177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608296396;
	bh=HtSLK8Qq3NQ+grFSmB3TwIvB2DSFsoE9tGloW3FPnUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UPMJ41Zb7kTZZldbfVF++m+MfkcCGOpxiIMGxFeQErCJ3uQM/YxYCfaYnCo727m2P
	 j9cmZaFcGjSN9bK2yS2ZcZFRYVMK/J9HCtvMgFRKdnwwK1hC61nsi+IGvc0jv1Kusz
	 84Hio/U/jFL5xBO7E9X+1UJXbmJNpxK1RzBQ8Vvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8AE4F80240;
	Fri, 18 Dec 2020 13:59:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CA82F80245; Fri, 18 Dec 2020 13:59:04 +0100 (CET)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F24E9F8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 13:59:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F24E9F8014B
Received: by mail-ot1-f54.google.com with SMTP id w3so1752288otp.13
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 04:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDDmWva6k+onru4ElOy7d/wNOJ87lqqkD8MjbWeXtwU=;
 b=f2FSOk0p4XKu8NbA0BaA2Ai/1XPxDaLGZ2eSUO5hWhb0EFylNLzHWyLh0oxuJW8b4w
 IstasRLvKnGonBWGaP79XhHC+QsWfvifULWQoJ7x+zqP8n9d1rGIZeJK2gaIydHjvPtb
 xxdS4qxzt6tfs3ZLjObnYqryMrXkgFt5psuRFECLxpqjpNNMoSDSt/fPSq0VSpgUnExV
 Sq5UN3A35yuH6RoUIq8qhHsuMtQQehu4CNTaV5MlPBI7imPQvSTw3pOWc9tgDJV21kPf
 vyiEt52s5QTGoHEhSPZkZ0Qhch0mgibfwRnPQqjDQ1t5r+As7kl9+hBXHsRkewU6Ih9e
 Ue7g==
X-Gm-Message-State: AOAM532G9TBkt2I4CzQcAO9Xh21f28tfT4CdbnJ9e1kPyTGTA148h8PM
 9Kiwvfpm61F1YMBsn4S/bD8RNxs1B4BgKRW9bI4=
X-Google-Smtp-Source: ABdhPJyVnS44pT7s+1XMXMXLzgmkCPbXXe1tAtY16NLc5knQgn/2hErWmFmznw8uQihbNqN3+62Ky++aLOQYfTNMNNI=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id
 u26mr2667908oth.250.1608296339939; 
 Fri, 18 Dec 2020 04:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20201217162740.1452000-1-aford173@gmail.com>
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Dec 2020 13:58:48 +0100
Message-ID: <CAMuHMdV3WKFLPKf_6nVc0bX4wXe55GtKST9whiEKpG_8wq6t6w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
To: Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Adam Ford-BE <aford@beaconembedded.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Thu, Dec 17, 2020 at 5:27 PM Adam Ford <aford173@gmail.com> wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/sound/wm8962.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8962.txt
> @@ -9,6 +9,9 @@ Required properties:
>    - reg : the I2C address of the device.
>
>  Optional properties:
> +

This blank line is not needed (but it will probably be removed during a
future txt-to-yaml conversion ;-)

> +  - clocks : The clock source of the mclk
> +
>    - spk-mono: This is a boolean property. If present, the SPK_MONO bit
>      of R51 (Class D Control 2) gets set, indicating that the speaker is
>      in mono mode.
> @@ -27,6 +30,7 @@ Example:
>  wm8962: codec@1a {
>         compatible = "wlf,wm8962";
>         reg = <0x1a>;
> +       clocks = <&clks IMX6QDL_CLK_CKO>;
>
>         gpio-cfg = <
>                 0x0000 /* 0:Default */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
