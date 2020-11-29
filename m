Return-Path: <SRS0=XhTq=FD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFAC3E8C5
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 23:55:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A4F206FA
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 23:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hZP2sDJa";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVS0297H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A4F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECEBA1743;
	Mon, 30 Nov 2020 00:54:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECEBA1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606694110;
	bh=dELoUncg4t1sOtmAmo5IQDZX+xSqBDjdCKZaFT9Ey50=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hZP2sDJayUFcyo7Zk5+l0qi4XINiQK5ceG9T6z/mI64mZTv7+R5umCgFgz8E9zoj7
	 /uDEo8shNEMEvO6n8UG/7dUtip9Ud+t8AN/+8/1cugPNZo6peAHhgoL8PpjMAN+a2K
	 LJTpEmxTcYYFco8or7LwyoLd6kYgIvV9mNxfCiQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79B26F80148;
	Mon, 30 Nov 2020 00:54:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 161A5F80168; Mon, 30 Nov 2020 00:54:18 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D3CAF800D0
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 00:54:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D3CAF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CVS0297H"
Received: by mail-qk1-x72c.google.com with SMTP id i199so9421445qke.5
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2020 15:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=dELoUncg4t1sOtmAmo5IQDZX+xSqBDjdCKZaFT9Ey50=;
 b=CVS0297H/jdQdkdWek+yub0GWmI2Y+rC6shKiyTrPTWO2bWIMTHW19KfXk1E/l79xh
 jif+6AhvJT4/7+Sb77xpVd7ms6MjpHp8s65PnU6YV5KPbFTsNiYuOMLT04iRnxsWdVH7
 69Aoudq+NSuOP2IzLWpT0VhVNFL4S9FxfnmDu6f3h9OYi84oarEAzPiHLJxpfGqifGMy
 osKEZUhDpzyCSlqMtRVI/DmKQtKBvPEHNYmGQr8WPpbQraocDVnRCDzFTUIXZ4hgC7ns
 Y2IXgbnqoSd5H6lt9QOD1BFvDGmP+jHrT8zBuGwIWzR1cZkv7Je3WInIvw3P+ohTPL/R
 D0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dELoUncg4t1sOtmAmo5IQDZX+xSqBDjdCKZaFT9Ey50=;
 b=HaSVV+BaRF3+O4ciGlJ4hvWJx8wk+1OZLPqEk+pkUMpR+rhYJy8nCgZVc2uT6G6Wz3
 +fsoDykvOtHAKZPYwiV0bvRhlkQm/JkT40/TO+Ui0lJkkinshhCX87h5L8XpB+TiEZuo
 3Hq9+nHW5gQiL76RZXL4PNDHJVCMLrvfp+R7uM9uOdaFtFVXWDsmMyqbkDwXLDHgkz+g
 SUs3x6Ae2GYKg4WIL+1KxUQ/HEAWIntmFyIv8Hy1/ZZJW6UT1VMwS5n1pzFWEvHTYtL6
 6uNCpNfl/MaGS0cXy8BCqBE15ipsqcZjpzQUuh31TGm/pSBw0hYpTxih+5EFk9qzMpcN
 wJVw==
X-Gm-Message-State: AOAM530XnLHnjkfe7BMLy84A6EPJ+jCr0Cfyt2wfpVVoyArAcWBgCjnh
 E6hVpvDXW4pw/9zB/XyEKsfTROwYjMbDdO9uEpmmsMaWPTerDg==
X-Google-Smtp-Source: ABdhPJwZv6ImbAX3LqkBO3VGoCdIHiQy9gc188HQGAERz7LNfKIMs5tT05sjQhEf5w+RbkVKmWgKgBhbXrrWOdjqO+g=
X-Received: by 2002:a37:afc6:: with SMTP id y189mr2800280qke.361.1606694049239; 
 Sun, 29 Nov 2020 15:54:09 -0800 (PST)
MIME-Version: 1.0
From: Soham Sen <sohamsendev@gmail.com>
Date: Mon, 30 Nov 2020 05:23:54 +0530
Message-ID: <CAGvD0_bewR3v4Pa+9f4XLGMreVL9cx6BNj=GXWnUN2XJuG9r5w@mail.gmail.com>
Subject: Mute LED not working on HP (Realtek ALC245)
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hello,

I've been trying to debug the issue related to the microphone LED not
working under Linux. I've confirmed that the LED works in windows.
Seems like most HP laptops have this problem, and they are fixed by
adding a model= parameter, however I've tried all HP mute LED related
models on https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html
to no success. A very similar model to my laptop, running Intel HD
Audio can be fixed by using model=hp-mute-led-mic3 but this didn't
work on my laptop either.

Can I get any help on how to further debug this issue? I tried
searching for the documentation for this audio card, but wasn't able
to find anything useful.

Output of alsa-info.sh:
http://alsa-project.org/db/?f=4173cebd458b6badbc21668461e9ba2e890333c2

Thanks,
Soham Sen.
