Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E7C77B7F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 May 2023 12:29:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F77811FA;
	Mon,  8 May 2023 14:28:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F77811FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683548946;
	bh=9eD6YK+Wdu6b8qbEG+Veu0DodWMoo19sJtCLrHEYixU=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A0V5Q/3AECzuXJOxzW9VUpiCDyVp/Gd9KScUlBZKsre0LrGofuRGOViuhumyetH+L
	 o7VzXDs1QrwsNf3QJBE0tvCxnxiJAjvwMPvzkeHIVHnQr0K3oWCfrRuJNOE+YGn+QQ
	 EiJTIG4678DuU27R4Ot7YRmBormgoPmT5WJCCo9w=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C68C5F8014C;
	Mon,  8 May 2023 14:27:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3C2AF8032D; Mon,  8 May 2023 14:27:45 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5EAEAF8014C
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2023 14:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EAEAF8014C
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-1924ec320c5so3535549fac.1
        for <alsa-devel@alsa-project.org>;
 Mon, 08 May 2023 05:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548862; x=1686140862;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbhTWzxFBA8cjY3QB1KEOYtXC8Es1z/fAvwcXxTXprk=;
        b=IbVPec9/T6C7GvgiVNgcUxxgsFe2PfGgiOiUmGRNgBNC0vUR0bbUkZWFfLQNpxby/X
         muMQm17f0c8Z15gFZfS2QiI6RZRUDlMFcY0sx+6d3XE3VH+AdxLrBN9I/sCxEJ6cd8/v
         NyMlOpF1jkQH0nqp6rYLpZlQK3Y3Hiw4sUk41ZX037o2bxG6WkwXa09zhcJ4LYyKE/SL
         A+RjGkXpev6cKQerhdzNym09eM0uRtbwAOa2AyBtcXAij+mq5hU6kP5IwA4Cqw6fzmoh
         Dl4ebD6JUYOOiLXRPAgsccO4wOv3QHZR16621ArVAJt5DLbwLI5Pi3W3CleNudENg+ZL
         yPPQ==
X-Gm-Message-State: AC+VfDz5cTtX4s0Joz5QWdk3nVwBTgaVTORvOF5CbKsv5ps7xzT7MraX
	LLNIN2mb2TR55QhZXY1swQ==
X-Google-Smtp-Source: 
 ACHHUZ6jqVJTOPEan49ez/yig9l6E+2Wm72pEEUy1n5q4wnl1Kg2i3kYZzyUB/3bpHP3Grxt7fWPLg==
X-Received: by 2002:a05:6870:9551:b0:177:a565:a7e1 with SMTP id
 v17-20020a056870955100b00177a565a7e1mr5114919oal.16.1683548862398;
        Mon, 08 May 2023 05:27:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 i5-20020a056870864500b0018b03bf5f97sm4853170oal.41.2023.05.08.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:27:41 -0700 (PDT)
Received: (nullmailer pid 927522 invoked by uid 1000);
	Mon, 08 May 2023 12:27:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
In-Reply-To: <20230508113037.137627-5-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
Message-Id: <168354885809.927469.7527279348028988087.robh@kernel.org>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3
 audio codec
Date: Mon, 08 May 2023 07:27:38 -0500
Message-ID-Hash: FVU43FIYLVFFLUALZR6H24L7FOZX5JSC
X-Message-ID-Hash: FVU43FIYLVFFLUALZR6H24L7FOZX5JSC
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: devicetree@vger.kernel.org, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, lars@metafoo.de, amstan@chromium.org,
 dinguyen@kernel.org, linux-kernel@vger.kernel.org, upstream@semihalf.com,
 nuno.sa@analog.com, krzysztof.kozlowski+dt@linaro.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FVU43FIYLVFFLUALZR6H24L7FOZX5JSC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 08 May 2023 13:30:34 +0200, Paweł Anikiel wrote:
> Add binding for google,chv3-codec device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-codec.yaml     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-codec.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508113037.137627-5-pan@semihalf.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

