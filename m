Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D616C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:52:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1843D2078B
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lwfpW2IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1843D2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B42A847;
	Thu, 13 Aug 2020 09:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B42A847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597305127;
	bh=ntdl+qovC8OGNNdbjuwSlJ5lRBKmrWZtOnkn+k8S2c0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lwfpW2IMgsvNH9Va+5MCOEADOnTPvWa8ltgyrjxClv0lVkJgbkoNwyuqpTTjwt6Nk
	 Z2EsMyxo0YRfZ0zOWnosD795iXynbG4PQJc4/X8/KUspuCO6bdaKY6Fw3k7FSJxdP6
	 YrfQIYoZn0bPV4ncAIugeeYGAfz7Jfv7BvQh+95I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02E2DF8014C;
	Thu, 13 Aug 2020 09:51:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F80DF8015B; Thu, 13 Aug 2020 09:51:15 +0200 (CEST)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 728F6F800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 09:51:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 728F6F800D3
Received: by mail-ot1-f66.google.com with SMTP id z18so4109096otk.6
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 00:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eU62SrftExeZEPFtSlHLsBRzbUkLx1KNOgZc6VKFeBQ=;
 b=kHUnPgi25lF7f+0zz/cpMmQH3sAhsnlGbwuQHLXFT8AwAoiRUV9dbZjmZDAX3cXvBA
 n/vV5ZxM9U+trFlsshLFi+87p5QUULbTR2xHqEf3jfuCyBOQ1AZYh+3KwTwoEIONxkMA
 LlD6Rx2lIlRk5+DEQz1+oFpCFrd5TD+pmpprdzlZmQ82QR6oect57orovApeLbuczp8p
 0msy9e7ktrOWPt4xvJyWCGPjoEvyJ+Hw4jaeCbFMEsxphe0FJrQfRx3mgKPh0FD3rc/t
 E0RLNJMvDSywSKzB6nZ3Xo9h5m+MCUCtAxggzOE9+sKpRn7dHpmHlBl+2tu32Im2FVvm
 Ww9A==
X-Gm-Message-State: AOAM530C541YahK6PKV4vhFPOUBmfNLHaEXIx7MBxsmKXBeM+9V1Md+W
 QG0eO7w4ZvvgPw3q9OboNx3SfmcMmnx74yHvoAM=
X-Google-Smtp-Source: ABdhPJzAAKS8g3t/W5mSJd2Vboc2FEvoNvVXoru7u4kNP7jabPCwVCki2JjTk/fEfMzVv8QAFC24k07bLAU2LYhSK+k=
X-Received: by 2002:a05:6830:1b79:: with SMTP id
 d25mr2990956ote.107.1597305067462; 
 Thu, 13 Aug 2020 00:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200812203618.2656699-1-robh@kernel.org>
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Aug 2020 09:50:55 +0200
Message-ID: <CAMuHMdVXvSRF-G_TYu4P+Bqa2FZJWsUCyzqFur3Rb-tBExfbsw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-iio@vger.kernel.org,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Linux I2C <linux-i2c@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-rtc@vger.kernel.org,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 linux-input@vger.kernel.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>
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

Hi Rob,

On Wed, Aug 12, 2020 at 10:36 PM Rob Herring <robh@kernel.org> wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
> keyword.
>
> Found with yamllint (which I plan to integrate into the checks).

> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
> @@ -24,9 +24,9 @@ properties:
>        - const: renesas,r8a7778-cpg-clocks # R-Car M1
>        - const: renesas,r8a7779-cpg-clocks # R-Car H1
>        - items:
> -        - enum:
> -            - renesas,r7s72100-cpg-clocks # RZ/A1H
> -        - const: renesas,rz-cpg-clocks    # RZ/A1
> +          - enum:
> +              - renesas,r7s72100-cpg-clocks # RZ/A1H
> +          - const: renesas,rz-cpg-clocks    # RZ/A1

This change breaks alignment of the comments at the end of each line.

>        - const: renesas,sh73a0-cpg-clocks  # SH-Mobile AG5

(I only checked the files I care about)

If you don't update commit  e0fe7fc6f2ca0781 ("dt-bindings: Whitespace
clean-ups in schema files"), I can send a patch after v5.9-rc1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
