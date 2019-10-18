Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D9CA9EB5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 05:05:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7790E2064B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 05:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qLPOemmQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDe9kDeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7790E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F3BC1676;
	Mon, 21 Oct 2019 07:04:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F3BC1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571634302;
	bh=RGl+S7gXh3z6Yh4qQKLL93TtDD+7qAmQh8mpJgfhUpY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qLPOemmQMS2z/xxQDP2cmUCYgrmT15JjwxzjxWSpccF5yau02pKFJ3P0d3phzruTi
	 Gc0acG8nzACIpv7+mUmcTt7hDhsHMzKoNjXCZ9y973HGO6e+CTV+3IjsjcTWasw9m8
	 tai92AWBg58D8tua2JSBq4jIynIU/tBrfCKaA0E4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D510F80600;
	Mon, 21 Oct 2019 07:01:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35D05F80362; Fri, 18 Oct 2019 20:38:11 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36E29F80322
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 20:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36E29F80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HDe9kDeK"
Received: by mail-pg1-x544.google.com with SMTP id w3so3827005pgt.5
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IFDsqOMwc2ojaPSLkT8+wMYUXewN1acLP2lqR1XP15Q=;
 b=HDe9kDeKBahe9NjGm/ugr3PrO4D0Lw085ywSNSA095A6Y7b0bdnZjmqC82XIISIIdt
 HL1478hYPAIvWzZLWe743K+0Z4UKFrxK0/hQ9QagRbJbspKW/xQebobzv2mUFy3hRLKH
 //wSlMwz56Seed2I+e/Y5zi3HKTITkVYbYNZcR/r9Ty9L4OUJxGZQa8n7sooJF+d06MV
 U8c1Xqzj80SWkW1+fMzKDsGOIVt27mRFx9PdNgqZxq/nnXPUUxC1LvIFwI/iWySD+Mw9
 Y/fW+KH35SuT8tMvpzVKHsaJfOpxO5whSf8Fu101J4r54ddKqPMDRDSv0HSvbuy5Taxu
 2ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IFDsqOMwc2ojaPSLkT8+wMYUXewN1acLP2lqR1XP15Q=;
 b=MXOsc1YKaqWwsTIaJs6KSlKWyUe0Er4DVnJQQCRY5KqDnRuKZKqoVXtZAx2ZunS9G+
 lchIcb2QTC8BUKpa1kkBmcN3F3OAMD7EwIzcn2M7mdo09fVkYeZBAjjRFicrySf+yUaN
 TtLq9rZ6OPKlMpsZeOOievyUZbOAdaVcaLtus4Kcu+A4bKzIcBkNLGXlrqdkzcpOPe5K
 12vhI6Hw//st2WcKFPipM4+91dCA3Z6ADQfQl/lsvjmXf6TKPLs0zQd1Sjt3Ked2D5+j
 JloOwTWrLPA/H0uS44tKIt8Ipdy791HL6ayCLoKlRtg7iFmaplKGdoI6G0c34lM9vQHt
 hoGw==
X-Gm-Message-State: APjAAAWu5FemdqKEqRVx1+vgyukwua65rN5gRKEa6yyIsBP46O0nJRWL
 /94YZDzGX9ibOIaN5A9wq8I=
X-Google-Smtp-Source: APXvYqxI3fG8J2/DXNrMqbp5He+LcRaizowKU8zXJc/NBeHP6e+1CmGad85VCcLrdR+rSgjhba5HPg==
X-Received: by 2002:a63:5762:: with SMTP id h34mr2723268pgm.235.1571423881363; 
 Fri, 18 Oct 2019 11:38:01 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id 69sm6908001pgh.47.2019.10.18.11.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 11:38:00 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:37:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191018183757.GL35946@dtor-ws>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Mon, 21 Oct 2019 07:01:38 +0200
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Mack <daniel@zonque.org>
Subject: Re: [alsa-devel] [PATCH 05/46] ARM: pxa: split up mach/hardware.h
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

On Fri, Oct 18, 2019 at 05:41:20PM +0200, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:
> 
> - the cpu_is_pxa* macros
> - an indirect inclusion of mach/addr-map.h
> - the __REG() and io_pv2() helper macros
> 
> Split it up into separate <linux/soc/pxa/cpu.h> and mach/pxa-regs.h
> headers, then change all the files that use mach/hardware.h to
> include the exact set of those three headers that they actually
> need, allowing for further more targeted cleanup.
> 
> linux/soc/pxa/cpu.h can remain permanently exported and is now in
> a global location along with similar headers. pxa-regs.h and
> addr-map.h are only used in a very small number of drivers now
> and can be moved to arch/arm/mach-pxa/ directly when those drivers
> are to pass the necessary data as resources.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
