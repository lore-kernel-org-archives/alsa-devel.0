Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E792CD343F
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 04:37:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1570B60204;
	Mon, 18 May 2026 06:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1570B60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779079019;
	bh=JEPSreuah6T4boxYXAVzGh3P6xLFXZ0PQPG4DvjoprU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JdIJ+wwZRf6b0uJPTEZSCFBkUtlUWmZS366/C7vqZRk3h/1V8SdakRf4lJ5IYepBk
	 isKz/umVtr/qVp1iz8ZfDARKKKgsUIewvZKPdkZXJGzk4HZPMBOrZwuJcrK66SHvAD
	 1KztyO8iCiQY9WywOlIHE1DC806/MfJbgRyoJ/EA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 265B0F805ED; Mon, 18 May 2026 06:36:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3ACFF805F2;
	Mon, 18 May 2026 06:36:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 290A6F804F3; Mon, 18 May 2026 06:36:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD5B0F80169
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 06:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD5B0F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Z/xR9gXR
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4040540432;
	Mon, 18 May 2026 04:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F17AC2BCB7;
	Mon, 18 May 2026 04:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779078970;
	bh=JEPSreuah6T4boxYXAVzGh3P6xLFXZ0PQPG4DvjoprU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Z/xR9gXROAfI1J4egeZRqDHcrA6bwqWpDcFClWx9owR2+ornhKjZ0TAtXofsZMjro
	 PIRZbqOZF/XqYdKUoZK11PyMX2c7juGSw2OgwOiLyj0vqF3v0HVR4N3nbNDlGBN63Y
	 pTU1hnnfFBFVErbDbqXlhW6OTTCrx5iTBMD4etlDrqZeptyBUxcjtUI60frc/A334m
	 vyf8LRPEOjmb141J3Ocz97+qhlCwxcb5ER5C4NnBt00GWb5VZRDZGPBmo0GwAwLgWH
	 mAGv3B7krHulDZI8InZ67rVQ7wpdtei8QpJ2CzGS035H5buHZ6QEaP+syBg0c+9gS5
	 cjXSFbIs5vh/Q==
Date: Sun, 17 May 2026 23:36:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lgirdwood@gmail.com, kchsu0@nuvoton.com, neo.chang70@gmail.com,
 perex@perex.cz, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 broonie@kernel.org, devicetree@vger.kernel.org, sjlin0@nuvoton.com,
 tiwai@suse.com, alsa-devel@alsa-project.org
To: Neo Chang <YLCHANG2@nuvoton.com>
In-Reply-To: <20260518024704.118613-2-YLCHANG2@nuvoton.com>
References: <20260518024704.118613-1-YLCHANG2@nuvoton.com>
 <20260518024704.118613-2-YLCHANG2@nuvoton.com>
Message-Id: <177907896943.890754.5956583926974686383.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add
 NAU83G60
Message-ID-Hash: DUP7EFKVCVPQCH5RKYIHQNUHRGS6QMZS
X-Message-ID-Hash: DUP7EFKVCVPQCH5RKYIHQNUHRGS6QMZS
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DUP7EFKVCVPQCH5RKYIHQNUHRGS6QMZS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 18 May 2026 10:47:03 +0800, Neo Chang wrote:
> Add device tree bindings documentation for the Nuvoton NAU83G60
> audio amplifier.
> 
> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
> ---
> Changes in v2:
> - Dropped the word "driver" from the description.
> - Removed runtime/software configuration properties:
>   nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
>   nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
> - Added missing "nuvoton,dac-cur-enable" property for static speaker impedance matching.
> - Removed unnecessary '|' formatting from single-line descriptions.
> - Fixed typo in firmware-name property.
> ---
>  .../bindings/sound/nuvoton,nau8360.yaml       | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml:25:53: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml:25:53: mapping values are not allowed here
make[2]: *** Deleting file 'Documentation/devicetree/bindings/sound/nuvoton,nau8360.example.dts'
Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml:25:53: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/nuvoton,nau8360.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1639: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260518024704.118613-2-YLCHANG2@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

