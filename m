Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0BBCCA479
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 16:00:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42C911743;
	Mon,  4 Jul 2022 17:59:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42C911743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656950406;
	bh=VZMFMq3ppDHBINfkSF5+BJgjRTEiJ6f8sgYyWjcwsPc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPSivZd40w7Hh9lqFzk5ECygx6Z6SAnZNB86GDtFhjY2F+3TjpKf9ClqZqtdOjj7J
	 9nrScLKiBPuCPx/qkl2ba+uhZ6VWwxJ6WEoNUxCTnexwC5w0RO8vv70vrTfHBh/hiR
	 9gQ3ufJKtcKPCKJSNvBQZYCuloQL1U7oF6ga3mz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1674F80553;
	Mon,  4 Jul 2022 17:57:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56E29F80542; Mon,  4 Jul 2022 17:57:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8389DF80141
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2022 17:57:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8389DF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rJc1f3ce"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECA460EAC;
 Mon,  4 Jul 2022 15:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C6C341C7;
 Mon,  4 Jul 2022 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656950272;
 bh=VZMFMq3ppDHBINfkSF5+BJgjRTEiJ6f8sgYyWjcwsPc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=rJc1f3ceNiHJxcmd6MQ9G1Exemf9amfYErTe4XjxJctna8fG8BUPMci2sk412jXbN
 ffDn7XLQQ4R52NyjU4l54XV79S65YTg32XvJuGZ33TOL2frFRUof+2Z5I05sNtvMdS
 7XRRKwMa1RrVvFSAmeL86SPi4cknTGOrRPKbtkAx0bHQXV6kl3tPAzg3HDMBGJBxbb
 YNl1i+l1ZYGTxvzxG+L5nFOM1fOWmBxbKCkaBdbxl+iUm971atRLzIXY3rBfnqYPJu
 m0fN3ZWdbaZCa4qaAtUzA+9j4MOc3rXrcZHVXlbEJxtEW/7TtrJFsyzj3ee5AhjjzO
 Gs2hI7yEG8viA==
From: Mark Brown <broonie@kernel.org>
To: zhuning0077@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20220704012416.3165-1-zhuning0077@gmail.com>
References: <20220704012416.3165-1-zhuning0077@gmail.com>
Subject: Re: [PATCH] ASoC: codes: Add support for ES8316 producer mode
Message-Id: <165695027086.481068.16537252704599856592.b4-ty@kernel.org>
Date: Mon, 04 Jul 2022 16:57:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: vijendar.mukunda@amd.com, tiwai@suse.com, yangxiaohua@everest-semi.com,
 pierre-louis.bossart@linux.intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 4 Jul 2022 09:24:16 +0800, Zhu Ning wrote:
> The AMD acp-es8336 machine driver requires ES8316 run in producer
> mode, which is not supported previously.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codes: Add support for ES8316 producer mode
      commit: 3684020a82ff43a64b5a7e42564ee7e2065d3011

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
