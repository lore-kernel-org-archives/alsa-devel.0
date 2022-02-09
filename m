Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB1BC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Feb 2022 15:36:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5636C187A;
	Wed,  9 Feb 2022 16:35:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5636C187A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644420976;
	bh=l+8AfwKk12cDPjhCx1zRP+yNdCniBP0DxBPVOilG/Vg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKw1hycCEeEOVLMTW2ahHRrgWomyIddmFLN+iYg6qTvVzhZ1vXJpfrmxUHD6MT8u+
	 eHn34sRfRPEcmcwb4jrhonaDR7YB7pngVrlX9jrZOntduYr+V7vMjbAr+QBaV3xph1
	 vcBbISdbkgOBm7NBUKryOcMCAUdOF1N0OHTrD5gY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9574F8014B;
	Wed,  9 Feb 2022 16:35:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EA37F800A7; Wed,  9 Feb 2022 16:35:24 +0100 (CET)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1977EF800A7
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 16:35:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1977EF800A7
Received: by mail-oo1-f41.google.com with SMTP id
 f11-20020a4abb0b000000b002e9abf6bcbcso2909578oop.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2022 07:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=H19TdmlGQeOvqWibXwnTgQaKpp298rj11z4re+ZlqzE=;
 b=NEbxK4Lo5+CFkCzmYo4KPNjMue9kbcZ2O5fvXA2UKLpX/LPyPKHENT8dVbT51lpyWq
 MNkB0cnHTVv7eWjlMo0mhoEsTiR/tKiTTxRoZ8IEH4+oPTv90DJYbit4SX45xTpOTTmU
 nnEA6luRPEAZuxgPsi+3fM7G8QsiWQt0ktUtDnwZhGX0oZLDAfX9eNjJKbYx1zibM63g
 XvnO6qNP6TwJEeEK593hxYwvbJg3fO1cZmVEqgDKUJqc+7E1Tq1BZ5fk9SyPCc3BZAVI
 b5Yi4G+5ifP0TMWbTFzpAANIqdHXLn/whAuTJsip/4rkQrqD8YcpDUrRccJ948CkkYAs
 P/EQ==
X-Gm-Message-State: AOAM533BMkH/8PIg6PB9nS+VaAfsa56tIMcSC1iJ7yXtfw9NGkcqXuZz
 YBpepJ36/s8cfX+0ZN+NuQ==
X-Google-Smtp-Source: ABdhPJxKdqFqfL7xuc3s+WdsojPu3tY6PLqK4sVB4rB6S59yfpnWW0p0L5BzV9TGDFMjVhphJCSaLg==
X-Received: by 2002:a05:6870:12cc:: with SMTP id
 12mr902265oam.215.1644420916147; 
 Wed, 09 Feb 2022 07:35:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id t2sm6862136ooo.24.2022.02.09.07.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 07:35:15 -0800 (PST)
Received: (nullmailer pid 391817 invoked by uid 1000);
 Wed, 09 Feb 2022 15:35:08 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
In-Reply-To: <1644413181-26358-2-git-send-email-quic_srivasam@quicinc.com>
References: <1644413181-26358-1-git-send-email-quic_srivasam@quicinc.com>
 <1644413181-26358-2-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [RESEND v8 1/3] ASoC: google: dt-bindings: Add sc7280-herobrine
 machine bindings
Date: Wed, 09 Feb 2022 09:35:08 -0600
Message-Id: <1644420908.409006.391816.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 robh+dt@kernel.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 broonie@kernel.org, rohitkr@codeaurora.org, swboyd@chromium.org,
 judyhsiao@chromium.org, linux-kernel@vger.kernel.org
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

On Wed, 09 Feb 2022 18:56:19 +0530, Srinivasa Rao Mandadapu wrote:
> Add devicetree bindings documentation file for sc7280 sound card
> registration.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../bindings/sound/google,sc7280-herobrine.yaml    | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@0: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@1: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@2: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@3: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.example.dt.yaml: sound: dai-link@5: 'sound-dai' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1590375

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

