Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91010C04FFE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 May 2024 12:55:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 078C7E80;
	Wed,  8 May 2024 14:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 078C7E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715172951;
	bh=gKVeUXfF3Ho2Ed/J5T0T6Hm5ka9z6vCma7xttwCG1nk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NqYudVpoWACtBdl70wEJiklGAi2wyz0o4V18a3d5to+R23W1gdp3lslOa9aoDDsWP
	 EirzKZtJRg1EsvJnGixYBH4hqoTUnICG75yPlqoSvxfbhR7ZhvkhM/u3VpVbDE1F5x
	 4LKSlORwuuNKctLM4lJqJi5M0exzwRoZ2JIuUdz8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C078EF805CB; Wed,  8 May 2024 14:52:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C2A1F805D5;
	Wed,  8 May 2024 14:52:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E947F805B0; Wed,  8 May 2024 14:52:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23569F805AF
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 14:52:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23569F805AF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZrLk9kfT
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C9E8161A88;
	Wed,  8 May 2024 12:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F67CC113CC;
	Wed,  8 May 2024 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172736;
	bh=gKVeUXfF3Ho2Ed/J5T0T6Hm5ka9z6vCma7xttwCG1nk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZrLk9kfTvdSk83ynbdqCIsg3st29lqtv/1sbYd9zMlbJIpR4kz4maM4bvCc7bhE6o
	 yeicwe6Lpe564y7ZeTXYSLQ51IQiSSW6S58nizMsqt4fhTcbYbrz9oSh5jnQnsLR98
	 y931YLg6R1Ue4LfhfurZjJByaIrDXAfJ1nNHI25RxtqX10yYg+hyCmxTQ044mJ95cQ
	 BJscpF/cQ2kK6GpAtC24TBHrXSBgMEXPptoXeyuP87wtgDwxMyEr5SPdO51/hPMPW3
	 IbFXQNFkPg2LMoFzyVXpN3PW2HKrAafh5ByHt/Rm86AsDKEYJWCokE7W0PqxVp3L/Q
	 iq/BrU0R0khYg==
Date: Wed, 08 May 2024 07:52:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-samsung-soc@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, ~postmarketos/upstreaming@lists.sr.ht,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240508-midas-wm1811-gpio-jack-v2-2-b4d36cd02c6e@gmail.com>
References: <20240508-midas-wm1811-gpio-jack-v2-0-b4d36cd02c6e@gmail.com>
 <20240508-midas-wm1811-gpio-jack-v2-2-b4d36cd02c6e@gmail.com>
Message-Id: <171517273028.1398305.2447515495565580200.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: samsung,midas-audio: Add
 GPIO-based headset jack detection
Message-ID-Hash: XLKQKLI45N5MWCZUIU67NLFQYJJJ73I6
X-Message-ID-Hash: XLKQKLI45N5MWCZUIU67NLFQYJJJ73I6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XLKQKLI45N5MWCZUIU67NLFQYJJJ73I6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 08 May 2024 12:58:50 +0200, Artur Weber wrote:
> Some Samsung devices that share the midas-audio driver use a GPIO-based
> approach to headset jack detection, as opposed to using the built-in
> jack detection provided by the wm8994 driver. This setup uses two GPIOs
> (one for jack detection and another for key detection) and an ADC
> channel for determining the jack type or button pressed.
> 
> Add DT configuration values that allow for describing these setups.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v2:
> - Added vendor prefix to threshold properties
> - Dropped pipe (|) character from description: field
> ---
>  .../bindings/sound/samsung,midas-audio.yaml        | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml:95:26: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/sound/samsung,midas-audio.example.dts'
Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml:95:26: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/samsung,midas-audio.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml:95:26: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240508-midas-wm1811-gpio-jack-v2-2-b4d36cd02c6e@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

