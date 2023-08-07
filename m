Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E092C04A6A
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 13:09:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40D75843;
	Mon,  7 Aug 2023 15:08:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40D75843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691413787;
	bh=YN5TMkTY0ygg4jFnAPE5f0kWVzSNcpz9+iRD79bC3Z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UhQBMovYhtUYEeho4ElBQU05QeU34OiPDqxAr8oso3YkK6wQ83kjUQGum6NXG0Rmy
	 1sbo6WCZ3wo+K2ToCScBrGT4v0MiCVSvv2tcjYfHOTs5ssye14p13b2EecFEIlSFBX
	 34e4uidDZT6UIi99UYcL3WbYc0ythHmfXeja2JQ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1C31F80557; Mon,  7 Aug 2023 15:08:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F3BAF80551;
	Mon,  7 Aug 2023 15:08:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DD37F8016D; Mon,  7 Aug 2023 15:07:01 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08455F8016A
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 15:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08455F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xpSCvUoQ
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so2842246276.2
        for <alsa-devel@alsa-project.org>;
 Mon, 07 Aug 2023 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413613; x=1692018413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN5TMkTY0ygg4jFnAPE5f0kWVzSNcpz9+iRD79bC3Z8=;
        b=xpSCvUoQbw1tjxn+0pZ6cSy2bPnR/cI/N5v1Xa8IkA31SVzn/S+g0e9pWhC2z1ew5h
         oU+JROfYYJZovhf186MJRP0DNrRNrtrBKPxMbRVGMSwQNFUZUm1h2qHsVrIZ/9OJIv9C
         fvgBVwcUpM2siwYe6A84FoyH8wuJBQVrP09+Zo6NBG9tl9SnLf1wNV0xx7hmw5RePlMs
         qwKSXeFlTsIy//gg+MU4nPzw9JfVuTmRxNIn+vTPB3YG30SvjpzU70gSB20XUwlCptb6
         LFbcqdFnalTPgXLGlG/1iJcEwt4cYFbpKf1ws5droSP7fBmcsG3P5llSCwvsY/eQIsiV
         maoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413613; x=1692018413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN5TMkTY0ygg4jFnAPE5f0kWVzSNcpz9+iRD79bC3Z8=;
        b=WWKEyHrjfQKr1M7IC1uzWsO+ati7bMlsZxaMnQ85BDIABxp9nSBYpyyaCGYoYopLpX
         Cj2O9HKWL1mBjRY+Jb0V5I92N3hJDNlFLytKWHPqY/Aft66dnerOszFRrYFyIAQ4Fve8
         jQuiwNU5K9B9DjDAng1P6Bn/ZnQei5ygGXviL8CdSHZJIFpfgw//94l1gC8hJkRPw6Lq
         8bek+wYk57n0kk+xicm1SltPFW6hTtpbB5HSTveflqGCpYjF56MXB1QRUCwqOMw1Y2Z9
         kyXlDjRuoZ2B1aHg7PmPN74cqs7k1Nvuot7nzQMQaMP1nW/O6uQFV/kgRCHqxsroxWTs
         bhCg==
X-Gm-Message-State: AOJu0Yys7ZnSeBU+ytZS8i960WHomYxLFMSnTEJnnZokN0ZX0PCb0+VA
	836e40Scyv+aeHFS3VbwTLC2TAwz+p2OGdDECIRw9w==
X-Google-Smtp-Source: 
 AGHT+IEMKCq/m3/N1+FiikwFsnDje8GRItyWdNDJE1nuhiz2PrdZl+YFSqKhB6L6a9fy66xvdbZfHLOx9hNasWI6TVw=
X-Received: by 2002:a05:6902:4f4:b0:d09:85d3:4edb with SMTP id
 w20-20020a05690204f400b00d0985d34edbmr8822226ybs.7.1691413613049; Mon, 07 Aug
 2023 06:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com>
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
In-Reply-To: 
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 15:06:42 +0200
Message-ID: 
 <CACRpkdZebvrdGXooLXmgXhUcgdgxBczJBpdEoEyJDR39abaAqQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256
 pinmux
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: GLZKA4TO6IB7KCIR26JFA32YHUKTQEKJ
X-Message-ID-Hash: GLZKA4TO6IB7KCIR26JFA32YHUKTQEKJ
X-MailFrom: linus.walleij@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Aug 7, 2023 at 3:05=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:

> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>
> So it is a bridge chip? Please use that terminology since Linux
> DRM often talks about bridges.

Replying to self: no it's not a bridge, it's a WAN thingy.

So perhaps write that this is a WAN interface adapter chip.

Yours,
Linus Walleij
