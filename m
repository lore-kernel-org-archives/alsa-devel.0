Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E36C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 21:16:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C95C60F4B
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 21:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C95C60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C5E91708;
	Fri, 29 Oct 2021 23:15:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C5E91708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635542174;
	bh=NApRpT97YjCTLweJMQYGNRmjqvkE4DYX14TtaZmj7m4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TqAefugAHcaR+Tlwn/v3Rbam2uzCTfAF57M+Q8KzIIZ2PamBSpntg8gj4gaxxrA+C
	 8p7JEjqa8dXb0DLRqUwaslPpIpzF9fBsD8BMhYa2jaW6CWZ/UObGaQ/o9WYctYjsvO
	 w/Y/P1z7CjQOCYONw7yUWwFzliCiV7q8sFd4PLwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97376F801EC;
	Fri, 29 Oct 2021 23:15:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34B8EF8025E; Fri, 29 Oct 2021 23:15:22 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E4A5F8010A
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 23:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E4A5F8010A
Received: by mail-oi1-f176.google.com with SMTP id x8so10896138oix.2
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 14:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=sgH+xfQQun/T1q5TEyK5JVkL2nNXV/yTPlo0T/9exOo=;
 b=ed66gThuETk98r0s5pkcjLX91TFBtUfCj/9R+/xWouykaGb3mSFUR5OKiuadWhms0A
 Z0qwkVEiiQA/WJXd9LyUyUr2xmqiqYC4tgGyRomfSeKj+WRbynHDcg3xN8mpyTdd6swC
 XyQ06ZQYxjmHv9uP9hOdniQWcTUDiqdxt3MGa8LvJxTmBaLYeOtZF5K41PpH72lNLKLJ
 nCuONlrImUbBZyBzRLZDLEvOWLFTCT1Bb0yzlp1BVxMUa4+WKbLKvHFuDBXAu7lyuHEj
 yP+q5tmrGqWxe8ett19fp1cXD5LfZ/qNqI/tkw5VP+JerzQ+BBkKs9kVcXq+MKKaqU/k
 Sukw==
X-Gm-Message-State: AOAM530cWgkUxsJ2NsSNJrL+ZL5mfMMLda+e6wEbn/Aa6C6bG9ufbmY/
 OBsktkNFDSru1lcV83fOojS5t7v4yQ==
X-Google-Smtp-Source: ABdhPJw6XFkSbvjRrn148G/ujZSxZmSDgqGMI/0mCVkDsmKEVLTZFos8weawXD1ekMeBj89OF7QlNQ==
X-Received: by 2002:aca:aacc:: with SMTP id
 t195mr15715685oie.118.1635542114218; 
 Fri, 29 Oct 2021 14:15:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id a71sm2144955ooc.10.2021.10.29.14.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 14:15:13 -0700 (PDT)
Received: (nullmailer pid 3221285 invoked by uid 1000);
 Fri, 29 Oct 2021 21:15:10 -0000
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
In-Reply-To: <20211029175418.83899-1-david@ixit.cz>
References: <20211029175418.83899-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: sound: gtm601: convert to YAML
Date: Fri, 29 Oct 2021 16:15:10 -0500
Message-Id: <1635542110.119595.3221284.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, angus@akkea.ca,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 ~okias/devicetree@lists.sr.ht
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

On Fri, 29 Oct 2021 19:54:17 +0200, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/sound/gtm601.txt      | 19 -----------
>  .../devicetree/bindings/sound/gtm601.yaml     | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1548195


gsm_codec: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/omap3-gta04a3.dt.yaml
	arch/arm/boot/dts/omap3-gta04a4.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5one.dt.yaml

sound-wwan-codec: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml

