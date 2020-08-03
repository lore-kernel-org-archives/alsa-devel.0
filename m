Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D3C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C362076C
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bkw2ChsY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXTgwroY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C362076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A3831657;
	Mon,  3 Aug 2020 13:59:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A3831657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596455992;
	bh=swGGTo+bHvK/rt142wGfznO9IEgVPLIKNyOWYDUHy50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bkw2ChsYNycrfKJcFYqsdoNyOck0ZHQkybNfMD+Rsc54Ta5f+ThmHc9LoX8bWFVDM
	 qg3zvNkp7Q5sma9yY23tbKtm3as81YhlHILZFFvOGq9J91bhfkt6Z2QRTZDqE5kg3n
	 uLBciJLQ68SgrHDf2y/g29sZW9oQh5t8DCyW2Tfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED096F801F7;
	Mon,  3 Aug 2020 13:59:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74D58F80218; Mon,  3 Aug 2020 13:58:59 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CF0FF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 13:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CF0FF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="uXTgwroY"
Received: by mail-lf1-x144.google.com with SMTP id s9so20334103lfs.4
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KvnlsttOP//2ODg8mN3tFkG+IukS91oGcszjnX8nUmE=;
 b=uXTgwroY4nemVJflAL7WFDGRNR0a0IJKvE/ClN+HA+FoF2FCuo3/islDqlqVTyeH5D
 8Dt2QZ9DoHpWsSlJGR97SC0gmfOZ8jDEnk0JkQAZH0NCJ3bXzNRXWxLeF5qHIqgmhOj5
 cePGNxol6e4lyZmdSDWTc/Sb/Bvb//TZgap8GBVROD+RPBqjzCtMt6+J5hBe+nhT0No9
 KDIOhYtHgm2Rf+EtaKn0H7DWmwN4nE0Xv+VXd7hhl+GM3VAj0kL8Jffbh1D0HcKZj9O0
 Y/mfIbZSZDhKaip3O+Y3Ki0GCphu7zt+ePRZkCpKh6VjcqubB9uOqJg8mfXhH+yOt+Pa
 4xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KvnlsttOP//2ODg8mN3tFkG+IukS91oGcszjnX8nUmE=;
 b=BaJqu9RU7TG+FpqaqyF2ZeOJUARqpgCLR6gKQxHXyVjv5dHs1jPi9YSgoDP8zb0SiV
 tRv5vatbpdUL2hgIjjbLiTkJmQlg0jfF+Guy++9YB1Oq8DpfENVOHegKk5cCVJtiwi3p
 9YbE0ChsqbIQR3j+Kp+WOR5E1k7rmX0Cj9gpKCQnrNsnIyuA547aQQ3YoAyJaLO2BZN6
 ohhFaxcuahLXWIfFfiF0swF/cMC4VxVMHkM41nev8HLPZGUZWvb2MDUXhCg8TXKHSSbo
 lqUS2XBQJeRKJ/m744X09gxcpREdGezYDscH6CzMuHUwoBwNhWsgRgLrWoFQhYMlCZ26
 f3vA==
X-Gm-Message-State: AOAM530CiJ1WaVGHpew8at4BRmUudLgxMj2tyTgsH/yQgxioNdY2Za9Z
 cNNEYZV4Z+p4hz2C9RAWsV1ycpcNl9btzYJNVgc=
X-Google-Smtp-Source: ABdhPJyRFSBrs6xHljo7z6SRDkqm2EvdA1xdCD4OQaJp79PjllwpDp7YKmPGJP5OD1k+P50zSfu2kF9oa9mllBOpbXY=
X-Received: by 2002:a05:6512:281:: with SMTP id
 j1mr8384648lfp.214.1596455928551; 
 Mon, 03 Aug 2020 04:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200717135959.19212-1-festevam@gmail.com>
 <CAA+D8AM8EKowXs_0nyNKMa0odyEAF=Sgu8y2n48pGFnEbE0Mpg@mail.gmail.com>
 <20200803105122.GC4502@sirena.org.uk>
In-Reply-To: <20200803105122.GC4502@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Aug 2020 08:58:37 -0300
Message-ID: <CAOMZO5BCuyzXZkHtKJ5oOtjTqgVthqBFruWtMvnhALTkjucfow@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Do not access WM8962_GPIO_BASE
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

Hi Mark,

On Mon, Aug 3, 2020 at 7:51 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 03, 2020 at 10:07:06AM +0800, Shengjiu Wang wrote:
>
> > WM8962_ADDITIONAL_CONTROL_4 should not be removed
> > from the readable registers,  after this change, there is distortion
> > on output sound. but this patch has been merged.
>
> If there's an issue please submit an incremental patch fixing this.

I have just sent a fix.

The patch I submitted originally did not touch the
WM8962_ADDITIONAL_CONTROL_4 register:
https://www.spinics.net/lists/alsa-devel/msg112549.html

The part that touched this register was below the --- line and it was
just a comment, not supposed to get merged.

Maybe this confused git. Sorry about that.
