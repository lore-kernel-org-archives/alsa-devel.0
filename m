Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9CECA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:14:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E472184C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cJTm1l1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E472184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E8EF1615;
	Tue, 22 Oct 2019 22:13:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E8EF1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571775266;
	bh=OpoVVHOFIloFwdUu0ZzznNt2K2JBfmqSYECkMKSlMsM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJTm1l1tV08lPJU/zTD6qhWdhxPRbqeowxvqdRNNTzYD02FkpH3xA5528LZQlYDg6
	 DLi+mPUeaAuk+LS17GTJkAb/HOZxLPhDSJhPjRjLeLPZuasdQkNE+Lgkr6dY41W3GB
	 PdhsOJqdWMkMadJjv0T7DALWzqLc9eYAMB37Uplo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BE30F802FB;
	Tue, 22 Oct 2019 22:13:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 306CAF8031A; Tue, 22 Oct 2019 22:13:34 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00868F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 22:13:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00868F800C0
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MEmAX-1iFZbd0fAh-00GLuq for <alsa-devel@alsa-project.org>; Tue, 22 Oct
 2019 22:13:30 +0200
Received: by mail-qt1-f181.google.com with SMTP id o49so20927193qta.7
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 13:13:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVFFvC46iuZf6sgYordqBzZmf/xCKCwlCVIMEAvcAXJ1feX+s/Q
 537kIybdMw2j3UbUbHh+JbAnPIIHLof1tp8LMjQ=
X-Google-Smtp-Source: APXvYqwHws2+wdbd8O8mZBRDAI3f/vMQUkU/DX6M5bMx+/92TDs7sn5fYNiZg1DtZYJeC8Fy8qgIRm0PfsfvEwlnrmU=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr3823785qvu.4.1571775208879;
 Tue, 22 Oct 2019 13:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-30-arnd@arndb.de>
 <20191022163913.GV5554@sirena.co.uk>
In-Reply-To: <20191022163913.GV5554@sirena.co.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Oct 2019 22:13:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0a2EU8mKNGLNoh+fnpNU6X=qgpAv3kOGN5uXv+f63KwA@mail.gmail.com>
Message-ID: <CAK8P3a0a2EU8mKNGLNoh+fnpNU6X=qgpAv3kOGN5uXv+f63KwA@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
X-Provags-ID: V03:K1:zmSArxz6rQRv6xcPqrwqYBElQ4Y4jesLbAlwQrpmCUkgoYnFDbO
 CMD43iAaX2Rl9mGv6ChH2xJX400LlHlHJ5caTDr+dj8zIENcOGjBhFS+OM8I/9E0ndEG1hF
 P1ACEPWfzw0LcYkhBG3IK7OVJLgUncOH9hmVHz78NmBiQeoYnT5bIDKnI//YhMPXgiqPhf0
 wQHMUYE8y1h4eTXepCMNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9RUIrxqEpkI=:hgD0/YD0H6DlT52RtWkvL8
 0ayDKSFKUsa4WRxAkBjXDg/HGc11dzFgtNH6jy/Zok7+rOP5juDkfI1hSIWIL93GUdkWFnm2Q
 5zH1+3MzZTeTeX6Sa3mfAuPI5zKjBbLqdhLPc364s3BOYuIz7ebyYwXFsmK6WmEKTSXhr1LKX
 EVU804S48BLZAAcnWE5D5EQmOdnHwkQ7EapsskhEK8zEEDeayL8tTawoWXPdZeabQGHmwu+iD
 CVczxRkKRzAs/tWHCHHk1RjZSWjtq365X/1vvBF6j1ACXUTzpDEf9ziE8mZMPu3QGUxhFX5qV
 4vcfFf5fBfPyq2WQkRQJT6pY6+ZisVQccF2rgGuaHs6vaU7tplStf86y/S5JK5K0ll2279smt
 CWAUW2qd8/z582OMbCdgvUrD6I87VEngxQeVghv7F8OU9CYoKI8L2ubN7R4S56ltrVcip7Z6/
 yjmqzdEkL098Gwf27wpFYa3/7a1fyJkwd579YM8QjM74s9MAdiNsWe7KOz9P/rdiHZI47dYPE
 /ZTKxeo+vqL3NC5m6sXwYafG1PCpRkdEv1V1eVA0dTGVt0P9616ilrjV8VOhDIuPyrDUQZ+I4
 EfkrpRt/sk/tprO1P/ybvlSyo79OaXWIRwGLonwzXOtX1pXyQCFZLgMlHNpl5SjEHf+X61G2T
 CRsEhCU3saL+HAN2JRB7thysoDA/vVtkaZpxKKVx9Neh/31VRWD8PyiuvYd1X8F/KKOg44co1
 eC7yhzy1cW2S8QQ2Ej7H4zdwwhbza5kJr2EMcPgDjFffPnx1SoqCY5RUg/dnYJ4zVTNP7n0mP
 18bfLB5mKqM7kzZPYVrJhaTbnE2iLePf7TJRpm9QavS05krp338XHAMf6uF2OhHsey8GBmPNs
 xP7RVh6e8bfFtX0AgUhw==
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 30/46] SoC: pxa: use pdev resource for FIFO
	regs
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

On Tue, Oct 22, 2019 at 6:39 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 05:41:45PM +0200, Arnd Bergmann wrote:
> > The driver currently takes the hardwired FIFO address from
> > a header file that we want to eliminate. Change it to use
> > the mmio resource instead and stop including the heare.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.

Fixed, I guess I lost an 'A' somewhere.

      Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
