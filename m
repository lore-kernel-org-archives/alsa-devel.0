Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34275C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 12:19:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B2F60FC0
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 12:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3B2F60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 189E482A;
	Mon, 13 Sep 2021 14:19:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 189E482A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631535595;
	bh=CXeL7IDgLiiA7dnIKx2ygcaY8eVXB2ULIV2sBR8cxrw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AoaoKhDZtFdxTMySSzxPLH5OPi8pDcErfNwC+EQY5fj7kj7OBF6WSIza1ZOgjuAL2
	 ltBIjZ/FRTAOQnQZHHh4KiDhqub0waD8oupuYc+G2OEL2FdU4IVS9aSb8iH0D3AYb7
	 5LMh6UbSMdV4ZJlVcv5SU8fFPP5Vl8NdChYxXGI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7599F80227;
	Mon, 13 Sep 2021 14:19:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 926D1F8027C; Mon, 13 Sep 2021 14:19:02 +0200 (CEST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 765A8F80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 14:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 765A8F80132
Received: by mail-oo1-f47.google.com with SMTP id
 q26-20020a4adc5a000000b002918a69c8eeso3311583oov.13
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 05:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=bugLB47+bgjh8v8+QK5frTd0NffoWq49bJO7kM44vYc=;
 b=a9LNqgoHXQvx5FMm9UDPE98xZrbb+2fSSOXxK91RMPPe5WhBNwS8omOC5/6UWycM9/
 gZ3EnY4u75cHVZjQCK4LKnfIBS2C3XIpbCVnaq33On9NwqADuQtnTVxU07LmFjZXz1HM
 gmR93Jim+eopFpgZbx5Fr7XNQBMdeXF8ifWKbuL5UBTYRiUuUANrYuRTjCyzTI8qTpQE
 lEokFQTqXg2XQfBxHBj1/ArI6NTHnNJbrMnikUkHjNkKjNPd7bfvxd8GRAZeuBQ8Kzcm
 lF6VZszlNboAU3EfjK1As0xBlmsn2JKonQEdr/79KVb/B3H9AvaMqsuUaWAMb5zCLzbf
 /a9g==
X-Gm-Message-State: AOAM532MlAFtHwghNoL5vDjmQ1Luo6lvMcDrrfvtny/ilQLI72voe0BC
 XCKJsBCM78V2R9wJZOkWwA==
X-Google-Smtp-Source: ABdhPJwt0IFdigIJfxeCTtwNeM7X3ErMU+2u8b0W1BgO/3uSEqQH3pWXKI6bH07SKMAfznY2eaixBg==
X-Received: by 2002:a4a:1506:: with SMTP id 6mr8762820oon.93.1631535529229;
 Mon, 13 Sep 2021 05:18:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id q26sm1806775otf.39.2021.09.13.05.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 05:18:48 -0700 (PDT)
Received: (nullmailer pid 444717 invoked by uid 1000);
 Mon, 13 Sep 2021 12:18:43 -0000
From: Rob Herring <robh@kernel.org>
To: David Rhodes <drhodes@opensource.cirrus.com>
In-Reply-To: <20210911004546.2139657-3-drhodes@opensource.cirrus.com>
References: <20210911004546.2139657-1-drhodes@opensource.cirrus.com>
 <20210911004546.2139657-3-drhodes@opensource.cirrus.com>
Subject: Re: [PATCH v7 2/2] ASoC: cs35l41: Add bindings for CS35L41
Date: Mon, 13 Sep 2021 07:18:43 -0500
Message-Id: <1631535523.185638.444716.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, brian.austin@cirrus.com,
 ckeepax@opensource.cirrus.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, pierre-louis.bossart@linux.intel.com,
 david.rhodes@cirrus.com, broonie@kernel.org
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

On Fri, 10 Sep 2021 19:45:46 -0500, David Rhodes wrote:
> Devicetree binding documentation for CS35L41 driver
> 
> CS35L41 is a 11-V Boosted Mono Class D Amplifier with
> DSP Speaker Protection and Equalization
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/sound/cs35l41.yaml    | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/cs35l41.yaml:151:9: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/cs35l41.yaml
Documentation/devicetree/bindings/sound/cs35l41.example.dts:21.11-21: Warning (reg_format): /example-0/cs35l41@2:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml: example-0: cs35l41@2:reg:0: [2] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/sound/cs35l41.example.dt.yaml:0:0: /example-0/cs35l41@2: failed to match any schema with compatible: ['cirrus,cs35l41']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1526664

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

