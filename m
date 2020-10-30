Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0077C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:06:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8FA2072C
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qD3GtSIV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSbb+fEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8FA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3BF51654;
	Fri, 30 Oct 2020 20:05:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3BF51654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604084800;
	bh=MkMpoKN9mdvQXcoB6tpKOQXDO/dEFfJA9sA6E97EIyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qD3GtSIVdoRNaOcg1JRbX6dB+yBie6r6KNK8fwUk5tRyahrda2Jx/X+u8xdv4qwdc
	 jsglJ3RTiIbJtZW6dV96EEPcIaurWnqXxPov03zHEBWBc4Ya6sbzvZ0gZEHqKdfvgR
	 8Y7NmE/9mP5gRSMkP6/DeiSM4AwUqaHuX1dcfT1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D9C0F80212;
	Fri, 30 Oct 2020 20:05:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B4F2F80249; Fri, 30 Oct 2020 20:05:49 +0100 (CET)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A853AF80107
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 20:05:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A853AF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BSbb+fEK"
Received: by mail-io1-xd44.google.com with SMTP id z17so8586463iog.11
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MkMpoKN9mdvQXcoB6tpKOQXDO/dEFfJA9sA6E97EIyQ=;
 b=BSbb+fEKOyH6Ks1ytY2GHgAipM8Lkzch8WZk8wpi6JKMLaKuY75rFl8MbLibtoLUZx
 T3CdErtcjaNSunZvVT8fr6pJd/SCf+nQpRmh4RHAsqPbk2TQ9nQ8DhM+mpLf9A5BQw9l
 fGWAY6gOlKTpxaE4awrtiZqEkI7Xnq0UP+1XWsQTYlWEfXmfn7v+Ptu7kAlRFq9xzhRB
 gfEjv8JxlMNYFMQi8k1a6sQexZ2V36redS71gc/KW/cKW/X2Qp3XSRcIRwsbaSmCzVY+
 42tL/9V1TC3JbQgPOuHQO7fCnoTGa88nV9V+1uEPE3SiaJYkrsCqRm3lXk5vaKmg0bwu
 oHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MkMpoKN9mdvQXcoB6tpKOQXDO/dEFfJA9sA6E97EIyQ=;
 b=NpWlre/e4gEXFTuyYoaIRokAYY7qHd92ovuM3g2pfu6YsgSPQQ4oayabl5+1MCoxmx
 T5lsuUQXKaFzQY06jKCRvYZfIztygIWznIddUspIi6GE/zYNu8IJzE6SxE00v9+LeMmv
 EzxvIx+E98iKE+ZtM/TmnUDV7tdJWrQS4m8ztOf7wuFlbgBH6LZIVRsR1EeNt7dS1AIa
 6MiCen7dvP8VTIroEAjCcT4wrmw7sdhnUO0V18knsa/gr4NOC2p7nQ6hoomV1Sh/t5zX
 VRl3ayWexJhRqvcPR5a8sTLVJjWp1hkDj5ObO2Okh0fbtp7qin5/yEjg0VpBkf46RyJH
 ObZw==
X-Gm-Message-State: AOAM5312glxbkLF8jdRSmrn6wywNa5Ph9jswBdPKNAVge2KVdxcB760r
 ukYu58qzWq+iDOM8zfrZH1GcePSH6U6K7rHZVBw=
X-Google-Smtp-Source: ABdhPJyEfQkAnfPA6e0+TIbGRTnMyNJm3rfqNIl1YH+JrAaGDGxybAIO2Br/u3z9ad0E571PBtZ9I5kYiAbeR5iZb34=
X-Received: by 2002:a6b:7907:: with SMTP id i7mr2883566iop.178.1604084742911; 
 Fri, 30 Oct 2020 12:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201030144648.397824-1-peron.clem@gmail.com>
 <20201030144648.397824-15-peron.clem@gmail.com>
 <20201030181935.GJ4405@sirena.org.uk>
In-Reply-To: <20201030181935.GJ4405@sirena.org.uk>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Fri, 30 Oct 2020 20:05:31 +0100
Message-ID: <CAJiuCccAjEHX4BmL9A81EwM_xnHTPVyHu3BOPGKKUQ=1HNaZGw@mail.gmail.com>
Subject: Re: [PATCH v10 14/15] dt-bindings: sound: sun4i-i2s: Document H3 with
 missing RX channel possibility
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Rob Herring <robh@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
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

Hi Mark,

On Fri, 30 Oct 2020 at 19:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 30, 2020 at 03:46:47PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Like A83T the Allwinner H3 doesn't have the DMA reception available for
> > some audio interfaces.
>
> Please if you're going to mix dts updates in with subsystem changes like
> this keep the bits for different subsystems grouped, this makes it much
> easier to handle things.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Sorry i have based the commit log on this file regarding the previous
commit and it was these:
5c7404bb30bc ("dt-bindings: Change maintainer address")
eb5b12843b06 ("dt-bindings: sound: sun4i-i2s: Document that the RX
channel can be missing")
0a0ca8e94ca3 ("dt-bindings: sound: Convert Allwinner I2S binding to YAML")

But basically for the next dt-bindings change you will prefer somethings li=
ke:
"ASoC: dt-bindings: sun4i-i2s: Document H3 with missing RX channel possibil=
ity"

Regards,
Clement
