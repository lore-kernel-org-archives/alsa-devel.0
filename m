Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC93C433E3
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFDE2065F
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P4thZE/7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz1JhZJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFDE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4156584A;
	Thu, 16 Jul 2020 00:13:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4156584A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594851262;
	bh=Zbhdl6sALo2atgdM5W15dn+y8u3p2HS1qQ+EUdFgpig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4thZE/7mUl97w7sMY1k/kGIf3b7s91UANBSImvhbNuvuikuPwqdjZbr2PEOGGVlI
	 R22/cdLENZKQPbNlP+PnI2CpLbO5wIXuOFb1Mfi5jRYYUWUFMqXWw73CSfYoF/lj+l
	 gju9sAyk3gk/MtWjcIjOnybSBnlBYcL8Irk3Rdac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1926F80217;
	Thu, 16 Jul 2020 00:13:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE0A5F8021D; Thu, 16 Jul 2020 00:13:30 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0618F800E8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 00:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0618F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Hz1JhZJq"
Received: by mail-lj1-x22c.google.com with SMTP id x9so4534703ljc.5
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 15:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EIwOcx3xakAQl+aytp6k21WdPOXiW4LKLnvT4rMht3U=;
 b=Hz1JhZJqRnK8pNhlac4KJKaAOrt6GLsozrPP7iGcRXSoePoz+4/oCVBbTuj3gKxy+F
 Iqupe7BXDyuvqUJFq7ux48yxZUXet2l6lCejiDEF5ECWlwRcMN4qBAfk7OUG/2xnGMtY
 ZH/nT62WZGA1pzdItKBop2AoEWnQHrTPncCft30e1/nh6uxRAgqcZODIGUaYQ0g744Uz
 r3G/6+naA1rtni+RG0gW7XB/jVGfSrm+e3VZFviXPRLv6VoBXrRiGq48YKSWTFfLzt8N
 NWUyzV3raOPM5tpvDRk2I4F5RbZS3kii+NhiJuQb8mYBHsHWwYp/6fk1byezdGCJCvn5
 FTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EIwOcx3xakAQl+aytp6k21WdPOXiW4LKLnvT4rMht3U=;
 b=TwupHUqu4guqDNlktPgZ6vBIA1LNKF4t7p5LbvC69YPdtwB+9h3hU0LLqcz5D913sR
 5dDCcYAkJbv4NfWfyl/42DgoUiXxxceOvRgv6RYJ2ioaCV4GFsfZEwONHwxrYGkU5wvN
 3xJUWBtUC2AuanAuBqpXlsyogk1MOsKLpyK3Kta5BRZ5cA6WLff5qbVA7g2gCKo9MdTG
 DTh/kj0uhgAToQwrPutfPCw0MoELYzbOBukSHwsjYUOqr+nmPydrCPtT477RK9HnUisr
 f7Il15L2bJ5c5A5Llxjr4qYrhuv/h349yPoHG21b5WxYbgjCQnRzO4dTYhSk2yh/lET3
 I8XQ==
X-Gm-Message-State: AOAM532bTYL1wFFkdNE3a1DPDDxC8mETBtWsGIfqxSUg7JtcHfntw/d7
 Ccxenh4dSoL2t5bZReX36YJQgAfLtg1VnuScyfc=
X-Google-Smtp-Source: ABdhPJwbsLNfkUD4HdIJ6IkkHbrTn5XQ0hwtojNOkp3i+xmDVdQLvJF2Xzpt34dORXBPkeyQoU9vlFrz+IAunQMkhA8=
X-Received: by 2002:a05:651c:544:: with SMTP id
 q4mr596756ljp.310.1594851203157; 
 Wed, 15 Jul 2020 15:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <87mu4cxlo2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mu4cxlo2.wl-kuninori.morimoto.gx@renesas.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Jul 2020 19:13:11 -0300
Message-ID: <CAOMZO5BYV_3GhcWsaGXnyxT_d86wQ+3wguW3AU+kVfx7bnZUkg@mail.gmail.com>
Subject: Re: [PATCH][resend] ASoC: dt-bindings: ak4613: switch to yaml base
 Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
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

Hi Kuninori,

On Mon, Jul 6, 2020 at 8:35 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        ak4613: ak4613@10 {

node names should be generic, so:

ak4613: codec@10 {
