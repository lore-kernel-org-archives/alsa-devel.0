Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF0C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:32:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB5C206F6
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mq9tUAyW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LHgaqoAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6DCC85D;
	Thu,  9 Jul 2020 04:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6DCC85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594261936;
	bh=X4Ooh2TepNDU2kUT7eH6cJMYnCAo6DGOXFEWrYUpDzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mq9tUAyWsCXQ1xTnCKCiauDY9MC28PPvy3wvH/ZZA33Fxl++H0YgPddJaaCxFYk1D
	 ISZ7OdzOS+RP9EkvqwSM9ziOiyhgGNBE+hXFyxKJtpiqQHE6c2Uf10JIxsnuo4a+ri
	 6GP7NksEhQpNyZiAC+b4EGflefPS+Suu55+x7L1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F365FF801F9;
	Thu,  9 Jul 2020 04:31:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCE1EF80216; Thu,  9 Jul 2020 04:31:22 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01D65F800AE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 04:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01D65F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="LHgaqoAT"
Received: by mail-il1-x141.google.com with SMTP id a6so715119ilq.13
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y1aFB8ecB2wmH9T4OAlgM3uPIr3+7dTGswq2KZGud10=;
 b=LHgaqoATqobXsJ823bt6UbEz6EFOF6myqOpjQDAnwqhgXKl07w4nHw+JB03BZYlt2X
 BNH+dH0z6LmpBnHFCumuSMuAdzaEP7M5WsxWs3gQu7DQ7dgritCm3xWZ+CHEUxizjiLP
 WTPrkPBuUAeyMQ64PvdBWCyu2vQkgWzCqizQH0GOGKHXYvYJaNuKqcM1H8eMJwBOmZRF
 7abA8/E8d+8fydzTVcEVQ7JMm7doNMOrPww7G/vZcmpETvsROzdtGumcGiL1jGG5x2QH
 YlRQ0q/flSV88Gf7LJiNjzISn/9i6uirwLeNNQJGZuXCHNK41ap2wqMgSIyGoNq1RLMV
 bJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y1aFB8ecB2wmH9T4OAlgM3uPIr3+7dTGswq2KZGud10=;
 b=J3VLo9a95ndgl72PHv+ROVRIXf9s2iybjNf3maop7SkfogCxTq1o2X+snfNzSo061K
 NRhwqfYxeeVJZQVanbMxQK7FnuM2pwChfysViNM4n0oMX/v2Jmt9bu35sgaLzhWpY+KU
 V/pPQ8ExnnReSs4AaoF4dIkPW3zjq3SV+UQ5fBXAiSpzob/bPH5shn0ZofoeobTA9z4r
 ic1h6+ZTtoew4bG8ds8NG+HekPTYitfWU5BjyyhHvv0aSLY3JofU8Zd6lfmEfSSaNwVS
 KrsfrvT2T0Y+jw2Iauf72lsbv6uuGQF59Y5TapHIiBHL1lf3fSLqkJO6wxXKifUVHcq1
 HgYA==
X-Gm-Message-State: AOAM532oshW+oDergy/+m7bgEfV6wfjgt/1vquUDummQ11gflQvC1/BW
 8+9XA/ME2HlYcpVu0CXwdRxKjrUdx8RaezqD3ViccQ==
X-Google-Smtp-Source: ABdhPJycmG2v/dMRqlo4y4LjYnpAsyQqnOVG2LTg3fO1f0wSLY2ig+oxacWew56SN7C4tQMpaHBJFn2jujQh0be0RaI=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr44851812ilm.257.1594261875306; 
 Wed, 08 Jul 2020 19:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200708113233.3994206-1-tzungbi@google.com>
 <159422758800.28431.1053466753613230176.b4-ty@kernel.org>
In-Reply-To: <159422758800.28431.1053466753613230176.b4-ty@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 9 Jul 2020 10:31:04 +0800
Message-ID: <CA+Px+wXPoW-VU-SXSZoBdMY7zSxWf3qxWJZGOE2hT4riwT8XtA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: mediatek: mt8183: support machine driver for
 rt1015
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>,
 Rob Herring <robh+dt@kernel.org>
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

On Thu, Jul 9, 2020 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> [1/3] ASoC: mediatek: mt8183: sort header inclusions in alphabetical
>       commit: 4dae01c2e5df7beb8dfd5deb9560e42f19d3cfb7
> [2/3] ASoC: mt8183: add compatible string for using rt1015
>       commit: ab1ba5252f611c0efabca5fca81f5717445da47b

I am curious about the 2nd patch's title.  Did you change it from
"dt-bindings" to "ASoC" intentionally?

I am trying to avoid using the wrong title prefix next time.
