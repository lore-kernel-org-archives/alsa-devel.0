Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7FC388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:09:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFECD2076E
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lbdOldmR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RejgqHVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFECD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A7111732;
	Tue, 10 Nov 2020 17:08:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A7111732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605024546;
	bh=OgJN6tTDsS/fS+87mkjYEUmzONyIpbrcOFnuZo/NVzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbdOldmREJgDDlGS1s1p/Oua2CqQytSYEHQvk3nF/LX7sqGWcwxaqVfTeQ9QM4WT3
	 NtUXGLbzkuswWkUBJlz1cyBGzxZ4VcCU9QXn2UQFH0riAbxCdqqGv+Fi+JsT3IwNRk
	 2b9juFFhF/N5XAP4IIZXiB2Kn7+YDfBhGDRQD6pg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97CDBF80161;
	Tue, 10 Nov 2020 17:08:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D1A2F801D5; Tue, 10 Nov 2020 17:08:14 +0100 (CET)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B0BEF80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 17:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B0BEF80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="RejgqHVr"
Received: by mail-lj1-x244.google.com with SMTP id x9so2876926ljc.7
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IdXpjX2fMBvN29YoOyMaOI1PARSVc0VzhKJzQ6c/jNY=;
 b=RejgqHVrBZZu4n1N0vlVzMwLbdbQEz7KDOjszF61G4q8FnDRgS6MlMMKiWMrZXVwRi
 C8H+ONHnQK3GJnpwFCGrj7Fjjj5F4RE4KtWhAayffxNUeXtlvMXbToJGo2vgtLLcaJqY
 peRHc6Z8Ayw2KbWU+aISfdBvaP/YrBNtZpBsI0qEWF4/hqkHjLL4F8T+mRom6j/cota6
 TQSbE1NjoQJKPX856Cxow92rdGCYIcyrktxvr8p8+99382ZchOXMvY62mC+8arBWtKey
 5U+z/S5+mUycsJXW9CjMbci8JwbcUuiXsjlR3nZ4kRBOE4I8I+YIImyCVntI7tSyibnb
 GUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IdXpjX2fMBvN29YoOyMaOI1PARSVc0VzhKJzQ6c/jNY=;
 b=sKQT1oxVuV6Hip56UmErHcbXng1wtuX+71TJoqtdjhPc55v5AAs6qmqYl9A1wM/Hof
 phRYRa+yiPdlPnUuAiF61s4vyvIZxe9YCTH9VMfiPTKcrakYXpQ4rHdlL4ULkzocvCXp
 WZNDy7cniUaZFejohsQ8XziX6c7X84U5vmdGU5b37pySiHqmxLOyN4LzP90AEaBaI20R
 l5HquzG/k2A6fBVLe+pLHPAX9x0WsUIEnhv5Yaj62JELM6PjjJ3n73Uk2XfzMMZdk9i8
 5AnYUyz9IAwBwUp2vtOlnKwP59FLLdl3p9BCrEEb8Oc+1scRVtzIiyYGympMquBshAtj
 KKhQ==
X-Gm-Message-State: AOAM531mvYPWW3RxIqteUZN+v8gJvWGHfJSTaXik8W7ZWrjsYH9yYFxz
 Z5O+JEEUrE5G4F4JFHUyos4OfLYya3fzeZfutUhZGQ==
X-Google-Smtp-Source: ABdhPJx+3OPv/DyILoTWnWz5YCDXJQRkrl7b/kpZjceXJV8+4bcdHjQXNz+aJr98/86fydWiNskQFSAqwT5vTI8Eyk0=
X-Received: by 2002:a2e:9449:: with SMTP id o9mr8049890ljh.457.1605024485448; 
 Tue, 10 Nov 2020 08:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201106061433.1483129-1-ajye_huang@compal.corp-partner.google.com>
 <CALprXBZCthdkxGbJBZZ+ESJRDBHY879FZMpB_4Mgpq1YAJun2g@mail.gmail.com>
 <20201110115631.GA5957@sirena.org.uk>
In-Reply-To: <20201110115631.GA5957@sirena.org.uk>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Wed, 11 Nov 2020 00:07:54 +0800
Message-ID: <CALprXBZKnJGzFCLp0=UxJQp423QuaiPiaPzyY3-662k1gHUk-g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Modify documentation and machine driver for SC7180
 sound card
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Douglas Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Ajye Huang <ajye.huang@gmail.com>,
 Patrick Lai <plai@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Cheng-yi Chiang <cychiang@chromium.org>
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

Hi,Mark

Thank you, I already understand, sorry for causing you trouble.

Ajye

On Tue, Nov 10, 2020 at 7:56 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 10, 2020 at 05:40:40PM +0800, Ajye Huang wrote:
> > Hi, Mark
> >
> > Could you please kindly review the series patch v6? And may I get your
> > approval if the review is done.
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
