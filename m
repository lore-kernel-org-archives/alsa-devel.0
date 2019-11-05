Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C39C49EAB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:24:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E54921929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rj2ncNkT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKSM2QTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E54921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 988E01725;
	Tue,  5 Nov 2019 10:23:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 988E01725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572945858;
	bh=AJrlN0OpQJxdiMqO7AQbX+EYSOV1A4eSdoGoBAK2Heg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rj2ncNkTkmRBMnYoHDv8hdo8t+PiZZdOFST0LWSNmAYuHwP5uu+xNqw2Z7YFdFaID
	 jzeeeTE4gO8EhCU5ktcQDl01gzAO+mxo7QG3J5A8jg+LeMWbdpuj86qgmyNnufGty+
	 ZurLPNrsVjPbrNbAoBu8gP8FXkurh21h7b7v4l54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69858F8049B;
	Tue,  5 Nov 2019 10:23:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F56FF805FB; Tue,  5 Nov 2019 10:23:05 +0100 (CET)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38D3CF8049B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 10:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38D3CF8049B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="YKSM2QTB"
Received: by mail-lf1-x144.google.com with SMTP id f5so14555314lfp.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ct9g/c4KnN6815DyJzsvIVZUxmWLuOF9LXKZAhVKbL8=;
 b=YKSM2QTBCckxvZ/6Gq5dfMrbdS0x5OlQiyIjgvVFfiy2DEtxC/YK2sAtJ8E8yGzGnC
 vC3vEgOdUGdyUWKGZm8gYADe06XUhQHrnBe6ZrDxDK7pUlLzOfDaqxBDFtTlhNG+NtMa
 8ZKf+R8bkPbKUrAZB7NIxUAycktPoNmgiLYHgWuBoXStS1YJJabyH96kbSVMiTGax8h1
 wT42Xk1tp58pYDdVtztuIbh5r2LpKP0lTkBAGpgnB5gRySMzDeXpQSAQSFInOLok0CtF
 ioN2DYfH8dv1tE3aoeLuiJ8++IkwiM1w9xYbdf7nkWsDbyvha3XVn1Ul07aTrAxlNzRy
 Dw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ct9g/c4KnN6815DyJzsvIVZUxmWLuOF9LXKZAhVKbL8=;
 b=ZfJ3SCR3kbJ83QRzgUQmkLH8nYb6NnWjYgzWMbt2eow98CLqdUhS6YfP+QfX3TlB1H
 +jDj471etqRDXls59QV7aGytBZU22eOxHaF87vJ6IduPd5kTyXycJ6uoaJAPBzAx2Wna
 14ANBADU9l22HlyzkIXwbvCgApA1mO8BFLCI6K/XtqnE2mgi6nmYQytMSLDCOEXG8IIQ
 xXbBFjfUPRwczC4nAha0cMh3peR78X4xYt+gSdxfKlk79YIGJttKowq22np7IAUx1/Os
 cRXQYYx6W808In6QlcWQH8O7NZo1SbYKcl0UKCRaGSIxujWLR9y2Pi0MPrd0SvG/8mZw
 5tkQ==
X-Gm-Message-State: APjAAAX4wiXzN2ZE933ufwCbX3Rv7AKX4h05xgYd/lvOsa5p2sXIFP8J
 TeJ7PHV+iK2wUdsNNRli58zP8cWa/hNz3AagM7nnsg==
X-Google-Smtp-Source: APXvYqxeopO09ns4NgTxjigartGjOoe+JETioaWMrKGhyhGNAt2HdlvOIjunc3L7nT5gZgJzxfa7ONCTaP16w47SjKw=
X-Received: by 2002:ac2:5295:: with SMTP id q21mr19505657lfm.93.1572945781604; 
 Tue, 05 Nov 2019 01:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-24-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-24-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Nov 2019 10:22:50 +0100
Message-ID: <CACRpkdaT4Tn2w0LZDo-mB-GGT=Epv-stkWW6S=AZ+OWam4QWPw@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 24/46] ARM: pxa: magician: use platform
	driver for audio
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The magician audio driver creates a codec device and gets
> data from a board specific header file, both of which is
> a bit suspicious. Move these into the board file itself,
> using a gpio lookup table.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
