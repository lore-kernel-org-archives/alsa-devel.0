Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360F9C021B8
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Mar 2025 03:25:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D0D0602F5;
	Tue,  4 Mar 2025 04:25:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D0D0602F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741058738;
	bh=zPVdx1fQPP2x9Q4mt2d3e4nQ491s+/oWZWndKGSEY2g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YCXns5/Ol1+OXYWZrXRZcthJPeR7q0rcSDvEk9IiKBl/zSQr8xqOVRkWySKwMUp3j
	 jZtuzwQipmXKJ71d+80Y3gSCNSP8/PwU3dJN03qHQ53TUWXtQRiOxqIAqlkGbk5xCw
	 Mpe8RDvHW/fMgvN8Z7PbK1uymg4kLxfeKep6rWok=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEE5FF805BE; Tue,  4 Mar 2025 04:25:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 727BAF805BD;
	Tue,  4 Mar 2025 04:25:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37CC6F8051F; Tue,  4 Mar 2025 04:24:51 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1B0F7F80424
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2025 04:24:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B0F7F80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Is6q4CGm
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2A3CCA4513F;
	Tue,  4 Mar 2025 03:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3AFC4CEE4;
	Tue,  4 Mar 2025 03:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741058683;
	bh=zPVdx1fQPP2x9Q4mt2d3e4nQ491s+/oWZWndKGSEY2g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Is6q4CGmOu6R/T7R42SqJUCFZ+PEDPIamXKtGlm7rHSYdoB5fUQ09kV19nVSQLF8c
	 5UevK7LV8c4dyIEVAgpTnz6aDtcblVK4lpfPwO4FNLbIjtcSnY4QQ4PzEsmp3c+htV
	 iQUfrIHRbn8QpR6P9JLObBqvsmDrteFr9zi6AqOGNizVIr+sUiKufZ38uNQDDjcuaW
	 nnVSLBiMgcYG/FfIK5rQbRUN441uqvg2QGLeTmenHrLTuzOP/A9GS2wYD6kzwFv/Z4
	 N0GLHk0EEyv5XZenC3MRD6JjTKmNzQYV332PZpoozUV++zTon6Bo1OuuGXRkTUlnEl
	 yQr4Afd5lb45A==
Date: Mon, 03 Mar 2025 21:24:41 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: broonie@kernel.org, devicetree@vger.kernel.org, tiwai@suse.com,
 amadeuszx.slawinski@linux.intel.com, alsa-devel@alsa-project.org
To: Zhang Yi <zhangyi@everest-semi.com>
In-Reply-To: <20250304014520.83292-3-zhangyi@everest-semi.com>
References: <20250304014520.83292-1-zhangyi@everest-semi.com>
 <20250304014520.83292-3-zhangyi@everest-semi.com>
Message-Id: <174105868195.540562.12665161671260028240.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: Add Everest ES8389 audio
 CODEC
Message-ID-Hash: YQHAIF2O4XQU7X3VJRVE7UC7O7AWNMRP
X-Message-ID-Hash: YQHAIF2O4XQU7X3VJRVE7UC7O7AWNMRP
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YQHAIF2O4XQU7X3VJRVE7UC7O7AWNMRP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 04 Mar 2025 09:45:20 +0800, Zhang Yi wrote:
> Add device tree binding documentation for Everest ES8389
> 
> Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
> ---
>  .../bindings/sound/everest,es8389.yaml        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8389.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/everest,es8389.example.dts:20.11-24: Warning (reg_format): /example-0/es8389@10:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sound/everest,es8389.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/everest,es8389.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/everest,es8389.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/everest,es8389.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/sound/everest,es8389.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250304014520.83292-3-zhangyi@everest-semi.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

