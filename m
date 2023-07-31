Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63211C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 14:42:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63E2E828;
	Mon, 31 Jul 2023 16:41:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63E2E828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690814557;
	bh=x4X6Vd4MRx2u+DQtuUwqxC+IvYEZ7pG3KR2WaNQBYVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lE7KjuR1TdYZTwdoRN0zzAKmSMkSFM1wi6viAzeOJ6Otr2jz0TVR8qbmBCMUeZQrE
	 kQJA8wA0Bi6tEygRRvgE+ySQt9TsVKLIBzdMvrivh7SAEmaDoaW7cbC1UdFY36wIPw
	 irx4EUT5IRkwbKu7Tw7f9cSRDRjEm8iBOkUhE0e8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6339F80520; Mon, 31 Jul 2023 16:41:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29B89F8016D;
	Mon, 31 Jul 2023 16:41:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35733F8016D; Mon, 31 Jul 2023 16:41:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3F18F80149
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 16:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3F18F80149
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Dk1cKjTr
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7025261147;
	Mon, 31 Jul 2023 14:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B05C433C8;
	Mon, 31 Jul 2023 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690814474;
	bh=x4X6Vd4MRx2u+DQtuUwqxC+IvYEZ7pG3KR2WaNQBYVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk1cKjTr8txjG9myauSyi8srO181x1piSN1rK92aHBebGpNOcqRb6HqzSJEnBo1cj
	 rUIDAm6L5xuxAxxVpuGbrLJsdBO5KL40y3ephQ1ed4GaaypQs1Oq/u4FQp4ANCGRg9
	 nbTI1RZTu38vjQSeE7juA9omyarQaqPLuCMJ3fVjAbIp5JQxnCWpqiDjgfdplHIA7c
	 0RemcawB1evy/A9Weu6III9F+g9+g0S73KmAkWcqUdsvA/dlQLyIhy6rmdlahzfxq+
	 06FDc5NkRENLxMAih/bIvKuJ7tZAUAmoqzBrfk/yaaPf5Mw/BoIQLaHPP1ELwVT0ti
	 AFIHsv+qn3/hQ==
Received: (nullmailer pid 2933791 invoked by uid 1000);
	Mon, 31 Jul 2023 14:41:11 -0000
Date: Mon, 31 Jul 2023 08:41:11 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Rohit kumar <quic_rohkumar@quicinc.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
 Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Cheng-Yi Chiang <cychiang@chromium.org>,
 Rao Mandadapu <srivasam@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Judy Hsiao <judyhsiao@chromium.org>, Jonathan Bakker <xc-racer2@live.ca>,
 Jaroslav Kysela <pere
 x@perex.cz>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 03/12] ASoC: dt-bindings: mediatek,mt8188-mt6359: use
 common sound card
Message-ID: <169081447103.2933713.1299872449693848874.robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094303.185067-4-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: I7O6AYZX2CJFGNHG2VGF5D3DKYORDIPH
X-Message-ID-Hash: I7O6AYZX2CJFGNHG2VGF5D3DKYORDIPH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I7O6AYZX2CJFGNHG2VGF5D3DKYORDIPH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 31 Jul 2023 11:42:54 +0200, Krzysztof Kozlowski wrote:
> The mediatek,mt8188-mt6359 Linux sound machine driver requires the
> "model" property, so binding was incomplete.  Reference the common sound
> card properties to fix that which also allows to remove duplicated
> property definitions.  Leave the relevant parts of "audio-routing"
> description.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

