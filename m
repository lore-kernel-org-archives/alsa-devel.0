Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E41C83001
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:38:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F1206D8
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VVzcGGd2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwnL/1+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F1206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 348681683;
	Tue, 28 Apr 2020 16:37:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 348681683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588084685;
	bh=Dmex3LDQcneY4J/M3ShTQVtfi+xtbHgPNK20/B0dRUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVzcGGd2WvS+raH1P/jMW2228Uxsk2/pUHqvedQodgbArl0hmfUyhFMhlqG2N2j/X
	 IsPf4b809RI8lR61hZU8BR/Z62XzAEVnOS1joLRBgg8ne505mL/qrJ0i6NTneoOVDf
	 hfcv47sp5J6CvQlt8T4Fc56fPg239ov2Nw4TPGKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0FB2F80136;
	Tue, 28 Apr 2020 16:37:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90C13F801DB; Tue, 28 Apr 2020 16:37:01 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CDDAF800D2
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 16:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CDDAF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FwnL/1+A"
Received: by mail-io1-xd44.google.com with SMTP id 19so23008412ioz.10
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VPA9Kxr39ERnqwIoc2UJSAp5IoBA3dbxr68iA+juyP0=;
 b=FwnL/1+AgacLVrzfCLrLz36o10+EmBtDT+Vx71m9oQ+I8Ep9EruaY8kVJkEYTxwWXr
 9mOoV34Me4r25FtQL4YIVI1WVIVyNTGJK3zSm5wkSCPHE+jnDdwe8NCx9Zz/Iyqozj4x
 Ru/LBFO5YLFEmUqcxt3LPB/c+vkH0Gq2GNhQFwD/3Om8Pufxq/LBJGmYKrJI2cgyygFA
 /KDRbpoVEG3SaE2JJ1Sl/nF5C1H4Disv6rZrIdh6EUgw/R53UwhrWWCzxwA8WJVh/hUy
 JPoJ0VP1t3RZs7VoNBMzXnRTP2nnt1Cw16eNbJ98uAjMlPANVBDzEt5854f2gIwdTT4i
 c67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VPA9Kxr39ERnqwIoc2UJSAp5IoBA3dbxr68iA+juyP0=;
 b=PDcbotAid89Etg9Fg9947dggYua5DjxcBvPrZPMGShg6nWH1k7B+z+Mrp6W79N/TXZ
 UnLLe+wrhh6iYfqQKfD4PChwSdrWyDdnu5SFn3UTj/qsg/Bm2bjg2HZUSBk+rLdfPhtp
 eD9dWJKYk3UCuQzOSmGqWVxH3pMcZwMbM32R42L/T92gSu3WZ5fJF0ro9thGo7vKjyKO
 wwm1J3dphXnTv87tnliFrwxbs8XWvjEqMEEIztrPLonV04cMbACcpP321K9SWDcZf/sY
 dmWdrxJDw6DoOQajdrl3MvOCYBQfAkWqDrZSnMl/BH5/h0uPTWrGK1TbW5SUiKKlg6Kg
 6uwg==
X-Gm-Message-State: AGi0PubfRonDLwim+LggSn6pTZwlFhdF1tfD9B/zatkPdkOnQ6LxYuSy
 b4MDXHzPBdXVOqESsDyACMaLOOkB87NjkF1u5BM=
X-Google-Smtp-Source: APiQypJWKcOZwolIsn7a73yc4aMqWx+mk2KAdEK/HRRLB/AFX92WYN4FJ4pKWxX8TsolxV933sbSRmnXvsBuyeUoSoo=
X-Received: by 2002:a5d:84d4:: with SMTP id z20mr15044943ior.36.1588084601133; 
 Tue, 28 Apr 2020 07:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-8-peron.clem@gmail.com>
 <20200428081444.vddwswsorl5tf7yp@gilmour.lan>
In-Reply-To: <20200428081444.vddwswsorl5tf7yp@gilmour.lan>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Tue, 28 Apr 2020 16:36:30 +0200
Message-ID: <CAJiuCcf6xzB+HhV4GSOuawi3FJDeA4dvHXkKMV36+UF8gLLj7w@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
To: Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>,
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

Hi Maxime,

On Tue, 28 Apr 2020 at 10:14, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 26, 2020 at 12:41:15PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Add a simple-soundcard to link audio between HDMI and I2S.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 31 ++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index a5ee68388bd3..558fe63739cb 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -88,6 +88,24 @@
> >                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >       };
> >
> > +     sound_hdmi: sound {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,format =3D "i2s";
> > +             simple-audio-card,name =3D "allwinner-hdmi";
>
> It doesn't seem to be on purpose, but the name is different from the othe=
r
> series you sent.

Indeed, I have sent this serie before looking at the other.

I will change this to keep coherency, once we agree on the correct card nam=
e.

Thanks for the review,
Clement

>
> Maxime
