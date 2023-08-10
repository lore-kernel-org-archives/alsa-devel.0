Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF185C001DE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 07:21:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 000D0827;
	Thu, 10 Aug 2023 09:21:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 000D0827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691652115;
	bh=uDem4JB4q4sqaGrfpIol0gA2878l0HxFLOab51e8w/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hRPVNknl4+sYqHR2G+oXDvu5qlVobgUQmq6nO3XDXCi0E1sB1j35hK3rENbiXt47G
	 yc6H2OmSZOqjxW4/fKSeRYIjPvWYiXMamQm2gaUuT1HkdEOE+BECGaoZ7ZnH+HlPA+
	 e+aGJO5nJ9rFUx73fXQpaxf9O97F9G+TqYaLinos=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B195F80549; Thu, 10 Aug 2023 09:20:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0A5AF80510;
	Thu, 10 Aug 2023 09:20:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90A91F801EB; Thu, 10 Aug 2023 09:20:37 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BB04F800EE
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 09:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BB04F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t8cE+sHy
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 46F5765130;
	Thu, 10 Aug 2023 07:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5818C433CD;
	Thu, 10 Aug 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691652029;
	bh=uDem4JB4q4sqaGrfpIol0gA2878l0HxFLOab51e8w/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t8cE+sHyKQfkjcNjnVokiMoo+/ikMe8yxMASHFjjc4/v+k3HyoyfAeRHVETZX7Vh7
	 fOk5g1vv0XoxMX+94xwFhfSmULhLyj1zkkyqM9qQwew0FAzWv6xvMDH2EDv0CMaaOZ
	 UCtBWpA/BVcXo+wjQvvNAa9oVChK8bX79bdB7MhcNpUjfKq8lrqJGPJnPRKw/ry3WL
	 JN41w6jK6ddL0DZDz+IyHaFH07HLUhCOW7RTbSDTsVY1SApJfValbQFMO+aqDzcDH1
	 gzUXPnHOtDofoN5clwrDWG4VKp/xD8JaQSadxupBYJf3hJ9m1WZMP5KpkbD+ALmzSf
	 fxWSp2jonvTGg==
Received: (nullmailer pid 3911827 invoked by uid 1000);
	Thu, 10 Aug 2023 07:20:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Judy Hsiao <judyhsiao@chromium.org>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Jonathan Bakker <xc-racer2@live.ca>,
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Jaroslav Kysela <perex@perex.cz>, Rao Mandadapu <srivasam@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Rohit kumar <quic_rohkumar@quicinc.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matth
 ias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230810063300.20151-2-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
 <20230810063300.20151-2-krzysztof.kozlowski@linaro.org>
Message-Id: <169165201641.3911557.18445521260746432395.robh@kernel.org>
Subject: Re: [PATCH v2 02/11] ASoC: dt-bindings: mediatek,mt8188-mt6359:
 use common sound card
Date: Thu, 10 Aug 2023 01:20:21 -0600
Message-ID-Hash: LMDXPENIPFL2BKZ3TYFIEORF5PBFOI6J
X-Message-ID-Hash: LMDXPENIPFL2BKZ3TYFIEORF5PBFOI6J
X-MailFrom: SRS0=zxi7=D3=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LMDXPENIPFL2BKZ3TYFIEORF5PBFOI6J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 10 Aug 2023 08:32:50 +0200, Krzysztof Kozlowski wrote:
> The mediatek,mt8188-mt6359 Linux sound machine driver requires the
> "model" property, so binding was incomplete.  Reference the common sound
> card properties to fix that which also allows to remove duplicated
> property definitions.  Leave the relevant parts of "audio-routing"
> description.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810063300.20151-2-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

