Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BDC2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:04:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ECB22262
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ON40SMLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ECB22262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B277F1AFF;
	Mon, 28 Sep 2020 07:03:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B277F1AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601269456;
	bh=iH4BCtKHYZco8jOSQGiNPWj56rYDuIQ1wb3Pt3Sr0IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ON40SMLnJ3oCKDoDX2RMLn0wDzgsvrz0SElqk/Kpiiw/VEbMFW4C4nWrSFpr9qJVl
	 /3mVSD2cqGO2zJf4uOdHLaYlEGOFoy0SITvx7O8vO/ZxNms+wrOvT8+cP1Gc3reATX
	 YUaS9KLuwQpix5aAv7BzaZJvv+HcU4sUCwylTNcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F30C9F801F9;
	Mon, 28 Sep 2020 07:03:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BCC7F8023F; Mon, 28 Sep 2020 07:03:24 +0200 (CEST)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0E05F800FD
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 07:03:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0E05F800FD
Received: by mail-lj1-f195.google.com with SMTP id a22so7169405ljp.13
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 22:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iH4BCtKHYZco8jOSQGiNPWj56rYDuIQ1wb3Pt3Sr0IY=;
 b=aLkOif/Aq6DdhEz2DWvH7Mn9RX6LHxJgBreCxi8reHHfgl+kvYzP1qXfi6Rylh6so+
 WUKeRDVI2bb0UAAIhBChVk4X3Z16PE9V4FsIgTHYVvPjRUD1CFzuRuu0VREKZpnrG9ed
 qS9cQsyMNE9h1bn6R9VuMe8idx8TPpX0Pf4XgQiN+ElD3G529Y4aT1D8qsLH45JoVkQk
 tApoPq9l5hPaZbtgvFAugIu1A9lphtKeX30j4A8CF6wsIf6MraOVdDvSaUGyZQW0OGrd
 kScZRdHPHgFtU8UlhfrjzTMdEUdSoLoBLDwKc0vS0nyOZE/GQfTIyJD5m5on0noYSYM0
 mNUA==
X-Gm-Message-State: AOAM531+Fck3AtuKWUuCSGzhc/QKcpLt1uRH3COZxDLZ029OtdEVf1eo
 1n6Utmx/GsRGIVRNc1U4jPj0Ppx2Va58MQ==
X-Google-Smtp-Source: ABdhPJykN4UOldrTpoFrilx6nkgd+J56EsTyyQc4JzXmW0j4t3LU1/uTpd5I85uOizls2/ehttpGOw==
X-Received: by 2002:a05:651c:141:: with SMTP id
 c1mr4649555ljd.182.1601269392581; 
 Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id j20sm2693256lfe.252.2020.09.27.22.03.12
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b22so9524670lfs.13
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr3034221lfc.283.1601269392234; 
 Sun, 27 Sep 2020 22:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com>
 <20200927192912.46323-5-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-5-peron.clem@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 28 Sep 2020 13:03:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v65noEYaHa=d4s1E+1+bcUFjtojvjK_DmEAyJkGU_T9cTw@mail.gmail.com>
Message-ID: <CAGb2v65noEYaHa=d4s1E+1+bcUFjtojvjK_DmEAyJkGU_T9cTw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 04/20] dt-bindings: ASoC: sun4i-i2s: Add
 H6 compatible
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Rob Herring <robh@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 I2S is very similar to H3, except that it supports up to 16 channels
> and thus few registers have fields on different position.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
