Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345F6C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 15:52:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA7F613E4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 15:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA7F613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 260861675;
	Thu, 15 Jul 2021 17:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 260861675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626364341;
	bh=uzBfGX6VlX2HimgUaGLPyk8GIam2ngRr30PfT26ptfA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfqjRQiG804Wo1MOgO0rgUg0AbwRncDDcmTXjhjCrSpuSfV57oMDyanL7P7OQvxvb
	 l5KUEn6jU6sm0BCGPpfqLEbLu+Hb7/fb6THPPMQZMSq6xy3HkOs7kXx1Cy6zA402JB
	 fPK/sYzL/PvV5eUF+wJ+3iT2PeXmou6Xb4IbWiYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6CBBF8020C;
	Thu, 15 Jul 2021 17:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73827F80217; Thu, 15 Jul 2021 17:51:29 +0200 (CEST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 485D6F800D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 17:51:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 485D6F800D3
Received: by mail-io1-f52.google.com with SMTP id k11so7016373ioa.5
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=JpZLiCBQnZ2+MHl1nUW2ILJ6GK8TQMEgnso1fyfpgW4=;
 b=HeD6NyYVqvJqvHNhAopSQpJdQm4VQyMFe89XCdbrWFYmN8S+6n+t7rFCZqxpoozqU9
 3/Kz8TFByCL+fVD3Du74T/CJMqr3e8RLJOCvGjZp/0U4eTV+Ngr0vGbbnWg0qNiP9cwL
 ITbFkpvzC3JH8nrA1lmGI2N4KNYCDaql90wAEzOUMCUD9djefRL2DLI2NiZH1qK2tCd4
 3YTAAPgA0QjCGCFXZv+Ow9dPP0qNQm7k4Zdk/GaUHBIJDgHISKba70j5dtISH1qj7zI5
 1Bc2oGVrLQnzX69TkL8oSoPlZdGWA7BBUQM7oG7QjzyeW19k8nNoHWGItSVoPoqe+1xn
 6YhQ==
X-Gm-Message-State: AOAM531msmly+kYoyWQGSWgTX1f6ui1vR2It7w6hFDRjrI4xYuCG6xp7
 UcGXMXelW9AbFiKihbaH4A==
X-Google-Smtp-Source: ABdhPJyfy6RNCVwpCt8/P77LlZHhH+LauiplhwP3w//gzu1aeDj+fIQWDdVj7YoLFnX7maRUNnZD0g==
X-Received: by 2002:a05:6638:13ca:: with SMTP id
 i10mr952178jaj.90.1626364280999; 
 Thu, 15 Jul 2021 08:51:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id k10sm3374997ion.38.2021.07.15.08.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jul 2021 08:51:19 -0700 (PDT)
Received: (nullmailer pid 1138776 invoked by uid 1000);
 Thu, 15 Jul 2021 15:51:17 -0000
From: Rob Herring <robh@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Document newly introduced fsl,
 properties
Date: Thu, 15 Jul 2021 09:51:17 -0600
Message-Id: <1626364277.745081.1138775.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, daniel.baluta@gmail.com, ranjani.sridharan@linux.intel.com,
 Daniel Baluta <daniel.baluta@nxp.com>
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

On Thu, 15 Jul 2021 17:18:02 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Document firmware-name, tplg-name and machine-drv-name properties.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: dsp@596e8000: 'tplg-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: dsp@596e8000: 'machine-drv-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1505740

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

