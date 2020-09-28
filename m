Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E4C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:52:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D302311C
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JDq26dnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D302311C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38B1A1B11;
	Mon, 28 Sep 2020 08:51:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38B1A1B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601275936;
	bh=XTACXA1Hxtvq1CFGlNEl/z/KQP4lC3PCO/x6XgxWWX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDq26dnMiGD6z4qYrxyrO4Ll57AFuCMkvhAKaWjCqSaQ5XiphmH+zpqHh3n447vuj
	 XcBu1NU6Dal3ePlMu3StKTKVn+4OITdB7iOfT3ETgPAk5nDvyUN9ZXbFTy1I0xgpxA
	 sg2FPPhljVUMR+6wiIrMJ5sPU/2LAtTRDtr5FmyI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA4BDF800DF;
	Mon, 28 Sep 2020 08:51:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1423F8023F; Mon, 28 Sep 2020 08:51:24 +0200 (CEST)
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70C79F800DF
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 08:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70C79F800DF
Received: by mail-lf1-f66.google.com with SMTP id q8so9802271lfb.6
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 23:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XTACXA1Hxtvq1CFGlNEl/z/KQP4lC3PCO/x6XgxWWX8=;
 b=pt1aE9k22wMnmmEN+8OXpPD25X9MULWSXlnch5PGV9I9EA7uvKGJSBzXbGY7Bvlw67
 qDFx9tVYO7F7CxCq7ddylR1HOQ3pWRss64CMhtUavnKufFYmVi2MAyILsmNg4QGMfLQ2
 LPszWmZ62vEwl4U+ddWZqH3ZINaUz2ujeAEc80iba3KwEvqFCooWf79i9OjqZ3I1VipL
 kwi1JAGXZVDOYZvdUByGS6pv1OAW+8X3TpNC88VDHtK0VKiJOA5codBX+bgksiJ+ZKSf
 U1gyf6UXetqM8Y9v/p/pFH4ECgBq15F90h24LUw2Ie8+7kDtLRnjTmkR8WrRCbNfcbJG
 amNQ==
X-Gm-Message-State: AOAM532DioWzWKnW1MIxMU1LKuG13RVJuFVXieSKFQuRVI5N0Ctn+O88
 kVvsBUJUJuJ+6lRwsu9x6ma5jHmmJ5oZMA==
X-Google-Smtp-Source: ABdhPJyBjIswdsllwgso88BPsT1mNE6JWr172fKAk6mIypoVOlLg+S6xn1L2jGJXSD1Jv6NLR9ER/w==
X-Received: by 2002:ac2:4149:: with SMTP id c9mr3381705lfi.412.1601275873273; 
 Sun, 27 Sep 2020 23:51:13 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id w9sm2752076lfr.220.2020.09.27.23.51.12
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y11so9811126lfl.5
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr3139536lfc.283.1601275872275; 
 Sun, 27 Sep 2020 23:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com>
 <20200927192912.46323-9-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-9-peron.clem@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 28 Sep 2020 14:51:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v64AZ2UO42fWU49m33-mx-CzEc1wLvRprb==FSf2XmcPWw@mail.gmail.com>
Message-ID: <CAGb2v64AZ2UO42fWU49m33-mx-CzEc1wLvRprb==FSf2XmcPWw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 08/20] ASoC: sun4i-i2s: Fix setting of
 FIFO modes
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Samuel Holland <samuel@sholland.org>,
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
> From: Samuel Holland <samuel@sholland.org>
>
> Because SUN4I_I2S_FIFO_CTRL_REG is volatile, writes done while the
> regmap is cache-only are ignored. To work around this, move the
> configuration to a callback that runs while the ASoC core has a
> runtime PM reference to the device.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
