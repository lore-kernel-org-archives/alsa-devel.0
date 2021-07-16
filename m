Return-Path: <SRS0=MRBS=MI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002CFC07E95
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 14:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878F4613F8
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 14:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F4613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98D1B1687;
	Fri, 16 Jul 2021 16:25:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98D1B1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626445602;
	bh=bzLRhUxncNIVhd0+XliEC+q+npcpHoosd7cK3T7Jj3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WiYV0sl5isb1Vh0eMBCZ+o33W8l0QTrzXWaHAcrHYjq+6Ny18WdZaIwfta1GFnDit
	 twdqTlguc/7P/Bum0JxuT1vI5KJzo8rWSTCLExSWywsq/MnpZU9AyUVjuj7yEwU7IA
	 Pjt61nRKwhEOf8SVbHTULvcKPEASTAUWcn42cw54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 358C5F80253;
	Fri, 16 Jul 2021 16:25:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 066CEF80254; Fri, 16 Jul 2021 16:25:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 154D0F800FE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 16:25:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 154D0F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nmniNX+a"
Received: by mail-wr1-x434.google.com with SMTP id t5so12292703wrw.12
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WVnjG/+uXUwA1TsIYDH7nvmxJ4xBCgnrB5THQ+2D+qg=;
 b=nmniNX+atXPU7ho+t8GwMmFltwGS6Ihpv2UTWVKOtddmqzb7KVIOt0xTam4FS1XSMM
 4coBRSmzO0gVWrjsCvLDeWpNbLD+COBo/f6MxkgpftEk8OiPodreZ1Svpt6lMpMFN84n
 5ll8HRM+lvOZoZ4XfwXh51iPVNR/ygA3IkAR/NxaJ6qIZij3JaMoxGmw5iy4HNC0ViO9
 NILUBLNTOywJ0uaak0kAhzmp99UOk10AvZ1ICAx5rxBvafEIvNVW9Ba+x3b15QRlsi1/
 b+joNyvYxUdx+Gi0zanLEoY10tuefxGXb7vpCdTHBLIi+V0e7q+sLaH4Ul3N2wa8SZDQ
 BimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WVnjG/+uXUwA1TsIYDH7nvmxJ4xBCgnrB5THQ+2D+qg=;
 b=HP2O1epT+Me8SFAcCGxLGQwiHtfC2L/4YPOf+hcDkpFk1AnqYj/QuJoP06DyuaJ6EN
 3u4iIW2tjnDfgecSzs1y9gbyIH7z3poUvY464SAXMS5GNb9PWY2mKYGkqNwTZ+zQfYx/
 MPdvM49fQxPwX9ZJuW4LbLBkLg6r8YxYL+8xKrthOnWUUrFP+3GajW4vTGQ3hj0uMiSx
 VexjLp6xk4hwIeru+iUqQMjY4swlZDEJAjdlCwa8TWdcLS1uixqXiYH3KQvFsLR7cnAi
 n8KQ371tWkInt/wPGQcm2s2c9rfVrXYn7YC8bChogODnbHZP1EosO2K7ZLlOc7hT8huc
 9suA==
X-Gm-Message-State: AOAM531RN2wd/RD4+GJXRn3yRUUJ95WuYywSNRdtIRewng+Rr6TBwy9P
 HRSRre9uBeHuuNwAcYqud9YvmHfrZn2SpS3ogZc=
X-Google-Smtp-Source: ABdhPJygEwGSx9s3w6+u2tEOsbZsFudYTpHorAQs8Gk+4jNB+JVE/ct8b5iIt+4v78W81rYNoXL/E0IMnrB342JNBR4=
X-Received: by 2002:adf:ce83:: with SMTP id r3mr12829270wrn.204.1626445543092; 
 Fri, 16 Jul 2021 07:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
 <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 16 Jul 2021 17:25:31 +0300
Message-ID: <CAEnQRZCLMSKJfDVP0U4Wdy6+9ZfhRBschG5RyiPHWMcUpbut_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Document newly introduced fsl,
 properties
To: Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>
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

On Thu, Jul 15, 2021 at 5:59 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jul 15, 2021 at 8:18 AM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
> >
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Document firmware-name, tplg-name and machine-drv-name properties.
>
> That's obvious from the diff.
>
> Why do you need these?
>
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index 7afc9f2be13a..8095aa178e7c 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -60,6 +60,22 @@ properties:
> >        used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> >      maxItems: 1
> >
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      If present, name of the file within the firmware search path containing
> > +      the DSP firmware loaded by SOF at DSP boot time.
> > +
> > +  tplg-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Should contain the audio topology file name loaded by SOF driver.
>
> Is this some format the DSP requires? Why do we need a separate file?
> This is defined by the board or user config?

This is not specific to DSP but to ALSA (See ALSA topology [1]).

We need the .tplg file in order to describe the support Audio scenario
by our board.

This could be defined both by:

board:
- e.g our CPU board can have a baseboard attached (so the audio
scenario changes).
user config:
- e.g user wants to enable post processing or any audio component.

I couldnt find a good way to specify this except via DTS. Intel folks
derive this information from ACPI tables.

[1] https://www.alsa-project.org/wiki/ALSA_topology
