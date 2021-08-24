Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA509C4320A
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:08:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D6A61BFD
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9D6A61BFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16FCC1677;
	Tue, 24 Aug 2021 19:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16FCC1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824881;
	bh=8kLO+S4jUGKLCgPeMORAjWXv/4L1u58hf3uyPzeeYR4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g05c6yJ1ihZUuZmaJprlinGWG4FXwMeqUM4GZfc/47sHHIo9GmXlvmtu2guA8ukq1
	 6rYxOL1iEISfTspOd99JbduIKIC53ZvcVPpv1LAduK4ykVpt0M4uwO0+ow4E83Zp8h
	 S1m3UWMl2LrIEY9gqHP1jozjeZBUbNpLRvxf48Yo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD86F801D5;
	Tue, 24 Aug 2021 19:07:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 475B5F801D8; Tue, 24 Aug 2021 19:07:09 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEA43F80171
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 19:06:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA43F80171
Received: by mail-ot1-f54.google.com with SMTP id
 k12-20020a056830150c00b0051abe7f680bso42864696otp.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 10:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lQJSsrqSi2z80AMSAprMtS7aiLQvJxPvOWMi6DLohc0=;
 b=Vsg7Eq8+xvMx/t8hX42Oc3prKgd/c/0glmoLx9UhCRvX/ZAT4pBaOUt40VVQ7brG2k
 cawwJMRoXiCqiBjzsvau8G8eWbZ5pvBtsRiP2DL2yOMG2aDPGk+iN43au2kVVVvTJAeL
 /kAPVCoAyotV8kDPPBzHd01BTXGW6CNLa5k06ix/Dz+r8Mwv1Ji8M3f5sxFVlh70F5RI
 T/uAdfkyIcedNCY56qmhEUtHm3gKJzcje+iq1cxTzjzqkZVvf0d7tI8bDzzvJLie5jeC
 hXF7ZWdQxQpej3A97JLFANpLXfZ4nkitZogNb73Pj7WCH3BfuxEUiqZdJtc7tQB9PuFc
 Ocvg==
X-Gm-Message-State: AOAM532S/5Ic/o3m/7Hq7h3FHBzA458SawMvciwkToPP0JnW4a1wjuYA
 SNTGc6zjE77Yv72BKimfcQ==
X-Google-Smtp-Source: ABdhPJzzoMH76+kiVkBOXNphyYPJfIc8lwIVxJVfGst2OQHQ8IMCcKTLo4/f/HzRUxdkiLxHMF2X7g==
X-Received: by 2002:a05:6830:43a0:: with SMTP id
 s32mr9194779otv.284.1629824817845; 
 Tue, 24 Aug 2021 10:06:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id bj27sm1125418oib.58.2021.08.24.10.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 10:06:57 -0700 (PDT)
Received: (nullmailer pid 638811 invoked by uid 1000);
 Tue, 24 Aug 2021 17:06:55 -0000
Date: Tue, 24 Aug 2021 12:06:55 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 10/15] ASoC: dt-bindings: rockchip: i2s: Document
 property for playback/capture
Message-ID: <YSUnL4xISXIPLdRv@robh.at.kernel.org>
References: <1629796561-4025-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629796682-4170-5-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629796682-4170-5-git-send-email-sugar.zhang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org
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

On Tue, Aug 24, 2021 at 05:17:57PM +0800, Sugar Zhang wrote:
> This patch documents property for playback-only and capture-only.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> index 9f9cc48..005b6e6 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> @@ -81,6 +81,16 @@ properties:
>      description:
>        Max playback channels, if not set, 8 channels default.
>  
> +  rockchip,capture-only:
> +    type: boolean
> +    description:
> +      Specify that the controller has capture only capability.
> +
> +  rockchip,playback-only:
> +    type: boolean
> +    description:
> +      Specify that the controller has playback only capability.

In the Rockchip TDM-I2S binding[1], these were dropped. Perhaps comment 
there why they are needed.

Rob

[1] https://lore.kernel.org/lkml/20210820182731.29370-1-frattaroli.nicolas@gmail.com/
