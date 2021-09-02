Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F95C432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:05:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F94610E6
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F94610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DFDE17A4;
	Thu,  2 Sep 2021 14:04:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DFDE17A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630584306;
	bh=ITEJISF2iTMe1yZqMsH6G7Y9pXwbxgUbWTf1bOQZyr4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWxmFmNEEPOd+rW2TGbtps9I24LQUHEkXr/D36wiytv8YcmFiQcMpdRYKDSNRe/Tx
	 TCaXdTz+2NpKwQ+J5GurQuORMR8QRjpqJzP+UzRZVBrwsBmtwmHjN7PiSYSci1ur7Q
	 pmU+Va3k7Hbe5P82x/+1c0HpE8jpSo6lJwXKUv/g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 357A5F800AF;
	Thu,  2 Sep 2021 14:04:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 336ACF80269; Thu,  2 Sep 2021 14:04:15 +0200 (CEST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D47BF800AF
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 14:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D47BF800AF
Received: by mail-oi1-f179.google.com with SMTP id n27so2252204oij.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2021 05:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=1BhybqLO/xSxTonTmG4+ysFiC+EsbInsMivl7h+IPwc=;
 b=PCV9Uw8mhAlDr6IAhq97NIF47Kh2j2K7UDtfrtNrY7d0XdpK2qG/pIdmsJKIOyBvfF
 VF6KOe3xVAh7XZG+qT7o24+pGl1Kmthi5IyFAjrRuZQ57ESXUNX3oKqdtwE2zUIbbcvR
 z1fKxD22yI9CpXUFCbA0HzRWqb4FApJJ8ABZcw2Rrsp/WY+5yDnv7+yOP3OcOJzSflDS
 0Z8nE323Wb5c4E3JlHzZZrjwx/PfW9EWOFv14lC5hKzoBru5uuoXa95U2unrxI/Y4hzY
 kjE7RFJA4Ss6tPSS9mosMDbIE8hKYlB6Y3LfCjyRrLThIXKG5X2D+Ef3D+idWV0BeEQI
 aGOg==
X-Gm-Message-State: AOAM533kp7bBHHbMle8bZLjU4ArQZdLCEwYhXrQ/DxXvQV0jLKFr51M3
 coAl3GwHUDc+0TFSOe3YPQ==
X-Google-Smtp-Source: ABdhPJyfKcFgOUXSmVvN4L+H7e8NArWiAR7hFp+ggaReieLCcYCZmbU/u2j43rfIJCSQEG7HchJk1Q==
X-Received: by 2002:a54:4105:: with SMTP id l5mr1856524oic.76.1630584246444;
 Thu, 02 Sep 2021 05:04:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id w1sm301368ott.21.2021.09.02.05.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 05:04:05 -0700 (PDT)
Received: (nullmailer pid 685603 invoked by uid 1000);
 Thu, 02 Sep 2021 12:03:59 -0000
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <1630562033-13231-2-git-send-email-spujar@nvidia.com>
References: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
 <1630562033-13231-2-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v2 1/3] ASoC: Add json-schema documentation for
 sound-name-prefix
Date: Thu, 02 Sep 2021 07:03:59 -0500
Message-Id: <1630584239.106707.685602.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, jonathanh@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jbrunet@baylibre.com
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

On Thu, 02 Sep 2021 11:23:51 +0530, Sameer Pujar wrote:
> The 'sound-name-prefix' is used to prepend suitable strings to a
> component widgets or controls. This is helpful when there are
> multiple instances of the same component. Add relevant json-schema
> and is inspired from sound-name-prefix.txt documentation.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/sound/name-prefix.yaml     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/name-prefix.example.dts:19.28-22.11: Warning (unit_address_vs_reg): /example-0/analog-amplifier@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/sound/name-prefix.example.dts:24.28-27.11: Warning (unit_address_vs_reg): /example-0/analog-amplifier@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/sound/name-prefix.example.dt.yaml:0:0: /example-0/analog-amplifier@0: failed to match any schema with compatible: ['simple-audio-amplifier']
Documentation/devicetree/bindings/sound/name-prefix.example.dt.yaml:0:0: /example-0/analog-amplifier@1: failed to match any schema with compatible: ['simple-audio-amplifier']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1523479

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

