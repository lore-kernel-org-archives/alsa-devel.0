Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ABC2D0A3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:35:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990FF2080D
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XDv6bk7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990FF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC26E167E;
	Wed,  4 Nov 2020 23:34:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC26E167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604529342;
	bh=HHHpZTPcDfGUBKDTKgSKdnPR02NLCDMK+9Pi/FxJwRM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDv6bk7YN394kGbSLcoOYEiaX+9pdLSjoij/kuIr1ACwwcHJuHn4qoD4Tu5jpb+iM
	 27J6xmM1eeDTSS1ku7q/T3BDS6xiHgf0FnW4jV5pqadtsauFB/gd8m2cXE/izpGm+4
	 8b2YtBDRum8qIRvF6ksfmwLOIqUG50PumFGT620k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 574A9F8015A;
	Wed,  4 Nov 2020 23:34:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68B8FF80234; Wed,  4 Nov 2020 23:34:50 +0100 (CET)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13FA8F8015A
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 23:34:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13FA8F8015A
Received: by mail-ot1-f66.google.com with SMTP id 79so283581otc.7
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2020 14:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=De/asBW+7ACsxJA0V0dI5OfXqmfuP7smHiv8mpwjXZ0=;
 b=BfVctAUfEbJbQnWBd4AKOBsjbHN10rG5NclB3y/8gdGUZSQULf21TixBKzaQLn7+Oa
 hr3dep4dmQoKceOTL5o6CX1lZkOlxRQb4ct9hCSw+SseM/QEw3HNxZx34Zde73/G4J7N
 C9RXEe+FkkL/WRD0oftjuknusYFYnnUIO2eJusSfMakBMTEQKA8LaoqtxJ6shp0DTGin
 bkBTemwhNZHnzR3r/oM0+vtwKGRAb/JrxWv7NsOh0DdgbIqki6h9WBAUBgLc//mjeVtP
 dV6oNEOvYPXkR8/VTCN+P175lKIvvHwNsi/rWfs2aP3kP16dIH4HfqhGGlJ+l3FgtJQu
 Olag==
X-Gm-Message-State: AOAM530R16PXxfzmBNbZYHaOZaP7zwxjt6C5pMYAZIZXHP+TjU6w3V6y
 /TQDhfSOjWmcDnVDaZLQpA==
X-Google-Smtp-Source: ABdhPJydVci5YTxHwBge3dnN274lTktXyAPo9XcUv0uObEVs8L/tBdqo/1r1n3NVYXAsKnCx7SfmbA==
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr19441014otr.303.1604529281700; 
 Wed, 04 Nov 2020 14:34:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t83sm789898oie.58.2020.11.04.14.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:34:41 -0800 (PST)
Received: (nullmailer pid 48871 invoked by uid 1000);
 Wed, 04 Nov 2020 22:34:40 -0000
Date: Wed, 4 Nov 2020 16:34:40 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
Message-ID: <20201104223440.GA48821@bogus>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Mon, 02 Nov 2020 09:52:26 +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v3:
> - Add additionalProperties
> 
> changes in v2:
> - fix indentation issue
> - remove nodename
> 
>  .../bindings/sound/fsl,aud2htx.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
