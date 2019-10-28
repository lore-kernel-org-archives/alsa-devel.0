Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED993CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D1921479
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vafTdICq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D1921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF68F21A0;
	Mon, 28 Oct 2019 22:59:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF68F21A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572300020;
	bh=OEieysX9uxQvM2rR/gQGps8wC0i67r9lZW4rIVciBmM=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vafTdICq8pgzOl65Idl6YibyVme9gOXWYi1K2D4W2Bq0OqI43xco5+ZkKlseNWbCL
	 rchM9elTxXnueeHvZaic6gMmI00+vCAAmO3oU6ZCALhDH/zzpfFYHBijCL9uXO20IJ
	 NYUp4IPayUS5FWMryfJre0XDX2jMyTP5OIYYmR7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8506F805FF;
	Mon, 28 Oct 2019 22:50:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF347F80600; Mon, 28 Oct 2019 22:50:48 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAB70F805FD
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 22:50:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAB70F805FD
Received: from belgarion ([90.55.204.252]) by mwinf5d17 with ME
 id K9qk2100a5TFNlm039qlNT; Mon, 28 Oct 2019 22:50:45 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 22:50:45 +0100
X-ME-IP: 90.55.204.252
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-32-arnd@arndb.de>
X-URL: http://belgarath.falguerolles.org/
Date: Mon, 28 Oct 2019 22:50:44 +0100
In-Reply-To: <20191018154201.1276638-32-arnd@arndb.de> (Arnd Bergmann's
 message of "Fri, 18 Oct 2019 17:41:47 +0200")
Message-ID: <87h83sk097.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 32/46] ASoC: pxa: i2s: use normal MMIO
	accessors
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

Arnd Bergmann <arnd@arndb.de> writes:

> To avoid dereferencing hardwired constant pointers from a global header
> file, change the driver to use devm_platform_ioremap_resource for getting
> an __iomem pointer, and then using readl/writel on that.
>
> Each pointer dereference gets changed by a search&replace, which leads
> to a few overlong lines, but seems less risky than trying to clean up
> the code at the same time.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
