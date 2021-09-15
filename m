Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72298C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:05:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23AA61247
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 12:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B23AA61247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EC6D181D;
	Wed, 15 Sep 2021 14:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EC6D181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631707503;
	bh=OWv7wCHAI//doQN8unJx0lRwtqpxd06uLs1WI6LWje0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9+26bpC1EP/PnsDv7X17unpLF+ZPv9BxvYhQDRriEJ5vJyZ+iG9nAjK9ozuflFwz
	 YfZi8XzfRTP9wt9G9t71aURwTnkgZKbukVT5kXXsGkZgLapN4emYxtL38MXgpkjxrI
	 xuiNVv5C2yttNNJgKmwlt32aC1xlI1I/wS5tIFIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D893F80227;
	Wed, 15 Sep 2021 14:04:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 197A7F8027C; Wed, 15 Sep 2021 14:04:12 +0200 (CEST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06773F800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 14:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06773F800EF
Received: by mail-vs1-f54.google.com with SMTP id p24so2556307vsg.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V7RMs5jGTFlhcvPGA0e1hDyrGY0ltbNUmDTaYFkP2PQ=;
 b=pJAcMC0tEbuMO7w7iK+TFdnYQz9hiaqzDqeTGfRDjqtjVTu43nmnZJRKFPKbVJF1TB
 KOzH5q+/AMD3Cgy+emUuswto+9OMiM0XhoapaY40xV5hFVHqJqcfXUL7WUoRWX7dYPS2
 kCe0a0NQOHe8dtwl2zJm5xBfMvL8QSRby5/St3DGUCh80G2iLVUCp/2SHjIUFx5EAPR1
 RJRNvtGTDqqbgMPrLhSY072IjNR20D6m9SmwgH0rMW/HpbxtF/n7RJgNTg513PZrEnvA
 +5inYaTIvNYVyXMGzSpi6YDsoikAoVJRnnPvxyLo2Hn5cwCk8Egd1lh1BsKQbWUu2j17
 5CKg==
X-Gm-Message-State: AOAM531DgPL7h1wEcdaDfUFagQKtSi8j6axOuK5l4JUjeT5upIUgqHdg
 WV2NB2qPxfU52DzqNMZYEO+xK+jAMU7dFSUUe38=
X-Google-Smtp-Source: ABdhPJwSSITFeO5bz1TDyTKf4Yo83/snpgk9r8c4pbnv7rl0it5La4y9XsWcpzM56ZSFV2DDynuhRmpZvBZ8JjUNNJg=
X-Received: by 2002:a05:6102:3112:: with SMTP id
 e18mr2846306vsh.50.1631707439508; 
 Wed, 15 Sep 2021 05:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210911004546.2139657-1-drhodes@opensource.cirrus.com>
 <20210911004546.2139657-3-drhodes@opensource.cirrus.com>
 <1631535523.185638.444716.nullmailer@robh.at.kernel.org>
In-Reply-To: <1631535523.185638.444716.nullmailer@robh.at.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Sep 2021 14:03:48 +0200
Message-ID: <CAMuHMdXvJju4SKreS8c2X47ew+8zshwxbhnJetyLLbGTo8tD5w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ASoC: cs35l41: Add bindings for CS35L41
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: David Rhodes <drhodes@opensource.cirrus.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, brian.austin@cirrus.com,
 ckeepax@opensource.cirrus.com,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 david.rhodes@cirrus.com
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

On Mon, Sep 13, 2021 at 2:20 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, 10 Sep 2021 19:45:46 -0500, David Rhodes wrote:
> > Devicetree binding documentation for CS35L41 driver
> >
> > CS35L41 is a 11-V Boosted Mono Class D Amplifier with
> > DSP Speaker Protection and Equalization
> >
> > Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> > ---
> >  .../devicetree/bindings/sound/cs35l41.yaml    | 151 ++++++++++++++++++
> >  1 file changed, 151 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/sound/cs35l41.yaml:151:9: [error] no new line character at the end of file (new-line-at-end-of-file)
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.yaml: 'additionalProperties' is a required property
>         hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
>         from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.yaml: ignoring, error in schema:
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/cs35l41.yaml
> Documentation/devicetree/bindings/sound/cs35l41.example.dts:21.11-21: Warning (reg_format): /example-0/cs35l41@2:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: example-0: cs35l41@2:reg:0: [2] is too short
>         From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml:0:0: /example-0/cs35l41@2: failed to match any schema with compatible: ['cirrus,cs35l41']

This is now commit 8d7ab8800184cc75 ("ASoC: cs35l41: Add bindings for
CS35L41") in broonie/sound#for-next, breaking "make dt_binding_check".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
