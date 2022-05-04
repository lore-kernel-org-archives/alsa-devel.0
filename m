Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA15C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 May 2022 20:38:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 574FA1777;
	Wed,  4 May 2022 22:37:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 574FA1777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651696715;
	bh=1x6d0c1VcJVLCQrLiqIiA9Eq7CkM4/3TNYeopi2LLbE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bt9+IwrXHRgmVS+MbJpGQWCB+v4YH08pzmgnJfy/qn/hp4yKOmrE0gEp5tBIbfmwq
	 IOzJ2k2ZrSYGKeyDe9F66tmrX7aq65yt7U7zioT2avFfz8YDrlHLMCMGEGlAGBY06R
	 d0Bz3UP5tciV7H7qmCWT/JyDJmWXZO2WfB15eheI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EBB5F80431;
	Wed,  4 May 2022 22:37:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8870DF80163; Wed,  4 May 2022 22:37:09 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A39EF80129
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2022 22:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A39EF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="me5bxklD"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2FB71B828CE;
 Wed,  4 May 2022 20:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21688C385A5;
 Wed,  4 May 2022 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651696621;
 bh=1x6d0c1VcJVLCQrLiqIiA9Eq7CkM4/3TNYeopi2LLbE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=me5bxklD3rexV+BLJoIK7ihdV6AZ8TJlBbyF05vQ/SgbT486sOHD6NGjTJNXNFFav
 qGz6AE9kiJ/bQ7QoR/wGaIODvn4Sfmf1JtPjmhJBfNY7J9SqrHIecES7ir+clfVoJd
 KPq+Leoeez40BCV+bAwoTZseXjYLhGsAims9OEhIIl7nevoAduf0xrUASi4Hx56Bqi
 wiP/VBIxztrrPPbVEA8tZSMXytGgxjwQTEkE8VKAUZ6bri1T40tq+Hix2gaczV/ZBH
 PDspG2kqoLk1LSLZxcgFyxiD11nmoMwUHChmRTPNOpTgCQfQZeqMlihc2l6HoCpNim
 d5VBKxu1uS8SA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20220502131335.2604158-1-s.hauer@pengutronix.de>
References: <20220502131335.2604158-1-s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: soc-generic-dmaengine-pcm: Use default config when
 none is given
Message-Id: <165169661985.1744642.14178720202501273376.b4-ty@kernel.org>
Date: Wed, 04 May 2022 21:36:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: lars@metafoo.de, kernel@pengutronix.de
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

On Mon, 2 May 2022 15:13:35 +0200, Sascha Hauer wrote:
> snd_dmaengine_pcm_register() can be passed a NULL pointer for the config
> which means that the we have to test for pcm->config being non NULL
> before accessing it. Make the code more straight forward by providing a
> default config when none is passed. With this pcm->config is never NULL
> and we can skip all the if (pcm->config) tests.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-generic-dmaengine-pcm: Use default config when none is given
      commit: 43556516fffe1d2be2d4a73cfe7cd34d6062dd11

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
