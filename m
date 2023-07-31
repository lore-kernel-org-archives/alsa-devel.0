Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC78C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 10:53:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 683F4868;
	Mon, 31 Jul 2023 12:53:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 683F4868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690800835;
	bh=VRB/1XE21uItYhBv3v9HcbSnr1pNI+FT1F8W0UoZ4EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BUUCH6q5Kr8+3HQgefY+HklcfMMYpnVq4cegNXCjh8bM5RiUPU2xm800Nh9Et7kew
	 639WdKNhhudH9NSpaVvgDTUSWbaLx2iBZ5Z40zDCI/fj8O3tciaY63CwnP20tltKE5
	 F0jdLUum1UgWFlFPgITkc3B9c8icDlTKAOHBTDtY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0557F8056F; Mon, 31 Jul 2023 12:52:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 084C3F8057A;
	Mon, 31 Jul 2023 12:52:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0282F801D5; Mon, 31 Jul 2023 12:52:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB6ABF8015B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 12:52:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB6ABF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Rx3XU9T/
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B84B161022;
	Mon, 31 Jul 2023 10:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139D4C433C8;
	Mon, 31 Jul 2023 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690800719;
	bh=VRB/1XE21uItYhBv3v9HcbSnr1pNI+FT1F8W0UoZ4EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rx3XU9T/DfTBZmTe1X/pitgrSt+EjtnzJoqNRAZuy+u5vwBhkfxh+hUZZrw8G6eyB
	 lFooQITIfBmh8/jxn75ajaVWWyL+K/4SU45HngfcLfFTzUUGPBR5u+9IjcHh4p2VuV
	 Gn/BP1tBlmjRqXbGir615a2nw2/EGblZCbb/EdH53HfxfeXjlH0iUF72exIeOeH8ce
	 iI0zsUs/KwhnnNIx6Lxy7o7ockkHS9S04Qeay5vnvJcuIp6si4rRnNUb+xaSuY4dlr
	 /lvwh+EQxuP3f465WPY0yRWJu6eDmjBQECj4Tp33HLlFzlfhS5JD89tNI3MxRd9Faa
	 LZXL9lzdwZVlg==
Received: (nullmailer pid 2405199 invoked by uid 1000);
	Mon, 31 Jul 2023 10:51:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-mediatek@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Jonathan Bakker <xc-racer2@live.ca>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 Trevor Wu <trevor.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 Rohit kumar <quic_rohkumar@quicinc.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Rao Mandadapu <srivasam@codeaurora.org>,
 Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <
 tiwai@suse.com>, Judy Hsiao <judyhsiao@chromium.org>,
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230731094303.185067-7-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-7-krzysztof.kozlowski@linaro.org>
Message-Id: <169080070445.2405101.15748974095026995722.robh@kernel.org>
Subject: Re: [PATCH 06/12] ASoC: dt-bindings: samsung,odroid: use common
 sound card
Date: Mon, 31 Jul 2023 04:51:46 -0600
Message-ID-Hash: WN6SGJ4T6UCRPH3XPCZFOKWEXE3L3SBX
X-Message-ID-Hash: WN6SGJ4T6UCRPH3XPCZFOKWEXE3L3SBX
X-MailFrom: SRS0=3R/A=DR=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WN6SGJ4T6UCRPH3XPCZFOKWEXE3L3SBX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 31 Jul 2023 11:42:57 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/samsung,odroid.yaml  | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/sound/sound-card-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.example.dtb: sound: False schema does not allow {'compatible': ['hardkernel,odroid-xu3-audio'], 'model': ['Odroid-XU3'], 'audio-routing': ['Headphone Jack', 'HPL', 'Headphone Jack', 'HPR', 'IN1', 'Mic Jack', 'Mic Jack', 'MICBIAS'], 'cpu': {'sound-dai': [[4294967295, 0]]}, 'codec': {'sound-dai': [[4294967295], [4294967295]]}, '$nodename': ['sound']}
	from schema $id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.example.dtb: sound: Unevaluated properties are not allowed ('audio-routing', 'model' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731094303.185067-7-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

