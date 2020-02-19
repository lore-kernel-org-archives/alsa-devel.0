Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A6C5ACC4
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9803024670
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UmsCUC6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9803024670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFDA2168B;
	Wed, 19 Feb 2020 23:14:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFDA2168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582150521;
	bh=N211GYwBeBK341ThgMDhwyjOl9k3AX/2zhp0K27AEWA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmsCUC6fmtTuNd/EM7LMV6I1p4sym9b7ckvYgYcJq3kAN0tnzXh9K8R6sHFykCrx2
	 DV/Y0f/8xxT2wuke0Za5K6EOURUcosSiOEUQQA9EJX2+bC7IBRo+ETc7G93HGatnDv
	 PGvCCxzL/sfApMFemYqN4QT/pz1NmdD3BbubI4H4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58698F8025F;
	Wed, 19 Feb 2020 23:14:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39F84F80273; Wed, 19 Feb 2020 23:14:29 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F24BF80142
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 23:14:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F24BF80142
Received: by mail-ot1-f46.google.com with SMTP id h9so1718608otj.11
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 14:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PCB28ZHMHLDxZ8UN0t28z/W7i0m8dXBxggY1wp5teCo=;
 b=i8RVaoRNAdJ1jFhdeqMcciaDF8JsHZh1sOupOI2QOiuBeQU8UVWLBqglc/ppMAZ59b
 RbyiZUYSggeFgVm2cNt/ppq6qzBH8NbWir/J+2QwF/0arxhgHQ1gHkyQrOn6nADXLeQe
 K/K3hVK+DR+TQ6YgmzoZ4why92V/RwesqvEok5cjNSRd/wTaSSYemfEQ4YWofDWP2Brq
 YLE8KSGFSZT2l6/6wSpj6U7citPcj51A708nenOeBe/D41Eq3x0xWpKz44RqfuSspjH8
 ObY1yOWAB7HbKCtu5KAzNalN9lozzXUJ9lIpmC7OnjqJcmSMtMb0tFKYqkzQGlZqKQky
 cX3w==
X-Gm-Message-State: APjAAAWcsaDKJJuO0rqfqAonsoyjdAi3X6R60sBucLwdQm3sMaByh7cH
 iZiC+5qF+SaSdq32gAznLA==
X-Google-Smtp-Source: APXvYqyobv41FyF6JR9Ye576ZoF0o/UE945k9arGF5Dektgk3qpqgQezDg6xv8alvXICKnJMdOqE9g==
X-Received: by 2002:a9d:7851:: with SMTP id c17mr21733875otm.58.1582150464028; 
 Wed, 19 Feb 2020 14:14:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 17sm376115oty.48.2020.02.19.14.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:14:23 -0800 (PST)
Received: (nullmailer pid 32442 invoked by uid 1000);
 Wed, 19 Feb 2020 22:14:22 -0000
Date: Wed, 19 Feb 2020 16:14:22 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: Re: [RESEND 4/4] dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry
Message-ID: <20200219221422.GA32379@bogus>
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
 <20200210095817.13226-5-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210095817.13226-5-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, Paul Olaru <paul.olaru@nxp.com>, broonie@kernel.org,
 linux-imx@nxp.com, festevam@gmail.com
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

On Mon, 10 Feb 2020 11:58:17 +0200, Daniel Baluta wrote:
> From: Paul Olaru <paul.olaru@nxp.com>
> 
> This is the same DSP from the hardware point of view, but it gets a
> different compatible string due to usage in a separate platform.
> 
> Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
