Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FB6C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Dec 2021 19:38:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFC9E17F4;
	Wed, 22 Dec 2021 20:37:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFC9E17F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640201901;
	bh=K8DHbx63a27vXJmwEqyZentYJuufaAtO31QFa60wjOQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwxRYZU7jP2SmDBgeYXJIdcJyf7SXSL8+qNK04kIXGRy2KS77CGDRUWNCGTPrgpE/
	 TwpGvnHBZFbUIbH17CwXi0SCHC2nsqksn3vYgPMEBrIAC+8vNucB6qkBgVJ3U02MW5
	 2F28rw0IsiFumyF0Y6zDrWdZfeDzje3umPCFhPBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FA9AF80084;
	Wed, 22 Dec 2021 20:37:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06B1DF80109; Wed, 22 Dec 2021 20:37:29 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E97CF80084
 for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2021 20:37:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E97CF80084
Received: by mail-qt1-f173.google.com with SMTP id bp39so2608824qtb.6
 for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2021 11:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ms1GIPZs1ev5xEZpY6o8FR181sPVC1wSUgdaLlJTuns=;
 b=6h7p65g/HEUipOaU3Et1oehVW7M0BLR8xw7SMPjGgMKwKgvLv7/OGHtagd6XlOZfe6
 vDhsKKD329WoPX3oWHc5TojWhPVrE84N5oB82cbbsAnGN84KFb8AY5Obuhce2Pwc8l6O
 TohbJlpnNBX2bvvpdPN6Pr9Hzm/P8wN4Iue2BPZRiulihhNpdeGXhc+dFFqhLDfaK35t
 8rTUTQRaMDq5wfz2eRsQs6gv0ls0Y9QwBG62pyZ2dFJlYAvD4Rb1L4dp/jPbV5wM+DUF
 F++ek1FwAWF7Su6CD8Y6abScpeTvKAToPR0zGaUUR/kuVqvEtYobtPAMV/fwYPI56nuo
 vymg==
X-Gm-Message-State: AOAM532EXg/LAfFmi+2wzJKQSZ8KYrmrtrZWme6ovXDORFCvH6v3Z4WN
 fSqoYhlriqi4cUvQWrFDPw==
X-Google-Smtp-Source: ABdhPJwrLYiMPJ95THVOxGleq3xFEWYS0SX9m4H7pLPhWxL+hwnKGMoLI6mBWWxqwPKqeakTQYf+EQ==
X-Received: by 2002:a05:622a:15ca:: with SMTP id
 d10mr3365524qty.81.1640201835775; 
 Wed, 22 Dec 2021 11:37:15 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
 by smtp.gmail.com with ESMTPSA id az16sm2868691qkb.124.2021.12.22.11.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Dec 2021 11:37:15 -0800 (PST)
Received: (nullmailer pid 2575737 invoked by uid 1000);
 Wed, 22 Dec 2021 19:37:13 -0000
Date: Wed, 22 Dec 2021 15:37:13 -0400
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: tegra: Update HDA resets
Message-ID: <YcN+aYRXKK7HRmqz@robh.at.kernel.org>
References: <1640147751-4777-1-git-send-email-spujar@nvidia.com>
 <1640147751-4777-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640147751-4777-3-git-send-email-spujar@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 broonie@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 digetx@gmail.com, jonathanh@nvidia.com, mkumard@nvidia.com
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

On Wed, Dec 22, 2021 at 10:05:50AM +0530, Sameer Pujar wrote:
> Tegra194 HDA has only two resets unlike the previous generations of
> Tegra SoCs. Hence update the reset list accordingly.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml       | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index b55775e..70dbdff5 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -50,13 +50,18 @@ properties:
>        - const: hda2codec_2x
>  
>    resets:
> +    minItems: 2
>      maxItems: 3
>  
>    reset-names:

Just add 'minItems: 2' here instead.

> -    items:
> -      - const: hda
> -      - const: hda2hdmi
> -      - const: hda2codec_2x
> +    oneOf:
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi
> +          - const: hda2codec_2x
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi
>  
>    power-domains:
>      maxItems: 1
> -- 
> 2.7.4
> 
> 
