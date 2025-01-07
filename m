Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74018E77199
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:33:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 837096034D;
	Tue,  7 Jan 2025 16:32:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 837096034D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736263988;
	bh=/0+QS6NTsRX/IygMfwY5jtbYiTI2pYu6dSVDhDfOj74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rn3FjMuVX0PHGADR483TQP5CE9cmnCo/qq23xEZYpOnVJ9pfbkLri02jcg0yVh74/
	 /u8qjPy+ZDLkrtlkSAzFvjtJQHIi+dIHbzwJ+swWbzoAtiBsAvoFY6BYHGcysGUiTa
	 Hm8sIOuPqFQy329Z87A6fLRFxZb/ph33bRDLCUQk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01CBAF805F0; Tue,  7 Jan 2025 16:32:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C0BBF805D6;
	Tue,  7 Jan 2025 16:32:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70303F802DB; Tue,  7 Jan 2025 16:32:07 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0D85F800F3
	for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2025 16:32:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0D85F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O1dS/RLG
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 592F05C51AB;
	Tue,  7 Jan 2025 15:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56BEC4CED6;
	Tue,  7 Jan 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736263924;
	bh=/0+QS6NTsRX/IygMfwY5jtbYiTI2pYu6dSVDhDfOj74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O1dS/RLGi91wgrGohwLo1tvVFRP7zLANTwQkUpBli0Z6Q/Rh7b0gp0dsA+1qXRYen
	 iieB7FCEEIdHfNjG2dxcmtdmWGItosU9sedRvItUY/L0YHNdNxDfnNTStov51lcxf9
	 tHyxIGI66nAbFqOD47Cb2y56rYSlSuuvyl8o9S/yguZs8PCqobWZT9qoBR+bu+f0SN
	 Fnb+sxMdddOf16uIoOfMfvq/PI8imv7qZsXZ3Ww6Bf6Cd/1eQhGZQ8dRKVM5Tfc+RZ
	 Gr51DWg6ypO3E9HfU9yMDrU/AymnY/MaSMFY/MwAFluxm8o8pZPYAiXYRhmFMOHpjM
	 RajZIRMYc14dg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, tiwai@suse.de, baojun.xu@ti.com,
 Baojun.Xu@fpt.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20241227074909.1974-1-shenghao-ding@ti.com>
References: <20241227074909.1974-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Fix occasional calibration failture
Message-Id: <173626392241.92253.9803996324620777407.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 15:32:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6
Message-ID-Hash: 3ROVY4IJIRPCPZXUEB76TUF5OWRCI5EA
X-Message-ID-Hash: 3ROVY4IJIRPCPZXUEB76TUF5OWRCI5EA
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3ROVY4IJIRPCPZXUEB76TUF5OWRCI5EA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 27 Dec 2024 15:49:09 +0800, Shenghao Ding wrote:
> The root cause is that TAS2781 internal register is not unlocked
> before writing data into TAS2781_PRM_TEST_57_REG.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix occasional calibration failture
      commit: cf86e0ae60a225e2c7921ced755e922da9012bea

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

