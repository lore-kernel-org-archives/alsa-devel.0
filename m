Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F148C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:37:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4930A20774
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CEKz4MCF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCH8LrFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDE3F17F8;
	Mon,  5 Oct 2020 13:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDE3F17F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601897844;
	bh=zshXkx+u5XrvYryxtxL0PzHTQ83MbPU3DM5RBxMYRuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CEKz4MCFqxB7mHySZPNMJ4p5r+eDdzCEeVDdgtTS6snK328mwaJ2p2bGxp8bJhl6t
	 02KMsfPMzsbdFAi8fMQ85r2i/OdRu4uEWLNrr5ZTgZs2VPxzFXF6kAhq8+Rcpn6FDG
	 pKvu73axn8I1d4yvazZxt3J7VPrF9LRa7IMI5gxQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1CD4F8025A;
	Mon,  5 Oct 2020 13:36:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B46CCF80260; Mon,  5 Oct 2020 13:36:17 +0200 (CEST)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CC6CF80245
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 13:36:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CC6CF80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HCH8LrFO"
Received: by mail-lf1-x143.google.com with SMTP id y11so10431031lfl.5
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2020 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QWUIVzlGRQWxPn+b1ACG3xDtfN3nM73oyQh+/xMJ6f8=;
 b=HCH8LrFO3R/ztzRAV9PAcOw5O5Vviirbs4HQWlEH3Au+DkBr8ueD2ielhoO0i2RPW6
 LpwvVuBnoGPtz5g0qd7o8XIxmWQ8RbyJ0cOZBfbOQA0FzO2KDmQbU2mrEgIYWtCnwGD0
 6XZD+5KZUUSH0X6FqjriZgNW3bvomR8OEn0O+uh0Tt0p4zZH21xRslACPUWQNilr0Bt4
 D2VvYdj4QGgntFwHqzj/4BGvb3hgoP65w3ukSwqNGM9WMkhWo41wc/J8wlfJWBqVzfKb
 lQQwlvNLSSWM+DKbVsF3V3LByeL3WnitEER1JXpZJkA3E12NTEYAViZEfi0RV9+4lDz/
 9OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QWUIVzlGRQWxPn+b1ACG3xDtfN3nM73oyQh+/xMJ6f8=;
 b=dmrSP/NlhqnPhBStvHth6cbcqxSRZ4ae4AIYYyR2p4K/8ZfdVk+Rg6AEuEJit+tFbB
 0IXEebVd0mUPFWrloEzO01L7AVYhdued9Wae8RrJnopvZRBiYIPoVNtDcoD+41HvDB6e
 nXvifkSGMbKl97x7psvxW6+9D+Ih0yHURTdeRzA//F0qr5oWX8skxzGZEw2cDkg0STMs
 RHki1x5mYqM6Eqskgc6bOaO5i04bELGNsyHkwEtYdNEgK5X6NQ0BkU7K+WTZPcIt5WxJ
 GOqii8ur/gDn4dl4TvFmAnjAZWhPkYoZa0yVXPFIFw2j2Ji7xX3jdlAfWRZU9Ek1wTTC
 0klQ==
X-Gm-Message-State: AOAM532bA3Tkepy0aqqLwnC5VZ/nKOSCUItbLPkCCzzs0W0sDE6pVsCF
 2EdZmw3445Q4iMU2aFXeBwpULHJ6nJmfEB7l9LM=
X-Google-Smtp-Source: ABdhPJyA4krJkKCasXMqip0QWH2CvXGO/9mR8gz3YpX36JyMZN9y+jEEA/PFRc94fP72ATphhoapuYVv/CkJaqwwZE4=
X-Received: by 2002:a19:c355:: with SMTP id t82mr5932460lff.251.1601897769758; 
 Mon, 05 Oct 2020 04:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201005111644.3131604-1-primoz.fiser@norik.com>
 <20201005111644.3131604-2-primoz.fiser@norik.com>
In-Reply-To: <20201005111644.3131604-2-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Oct 2020 08:35:58 -0300
Message-ID: <CAOMZO5CQkh06TfKj3qR9P+0ZQOQo07NAg8v9j==KMrLCWBn0mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: fsl: add ac97 fixed mode support
To: Primoz Fiser <primoz.fiser@norik.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>
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

On Mon, Oct 5, 2020 at 8:16 AM Primoz Fiser <primoz.fiser@norik.com> wrote:
>
> Add devicetree bindings documentation for operating SSI in AC'97
> variable/fixed mode of operation.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,ssi.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
> index 7e15a85cecd2..abc5abe11fb9 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
> @@ -43,6 +43,11 @@ Optional properties:
>  - fsl,mode:         The operating mode for the AC97 interface only.
>                      "ac97-slave" - AC97 mode, SSI is clock slave
>                      "ac97-master" - AC97 mode, SSI is clock master
> +- fsl,ac97-mode:    SSI AC97 mode of operation.
> +                    "variable" - AC97 Variable Mode, SLOTREQ bits determine
> +                    next receive/transmit frame
> +                    "fixed" - AC97 Fixed Mode, SSI transmits in accordance with
> +                    AC97 Frame Rate Divider bits

It would be good to mention what is the default mode when such
property is absent.
