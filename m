Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F427C352BE
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:25:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDA4206B9
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UnxvNoc/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0/ss7Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDA4206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E8AC1675;
	Fri, 17 Apr 2020 11:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E8AC1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587115509;
	bh=sHJ12tcYNsSfgttEUfr+8K97RYYeru+HfS3132z1u6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UnxvNoc/MqA6+Uq67m/WC5VExGYGY3/A6jYkxBQZiuiBG87dUsMNJoyju0OFUjDtv
	 YyU1IexsjYi+GldWcYiFRjSSn7epu2mmB2VQ68TTJpzUu4uLYnmAQJEnYombKXNp1l
	 rAm+SgKQbLbs2/KubB63OVfqluNCMhFZouT81Hyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB64CF80306;
	Fri, 17 Apr 2020 11:16:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 098B2F8014E; Thu, 16 Apr 2020 10:04:34 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D61EDF800AB
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 10:04:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D61EDF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="X0/ss7Bs"
Received: by mail-lj1-x241.google.com with SMTP id u6so5179610ljl.6
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sHJ12tcYNsSfgttEUfr+8K97RYYeru+HfS3132z1u6U=;
 b=X0/ss7BsABjV0v58eUDRQHcZuoc6jZGR8QlxXHm4iMm2jIobcqWr46sIwdS9XtZxjv
 J6lyowndGnsjJ2T09ZLAXy4vuLLuNuWfByvI3ZL89WC2FPNAxvWKs0UVVQzT5Ee2llor
 wzSBTCJVOBt2+9Ohb9KBSlvOhscZ+OiUHUnMWxgzt6ZDO9PVTPdpvuxMydg2t99gu6wZ
 oj37Ec/BUycHap9z0+LYieFHR2fzSSCOI+l9sq7xxfebteYGbDW3WPgbMFAteqOk2bKf
 K6q0mR7VNoF30yy9UA6z33ozE8ZHcOBMgzyIRBgLhkAceDqUT6mHxhpEYBOQpImmHhPe
 fohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sHJ12tcYNsSfgttEUfr+8K97RYYeru+HfS3132z1u6U=;
 b=lEH8v8wYWJo4vLAt7T8/+c2qzlGG6rUok3HcTpY5y3JwA8r5mCm3gnlBcg4abyRxuP
 3P/ZvJqEbMbbRDR5c1nixOy3I5pGwAevgqyfEMBrb/tSRvXOnKK4OmZy1KEYlh+eH9R4
 Swgui2KBrIyjieYkZKf4btaKXSxxixepaacljVTr5X0VEI/9esYWxXnAtTG527PfVoTr
 CwjzX4QKrcfpsm4LhavuOyOGZ54bJwt7+g/Wyt1MrXzscxXzPTreHZ9oMxFWQ7nogJhD
 ca7HRubJXAWFYgLYkrTICHG/3yg9gsjaNUnDUe6G2Ca6Dkc3O072dTZRcPP/f6zQ2Zm/
 FcPg==
X-Gm-Message-State: AGi0PubCefwsBnQ3g/Ddf4dDYID5/eI0c14N2loRnjtm8V4HERVHxROX
 4qx56bLAxoXfkdaiiDr7+u0gh6XGKFnYM4eX+zlxoA==
X-Google-Smtp-Source: APiQypJa0ViiE/ZtKOxobDklTprFmqZh7Nrc1Zappo4GrzOsZZrJysLNIrOKRtQLmBogZMZaiR9WSbvdJtt5f/9aPuw=
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr5793355ljj.39.1587024265660; 
 Thu, 16 Apr 2020 01:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200416005549.9683-1-robh@kernel.org>
 <20200416005549.9683-2-robh@kernel.org>
In-Reply-To: <20200416005549.9683-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Apr 2020 10:04:14 +0200
Message-ID: <CACRpkdYDrytCL3ZX9YeW39t2mb4M8KbCfCFm0Ba67oPpshckLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: Remove cases of 'allOf' containing a
 '$ref'
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2020 11:15:50 +0200
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Sam Ravnborg <sam@ravnborg.org>,
 linux-pwm@vger.kernel.org, linux-iio <linux-iio@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org,
 linux-i2c <linux-i2c@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux LED Subsystem <linux-leds@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Linux Input <linux-input@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-media@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Maxime Ripard <mripard@kernel.org>,
 linux-can@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 linux-spi <linux-spi@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 netdev <netdev@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
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

On Thu, Apr 16, 2020 at 2:55 AM Rob Herring <robh@kernel.org> wrote:

> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed
> in the 2019-09 json-schema spec and '$ref' can be mixed with other
> keywords. The json-schema library doesn't yet support this, but the
> tooling now does a fixup for this and either way works.
>
> This has been a constant source of review comments, so let's change this
> treewide so everyone copies the simpler syntax.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this!
Linus Walleij
