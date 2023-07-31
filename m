Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E86C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 14:43:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7E3E83B;
	Mon, 31 Jul 2023 16:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7E3E83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690814584;
	bh=x6gwteO8wm+nEx6S7vKzpRLQHolXy2la/OsV7eQgzEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fLKK8TXZ7ndBg2BgHEubgoU+NpuTTEmvaCAPnOWN5FLBRfN8ZfW7WWu2VRg2N/6n1
	 LKDcuDtglzkcR4IcDZC/eaIxH6Yi7c7M3CB27hVKnpiD81eh1GNclInzxzf3Gm/8Rf
	 bSgn2w7w3Y/HzcWcQfad1Jd60J7+2Jy1H9hK2Ui8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DC7EF80551; Mon, 31 Jul 2023 16:41:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88DEAF80549;
	Mon, 31 Jul 2023 16:41:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E83F5F80549; Mon, 31 Jul 2023 16:41:29 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00E9AF8053B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 16:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00E9AF8053B
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TFg73a75
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEE661182;
	Mon, 31 Jul 2023 14:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F82C433C8;
	Mon, 31 Jul 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690814485;
	bh=x6gwteO8wm+nEx6S7vKzpRLQHolXy2la/OsV7eQgzEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFg73a75Trc6lH/hs+o1+Ry1vWzVceNDfCSrck4T4k2Zycc5DcrUb1SObuv4R+WTk
	 wKrBBZ8qX61ki6uw+u0gUwd3z81ZBzP8pt6Zethmoy0GeqUq20lQpVK2jVxFA5Mgz7
	 iXkgDrwFGGc2UpALMZHoffcG11GqhvgvG+JRLtf6VWGgQhT2cdGeRj3SeXjJEt1bBQ
	 83Z+PZ8zG1LREBDbyu5VytllfsRgoAOWRiq4ghsIY6EslP1JaKoU2S5WqCG4Dg9D8s
	 vmVAV+uzkNllnwIMFLnTQ5HgSQ1V57actO28GEiPXqoN2HXYshs6lODA+fbKFn4zcD
	 LkP4LDDA1/g6Q==
Received: (nullmailer pid 2934074 invoked by uid 1000);
	Mon, 31 Jul 2023 14:41:22 -0000
Date: Mon, 31 Jul 2023 08:41:22 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Jonathan Bakker <xc-racer2@live.ca>, Jaroslav Kysela <perex@perex.cz>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Rohit kumar <quic_rohkumar@quicinc.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Rao Mandadapu <srivasam@codeaurora.org>, Trevor Wu <trevor.wu@mediatek.com>,
 NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-mediatek@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Judy Hsiao <judyhsiao@chromium.org>, Shengj
 iu Wang <shengjiu.wang@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: samsung,aries-wm8994: use
 common sound card
Message-ID: <169081448188.2934017.10192674386465397658.robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094303.185067-5-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: BWAACUUQPFC4IA4TOH5Y7WUPLF2DYGPU
X-Message-ID-Hash: BWAACUUQPFC4IA4TOH5Y7WUPLF2DYGPU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BWAACUUQPFC4IA4TOH5Y7WUPLF2DYGPU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 31 Jul 2023 11:42:55 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/samsung,aries-wm8994.yaml     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

