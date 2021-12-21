Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEE2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 02:55:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1713617A4;
	Tue, 21 Dec 2021 03:54:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1713617A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640055301;
	bh=EiTu3D/iB2m8ZgFQc5WGcJUsw+qHOMhEI8PMibu7X/k=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prid31ZrfPmxlIBws1Or+QN7tzBXxuOqO5LmHYLJQ0DC78ucQUvxxPW2MT4zO3o8u
	 ZvuywU+MothgHq/OsNtSDDFV+zFs/Gn795eNlZNYtkefKCRMVQmkF2Kz7wW3CpfGlp
	 YRvPY63Ouf9ZDYeNnvJRLpCrafjMFpMHNHlEwQyw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BFB0F80543;
	Tue, 21 Dec 2021 03:51:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CF4BF80525; Tue, 21 Dec 2021 03:51:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67FA9F80517
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 03:50:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67FA9F80517
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JyPlTs+Y"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B95E36136E;
 Tue, 21 Dec 2021 02:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FAFC36AE9;
 Tue, 21 Dec 2021 02:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640055056;
 bh=EiTu3D/iB2m8ZgFQc5WGcJUsw+qHOMhEI8PMibu7X/k=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JyPlTs+YsVk6qMlx/4KGPBKqGgeD48U2knrvRHK6mjclTvpq75mKdQUNeH6PNuF2P
 2J+RalFIZynp83p1nZNV2nfKhp8UGpc18UugoMeBAMc/xM0wWa3k1Fmbj1Scq3b6hX
 w8SWUK3oLD4iF62uVlcnmMFy4sNuTzBj7rIga1LTqyoyJZVmSEFmQqnAOEMCk1H20Y
 RQV6qbfvDTah8MuIQxalbNU1d5PCPXaHwwYNRPa2Y49ltaxQkRx/dAAv4EhCOffbk5
 VJP5h970ZLMTkLhFzWk9wVW7HZffqf2/8tEU/trHCZYdS1fMl2kKouAxCovNDRB0M+
 r65OpwigxV4VA==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>, lgirdwood@gmail.com, tiwai@suse.com,
 perex@perex.cz
In-Reply-To: <20211220093408.207206-1-tzungbi@google.com>
References: <20211220093408.207206-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: reduce log verbosity in
 probe()
Message-Id: <164005505526.2647792.1826732615347816630.b4-ty@kernel.org>
Date: Tue, 21 Dec 2021 02:50:55 +0000
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

On Mon, 20 Dec 2021 17:34:07 +0800, Tzung-Bi Shih wrote:
> Eliminates error messages if snd_soc_register_card() failed.  Kernel
> emits messages if device probe error anyway.
> 
> This is mainly for removing the following error messages during boot.
>     >>> snd_soc_register_card fail -517
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195-mt6359: reduce log verbosity in probe()
      commit: 98bf33ca3f00d76659aa1be1586a433efa74d34e

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
