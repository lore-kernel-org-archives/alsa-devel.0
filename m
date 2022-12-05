Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A32C4321E
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 08:01:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA2ED173A;
	Mon,  5 Dec 2022 09:00:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA2ED173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670227299;
	bh=qjwZMQ9bvKUGdiCWKz3bxckuPmQkhoNp2kuA6/O9/IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QypyEI/Uki5HuDuyyXs1BHZkwj/RWte0i9Eweyt67s9X6St+Mh7SlTQNjBGqqlvdK
	 ++ga7YXsp6KissaqfFJ4iknhl89T8BzMp0pQJ4a4AYQ47kRHXuQiBuX1FsUE5mNgK8
	 sj7nZBvKjiZdFFmNhps6vFrDaByoZaf5pTC4fmas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D6E6F80171;
	Mon,  5 Dec 2022 09:00:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D141F80236; Mon,  5 Dec 2022 09:00:48 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1E94F80155
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 09:00:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1E94F80155
Received: by mail-qk1-f169.google.com with SMTP id k2so4366310qkk.7
 for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2022 00:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=me207DjYqa1mkCSQToax0L6y51smuqPSYa6gnZpD/eg=;
 b=Oy1SD10EuHfLyZyq55JS5nsOgYSbcwElzV6xy5fhd7Fxa3CzV47HedeL2uyg587iQg
 lu2B14Eg8i/5BGTP5O4HfFC65yEPSewxSrH34854woxKavWMzBaLurqKwjoh0khveZBN
 K5KXpnnySn2lF9rMz8sscav6Zlk6OWmUvDVHfzBEuGC4UkELu1EOX0TJhPvD2pxwm9rs
 OBSgb1YDrOAey/HdLNIew7+qFvl9C8VJ2SFVOTc1hFEnKb/150Oi2f/6v8uzIKTo3e/+
 Rw2WY4ZQMbrCaGcOeE8aaCFKM4xF536ybxr2EE+iLQwHcDn8WVyVTop49TpHyAIDoRqc
 4PEw==
X-Gm-Message-State: ANoB5pl0LAuLWYurDO3qVHADQcduKg9EmuPDcrsjLOeIyInpGcNb+Kbg
 TnKY3CMeRBtXsz7ssPrGdG6D8e2M2xsmsg==
X-Google-Smtp-Source: AA0mqf5nhUX9B+3RR1LXjnnmFsSRJC9QUbnTZ6JlDj6kFbTuphamZ79bt2RxZ/+RDllrmRlDZbEDyg==
X-Received: by 2002:a37:ac11:0:b0:6fa:546e:52c2 with SMTP id
 e17-20020a37ac11000000b006fa546e52c2mr71699722qkm.382.1670227239095; 
 Mon, 05 Dec 2022 00:00:39 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a05620a179200b006ef1a8f1b81sm11831480qkb.5.2022.12.05.00.00.38
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 00:00:38 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id i186so1310356ybc.9
 for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2022 00:00:38 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr51193068ybc.543.1670227237838; Mon, 05
 Dec 2022 00:00:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669980383.git.geert+renesas@glider.be>
 <9f2a2474ec71dcc2a76e868295202a8c425a5d41.1669980383.git.geert+renesas@glider.be>
 <b105572c-96fe-dbad-c435-43233cfb25a7@linaro.org>
In-Reply-To: <b105572c-96fe-dbad-c435-43233cfb25a7@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Dec 2022 09:00:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXG39BoMScDpH_Cxc-BXBKZHxyQqe6MJMEhnerN3yU6Uw@mail.gmail.com>
Message-ID: <CAMuHMdXG39BoMScDpH_Cxc-BXBKZHxyQqe6MJMEhnerN3yU6Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: ti,
 pcm3168a: Convert to json-schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Damien Horsley <Damien.Horsley@imgtec.com>, linux-renesas-soc@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

Hi Krzysztof,

Thanks for your comments!

On Sat, Dec 3, 2022 at 1:13 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 02/12/2022 13:55, Geert Uytterhoeven wrote:
> > Convert the Texas Instruments PCM3168A Audio Codec Device Tree binding
> > documentation to json-schema.
> >
> > Add missing properties.
> > Drop unneeded pinctrl properties from example.
>
> Thank you for your patch. There is something to discuss/improve.
>
> > +description:
> > +  The Texas Instruments PCM3168A is a 24-bit Multi-channel Audio CODEC with
> > +  96/192kHz sampling rate, supporting both SPI and I2C bus access.
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,pcm3168a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: System clock input
> > +
> > +  clock-names:
> > +    items:
> > +      - const: scki
> > +
> > +  reset-gpios:
> > +    items:
> > +      - description: |
> > +          GPIO line connected to the active-low RST pin of the codec.
> > +            RST = low: device power-down
> > +            RST = high: device is enabled
> > +
> > +  "#sound-dai-cells":
> > +    enum: [0, 1]
>
> This is a bit unexpected. Looking at DTSes:
> 1. I see in ulcb-kf.dtsi with cells==0, but two endpoints. The dai cells
> seem unused? In such case shall dai-cells be skipped if we have endpoints?
>
> 2. in k3-j721e-common-proc-board.dts has cells=1, but user's phandle
> does not have an argument, so practically it is ==0? The user -
> sound/soc/ti/j721e-evm.c - just gets the node and does not use cells,
> right? So even though dai-cells==1, it does not matter, because user
> gets its own parsing?
>
> 3. The pcm3168a driver also does not have any xlate function, but it
> registers to DAIs, so all uses should be with cells==1 to select proper
> DAI...

I have no idea (DAI is magic to me), and hope the audio experts
can provide some input...
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
