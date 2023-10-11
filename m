Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D76DCD98E7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 02:32:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7507E8F;
	Wed, 11 Oct 2023 04:31:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7507E8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696991558;
	bh=2kt6GpEYEc8TWPUIQauHW2cC+U9TC95GtdTD5AMuWXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EfhamkCGhIIDrm5rdG8Q8DY7k0rTqOY3xZW0CNz+Wnls2TM47tsjvCcz64q49Sojb
	 LphOHa7SQbVZcyk8q7G7s66SzMffl/W93Dlp8EubdSJROXaPvyh1W8WiPy74hY3qd8
	 Qdw7BShW09lhu1AcBvA1XrgDpQDi5Gp7Hfis4+Rs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 343A2F802E8; Wed, 11 Oct 2023 04:31:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 733C2F80553;
	Wed, 11 Oct 2023 04:31:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14579F802E8; Wed, 11 Oct 2023 04:31:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BE56F8027B
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 04:31:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BE56F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sxdTmUcf
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 80D1F60F6A;
	Wed, 11 Oct 2023 02:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598FBC433C8;
	Wed, 11 Oct 2023 02:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696991467;
	bh=2kt6GpEYEc8TWPUIQauHW2cC+U9TC95GtdTD5AMuWXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sxdTmUcfddQMbjHtHzygFI7iHhQppaRc61TRTTgLg79FG3XdyZLUmkIhmx2sDGmrE
	 bI6yKgT1rXtFEa1tH31L0zuSO6PN7iQDP7v3lwOuPXeJmQNycI4APPH69ReNufSXNq
	 BhRyZeWo8EP11u4ndChfI0HpAsxzYtUevHR7wzzrg+hL7CrugQrSq9/UICShEK82W3
	 kbPc4w5w5bG85yIXh4KZQ4x1hQMv1el5VFbuJA5FnSMZQXEitnoLcoZz7PTZ1cTtFf
	 y0+WECKdKwL4wP/rJYK4sAi9AQOac2YvTFr6rKCNQkxWV0d/9J/6YLFv0fiEX5Qrie
	 ptfsmbNPUWo6Q==
Received: (nullmailer pid 2560993 invoked by uid 1000);
	Wed, 11 Oct 2023 02:31:04 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: konrad.dybcio@linaro.org, agross@kernel.org, devicetree@vger.kernel.org,
 bgoswami@quicinc.com, broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 lgirdwood@gmail.com, gregkh@linuxfoundation.org, andersson@kernel.org,
 conor+dt@kernel.org, linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 srinivas.kandagatla@linaro.org
In-Reply-To: <20231011002146.1821-15-quic_wcheng@quicinc.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
 <20231011002146.1821-15-quic_wcheng@quicinc.com>
Message-Id: <169699146356.2560906.8654324582682669209.robh@kernel.org>
Subject: Re: [PATCH v8 14/34] dt-bindings: usb: dwc3: Limit
 num-hc-interrupters definition
Date: Tue, 10 Oct 2023 21:31:04 -0500
Message-ID-Hash: SAGNFIR3NALFYYVTY225K4E3Z37KG5W6
X-Message-ID-Hash: SAGNFIR3NALFYYVTY225K4E3Z37KG5W6
X-MailFrom: rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SAGNFIR3NALFYYVTY225K4E3Z37KG5W6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 10 Oct 2023 17:21:26 -0700, Wesley Cheng wrote:
> Ensure that the number of XHCI secondary interrupters defined for a DWC3
> based implementation is limited to 8.  XHCI in general can potentially
> support up to 1024 interrupters.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: num-hc-interrupters: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231011002146.1821-15-quic_wcheng@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

