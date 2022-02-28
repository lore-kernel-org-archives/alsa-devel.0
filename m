Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72361C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 19:19:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEC0818C5;
	Mon, 28 Feb 2022 20:18:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEC0818C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646075973;
	bh=XSSI1r9wkdEO3umehZdkACUwmaQwYPgp78300YUk2nE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQ1Envd5++8WSfKfzARLCTOt4/FCGbp1lJzTYr7sk92oNxENBKrs7+tmDXejB/lVR
	 b8UTHtVpIAHqZMMXv/Q8hO/qBKxVYQcXnkIdgbKH8F18epTPaczECvKVgxI5TVadTg
	 NE2w49Swy+0p+ldqaMbvsbPPRQlev+nnckx9V/U4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE7E3F8054A;
	Mon, 28 Feb 2022 20:15:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3398FF80533; Mon, 28 Feb 2022 20:15:32 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F1C9F80526
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 20:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F1C9F80526
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SV/0TxT4"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BFCB561590;
 Mon, 28 Feb 2022 19:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAD3C340F2;
 Mon, 28 Feb 2022 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646075726;
 bh=XSSI1r9wkdEO3umehZdkACUwmaQwYPgp78300YUk2nE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SV/0TxT4i+2m6x+gRvzomlbEFj6wS1B+fT34heJd9bI+cZvFVhCyq58R0N+8dI0+5
 e9jwZBDkWbsxf+4BC/j2ch46aL5EqWGDvqU4GaCsKTQlmI6x19LFprzfZor1kvoEGd
 t3dChxffdk3zP3SwfxHIY5K8Ipje6B+DkdISFVnnpQ0Y+y0mImh0ZRKn4o23QoJNmw
 doWekFSBnjVKu9+QlxYLftXukMFyUrEV8Ytiizb7CK0vCehHQ2RrvQvihueG4L/Kw8
 bUhFUQGYkEDvtK+A4gLFtx0+TF4CUma6wCm1/YBEtnvJsxcUa57zjy1HTBnlpvQkcd
 mr0Um/PL6d8dA==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220223002502.1451015-1-broonie@kernel.org>
References: <20220223002502.1451015-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sti-sas: Use modern ASoC DAI format terminology
Message-Id: <164607572563.3538791.13959246263010283398.b4-ty@kernel.org>
Date: Mon, 28 Feb 2022 19:15:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Wed, 23 Feb 2022 00:25:02 +0000, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the sti-sas driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-sas: Use modern ASoC DAI format terminology
      commit: a325068e2be110254ab19e2c0fdcfc9f2b9d4694

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
