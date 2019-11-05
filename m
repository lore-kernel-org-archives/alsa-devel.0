Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850FC49EAB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1702217F4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NSNUCAje";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwkOtNt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1702217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6A771711;
	Tue,  5 Nov 2019 10:22:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6A771711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572945811;
	bh=dZRqkDHy7jjV9a+MCtV6dlsmz1Ew0d85BO1SFbCLg8w=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSNUCAjeA8eF7jADl17sIknsT9bZSVFv+kL3MCWYavkXS8FQBaPrjIzwddijlMjg1
	 fUxMfzPFeuADvRO37kT+j4QONolxitQrwfQydKNRfDSw67g6lEkGIpEPmo/DRepzj7
	 xj4dZUUR/RjTqYbE/2QVvPNYv6csAi4pMfFCk7/s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5087AF805AE;
	Tue,  5 Nov 2019 10:22:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F719F805DF; Tue,  5 Nov 2019 10:22:22 +0100 (CET)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 014D4F80271
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 10:22:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 014D4F80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ZwkOtNt5"
Received: by mail-lf1-x144.google.com with SMTP id v4so14534303lfd.11
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zT+1Y7p9/KJc9h5D2GRF7qfZtVnGufdHVpBg/W0NqHo=;
 b=ZwkOtNt5VUl11C77Q+z56zLs2I+csPAQAsgRQjB47zGyNSCR0Kg6cRabic9UhhWEwA
 N0Gv7FmAv/516sORohvg4vdXZFunZZarxm8ZdPsc50kbb31tvdjv4Vj6woz+w9YnntMz
 B0Qdzkx08jMesl1R2NO8wOct84UjT0XGvNHWJGi52lgYp5wjPBFiJ8KiaSDJ4pEXZH2R
 G05DJFV6PDy7slo60/TCchbTZvPcTuIwKkfMqfsyCPdSMf9a2ETL3CQLbPHez+AyIHdK
 3m4lBve1nyb78ScgbOCRuwcW/1kOcpLp8yP81uetBqFoJCgyMdTuJSsHrniPMAgAio+V
 UALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zT+1Y7p9/KJc9h5D2GRF7qfZtVnGufdHVpBg/W0NqHo=;
 b=p/SMGJ2CWCs97eq1o3wPpSjzublh0DAP4GC7fBZhG5qlKDfiQH9/rXWErcQHVKOnaq
 EK0ivFcVx6L2Od4CPUhjjCgFTNV6dMnuDIHzeDe9jMT2uSefjJSIy7xTi4TcfAKlMt39
 /TmVwkaFdoP+5E53RjLhFKbafsgT56rMV1CopA44jiBqlMybiQXQFjVyZg8t86rZpn2k
 oW+z5GY6+hjxHn5hmXdRefoTji2mz/u5P90AhqyPZXPUe3sSBVfIQw+p67d8j/0kDOOc
 TYnaq/6g9zOh9QflJVqrWurHnt0mHj6SHwbExVwXGEHHIenUITozo78mMye/e4vhW76u
 0v7w==
X-Gm-Message-State: APjAAAVNpj3kj9jdrxulQ+ug3HJ5lZWdy6RyJk7ZZ72TUsxMBdjeY3Ch
 4spfjGNPsPSj6hQBfqwoyTh58BByPpCiRC6vPBVgPw==
X-Google-Smtp-Source: APXvYqzpYAIITTHyBlX7CRUeDoZEPf4WEShwX/ix+K2/HWFa8VXeIGqJrHDlKgc52PfZ9txl+qufupLsU//qO5Q8CZQ=
X-Received: by 2002:a19:6a0d:: with SMTP id u13mr11068219lfu.86.1572945738652; 
 Tue, 05 Nov 2019 01:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-23-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-23-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Nov 2019 10:22:07 +0100
Message-ID: <CACRpkdb8FQ8qqkSJic-7S5nA8c_fzNruYMrTC=dWwTridxygAg@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 23/46] ARM: pxa: z2: use gpio lookup for
	audio device
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

On Fri, Oct 18, 2019 at 5:43 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The audio device is allocated by the audio driver, and it uses a gpio
> number from the mach/z2.h header file.
>
> Change it to use a gpio lookup table for the device allocated by the
> driver to keep the header file local to the machine.
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
