Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF523C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:25:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D71C20757
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sYf2IUdQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgk3l2Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D71C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A251F16F6;
	Wed,  9 Sep 2020 11:24:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A251F16F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599643514;
	bh=1rNPusSwQXXuTiwsU5fcEOm3wpvvGEZ7ubuP9DYku7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYf2IUdQ7FwnLD8YRoX/mXeFkQk+bHdWHt0ZJe0BWRW9eBmAacCIQWnH41ywUtbdA
	 eRLQM8g8DAXcQ0so/daNz7Q1yIa6p2Eg/GG20urJ2QwdkgMctlc6aczNL48LYUm3op
	 WLPe6A66TvRPnr1DE7ZIj0Kt6PvqyRUx/jmMrhQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14A6FF8021C;
	Wed,  9 Sep 2020 11:24:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B1B0F80227; Wed,  9 Sep 2020 11:24:22 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44760F800E9
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 11:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44760F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="lgk3l2Qh"
Received: by mail-wm1-x343.google.com with SMTP id e17so1579036wme.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2020 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AmAjr6xvyauDkIBPHoJreMuavbYPMqoWr9WPQMiNPkg=;
 b=lgk3l2QheCZRIdB/DXYePwXEoUJvYOIpV83Gh1pRZ2BYhkcAj5c3ogzbaLtFuFI9ts
 jpGHnH6HqqegvOnM9Uqug7F1IJiuwk+eek3yWSn2ufF9Y+cYzVYdiFc0zs3ZtTMRf5cM
 XT5LclUiUzG/7eZUxr9lBGgyThOWt8HJEhlvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AmAjr6xvyauDkIBPHoJreMuavbYPMqoWr9WPQMiNPkg=;
 b=PETDIAVLJfEXzo4Hlas17p+BmF9OhMBnQ88iOEb56+ZwzvoZwxM1tLjOsavbYg9jQ/
 MbtYIlOSDCJFwtMz6ndoJ22ZXDHxYrWkCoHeP+ll3wgfq/6KflGnKfhKH8Vxjfn9Z+K8
 bKTZM3mnLHcx1TmOJqlIfzoe9FwXUJE/PIo6MXz+fHO7MwI+SVaJ4tdIhB9v65jaS6LM
 PdfkO5isGxhlKypim51RhvnyWtd54PEqe2wbhw5FB2iHSOOwQGSP4NLlVdVJBQcoZNfR
 TcDS13DMuxbeTlm0eBMxLaHTABZDWa3NWs8Ais1avIrZV+1kfcltqpWY3X1NiikJusuF
 Xu+Q==
X-Gm-Message-State: AOAM531JvrrSn+4wnBcmtFbsYaYeYocyFZU9Cqq9LHIWjK+ktSqwqMHZ
 e44a4/akIrFuiqWg4GQXhu1pKFZ5hGL96epJmkUPUw==
X-Google-Smtp-Source: ABdhPJyCFk+9azkQozj50ygO4Fld+/Ww0XhKIzoSM/wUVfsy/tdWyDVDQ6WSJk0DhWTK8YoZzQXF1zAmuO+KS+gPPFU=
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr2599038wmj.101.1599643450162; 
 Wed, 09 Sep 2020 02:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200907100039.1731457-1-cychiang@chromium.org>
 <20200907100039.1731457-3-cychiang@chromium.org>
 <20200908203357.GA861143@bogus>
In-Reply-To: <20200908203357.GA861143@bogus>
From: Cheng-yi Chiang <cychiang@chromium.org>
Date: Wed, 9 Sep 2020 17:23:43 +0800
Message-ID: <CAFv8NwLMAkFhVT-ML7QHbnSkqmgh=5SrNSik5eSCTHB1=DGQ0A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>,
 Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 Dylan Reid <dgreid@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Doug Anderson <dianders@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

On Wed, Sep 9, 2020 at 4:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 07, 2020 at 06:00:38PM +0800, Cheng-Yi Chiang wrote:
> > Add devicetree bindings documentation file for sc7180 sound card.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/qcom,sc7180.yaml           | 143 ++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> > new file mode 100644
> > index 000000000000..ae809346ca80
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
> > +
> > +maintainers:
> > +  - Rohit kumar <rohitkr@codeaurora.org>
> > +  - Cheng-Yi Chiang <cychiang@chromium.org>
> > +
> > +description:
> > +  This binding describes the SC7180 sound card which uses LPASS for audio.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sc7180-sndcard
> > +
> > +  audio-routing:
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    description:
> > +      A list of the connections between audio components. Each entry is a
> > +      pair of strings, the first being the connection's sink, the second
> > +      being the connection's source.
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  headset-jack:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of the codec for headset detection
> > +
> > +  hdmi-jack:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of the codec for hdmi jack detection
>
> You already have links to these devices. Why duplicate it here?
>
> What if you had 2 headsets? This doesn't scale.
>
Hi Rob, thanks for reviewing.
There was some discussion in
https://patchwork.kernel.org/patch/11737905/#23571643 about how to
specify the dailink that has a headset jack.
I would like to pass the information of headset jack and hdmi jack to
the machine driver so the machine driver can call
snd_soc_component_set_jack to set jack when init the corresponding link.
Headset jack and hdmi jack will be treated differently for button and
event type.
Because of this, we can not just set a property "jack" in the link.

As for the 2 headsets case (I guess you mean hp jack and mic jack), on
this board we will not have this use case.
If someone really wants to build hp jack and mic jack on the board
based on this machine driver, we can add two more property hp-jack and
mic-jack to specify that,
as the machine driver will need to know the different jack types
anyway. What do you think ?

Or could you please suggest a proper way to pass such information ?

Thanks!
>
> Rob
