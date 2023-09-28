Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A184E732E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Sep 2023 14:53:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 692DBE11;
	Thu, 28 Sep 2023 16:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 692DBE11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695912805;
	bh=JRSsDtLzeKIy9n8963zFa9jQq53Jmt6jQUGB+nO+3dY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hBu+Cbk/LKvpxhj30holmLy4WphI3YoHepXROGEribEwRBL6mD5ZiEFgQr60gC3ZL
	 ttxQy/hmZ72LQASEhHdNaPo6OITbfq/gwjIDDyVt1krLmF7cvGbnbrxiY8xUCWH33t
	 cL5YMqNAZApsEU89fNXBP775C+I09RC5uhSsX11k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B23E8F8057D; Thu, 28 Sep 2023 16:51:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3191AF80578;
	Thu, 28 Sep 2023 16:51:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4252EF801D5; Thu, 28 Sep 2023 16:51:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D0D1F80130
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 16:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D0D1F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KhbGXl68
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15DD261CB5;
	Thu, 28 Sep 2023 14:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AC9C433A9;
	Thu, 28 Sep 2023 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695912686;
	bh=JRSsDtLzeKIy9n8963zFa9jQq53Jmt6jQUGB+nO+3dY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KhbGXl685KDuzQMQKK4KmHyr+//v0EOw1ynKd8tpIaQUTBt/FLsLUQGAF3wnuO7F4
	 clilN7rRVCPqJszpWblnzRFq3F9LMannjpSmvgnruw/ALzEryN07eD0z+iTKKOSmok
	 jllSTmFRvrf3mpKFg7BMoC49YxjKfsL8TjZB/5WPfGTO5+2zvPVLsnVmmXiAjAuIPW
	 L/AvAFrrn+Mb0QCMWEXIOQcaJqRjMfMU+3Kzdcc6WReBBkU4IqPM7sHR3zKAM7FEM+
	 VeFnUMrVHX/JmS6NyJOgQG+Io0DyJ/lZYurUd/Z6jiXQZkORLvd7+Fzvmno++kSaSK
	 0qZ0NHK/9JORw==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 cy_huang@richtek.com
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Allen Lin <allen_lin@richtek.com>,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
References: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH 0/2] ASoC: codecs: rtq9128: Add TDM input source select
Message-Id: <169591268524.2776105.13245316160946357436.b4-ty@kernel.org>
Date: Thu, 28 Sep 2023 16:51:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: 7LGQCBU3NH4FKSHKIYK6GDFG27UMQHQE
X-Message-ID-Hash: 7LGQCBU3NH4FKSHKIYK6GDFG27UMQHQE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LGQCBU3NH4FKSHKIYK6GDFG27UMQHQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 28 Sep 2023 11:41:06 +0800, cy_huang@richtek.com wrote:
> This patch series create a TDM source select property and use it to
> decide which TDM data source is connected.
> 
> Following by the below patch disccuion
> https://lore.kernel.org/lkml/1695780376-32301-1-git-send-email-cy_huang@richtek.com/#t
> It may not be a good choice to add the user controlable mixer control
> item. Since it follows the board design, make it as a device property.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: rtq9128: Add TDM input source slect property
      commit: bf38a0be7c57e43303600b5afc9b740882b3ed87
[2/2] ASoC: codecs: rtq9128: Add TDM input source select
      commit: 54ac512048c98b720a8fbf5899308788dff8def0

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

