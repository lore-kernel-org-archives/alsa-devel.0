Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D1C4332D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:51:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B958B2076E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OcQxMAYh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLazMcVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B958B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04636172F;
	Thu, 19 Mar 2020 00:50:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04636172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584575491;
	bh=qig1wOJ7IgBTZ7kXTk2gpe9JQRnJPM+buCwo1cSu+mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcQxMAYh5qeXnf+lurP9WlVJke+ks6mZfMJ3M8Xs6Pnjsh8PLMvS6sFEAxtaLFfLf
	 bABu4UBgxrtFi1MKRzCkpDYZBZASnvXJfut1cMO4JnfyfzixMlDtVPM8VT43u5K8iN
	 eoPMIsOPtksVVQFJjU//IwAx7VnZ5jHTba4OM82c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66D52F80132;
	Thu, 19 Mar 2020 00:50:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B3FDF80139; Thu, 19 Mar 2020 00:50:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1A9FF80058;
 Thu, 19 Mar 2020 00:50:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1A9FF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cLazMcVb"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E788920774;
 Wed, 18 Mar 2020 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584575430;
 bh=qig1wOJ7IgBTZ7kXTk2gpe9JQRnJPM+buCwo1cSu+mA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cLazMcVbX0OWV/lh16fimWRUd6291oIO/HK2kz1wmJ4/LN6IdsggqAO+W7egB78hU
 8Mrq85fS+WqwPTN3GH6FdGeaWIxq/B6yucDw7/gchrGZRBwlW7Ev4pTmC2qVEN9nUC
 kqqD58YMRbY1JkKpM6h8y0iLcYzcEiSnOJ+2VY08=
Received: by mail-qk1-f182.google.com with SMTP id j4so336349qkc.11;
 Wed, 18 Mar 2020 16:50:29 -0700 (PDT)
X-Gm-Message-State: ANhLgQ10s6MSoLaTUvv98JEjPptq76vuamcR8HWgOsuiwSoSWsSZS/3s
 NzLoKQF5aErQ6pp3N7jFvoFVKXYoiNT+5V+z8Q==
X-Google-Smtp-Source: ADFU+vsGgf3CiWdZiuk9hVpaRnFNqJkCyylwUsiB5EVfVsqRfIvJJ3ipMxAlOst4B0glkuDEqDWtIgLMddwWogY9zU8=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr464472qka.152.1584575428917; 
 Wed, 18 Mar 2020 16:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200306111353.12906-1-daniel.baluta@oss.nxp.com>
 <20200306111353.12906-2-daniel.baluta@oss.nxp.com>
 <20200312202306.GA18767@bogus>
 <CAEnQRZCLa+NAk=3M84MxjgOzYQdJXGY9S84dU6HO8GG64Lm_mQ@mail.gmail.com>
In-Reply-To: <CAEnQRZCLa+NAk=3M84MxjgOzYQdJXGY9S84dU6HO8GG64Lm_mQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Mar 2020 17:50:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNeiPc_isukXKt9wgwNS+kPDujx-Q24V1HJrUv0Fq77w@mail.gmail.com>
Message-ID: <CAL_JsqLNeiPc_isukXKt9wgwNS+kPDujx-Q24V1HJrUv0Fq77w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add FSL CPU DAI bindings
To: Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

On Mon, Mar 16, 2020 at 7:01 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Thanks Rob for review. See my comments inline:
>
> <snip>
>
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license new bindings please:
> >
> > (GPL-2.0-only OR BSD-2-Clause)
>
> Ok, will do.
>
> >
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/fsl,dai.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Generic CPU FSL DAI driver for resource management
> >
> > Bindings are for h/w devices, not drivers.
>
> Indeed. I think I will change it to something like this.
>
> title: 'FSL CPU DAI for resource management'
>
> The explanation are already in patch 2/2 of this series but let e
> explain again what I'm
> trying to do here and let me know if this makes sense to you.
>
> Digital Audio Interface device (DAI) are configured by the firmware
> running on the DSP. The only
> trouble we have is that we cannot easily handle 'resources' like:
> clocks, pinctrl, power domains from
> firmware.
>
> This is because our architecture is like this:
>
> M core [running System Controller Firmware]
>             |
>             |
> A core [Linux]<----> DSP core [SOF firmware]
>
> In theory, it is possible for DSP core to communicate with M core, but
> this needs a huge
> amount of work in order to make it work. We have this on our plans for
> the future,
> but we are now trying to do resource management from A core because
> the infrastructure is already in place.

When you change things in the future, Linux gets to keep supporting
both ways of doing things? I'd rather just support one way.

> So, the curent driver introduced in this series acts like a Generic
> resource driver for DAI device. We can
> have multiple types of DAIs but most of them need the same types of
> resources (clocks, pinctrl, pm) sof
> for this reason I made it generic.
>
>
> >
> > > +
> > > +maintainers:
> > > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > > +
> > > +description: |
> > > +  On platforms with a DSP we need to split the resource handling between
> > > +  Application Processor (AP) and DSP. On platforms where the DSP doesn't
> > > +  have an easy access to resources, the AP will take care of
> > > +  configuring them. Resources handled by this generic driver are: clocks,
> > > +  power domains, pinctrl.
> >
> > The DT should define a DSP node with resources that are part of the
> > DSP. What setup the AP has to do should be implied by the compatible
> > string and possibly what resources are described.
>
> We already have a DSP node: Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> but I thought that the resources attached to DAIs are separated from
> the resources
> attached to the DSP device.

I'd agree if the DAI was fully described in the DT.

> In the great scheme of ALSA we usually have things like this:
>
> FE         <----->       BE
>
> In the SOF world FE are defined by topology framework. Back ends are
> defined by the machine driver:
>
> On the BE side we have:
> - codec  -> this is the specific code
> - platform -> this is the DSP
> - cpu -> this is our Generic DAI device
>
> Now, I'm wondering if we can get rid of cpu here and make platform
> node (dsp) take care of every
> resource (this looks not natural).

I would think about how the DT will look when the DSP manages all
these resources itself and how the kernel drivers evolve. I think
perhaps if you can get rid of the DT part and just define the
resources in the driver, then the future transition would be easier.

> Perhaps Mark, Liam or Pierre can help me with this.
>
>
> >
> > Or maybe the audio portion of the DSP is a child node...
> >
> > > +
> > > +properties:
> > > +  '#sound-dai-cells':
> > > +    const: 0
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,esai-dai
> > > +      - fsl,sai-dai
> >
> > Not very specific. There's only 2 versions of the DSP and ways it is
> > integrated?
>
> As I said above this is not about the DSP, but about the Digital Audio
> Intraface. On i.MX
> NXP boards we have two types of DAIs: SAI and ESAI.
>
> <snip>
>
> > > +  pinctrl-0:
> > > +    description: Should specify pin control groups used for this controller.
> > > +
> > > +  pinctrl-names:
> > > +    const: default
> >
> > pinctrl properties are implicitly allowed an don't have to be listed
> > here.
>
> Great.
>
> >
> > > +
> > > +  power-domains:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> >
> > Don't need a type.
> >
> > > +    description:
> > > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > > +      PM domain provider.
> >
> > Don't need to re-define common properties.
> >
> > You do need to say how many power domains (maxItems: 1?).
>
> We support multiple power domains, so technically there is no upper
> limit. What should I put here in this case?

There's an upper limit in the h/w so there should be some sort of limit.


> > > +  fsl,dai-index:
> > > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > > +    description: Physical DAI index, must match the index from topology file
> >
> > Sorry, we don't do indexes in DT.
> >
> > What's a topology file?
>
> Topology files are binary blobs that contain the description of an
> audio pipeline. They are built
> are written in a specific format and compiled with alsa-tplg tools in userspace.
>
> Then loaded via firmware interface inside the kernel.

Sounds like a kernel-userspace issue that has nothing to do with DT.
How do other platforms deal with mulitple DAIs?

Rob
