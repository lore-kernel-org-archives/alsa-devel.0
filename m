Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD83C04A6A
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 16:58:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4391D820;
	Fri,  4 Aug 2023 18:57:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4391D820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691168321;
	bh=H2I4zXc2nLBpbMumRh3ZQqMyQSqwTBBH0hegTbmAV9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jwOaOrCZ4s8rtLADXh5P7xQlrzvx/+iIjaU8Wvy8osdFmIxa0vBe0njkvnlJwDQpt
	 ktCotqI0sHLN/SlkEWYBYyAinDSG1pGGFeGdTVJg/XVWrlIBRMj99ns19+ZlNewXZO
	 KqhtKbWqrBpb/fV30VQplSBx/mkjKaJy2KFUqBuk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B24EF8015B; Fri,  4 Aug 2023 18:57:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E00E8F8025A;
	Fri,  4 Aug 2023 18:57:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69E6EF80425; Fri,  4 Aug 2023 18:57:37 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 979FFF8015B
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 18:57:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 979FFF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ON1ljACx
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 80491620B7;
	Fri,  4 Aug 2023 16:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FE6C433C7;
	Fri,  4 Aug 2023 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691168243;
	bh=H2I4zXc2nLBpbMumRh3ZQqMyQSqwTBBH0hegTbmAV9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ON1ljACxay13fH0eKtcQ0sm0HX+oy8oRyda6c84If7cwkab2VpSxBcYtJEnF6Zly4
	 jnkWppiPqZC/aQPdeuVtXbaUT2gf7JFSaXXaouS9n1YsRQziu6A1cwv27QcDIDi9y8
	 kofabDzbls8cWDGOERnWZ5dnGOYT/HJpdkIf2lI/dCTiC4xdFmvak8Dxfbv5g44+2m
	 A2FQxuSRLUjQdwO+Rzqfj3UYeVlOYAObgAFnBDLACy1DTaDaEh0vzgpvf08KObYXwP
	 24LPhGPKMJ9gi1oAgH9rYZSoyaolkdPXSXyx6cf7vTgNGcfMRxMdDibJfdWu6sV6QB
	 EodIsV8ebMTRQ==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 shengjiu.wang@gmail.com, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
References: <20230803215506.142922-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Message-Id: <169116824118.110745.15372323880400701432.b4-ty@kernel.org>
Date: Fri, 04 Aug 2023 17:57:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: IZXNTCGTAOXGMOBSFO65TQ7TFVTFE27D
X-Message-ID-Hash: IZXNTCGTAOXGMOBSFO65TQ7TFVTFE27D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IZXNTCGTAOXGMOBSFO65TQ7TFVTFE27D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 03 Aug 2023 18:55:05 -0300, Fabio Estevam wrote:
> WM8960 has the following power supplies:
> 
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power supplies
      commit: 6a41c3a1606089bdf7f8da2b267d1d82fb32b378
[2/2] ASoC: wm8960: Add support for the power supplies
      commit: 422f10adc3eb5a7ff8567bf6e6590a4e4fa756c3

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

