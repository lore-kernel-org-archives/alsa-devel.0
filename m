Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C65C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 13:59:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BAD61AEC
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 13:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98BAD61AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DE5F1843;
	Thu, 18 Nov 2021 14:58:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DE5F1843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637243965;
	bh=ZvIvFWL/HM9LzOdH2o/5dAmfXYHay8GPdvZsv9M6RHU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vddzlF44I23JO5LaZqCeYlRSbPDdkwNJkNi6WStOQFlQ63goS/T+hxXPj8AsZ3Bab
	 S4IwXuNL5iqmwK/s5YY3V1zegFjZ0JDC1oqcb2SvBBl56Pcucgv5ikyR/A8mZgZISK
	 I3Ghdj7aGrnIleEhJDO+fEeEY4vQsklQemjTzREc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21210F8026D;
	Thu, 18 Nov 2021 14:58:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE778F80272; Thu, 18 Nov 2021 14:58:33 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEA8CF80115
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 14:58:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEA8CF80115
Received: by mail-ot1-f52.google.com with SMTP id
 h16-20020a9d7990000000b0055c7ae44dd2so11046682otm.10
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 05:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=WmMfhkzPjWTKlEZ9yIh2W7NHeFSMUgJDMyPJqo/TBCY=;
 b=z+ExRqmKTjhOQfpSA9+kIeSxdukvY/4ytrCPn3YFClSgBksDcw0hZ4IvYbSMLKbD+u
 TuPvd2eq9ORkkIDfaQtuD1sbomG/oaU7fwVTbDXDD7QEHil43EBy41J9yFkaT6rNvBJO
 a+fdK8DO86Mhj/HUXR4Z1wtkrF2prqFhRwkFPNNJrLutqXCwETeQtMsca4fTuTMwSwPW
 D17dP8Hos1eWm+uwICx96NWQ5ICA+TwFkO1yckwFfdxj907PVya2yh34WIcprtJ9UDbp
 KiO0GIsJixaii3A9Sris3z4WooKuHpqUFc0DqM0laI8u6H+cGHh7DlJqxc/iCkltwrSj
 5YdA==
X-Gm-Message-State: AOAM5301jfMHdDPtmxC8F6AFEbILv45rjfTXLe7OoUq15jX7JVtGTHNh
 lK3Brbl64Hxx+8ZTfWOFsg==
X-Google-Smtp-Source: ABdhPJzWykudMzngz7+fYsbqh9ICTA5Q5lY0M4wTA9me0nH9FEPyMXguhDFWK2e4MNPzw3UyklnkQw==
X-Received: by 2002:a9d:7a42:: with SMTP id z2mr21463015otm.362.1637243903121; 
 Thu, 18 Nov 2021 05:58:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id q33sm522530ooh.16.2021.11.18.05.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Nov 2021 05:58:22 -0800 (PST)
Received: (nullmailer pid 998654 invoked by uid 1000);
 Thu, 18 Nov 2021 13:58:21 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
In-Reply-To: <1637239506-9387-2-git-send-email-srivasam@codeaurora.org>
References: <1637239506-9387-1-git-send-email-srivasam@codeaurora.org>
 <1637239506-9387-2-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v6 1/2] ASoC: google: dt-bindings: Add sc7280-herobrine
 machine bindings
Date: Thu, 18 Nov 2021 07:58:21 -0600
Message-Id: <1637243901.366064.998653.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
 broonie@kernel.org, rohitkr@codeaurora.org, swboyd@chromium.org,
 judyhsiao@chromium.org
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

On Thu, 18 Nov 2021 18:15:05 +0530, Srinivasa Rao Mandadapu wrote:
> Add devicetree bindings documentation file for sc7280 sound card
> registration.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
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

See https://patchwork.ozlabs.org/patch/1556613

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

