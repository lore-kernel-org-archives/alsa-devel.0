Return-Path: <SRS0=hmI4=ZT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA75C43215
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:00:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C9C2080F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rp9QGxh9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eHCTU1QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C9C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8CD516E5;
	Wed, 27 Nov 2019 19:59:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8CD516E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574881232;
	bh=D571o1h5aFnmSsQ2b3ePPnmWoPk56x4PjVAKGoNMtuo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rp9QGxh9AJRDfcK+2Ck5YfrE3/SpKrDWJZEY3E5pkAi8CUR98qmR6H6EFLDtJ7GWC
	 9yayF3qLVLsuJBoDYOSG2WO2o6OGuIAkGNGRO8SPuNmD/Qldyl8DpqHFXPX31b1i97
	 9MnHf+TcCCkvN+AX07/88ICfAJo9eoWeQbT9TmxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46B75F8013B;
	Wed, 27 Nov 2019 19:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26788F8014D; Wed, 27 Nov 2019 19:59:40 +0100 (CET)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50E4CF800E9
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 19:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50E4CF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="eHCTU1QY"
Received: by mail-qv1-xf41.google.com with SMTP id cg2so9340847qvb.10
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=geVGu8MBW5PeHjvdy4rCo2MPVBJQGl//bajAqe2ly1A=;
 b=eHCTU1QYxVuGhChIncMyHJ9Pm+6/dZy6dgMluWm3zrkYV9jdgNv+PuDkJdqjp/SQ68
 OAUxXumGOl5myH27v6FfcWTuDGABtRiSSQMK+xtAX4a4jCFMCvADUT2oCN+GwyYYlTZV
 YwQw+7TMamciR05gVvQZS1Tq4jRYuOAcAwghj/slaAzH/qIFSG5+RwI6zyiw2aVEwPI8
 UBfV74BpdOo0iL2DNIcEMk6Metyucdu2pJfjg8BNCka4XchEnxLK4ZVVPzXe53AZXFys
 XRx3BjrqTHHfWOezDRDr3bKoncCv+SKdRT/bXor99Ezi6spieeClLT4gsoP1gmDb9XWj
 kehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=geVGu8MBW5PeHjvdy4rCo2MPVBJQGl//bajAqe2ly1A=;
 b=sG5VxQUpAL9okipsl8/Yx9NG+XdcVbzJP0sbFb3dnfUrTaMubt3/0v5fMgA0McYcbl
 1NC6hVRqzosqsWxPWSSshiisqsw0Z/g+zjtjV7zHUZNZ1RWxW/sS9xRhn6m0jNVfvyb5
 1xTESvV3FIMnuTRROTr164o8CAfvS1Y4rfTlg/V+SsZL3xQm4WhqWZnVfoxRGtXnqff9
 m+kSlwvuSXU0D4N0x2myjLuv7jQewHgHylAyMQ4Tjm4gn49DmUMccsq697/b66Cl8DOy
 MtwBtFyheMCUkyxkS59iQbleU1yRBc9C6RFyWRFP+Qdr0VInZKQsyfOO9t0Rs83gxxWd
 VDHw==
X-Gm-Message-State: APjAAAU3v2XtgNqJdQtHymAh9+2STuAzQ0oARe4+/5XRvPkjVT79SVJD
 nnWk3473QVyYN+aypeeceU4Wwd7R5g8bYffmko+tCQ==
X-Google-Smtp-Source: APXvYqwzbioROwUxTls76I+kI8XT3+8LulhD/EKcnF1Xcb3Thi0WYWiroVHFIWuQe7i3Hx6HMIOZ7Twk+gkVIhU3wA0=
X-Received: by 2002:ad4:4c4e:: with SMTP id cs14mr6646423qvb.198.1574881174864; 
 Wed, 27 Nov 2019 10:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127082145.6100-1-yuehaibing@huawei.com>
In-Reply-To: <20191127082145.6100-1-yuehaibing@huawei.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Wed, 27 Nov 2019 10:59:24 -0800
Message-ID: <CAOReqxhf4qU7DwLN104Mq_Q2BCdmPSC9sjJv2QsGY4uPEK-u6g@mail.gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>,
 Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: rt5677: Fix build error
	without CONFIG_SPI
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

On Wed, Nov 27, 2019 at 12:22 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> If CONFIG_SPI is n, SND_SOC_RT5677_SPI also is n, building fails:
>
> sound/soc/codecs/rt5677.o: In function `rt5677_irq':
> rt5677.c:(.text+0x2dbf): undefined reference to `rt5677_spi_hotword_detected'
> sound/soc/codecs/rt5677.o: In function `rt5677_dsp_work':
> rt5677.c:(.text+0x3709): undefined reference to `rt5677_spi_write'
>
> This adds stub helpers to fix this.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 461c623270e4 ("ASoC: rt5677: Load firmware via SPI using delayed work")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>  sound/soc/codecs/rt5677-spi.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
