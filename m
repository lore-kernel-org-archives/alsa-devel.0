Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50F7C001B0
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 13:09:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E70782B;
	Mon,  7 Aug 2023 15:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E70782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691413764;
	bh=bhI9PIqsdmyp0v4Pl4wvCmRf8rEnEQ5xyQfGlic6uiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZTqK/UVCBXWXbZdyfITINFPmhxbFxYsQkIf8B6tiw5r5621bLHKhWekyxWVF1EHdV
	 mzdGq6XC6+8vIrZ7BIxacnGziSt3Nev8Est/29D8ymJUOnLTXU8L++Xo7ZmiCnUbZB
	 zp2001yAhMJUcIYCdicjgVKtmfkkdRbWHv6lUgqQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E79CEF8016B; Mon,  7 Aug 2023 15:08:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ABD0F8016D;
	Mon,  7 Aug 2023 15:08:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7CCBF8016D; Mon,  7 Aug 2023 15:05:37 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A40C8F80116
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 15:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A40C8F80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ut8sOt7l
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d05a63946e0so4584025276.1
        for <alsa-devel@alsa-project.org>;
 Mon, 07 Aug 2023 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413526; x=1692018326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCHsXc+lT27JE6Z6+8ylge5LujDr0uIa0UFtHeUGk2Y=;
        b=Ut8sOt7lpFeoV7uC5nic5YMi0GUeC8HpWsn9X2ZvHUqogbJC59sug1OCXgBIO45szT
         zu/yDK65dLYqv6f+km1qpewpLLAyHgB83sO8QJplPf6Hb+zQxEgpYnezxw31ErxCfwYd
         DG1K/BD7UexEi2CLbm33TPIAEV+JP9uckCAnXOKFdFxQCTLDT9vDW0yo5WN6ssAjMwB6
         jQausBUtY12YsJG/lvlFmGhmKUqnRUZYXZJAg6WdrWcdht+kmstTdnIijp5oZIEpsXDt
         nq9gS+ZIoUWmVgbHZ6Clm4PxrSxeiApl2AxIg5A46SblXoW3BcU9kQkBbE2yZj77FvnD
         FVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413526; x=1692018326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCHsXc+lT27JE6Z6+8ylge5LujDr0uIa0UFtHeUGk2Y=;
        b=OlBBm3dZCVjdjCpbQOZP3OTxoIfIIFk8gJZI6pwuhX/4PDNonaKdns5ZO9qo7TLR4T
         yVRPMB6wrfW2tLvmdW6T9s7h/U+LdRbx11u+2Zt+tXOATyhNf4H/4HAsk4qQoZ9gnbmb
         EI6Gz9GUVrQq8mSiGH/m5hnxB721GFNV7+1gLZVdIILnoYA/cV9rDcIBCre0XdqiPu2z
         46RLoFbAbfY4Jxj8xAA3+OY+v9DLsBZ4tLd5jsgJi2jnNTvDPgtwgL+hSgEQ5yK7wodZ
         /UEMG8NOtxPmgNcFBj9RMPWtFzA1JXX0DkWKnC/LlgRG+Mgr+PoXnLL2nXdjLo7LQJPL
         7WrQ==
X-Gm-Message-State: AOJu0Yyh357U+7xmVz4WY9Wki640DDKM2u/3bMJU5Ao/+BBYUQ7IfsoH
	xBn35GdLArA/kvejP7GS/tMozgLXWPp1nsKEVSpxDg==
X-Google-Smtp-Source: 
 AGHT+IGLxVHYBN4YJi+z5+HalzYdVADQ/IRYzWidcu2Ji/atGqIFAXQgU8cOxoHK1pmjGmBx4BMj8ebAiBn6KY0iG4o=
X-Received: by 2002:a5b:5cf:0:b0:c39:9e09:2c71 with SMTP id
 w15-20020a5b05cf000000b00c399e092c71mr8293260ybp.41.1691413526341; Mon, 07
 Aug 2023 06:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com>
In-Reply-To: <20230726150225.483464-25-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 15:05:15 +0200
Message-ID: 
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
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
Message-ID-Hash: RBVTFHXXKTF53KSS6QKCMKBYO3FVKBPZ
X-Message-ID-Hash: RBVTFHXXKTF53KSS6QKCMKBYO3FVKBPZ
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

Hi Herve,

thanks for your patch!

First: is this patch something we could merge separately? I don't see
any dependency on the other patches.

On Wed, Jul 26, 2023 at 5:04=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> This pinmux support handles the pin muxing part (pins RP(A..D) and pins
> XP(A..D)) of the PEF2256.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

So it is a bridge chip? Please use that terminology since Linux
DRM often talks about bridges.

> +++ b/drivers/pinctrl/pinctrl-pef2256-regs.h
(...)
> +#include "linux/bitfield.h"

Really? I don't think there is such a file there.

Do you mean <linux/bitfield.h> and does this even compile?

> diff --git a/drivers/pinctrl/pinctrl-pef2256.c b/drivers/pinctrl/pinctrl-=
pef2256.c
(...)
> +struct pef2256_pinctrl {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       enum pef2256_version version;
> +       struct {
> +               struct pinctrl_desc pctrl_desc;
> +               const struct pef2256_function_desc *functions;
> +               unsigned int nfunctions;
> +       } pinctrl;

Uh anonymous struct... can't you just define the struct separately
with a name? Or fold it into struct pef2256_pinctrl without the
additional struct? Thanks.

Otherwise it looks neat!

Yours,
Linus Walleij
