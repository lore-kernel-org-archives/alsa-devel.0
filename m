Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F8C001DE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 17:51:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE0F8857;
	Tue, 25 Jul 2023 19:50:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE0F8857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690307500;
	bh=RU1yt+0Cu3kvPsoECxJVmwUh0wZQeJo4rj4qI+5pd+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iF1dcot9Mc/qO0xQfFKXotwBvtgtc4ES9zSSXDjkD+zl2hS45PHCKR/9wylow8W8G
	 dluvCn62GM4sz5HfQWvEGP8m81nPlx3J9aIxycOtxYRL2UkixtzB1f07T9+ws781E+
	 c1JwO//lDc5hJBR7oLFTT/MDv3UeyFgmFkKuMwu4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 744FEF80563; Tue, 25 Jul 2023 19:49:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C65A9F8055A;
	Tue, 25 Jul 2023 19:49:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C505FF80163; Tue, 25 Jul 2023 19:49:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1CF2AF8019B
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 19:49:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CF2AF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=luJ/sojL
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D9178616E0;
	Tue, 25 Jul 2023 17:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89EBC433C9;
	Tue, 25 Jul 2023 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690307380;
	bh=RU1yt+0Cu3kvPsoECxJVmwUh0wZQeJo4rj4qI+5pd+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=luJ/sojL/eju59UKvv7KPRUv5zpARMbC8f1KoW1mcTCaBI95NpBwjsFS+jjMlnEra
	 UwRBdCUoOpeQ+PRT23Y9eKuLemPcL8WAUCKUwypqaKayAms4+JmGoK7UpHX8glvsqL
	 WcsQ5CafV2BdB6y5os43l4smEcGY8FPjbW0ZYz7uYTYdwzTmoReIhsKN7y/IaCuWHd
	 8qSOXqN6EeKAJ8r6RE1UO/5CxmHKtnm4hVP4txEBXkBTttne30yHuWBkHkKp6A9S5q
	 HMCvrugtwMy1R9TziQ8J6Ie10YG/5nmHIJBy++pNRTbOPeVG/gsG31kFEfY1eZUmIN
	 uGJVoAGjxh2PQ==
Received: (nullmailer pid 3497937 invoked by uid 1000);
	Tue, 25 Jul 2023 17:49:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org, hugues.fruchet@foss.st.com,
	herbert@gondor.apana.org.au, devicetree@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, lee@kernel.org, will@kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	olivier.moysan@foss.st.com, arnd@kernel.org,
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org, ulf.hansson@linaro.org,
	edumazet@google.com, linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org, andi.shyti@kernel.org,
	arnaud.pouliquen@foss.st.com, fabrice.gasnier@foss.st.com,
	vkoul@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	jic23@kernel.org, linux-i2c@v, ger.kernel.org@alsa-project.org,
	linux-serial@vger.kernel.org, catalin.marinas@arm.com,
	krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230725164104.273965-3-gatien.chevallier@foss.st.com>
References: <20230725164104.273965-1-gatien.chevallier@foss.st.com>
 <20230725164104.273965-3-gatien.chevallier@foss.st.com>
Message-Id: <169030736432.3497864.4682647411146090051.robh@kernel.org>
Subject: Re: [PATCH v2 02/11] dt-bindings: bus: document RIFSC
Date: Tue, 25 Jul 2023 11:49:25 -0600
Message-ID-Hash: FUCVJM2XF5N2DTZETLYRDCW2W7OE6TMQ
X-Message-ID-Hash: FUCVJM2XF5N2DTZETLYRDCW2W7OE6TMQ
X-MailFrom: SRS0=nS92=DL=robh_at_kernel.org=rob@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FUCVJM2XF5N2DTZETLYRDCW2W7OE6TMQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 25 Jul 2023 18:40:55 +0200, Gatien Chevallier wrote:
> Document RIFSC (RIF security controller). RIFSC is a firewall controller
> composed of different kinds of hardware resources.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V2:
> 	- Corrected errors highlighted by Rob's robot
> 	- No longer define the maxItems for the "feature-domains"
> 	  property
> 	- Fix example (node name, status)
> 	- Declare "feature-domain-names" as an optional
> 	  property for child nodes
> 	- Fix description of "feature-domains" property
> 
>  .../bindings/bus/st,stm32mp25-rifsc.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.example.dtb: serial@400e0000: Unevaluated properties are not allowed ('feature-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230725164104.273965-3-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

