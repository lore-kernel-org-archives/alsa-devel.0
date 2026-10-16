Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4680CCC6B38
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30C69601F2;
	Fri, 16 Oct 2026 16:24:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30C69601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792160673;
	bh=VUTI1Ps/HVX0yHZlKPgOrBlj7oLbgwa9Zo7YwK2gT8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hu71b/ODdBAVKRXF3I7MU6KMba9IPcCiNpUCFPOsi6ySrxpkF2ki0I8bR9uMlErn4
	 FGrkTUaelzHAX8t5xP/uEhTHpZRiYFHA1MgKBgT3bexRRV+kiKoMs/WyW0qEK+BX5H
	 evJwaAjUtFxJojINZzvcQ4p4e45l3ZVpDch2h3sA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75020F805F3; Fri, 16 Oct 2026 16:24:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4184F80601;
	Fri, 16 Oct 2026 16:23:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42CBFF80423; Fri, 16 Oct 2026 16:23:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792160633;
	b=dTS7WfU+jrsyv7SesNLXy1ZoHLJ1Aer8YEtb6psB1SF8i1yE+vywe54spmlTKHKwitz+
	 kKIgpU19Tv3P5VyX9p3OOav411wLwBlbsAE+WL+uP2lGKw6pIA3/EZKT4XxQanBGJ94V/
	 pBtrbAj7OPtCU2foVt80gVAVOUxc2nP37cHC3R55AlBy7Epi4G7CirKXnPzUr5LvC437S
	 7ldRc2WCqvK0aLbiB9ZXCktznPrq17a+VAhyLYl9MvB9yvTuq1yyyubAtu53KpPVEkvTS
	 uxAUHyL5ESwX2lGDEKt+fmJdRUNfghe+TlO/sQK9IR3dlT4Kb8AUuu1wcaRZgyQvYaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792160633;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=VUTI1Ps/HVX0yHZlKPgOrBlj7oLbgwa9Zo7YwK2gT8c=;
	b=ilviBeHWK6/umXv44/xB9Yqpe7u0oFI9b5ZVPcG4omRry16srEp/KQR+TNrdr7vTzRZq
	 XNTfCJyGPzdj1mOUzr9vy+BkOV5nMf2AA+/sWou8ckXE3Z7M67UdUCqNP/oM6ICpX+13F
	 g7mgSYCTZt7quRGRD18v5XxlRL5BJ1gx1M4061l3KBE4udmB79rbGKA33M+feoeIsJ8/d
	 KUnRhzJPrr4obFeD+vcg0RgVidWvc/l5dOA6WUwGLtboZKBsGX2xTOqbTaibShLNxaExc
	 9mTAv4DnQacX9cym2NtLYk2i1amjRG6tEcB9xoJKUQ3SVn5D2LKJV2NNfrYaURzf3NA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QK8Kk8y5;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7E34EF80212
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2026 16:23:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E34EF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QK8Kk8y5
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A2767437FF;
	Fri, 16 Oct 2026 14:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFE61F000C5;
	Fri, 16 Oct 2026 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160628;
	bh=jKGRCDJywNXIy0o0GEB9rEe4gcEVVIbzwoXeQHDDVew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QK8Kk8y5fELtqLTMkhTC3LXgRQh0ozat6sm07LS8wHWgiaBxbhrC1TnzayqF6kfp+
	 N86A5pnxxGv+1p4BMMZmnE8ymWi2eGGaHWdX8R9I2GfmDIJftqiMB2mWewOBLXCsmp
	 cPycq0nOTwYaDeD9geQAmb4CEPZPwTVyJod7pGK7h/B9eeWE1n/4pwPsnjwoG+G1J/
	 ro6tqXIFamEFHj4hQPAayNmhjV4s5tT1XxBydtxBuqMO0vJqFyduUNyI5Ga5MY34on
	 g5OJKw2XOrv052R1/11UhjvzKQRS8zF0xH2McJH2n54qLRlDWg3qLfJ28olyxMz6Id
	 BzyEks9ZHHBJw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com,
 kernel test robot <lkp@intel.com>
In-Reply-To: <20261016082243.1352940-1-jack.yu@realtek.com>
References: <20261016082243.1352940-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt721-sdca: Fix inconsistent indenting in jack
 detect handler
Message-Id: <179215554214.2297680.18307004591616965300.b4-ty@b4>
Date: Fri, 16 Oct 2026 13:59:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
Message-ID-Hash: 27RWPFRFCOWSXJBXTJ6BXSHNYBVITHJ5
X-Message-ID-Hash: 27RWPFRFCOWSXJBXTJ6BXSHNYBVITHJ5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/27RWPFRFCOWSXJBXTJ6BXSHNYBVITHJ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Oct 2026 16:22:43 +0800, jack.yu@realtek.com wrote:
> ASoC: rt721-sdca: Fix inconsistent indenting in jack detect handler

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: rt721-sdca: Fix inconsistent indenting in jack detect handler
      https://git.kernel.org/broonie/sound/c/ba982c33278c

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

