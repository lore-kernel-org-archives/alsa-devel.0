Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F86C433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:08:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA2122B49
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA2122B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DBDE16EF;
	Mon, 11 Jan 2021 14:07:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DBDE16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610370503;
	bh=T+iZKNW1gmpT+HQqIiqmRRpQMcaG8pgogUVWa/pKYOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXohETfvZiwYqYWEwY4mfgrSYAmyKkCYUaKat7jJER1I0h1BF8a7q2GFSrQ8nCFoH
	 9I+J1d1JcAfK78pXqRWc6+w6Lr4t3HJZiksNeTSYKcwWni4+ZVOQ5c6WXgDm1ouqjf
	 Z4Ug1mrrXr5ZdfQYF0kHgk9EsZi/bGlCNOmDF2Fs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2C32F80475;
	Mon, 11 Jan 2021 14:06:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D1C6F80258; Thu,  7 Jan 2021 10:10:35 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97C0AF800FD
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 10:10:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97C0AF800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="cyz7QwbT"
Received: by mail-lf1-x130.google.com with SMTP id 23so12896412lfg.10
 for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2021 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T+iZKNW1gmpT+HQqIiqmRRpQMcaG8pgogUVWa/pKYOM=;
 b=cyz7QwbTfHcC+qnorIFVkv7DnbL/oyA5L+VJJAN8XWkNMg42oKdig8X5tU4xa7X7pN
 01zspKzmEcVvu5fY2nzlSr3geA/q2812tr8Wz0sUieGMHhvg1aGrsz+m0J4b8Wmr2jr4
 Bxuqd5E5gXQb8ARkFssKYAOK0W62M412pmNUBd9NwRQD04zf23syAxjzcLmFBod8VeLt
 Wkczn2W4OJkxg0o6mQ3tRUOpKTABRCCUpHtxAiPQFjxJEJCf/WQ1QzYZHEZTgGgMtnu2
 jNC0bNdR63+2S3cfHE4fDoxHLsYIWb3l6Ja+q5Vt8aM4kBs1TbyhYMIEDY91gB4GZfH3
 2CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T+iZKNW1gmpT+HQqIiqmRRpQMcaG8pgogUVWa/pKYOM=;
 b=FO84mobcXav9g3eEW7Gh6Q5peeIdURePzFawByfqZFvugdVqb6o5AYNsIYHsOfKm5E
 Gd8/lp8MtyeD3ikNe3DSfxdsgdoYi/jxje/vbTwctX4RHocovCb7Lg5DOEn9iQAEDbar
 IiOkhVpo+Wm48UUkWdBRRJDnNOfCy2uIecX3qHKh3QCPHcDZmWKJfJcpn56ygB1w0WIe
 D16Zt/4Hva7J9Mlve6N2YXvvE/pyuf0XSB9QvTBWUfgSzukFRDpXUE0Ic/v9HOuHZ8+l
 64ujgMUu6/WJjBzFc4sQEQtBbvW8Hblq4LyJlv85FcRE0ys52peO+xbWXqCXDvrEgdZr
 S7tQ==
X-Gm-Message-State: AOAM530Uw/na5rGc2AnjHIn8OcI2H+pXoWchJNAgyi4+eGkle6+UYZ4X
 YGAUAPQoGWig97axGVeDSmlrwgdHLQLgsJS4Aymg8w==
X-Google-Smtp-Source: ABdhPJz6FNuZKYGADUxlk9Tv8Rh/lJVu/2CmZBJO3UIrMaB/edLmB9ZlsVBcuBoQ7GbjgHsRrGXCE/gOnIldpK4OwK0=
X-Received: by 2002:a19:495d:: with SMTP id l29mr3392190lfj.465.1610010618615; 
 Thu, 07 Jan 2021 01:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20210104230253.2805217-1-robh@kernel.org>
In-Reply-To: <20210104230253.2805217-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Jan 2021 10:10:07 +0100
Message-ID: <CACRpkdZVC8RE-DTes+p6g-1EAHxQWpu2u+sBCX2ei32cvaCrDA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing array size constraints
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 11 Jan 2021 14:06:42 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb <linux-usb@vger.kernel.org>,
 linux-iio <linux-iio@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 netdev <netdev@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Marc Zyngier <maz@kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Linux Input <linux-input@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
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

On Tue, Jan 5, 2021 at 12:03 AM Rob Herring <robh@kernel.org> wrote:

> DT properties which can have multiple entries need to specify what the
> entries are and define how many entries there can be. In the case of
> only a single entry, just 'maxItems: 1' is sufficient.
>
> Add the missing entry constraints. These were found with a modified
> meta-schema. Unfortunately, there are a few cases where the size
> constraints are not defined such as common bindings, so the meta-schema
> can't be part of the normal checks.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

This is good. The stricter the better.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
