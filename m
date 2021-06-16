Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB48C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:39:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1814610A1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1814610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74123173B;
	Thu, 17 Jun 2021 16:39:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74123173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623940793;
	bh=V/6H0Lv40Xk43XmUp0RaX/eF6Wme6v3BP1cMMkdbnEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ql1GTmBiCZ7cSVhVtIFvwgldnsGQgCt1jhQg9NBv9FGknW60IdEWJKOV/0HZgbhxr
	 qMrOdIIFILvxJDVANx2gZ2twkWprGRcvZJ7cGZRqgC6qL26jmYceG03IjL12Q70BHK
	 T9sizadHBsawLF8+9AOjFwEYklAeN5f5FKZ84/ww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1EFF80517;
	Thu, 17 Jun 2021 16:34:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A882FF80423; Wed, 16 Jun 2021 12:56:50 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65E58F80148
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 12:56:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65E58F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Zhj8UEuY"
Received: by mail-pj1-x102c.google.com with SMTP id
 mj8-20020a17090b3688b029016ee34fc1b3so1556003pjb.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HuLGw9v7JLauPhtnxWS8KYadx9N1A/H3l9fDM2qNdFs=;
 b=Zhj8UEuYrb4byhhy4fvAXLyIcmOOFNXknm7PP8rsag6hkDRyQUHz2glSE9P47Ax/o8
 2x6T4LwzcY9FMCJt9+/ZIMwszYNdgg53J30WeeWvWMf3yA7rrzPaoSXcZ0pEDUNMPQIH
 uPYFMbPHjYNjzKlHTDGbC6HGv96cokWjzplROekLytbWjppWC9KJnRFEZI8Y2a49AQoX
 vJWVAQj9bplLUyd8X1E9rAzy9zil8Ke0Lb7Y5Y8UtCkQ1uJD0VvN6hlbWroddcoM3PVn
 UBYR1nXZQAagH8XFLPrxMHoctTJ8Y76+0UIT68BeR0Nk36MVaOzawLd+4yL73vyIez4Q
 1rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HuLGw9v7JLauPhtnxWS8KYadx9N1A/H3l9fDM2qNdFs=;
 b=GS6sadx55mjdRKpj1TqYgu+IWj4MiRopqChE3Pz22zuMD4DvfGD/+c39pnJ7oVOO3n
 QQU1dAG4Iztp65Cs5lUF2LJIXfuWtZTUHZ4p4B7Irf6AuSQh6uqBqlZkT5p5204PDf5X
 WuE6e1oYgOM0X8QNJWtNvvnT3u6Kq2TgW08ZCJ+NqskR8djJruIiM9Z6J7n6d+zqTu1b
 2KKqvj1aBPRFQV4oC32aAeH91HPNF30hKyioCXAzTvn19Nt0VbX9V1273otsbE/J/I0a
 n2PXs9lhPijvy/HgsiXv7Wk+1VPkDxlHeGMWY65wVH1sNlzTXO7qIFKwVm4AJpzXs+Bw
 vOzQ==
X-Gm-Message-State: AOAM533QsHAoyctzj3tQOK22N5W0wHzDamYYaiDb41r+lhjP/n4JOKB7
 Vy6HfFJsn7JERne79HCVkkeEVxCQMP1tBUanOA==
X-Google-Smtp-Source: ABdhPJxTheKUcJqyRfJvtawPTMCjeDGxyzMx7Xo/qrwPj+nkXyk+JqpYYCZmLzAA+Kf7pa2yv3lgVepdJoP3repgnkw=
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr4447446pjq.156.1623840996957; 
 Wed, 16 Jun 2021 03:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130737.2098-1-fengzheng923@gmail.com>
 <20210616084920.y6yjic4sau6ungv5@gilmour>
In-Reply-To: <20210616084920.y6yjic4sau6ungv5@gilmour>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Wed, 16 Jun 2021 18:56:25 +0800
Message-ID: <CAE=m619_52DDC_up=QqRXkF88uJR6CcAJqentnBzb=pxL7LhxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for
 DMIC controller
To: Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Jun 2021 16:34:45 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, wens@csie.org, broonie@kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

Hi,

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B46=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Jun 15, 2021 at 09:07:37PM +0800, Ban Tao wrote:
> > The Allwinner SoCs feature an I2S controller across multiple SoC
> > generations.
>
> Which SoC generations?
>
> > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> > ---
> >  .../sound/allwinner,sun50i-h6-dmic.yaml       | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,s=
un50i-h6-dmic.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h=
6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-d=
mic.yaml
> > new file mode 100644
> > index 000000000000..81d40c374e44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.=
yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner H6 DMIC Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Ban Tao <fengzheng923@gmail.com>
> > +
> > +properties:
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    const: allwinner,sun50i-h6-dmic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: dmic
>
> The convention we use is bus and mod
>
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    const: rx
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - "#sound-dai-cells"
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - dmas
> > +  - dma-names
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spdif: spdif@5095000 {
>
> The label and node name seems wrong?
>
Yes, in fact, I don=E2=80=99t know much about yaml format files.
The allwinner,sun50i-h6-dmic.yaml file is based on
allwinner,sun4i-a10-spdif.yaml.
So, How do i convert txt file to yaml file, for example:
---------------------------------------------
Required properties:

  - compatible         : should be one of the following:
    - "allwinner,sun50i-h6-dmic": for the Allwinner H6 SoC

  - reg                        : physical base address of the
controller and length of memory mapped region.

  - dmas               : Generic dma devicetree binding as described in
                         Documentation/devicetree/bindings/dma/dma.txt.

  - dma-names          : DMA have to be defined, "rx".

  - clocks             : Contains an entry for each entry in clock-names.

  - clock-names                : Includes the following entries:
       "apb"             clock for the dmic bus.
       "dmic"           clock for dmic controller.

  - resets             : reset specifier for the ahb reset

Example:

dmic: dmic@5095000 {
        #sound-dai-cells =3D <0>;
        compatible =3D "allwinner,sun50i-h6-dmic";
        reg =3D <0x05095000 0x400>;
        clocks =3D <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
        clock-names =3D "apb", "dmic";
        dmas =3D <&dma 7>;
        dma-names =3D "rx";
        resets =3D <&ccu RST_BUS_DMIC>;
};
---------------------------------------------

Thanks.


> > +        #sound-dai-cells =3D <0>;
> > +        compatible =3D "allwinner,sun50i-h6-dmic";
> > +        reg =3D <0x05095000 0x400>;
> > +        clocks =3D <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
>
> You'll need includes for it to compile
>
> Maxime
