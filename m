Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B10C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:52:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046A82311C
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cKdM0RTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A82311C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74D921EE3;
	Mon, 28 Sep 2020 08:51:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74D921EE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601275964;
	bh=NSd7kmJ0XPqlHiWdJOBvLiYopxwgxQJXndbLZWccj+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKdM0RTUiRXnwBvhDm0BzDSpyZ8XtcSy78Mu0hVBCOVXYPikoV3x0ipqbQ3d17DcQ
	 zoIqHOj3wmbiSm10DCw/5vyAlGAurcqVUnVD6vkPPJ91vK1MlbvBeGzgaGJX01EfLw
	 /dEEZMpjSTpfm7fLOlHFhapynnGl/KuoMkFoPJ1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16166F80247;
	Mon, 28 Sep 2020 08:51:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93CAEF80115; Mon, 28 Sep 2020 08:51:52 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95A89F80292
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 08:51:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95A89F80292
Received: by mail-lj1-f196.google.com with SMTP id s205so106458lja.7
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 23:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NSd7kmJ0XPqlHiWdJOBvLiYopxwgxQJXndbLZWccj+w=;
 b=BCetAVxQFyFb0qpRdAelSP2Xq+atZvrIFePFVt89lvTxmKKofw9X0rzOkFZZ8BocIZ
 DK1wzRfNojRDA9pnVqzLju0f5yNeoFzivyRGnA3HTINQQjqiimcWnMQ4ujPEBtaawfH3
 tOKwWjuLTXQkKaPOW/7BXcAxKCQtC9TGpFNKga6XsmG4ip6x+o4ASAZPyjh56nJLzc0j
 aekytpHeIzva6XNTn18dWoWYCTihbmSstwSzkDntTUlPun6lPc1mg984izmWsU4izvO/
 Cw73HjU8Eu33pQC5bn4+EG/1vv0IPp3yoI7StOK23CMimjp3feaUzuarZzRnEAp29Pjr
 7tFw==
X-Gm-Message-State: AOAM530rTCxV0Nezaa8gY1NLYxmY+pmBjB+N6+GI9C4KZlVHQ2KInPs9
 xKXkXQquZNZHZldQaUhYW3nQMc5woQBptA==
X-Google-Smtp-Source: ABdhPJx6Z5xm3oLs4LG/6FWRrK8TGjbThx0FmuBxIywopLhXmSzNTow627Rv1uiYQVGkgn6cWyNnPg==
X-Received: by 2002:a2e:9b51:: with SMTP id o17mr4934787ljj.141.1601275902041; 
 Sun, 27 Sep 2020 23:51:42 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42])
 by smtp.gmail.com with ESMTPSA id u17sm2734288lfi.2.2020.09.27.23.51.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d15so9786346lfq.11
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
X-Received: by 2002:a19:4281:: with SMTP id p123mr3134583lfa.398.1601275901690; 
 Sun, 27 Sep 2020 23:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com>
 <20200927192912.46323-7-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-7-peron.clem@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 28 Sep 2020 14:51:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ExC9idS3ZW_EPsTNjmVb05op04CdeWfx2O3sN2Fp2gA@mail.gmail.com>
Message-ID: <CAGb2v64ExC9idS3ZW_EPsTNjmVb05op04CdeWfx2O3sN2Fp2gA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 06/20] ASoc: sun4i-i2s: Add 20 and 24 bit
 support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
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
> From: Marcus Cooper <codekipper@gmail.com>
>
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
