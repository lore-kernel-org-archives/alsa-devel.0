Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75341C3F2D2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00423246A2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gZj9gQyP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE1j9aFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00423246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 575D416DB;
	Fri, 28 Feb 2020 18:16:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 575D416DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582910257;
	bh=IDaZjLZxrZLRt50u+ZaYanMdErYZ7ar+lCyzISvKj2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZj9gQyPx9U/BZOj0Qou7Lzh52rHVABda9o6BLvGHxKRmen6FGpd+5CrVKN3YdyUk
	 l4vqT3sVGmuMY7GBgUNfvRHvAON/No+IOQtVRN022eqYVeWFB7dinNYb5itfu+9QSk
	 VKwsKqzm3VTNuL3ipWlkgaVAxnGK7zplxBh8DwWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8738F8014D;
	Fri, 28 Feb 2020 18:16:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 614CFF8014E; Fri, 28 Feb 2020 18:16:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87D64F80113
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 18:16:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87D64F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WE1j9aFo"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B29D246AF
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582910199;
 bh=IDaZjLZxrZLRt50u+ZaYanMdErYZ7ar+lCyzISvKj2o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WE1j9aFo5u71FkqhULMUZ32EgunKxjjLmN4sqCikQG6oKVcohm+HTAPry5CI+zK5I
 ouuZ7XMgikz00NqOGVlYGJ1Xht0xbn1dZ9zoT82jGq7PqpmfecBdPe13yK0sdNMryQ
 2YcPKNie2iqm/l26mqGO1+87yUwl/KY5kR3zrtCw=
Received: by mail-qk1-f171.google.com with SMTP id z19so3669495qkj.5
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 09:16:39 -0800 (PST)
X-Gm-Message-State: APjAAAWZxnQB2HGaqGmZrPX1bpSms1hHWYcoFbF/TVexm1VjWr4zrk3f
 CtV1i2DgL54B1SwyWMOBwmWxKkAWepUg7+DLJg==
X-Google-Smtp-Source: APXvYqwm/UEHV7zIm/RLE/ehDEw018Mzqy218BUmwoYZizs7XmEV5j7FEcuMv4eYBsp5fxF5wJIcJGeBjuznVZuuysk=
X-Received: by 2002:ae9:e711:: with SMTP id m17mr5272958qka.393.1582910198275; 
 Fri, 28 Feb 2020 09:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20200224145821.262873-1-jbrunet@baylibre.com>
 <20200224145821.262873-3-jbrunet@baylibre.com>
 <20200228155017.GA24730@bogus> <1jpndyejkn.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jpndyejkn.fsf@starbuckisacylon.baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2020 11:16:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+K=XHXmPbKrkO1_jnUO8sOyCM-XRpCmEX0+aWwBoBbVw@mail.gmail.com>
Message-ID: <CAL_Jsq+K=XHXmPbKrkO1_jnUO8sOyCM-XRpCmEX0+aWwBoBbVw@mail.gmail.com>
Subject: Re: [PATCH 2/9] ASoC: meson: convert axg tdm interface to schema
To: Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
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

On Fri, Feb 28, 2020 at 10:57 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Fri 28 Feb 2020 at 16:50, Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Feb 24, 2020 at 03:58:14PM +0100, Jerome Brunet wrote:
> >> Convert the DT binding documentation for the Amlogic tdm interface to
> >> schema.
> >>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
> >>  .../bindings/sound/amlogic,axg-tdm-iface.yaml | 57 +++++++++++++++++++
> >>  2 files changed, 57 insertions(+), 22 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
> >>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
> >> deleted file mode 100644
> >> index cabfb26a5f22..000000000000
> >> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
> >> +++ /dev/null
> >> @@ -1,22 +0,0 @@
> >> -* Amlogic Audio TDM Interfaces
> >> -
> >> -Required properties:
> >> -- compatible: 'amlogic,axg-tdm-iface'
> >> -- clocks: list of clock phandle, one for each entry clock-names.
> >> -- clock-names: should contain the following:
> >> -  * "sclk" : bit clock.
> >> -  * "lrclk": sample clock
> >> -  * "mclk" : master clock
> >> -         -> optional if the interface is in clock slave mode.
> >> -- #sound-dai-cells: must be 0.
> >> -
> >> -Example of TDM_A on the A113 SoC:
> >> -
> >> -tdmif_a: audio-controller@0 {
> >> -    compatible = "amlogic,axg-tdm-iface";
> >> -    #sound-dai-cells = <0>;
> >> -    clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
> >> -             <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> >> -             <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
> >> -    clock-names = "mclk", "sclk", "lrclk";
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> >> new file mode 100644
> >> index 000000000000..5f04f9cf30a0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> >> @@ -0,0 +1,57 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Amlogic Audio TDM Interfaces
> >> +
> >> +maintainers:
> >> +  - Jerome Brunet <jbrunet@baylibre.com>
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^audio-controller-.*"
> >> +
> >> +  "#sound-dai-cells":
> >> +    const: 0
> >> +
> >> +  compatible:
> >> +    items:
> >> +      - const: 'amlogic,axg-tdm-iface'
> >> +
> >> +  clocks:
> >> +    minItems: 2
> >> +    maxItems: 3
> >> +    items:
> >> +      - description: Bit clock
> >> +      - description: Sample clock
> >> +      - description: Master clock #optional
> >> +
> >> +  clock-names:
> >> +    minItems: 2
> >> +    maxItems: 3
> >> +    items:
> >> +      - const: sclk
> >> +      - const: lrclk
> >> +      - const: mclk
> >> +
> >> +required:
> >> +  - "#sound-dai-cells"
> >> +  - compatible
> >> +  - clocks
> >> +  - clock-names
> >
> > Add an:
> >
> > additionalProperties: false
>
> I did not put that on purpose.
> Most of the amlogic devices use an generic ASoC property called
> "sound-name-prefix"
>
> You may see examples of that in
> arch/arm64/boot/dts/amlogic/meson-axg.dtsi.
>
> That property is not expressed in json schema yet, and I don't
> really know what is the best way to add that.

Just assume it is (and I believe there's a patch I reviewed adding
it). Regardless, you still need to define what the strings are.

> Adding 'additionalProperties: false' right now would generate a fair
> amount of warning with 'make dtbs_check'

That's a good way to have a todo...

Rob
