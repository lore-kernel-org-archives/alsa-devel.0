Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC805EB64DA
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Jul 2023 12:53:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF72EE12;
	Sun, 16 Jul 2023 14:52:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF72EE12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689511997;
	bh=6Ah7bT014+0EnYhqIBI4z9U9khMOfEK4P7UjUPWCSxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Md3CxwtxflS0pkcfVI3fE4/oVPYzjVMOLDX5Hm5y1GriazF2nYimIjeXEN/UvXfSU
	 7QCgb6Tf5ZVxbVdVIrnSx5zHSglHVw+m/fEzgFu8kiWU8oq9xcrR7QAFSN0gY2Qo4Y
	 SPVuNSEV6a5A4vX1XcEk/9sEJhGFVRFM/Fl+fDlw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B99AF80571; Sun, 16 Jul 2023 14:51:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4B0CF80563;
	Sun, 16 Jul 2023 14:51:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E889BF80564; Sun, 16 Jul 2023 14:51:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9AA3EF8055B
	for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2023 14:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AA3EF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=E+h/Ukdh
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CF91C60CF5;
	Sun, 16 Jul 2023 12:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6C1C433C7;
	Sun, 16 Jul 2023 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689511889;
	bh=6Ah7bT014+0EnYhqIBI4z9U9khMOfEK4P7UjUPWCSxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E+h/UkdhumcoJ4HqBmsPIMeTwkRDFC4ycuUsfi8iRjo/ubUHjkhxpR1K2ShJQKkOc
	 GyXh7yw1tRMQ0rqEn42E0GF/lTImLi092PC9i71UtK5av2xpe+uLzPKPsSA9vCJSFM
	 X5cWzUTrORe/FZu77NEXTP+32YWBXrBLWypDOESqxOqoDeR8gTcxpH5BrgSE159a1N
	 bPymxy4PXNuNVCteg5eFUcHlzXVJJSm0gNB/xD0fEUB9AmyoXAQabxl2JsyXNDdl0V
	 ErAvexHeNAjgpPNYUdff8BJpiLVnsDtkAyu7rv+s53wdf2MZ0OHAJRNLjaDisrrCo9
	 InxxOfbrJHd2A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Rob Herring <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230707221725.1071292-1-robh@kernel.org>
References: <20230707221725.1071292-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-card2: Drop incomplete
 example
Message-Id: <168951188735.111741.5556934067507918696.b4-ty@kernel.org>
Date: Sun, 16 Jul 2023 13:51:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: 5UE72D6DGWQU7TA5T3UJ2E73YO6SF3D3
X-Message-ID-Hash: 5UE72D6DGWQU7TA5T3UJ2E73YO6SF3D3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5UE72D6DGWQU7TA5T3UJ2E73YO6SF3D3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 07 Jul 2023 16:17:25 -0600, Rob Herring wrote:
> The example in audio-graph-card2 binding is incomplete, uses
> undocumented compatibles strings, and doesn't follow typical .dts
> formatting. Rather than try to fix with what would probably be a lengthy
> example, just drop the example.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: audio-graph-card2: Drop incomplete example
      commit: c65b21f8aeac86768d387a86dfcbec5980480b6a

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

