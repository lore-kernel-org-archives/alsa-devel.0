Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8C0C197A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 17:20:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3F56A4D;
	Mon, 20 Nov 2023 18:19:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3F56A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700500840;
	bh=KdMpAjwTLabg6HzVjLeUzYXEVS5h+SXTPQxdrCJRAIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mYhT/DIMtTPr55zoBN1+hmzF8KOYEz6cGKtWpWgwkFS3/+9jMVv3rpO5wsKu/e5M7
	 9toC2zeChTlLFOcdk3M/2wElVK4F2LRqtIDS/bxMHApqq8CrootbT+fvvgYLb/DVfA
	 p0jk4bGgquwB+SP+ibVFTi6B6ZNHiZk0iVx/K7iE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2B1FF802E8; Mon, 20 Nov 2023 18:19:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B9F0F80246;
	Mon, 20 Nov 2023 18:19:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77872F80254; Mon, 20 Nov 2023 18:19:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3202F80246
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 18:19:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3202F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MbkZ/8v3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0B0146130B;
	Mon, 20 Nov 2023 17:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2594FC433C8;
	Mon, 20 Nov 2023 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700500743;
	bh=KdMpAjwTLabg6HzVjLeUzYXEVS5h+SXTPQxdrCJRAIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MbkZ/8v3f6a4IWq1LjYkb+LgMt02kowAVS4nSrzE3iP4nIvKyGcF5Aseln0UQCdVG
	 sWYH2Oe2W5tuV5Uxby/rzX6qgpbQ7xvJfwS/EK3x/MU/taTzrn3GZzVXtjKcOWTEa7
	 dBrwGbPRqPBrCWhFmbTPQlIFgaoSrd9TSG9NSrIsZ/9pxa6ZyK6m7TXqQ0tBGo4m7M
	 fxJ4mbBHxdsFtzdwK1+RiMbOEXyGziBFdujaUDUw9fXliyQKwUF73SUIBCp9xli9lH
	 hnHTC60SSv02klKw4X15blN2kdL738A0y8NFEjSxqcLl7Oz7H1BUUojHS2b7VVLU8P
	 8RMyaod0Hr2Nw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Lucas Tanure <tanure@linux.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231119104514.25536-1-tanure@linux.com>
References: <20231119104514.25536-1-tanure@linux.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Remove duplicate linux/of.h header
Message-Id: <170050074083.869901.16484540368376230648.b4-ty@kernel.org>
Date: Mon, 20 Nov 2023 17:19:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: D3MFV564JRRNJ2NXVNWOER25MVJHTWME
X-Message-ID-Hash: D3MFV564JRRNJ2NXVNWOER25MVJHTWME
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D3MFV564JRRNJ2NXVNWOER25MVJHTWME/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 19 Nov 2023 10:45:14 +0000, Lucas Tanure wrote:
> Remove linux/of.h as is included more than once.
> Reported by make includecheck.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: Remove duplicate linux/of.h header
      commit: cac15dc25f416972f8dd0b6a8d74daa79dc3a998

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

