Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A80C2BB1D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:59:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AA22072D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CCwn+W/c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyBX2dum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AA22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A899829;
	Wed, 15 Apr 2020 04:58:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A899829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586919550;
	bh=2gyegij/148ozlQaCG0Am8haTLiMoCJW8pVdtiqzj/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CCwn+W/crS5VTIv8LL1fNgGPy5rm6rJJL8OICzZAmqntOQao0dQRhYidyobiHyLhT
	 FlggVPngMhvXfrQEX3Z2EGTikAeoInO5Un9sryooymaCKtiS/anYiHr0TGW5W0DjQH
	 caVZKo/uHRMJOS4naJIhCx+KgDaAeDh62wA0rjK4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCD8DF80229;
	Wed, 15 Apr 2020 04:58:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EBF7F80115; Wed, 15 Apr 2020 04:56:12 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42F3AF80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 04:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42F3AF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="dyBX2dum"
Received: by mail-qv1-xf43.google.com with SMTP id s3so990139qvk.12
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+pk54KXVRCt6mCeYfu6u1hgghJvTphtuH45b199eug=;
 b=dyBX2dumBT3DX60HltmnArMIt6VdxDUSG499ZJ+SRAW1GNYbaDK0TUKMeEq/aSkESG
 ChLKmTo6et7e8BsIPVwRNLLNO9n/dw8bpcW9L9WweiHlT8y42jKTCt+AeIllZGKe76jU
 RCJUyCb3E7/1slLwAqTMTggJnLfQCt+1pYkAtHgsu7uB3FhuoZHhbfYnkQ+I6xm8NEE6
 FnY3Z833zX6HWbAH1HxGSB0Bo9GqexomPFByl1c6UoTg01cXsev+ZUKRSoBVimBuYroh
 m71L7+eFHi5pdsEosfQhCxZfgq5510wDXejkW+/+V2tIAXptyqXdWbIIQX8BclLlyFL4
 l+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+pk54KXVRCt6mCeYfu6u1hgghJvTphtuH45b199eug=;
 b=ulPgnIiX29Xc1LiG/zS2m/tobRjc9LLo1UHNiMXVq+RBc1pGQkl0sAMI5nXEpU2jVG
 7vWqLapaHyRMWe0uUES1pdZMnM5cA5PsDVIxWkgiv/w2+mZxhOY7Awn7gc4PrhBWwHnc
 yAxMfiZ/4MOpN0+CtpD2FQ2dYNLQTY+27Z2XTvnm9v4lKNIx5xWnabQdKIB+WkAf6Vcc
 dZmqte2I6O0XzYCrelab7+r7TxkNAXyQT6tyCSK4es2U0eMDr8VJqapXwxLFb8coMq7/
 nPbwjl+ZBiOz4UmUPFS08o7RX+U8Q0MSDRiYbFyNWYguAJYeCYTto+pv6doLIjF8M1pU
 npwA==
X-Gm-Message-State: AGi0PuYp+Fsfv6Y1SXeIN5Fo4PHdvBSoaovw036Ar9+mK08sjQ5m4UeD
 GYzGenY9Z1pbcsPbSbF6+DAY5VspqwACgi6roR4=
X-Google-Smtp-Source: APiQypL6fx5Jo66bviF7emrcPPuSgkq+sExxjq0BShhEl+ej8+MVt0ZP8mIC/3uoA9xgoayPyN+s0Rj7dR5hh4U60L4=
X-Received: by 2002:ad4:46e3:: with SMTP id h3mr3036173qvw.14.1586919359561;
 Tue, 14 Apr 2020 19:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <68208297b49e85adfddf843bc205d154790a49de.1585726761.git.shengjiu.wang@nxp.com>
 <20200414154643.GA29098@bogus>
In-Reply-To: <20200414154643.GA29098@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 15 Apr 2020 10:55:47 +0800
Message-ID: <CAA+D8AP2CiRT7qkNa7yBDH0Dbd=i1eyqL4g4zobRmR-vEx4VBQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Rob

On Tue, Apr 14, 2020 at 11:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 01, 2020 at 04:45:39PM +0800, Shengjiu Wang wrote:
> > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > IP module found on i.MX8MN.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > new file mode 100644
> > index 000000000000..14ea60084420
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,easrc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP Asynchronous Sample Rate Converter (ASRC) Controller
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^easrc@.*"
> > +
> > +  compatible:
> > +    const: fsl,imx8mn-easrc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: mem
> > +
> > +  dmas:
> > +    maxItems: 8
> > +
> > +  dma-names:
> > +    items:
> > +      - const: ctx0_rx
> > +      - const: ctx0_tx
> > +      - const: ctx1_rx
> > +      - const: ctx1_tx
> > +      - const: ctx2_rx
> > +      - const: ctx2_tx
> > +      - const: ctx3_rx
> > +      - const: ctx3_tx
> > +
> > +  firmware-name:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/string
> > +      - const: imx/easrc/easrc-imx8mn.bin
> > +    description: The coefficient table for the filters
> > +
> > +  fsl,asrc-rate:
>
> fsl,asrc-rate-hz

Can we keep "fsl,asrc-rate", because I want this property
align with the one in fsl,asrc.txt.  These two asrc modules
can share same property name.

best regards
wang shengjiu
