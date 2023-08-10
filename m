Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00283C001DE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 07:22:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE18D832;
	Thu, 10 Aug 2023 09:21:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE18D832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691652120;
	bh=0c71K9DeM7QeqvBecvaRkvI2WmiHZjyHAiHiW+B1qZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M1zLgjplEgwWdlU0RPNtLym0ojNzxQXE3SUGgBFaMe6cYQQzTYNg6c3v/WX2z1EDm
	 JHho6dGBI5JdwGRVadOhUsse+Yyzblr8wboEknIofQwjTVcbCxHjdMhoJnbKquO20h
	 lH3ZfWDjI9GHOC0w2fk4bpQNI96cWTbHTkpWFhjY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22EFEF80557; Thu, 10 Aug 2023 09:20:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92E93F80558;
	Thu, 10 Aug 2023 09:20:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1008EF8016E; Thu, 10 Aug 2023 09:20:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA0A5F800FB
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 09:20:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA0A5F800FB
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=unFJi0YZ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B8A7465117;
	Thu, 10 Aug 2023 07:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4B4C433C7;
	Thu, 10 Aug 2023 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691652035;
	bh=0c71K9DeM7QeqvBecvaRkvI2WmiHZjyHAiHiW+B1qZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=unFJi0YZVDppCB3mroZ+tGeB+jeSMJeEtY05YuHeEiRvEhRXyZyDSJffYJFyHdedY
	 gaAoCV2OXoxmLZ/XaxaA03dipcfEtrgb+jwBJvkKfKQHcigpvU56HgOaSgQ8b0nBHq
	 QIx1gIGf1ji+hoeCrdl/Mh3waHFwx551hXKDbytJ+0EbtBA1KfKi7kSBr13YbXol7j
	 iIFDI020XPzol662SIIrheG+yE0T+w/CE/DF/83x4iW+2Ea4IS8gSRfzjNQ1z9rxSx
	 xVuEaPcjgxtY4u50U/sZttRHlXDPyCwMJ2slOhmzXDBKZzSJXx5z6MPbp6ny7iKu5q
	 n8AVYZywnEdHQ==
Received: (nullmailer pid 3911829 invoked by uid 1000);
	Thu, 10 Aug 2023 07:20:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-mediatek@lists.infradead.org, Rohit kumar <quic_rohkumar@quicinc.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Jonathan Bakker <xc-racer2@live.ca>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
 Judy Hsiao <judyhsiao@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Rao Mandadapu <srivasam@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>,
 NXP Linux Team <linux
 -imx@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20230810063300.20151-3-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
 <20230810063300.20151-3-krzysztof.kozlowski@linaro.org>
Message-Id: <169165201731.3911601.3340510494871995282.robh@kernel.org>
Subject: Re: [PATCH v2 03/11] ASoC: dt-bindings: samsung,aries-wm8994: use
 common sound card
Date: Thu, 10 Aug 2023 01:20:21 -0600
Message-ID-Hash: 55Y4PK5QMMPSZMJYSV3IMSWDAQ6TXKB7
X-Message-ID-Hash: 55Y4PK5QMMPSZMJYSV3IMSWDAQ6TXKB7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/55Y4PK5QMMPSZMJYSV3IMSWDAQ6TXKB7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 10 Aug 2023 08:32:51 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/samsung,aries-wm8994.yaml     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810063300.20151-3-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

