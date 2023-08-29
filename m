Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F32C71153
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 19:14:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 386D8DE5;
	Tue, 29 Aug 2023 21:13:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 386D8DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693336459;
	bh=bRYIifLgkuUPG5p3oQ5mGo6bchndBBgLudqkZpSpN/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pzswAHhcmeFfEybeQ/ZcQElIm5mHuxng8ZR7nL7EYntmKA1pAKvFf2K7cRv9qiGEz
	 v1/XHaOcF0uIGrIH2OuGkUtFCeJFr0LnHaWH3Z9DQ4MA/3Vtmu+X6Fchp5plD2Y1Wx
	 YC6zWMhw0vFv6HmPMbvdP5KVKupQs0rhkQqHohD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75266F80571; Tue, 29 Aug 2023 21:12:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E529F80563;
	Tue, 29 Aug 2023 21:12:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D324DF80563; Tue, 29 Aug 2023 21:12:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A135F80537
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 21:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A135F80537
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AVi3GhIE
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A160E61346;
	Tue, 29 Aug 2023 19:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC865C433C9;
	Tue, 29 Aug 2023 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693336351;
	bh=bRYIifLgkuUPG5p3oQ5mGo6bchndBBgLudqkZpSpN/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AVi3GhIEibAzhB4UqxMA/KpFN/QdGTMFAE/DV5noYmVXNkgP7uMbzCZ0qqo7LifEo
	 30+uX7Ku9PVqCvYWjZk03mvcDAiu5JDPgFyH0NHIKOjVq09KJRtVnQS0c15lhSXasb
	 f20QyD4wVzkzJfFnekBUGsix+h9Ef14k3vEuS1jySD/BSrWbI1LyDZqpw4S/u5T+I3
	 P5Q51Eo2VomZPsJnnZeeim0r0X6k67C9mBmqEEfVxbU2agpnm/6ZP8GUi2YNt3XAdn
	 1IFiDf364auENySljCAo/VTO3HUE85C9HkJngJZG3IYDjmOgeXdjH9DJXRkeWswNBW
	 +YD/oLsGurGiQ==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
References: <20230827023155.467807-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH V2 1/3] ASoC: dt-bindings: fsl_easrc: Add
 support for imx8mp-easrc
Message-Id: <169333634070.3145573.16731628887521536226.b4-ty@kernel.org>
Date: Tue, 29 Aug 2023 20:12:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: KX6D5IC7HRMPFSLQFHYL56K5WHISZLWC
X-Message-ID-Hash: KX6D5IC7HRMPFSLQFHYL56K5WHISZLWC
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KX6D5IC7HRMPFSLQFHYL56K5WHISZLWC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 26 Aug 2023 21:31:53 -0500, Adam Ford wrote:
> The i.MX8MP appears to have the same easrc support as the Nano, so
> add imx8mp as an option with a fallback to imx8mn.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
      commit: b5f3cec3159dd28563e5a88096769f7b77272790

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

