Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A88C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 15:38:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6C2A244E;
	Wed, 22 Jun 2022 17:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6C2A244E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655912302;
	bh=McrNGXsV5fP0fs1TqHyRxes4J9rn7QK0SaHou7Xu+p8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEtG0kPrQTUrQN7KOjxAJDWHLEdd+hwUFu5AxkpIPcOlzjx1bUEmHfe+bUu0Hz80h
	 9aeEtsM9WTuhO4YY7gIeLmZANfNE7TdPXXObvXjnRBkGdE/AK8F13N+9VwdaygmtS4
	 OYNOPKOBqhq+h+v3R9yHMASsgxhX1j9M5wPMPa0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6980F806E8;
	Wed, 22 Jun 2022 17:24:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 286DEF80155; Tue, 21 Jun 2022 09:04:29 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EAC2F80104
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 09:03:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EAC2F80104
Received: by mail-qk1-f182.google.com with SMTP id 15so9392606qki.6
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 00:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ezwPnqEAb9XxkVE6EHdU5akaM6B3QfniuvIAXM1ujs=;
 b=AqYss1YGxkuk8fEaAv6IF7Lt+h0R4U+6yzHA5NFBzc9NxU7SYcxFagGxZFYwETNvGP
 mYkR+MeMRJe1ZDS1oj7Abs4e9I8t9Z3tltZElMFBDEclX0XqXTyp+P8rPF0PDJyMWV1u
 VopEDQCgMaZzJJSdBHqHSNWP2yEWLS9l01+8Mpd4xB6vvENYB0PC9mGN3wOpUR+0yk40
 oIROYiDT7wMPiVeF3EKIV37dZdWqSrVxii48Vg1LnNQ9dVx+FiIFG3gFHFV/AwI/Y7h8
 CDz+i6F+kqWTDopagCc/KonsZsVN4VcxopfkmtwaM7N5McsV+jRKXVXLa1zR5JxyIXdk
 r2Ug==
X-Gm-Message-State: AJIora9EGaSxgcqWeMcEgLnMENQbkJnD0lIoksixUTlWuprJ5n545tig
 pqdZeOdo1DQIzc3XABdVohklv4M8ek+vyA==
X-Google-Smtp-Source: AGRyM1t/iORZhSVUchw4EBHHI4pS7ItTqb3pcZzCzVBt4N70XGNWufiSzSj56d0b/65xCS25xvZWJA==
X-Received: by 2002:ae9:e316:0:b0:6a7:7d6:1300 with SMTP id
 v22-20020ae9e316000000b006a707d61300mr18727567qkf.505.1655795018789; 
 Tue, 21 Jun 2022 00:03:38 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com.
 [209.85.219.182]) by smtp.gmail.com with ESMTPSA id
 d8-20020ac85d88000000b00304edcfa109sm12804469qtx.33.2022.06.21.00.03.37
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jun 2022 00:03:37 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i7so5239631ybe.11
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 00:03:37 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr30754158ybh.36.1655795017074; Tue, 21
 Jun 2022 00:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
In-Reply-To: <20220620205654.g7fyipwytbww5757@mobilestation>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Jun 2022 09:03:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
Message-ID: <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
To: Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Jun 2022 17:23:19 +0200
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 David Airlie <airlied@linux.ie>, Palmer Dabbelt <palmer@rivosinc.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Jose Abreu <joabreu@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Mark Brown <broonie@kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <mail@conchuod.ie>,
 Thomas Gleixner <tglx@linutronix.de>, Dillon Min <dillon.minfei@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Heng Sia <jee.heng.sia@intel.com>,
 linux-spi <linux-spi@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Vetter <daniel@ffwll.ch>, dmaengine <dmaengine@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>
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

Hi Serge,

On Mon, Jun 20, 2022 at 10:56 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
> > width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
> > this.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
> >  1 file changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index e25d44c218f2..f2b9e3f062cd 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -135,19 +135,41 @@ properties:
> >        of the designware controller, and the upper limit is also subject to
> >        controller configuration.
> >
> > -patternProperties:
> > -  "^.*@[0-9a-f]+$":
> > -    type: object
> > -    properties:
> > -      reg:
> > -        minimum: 0
> > -        maximum: 3
> > -
> > -      spi-rx-bus-width:
> > -        const: 1
> > -
> > -      spi-tx-bus-width:
> > -        const: 1
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: snps,dwc-ssi-1.01a
> > +
> > +then:
> > +  patternProperties:
> > +    "^.*@[0-9a-f]+$":
> > +      type: object
> > +      properties:
> > +        reg:
> > +          minimum: 0
> > +          maximum: 3
> > +
> > +        spi-rx-bus-width:
> > +          const: 4
> > +
> > +        spi-tx-bus-width:
> > +          const: 4
> > +
> > +else:
> > +  patternProperties:
> > +    "^.*@[0-9a-f]+$":
> > +      type: object
> > +      properties:
> > +        reg:
> > +          minimum: 0
> > +          maximum: 3
> > +
> > +        spi-rx-bus-width:
> > +          const: 1
> > +
> > +        spi-tx-bus-width:
> > +          const: 1
>
> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> irrespective from the compatible string. The modern DW APB SSI
> controllers of v.4.* and newer also support the enhanced SPI Modes too
> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
> run-time there is no way to create a DT-schema correctly constraining
> the Rx/Tx SPI bus widths. So let's keep the
> compatible-string-independent "patternProperties" here but just extend
> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
> properties values.
>
> Note the DW APB SSI/AHB SSI driver currently doesn't support the
> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
> activated by means of the corresponding CSR. So most likely the DW AHB
> SSI controllers need some specific setups too.

That doesn't matter here, as DT describes hardware, not software
limitations.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
