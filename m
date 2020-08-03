Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2C8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:26:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C1A206E2
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pMJyZ/E5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIizX0es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8CA71657;
	Mon,  3 Aug 2020 10:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8CA71657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596443163;
	bh=1vElN49IGliF2LwMXj6alv755s+9frfMuCNztXv/T+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pMJyZ/E5uKY53Vc8v3VZvoyZpE9DUao/sijyyIzxlrpfv2XfianINIxioJpZpcQK5
	 dsLb33pioYMvo4ttasigdJ+g1BdE83FmjOk16xXiojDHVfo7zKVZ/6kcLKxnix6R/u
	 yvlbODUI5qdTBvIHWO/IRyo/Fjy5cjWJQCYiFQqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AFC5F801F7;
	Mon,  3 Aug 2020 10:25:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9838CF80218; Mon,  3 Aug 2020 10:25:11 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 859C2F800B7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 10:25:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 859C2F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="DIizX0es"
Received: by mail-wr1-x444.google.com with SMTP id r2so28254203wrs.8
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=idno4XA8cyFxWToJkaA+wyHL6pf3C4NEsthkMu6eKrE=;
 b=DIizX0esDlRGwFEkVKmrfd9GB9tB45pOEX3X2zXslub6Z2+O8utOXdqcr5nQ/Oa2Zr
 qtDmg3vVY5gz7a0B5axSSwjHiudMITKOUM74BbyU9hsICaPu+1LFFu3AYhyE9TyuARBH
 GvuSes6pSGu2yftPCeqqaMsKqEtQaeiIFz3pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=idno4XA8cyFxWToJkaA+wyHL6pf3C4NEsthkMu6eKrE=;
 b=SO5V2bfaSBFBjC/pBDOqZpYevoMPsh5HICug4T7KHr+4WK5KMBOzuhUhDH2sS5P3TX
 5tFZs7mtikjvZQs3uNObSkbWRtF9kAaB1KgLQunGrNGWxczM5fpJB6yCqeKWgpnH82zz
 NZL44el08NrRLA08VmzOsQMQoGB6aPzJnuyfepYEO7Bbh1ZeQ1Aeb8i+L2uzB9O2qREw
 LqrsPXYHzG8hVZB6V6gIW2wmI83Ro9f+amdyRtPmBX+mwEtB4kvjlO9ekIiFXti3ouoY
 PzedXPCQBbxaQFMfUDc00v+tbOIsRsySww8YOYl/rR+p2Gpnbctbp+fNo80TAT/93zpY
 P1VQ==
X-Gm-Message-State: AOAM532bQrYjPZi9JN8AQTjDg/utWWyTpPLKsSRRf6pFW4jfzvpwiy6G
 FmpAaq8aWT3/fnSdcIQxE26k60jskVID5ZDXBRmAdg==
X-Google-Smtp-Source: ABdhPJyMr8Qvm79z3JxDUYSbnhyiu1LPeKjwbT1/t95HT7mmACCwcVs3ic5l8CuEVZXehyw2+vldMmejt18EJU2jItw=
X-Received: by 2002:adf:e486:: with SMTP id i6mr13791882wrm.258.1596443098745; 
 Mon, 03 Aug 2020 01:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-2-cychiang@chromium.org>
 <20200731182712.GA531472@bogus>
In-Reply-To: <20200731182712.GA531472@bogus>
From: Cheng-yi Chiang <cychiang@chromium.org>
Date: Mon, 3 Aug 2020 16:24:32 +0800
Message-ID: <CAFv8NwLCkHBVE-JcaDLOrRs6U_MhS4_n1oBicNG1DjQxh-d3UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephan Gerhold <stephan@gerhold.net>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Doug Anderson <dianders@chromium.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Sat, Aug 1, 2020 at 2:27 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 31 Jul 2020 16:40:22 +0800, Cheng-Yi Chiang wrote:
> > Add devicetree bindings documentation file for sc7180 sound card.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:32.24-41.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@0: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:43.24-52.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@1: node has a unit name, but no reg or ranges property
>
>
> See https://patchwork.ozlabs.org/patch/1339316
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
>
I have passed this in v2 patch, but removed reg in v3 patch since it
is not used.
In v4, I have added back reg = <0> and reg = <1> into the example, and
reg property into schema to fix this error.
Since reg property is not used in the driver, I am not sure whether I
should add it in the schema.
Please let me know which is preferred. Thanks!
