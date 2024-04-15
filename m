Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84357C4345F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:28:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B382314E6;
	Mon, 15 Apr 2024 13:28:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B382314E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713180513;
	bh=FE+i4A70L7DRRL+U0mi5Ziz97jbyagDFCw1I4beVKMw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RXGWCkJw5Laq2yCuOxd3IrWg7d2rOtxg2+emYX//IjKcVjGI8sgz8SVugSHL6Xr7Y
	 4Y4Gyr9plmHMSqpKvblEKnsL7t3GeMz8JgHUM0locPSf4OKLBnaxRLcnDvA27R+bqo
	 TulmFitLhNyvguNJu0c263PbFIYCxCm3mZYYY+4o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D748F805AC; Mon, 15 Apr 2024 13:28:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EF77F80578;
	Mon, 15 Apr 2024 13:28:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33FE1F8025A; Mon, 15 Apr 2024 13:27:55 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 449D9F801C0
	for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2024 13:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 449D9F801C0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BW1+ShCg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 164DACE0B59;
	Mon, 15 Apr 2024 11:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5BC113CC;
	Mon, 15 Apr 2024 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180463;
	bh=FE+i4A70L7DRRL+U0mi5Ziz97jbyagDFCw1I4beVKMw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BW1+ShCg1VAfxs+Ck7wYiiXN6PpqtM4LfVjrdNe7ZlzBLK3/Lru9zS8Zmunvqy+nc
	 ocmPHWfwSV8WfTfqDubrINXno/VHb1hHmEdU61UGVJi6TJIn7bW5sqT9yxUoIqaRAX
	 Mx3mfu6KLLWgL03nRZ0vjY/rgb7+irhRvnrbmg79/LIGyqazxpt/huyctxeVWKhHKt
	 nelcLknBE4GJZBjzS2IQGJEh5EydRwP/t3j7hb60yasMJeMWi9RiYkjYtHJjpTPGg1
	 6a0sQv7d/+ip2nn+Ny1oUPEgXU7b+5m+OpdpVgaE299epp2eGgKmRE2trbOOgD4oYC
	 yp0oRgveyVNRg==
Date: Mon, 15 Apr 2024 06:27:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mighty <bavishimithil@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org
In-Reply-To: <20240415103523.139-1-bavishimithil@gmail.com>
References: <20240415103523.139-1-bavishimithil@gmail.com>
Message-Id: <171318046103.2331667.2375787628199943181.robh@kernel.org>
Subject: Re: [PATCH v3] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Message-ID-Hash: J6EEAEBLNPRXHM276QILXKXZOZG36Q7P
X-Message-ID-Hash: J6EEAEBLNPRXHM276QILXKXZOZG36Q7P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J6EEAEBLNPRXHM276QILXKXZOZG36Q7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 15 Apr 2024 16:05:23 +0530, Mighty wrote:
> From: Mithil Bavishi <bavishimithil@gmail.com>
> 
> Convert the OMAP4+ McPDM bindings to DT schema.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415103523.139-1-bavishimithil@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

