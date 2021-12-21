Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FAC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 02:53:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD1031747;
	Tue, 21 Dec 2021 03:52:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD1031747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640055210;
	bh=CBOnNDVujvEbw/nnoMTHDPxRXv/kUzjHeFeU2rQOlDk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8O0Sg4vi135+mrEbRhV3EmGqLRipdFbpc50rJIZGXWJFnb8gicbjLuws46ZVg0p5
	 L7AIEVDWWJa4Ki4AkXtQkEDz+tQKCJqEfKgSonesxOgJ5ll+6+BDMzVI3x8lK+TJZ9
	 ye+cM2v7azz4L4xKcsv0/dsC4U7uvy/s59zfCdvs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89F0FF8051F;
	Tue, 21 Dec 2021 03:51:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1D64F8051A; Tue, 21 Dec 2021 03:50:56 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80800F80516
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 03:50:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80800F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qbUUoFD6"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DC59E6134A;
 Tue, 21 Dec 2021 02:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44981C36AE5;
 Tue, 21 Dec 2021 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640055051;
 bh=CBOnNDVujvEbw/nnoMTHDPxRXv/kUzjHeFeU2rQOlDk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qbUUoFD6ZIaqLfIyjZ+APWVth4zV9qvMrNaj1pP3rgg8MprDy3AIlHLz7YjTFeUnE
 4kvPdKl1iUOIGOUj/22HBi5vQ5e4JaRgqUS8duCfpyP7egEeLSuM14LvIc1P4Ugb3h
 4/xuMprG88K8YNgPjXukEwCMlUuuhpiP3nK248D4KDrAK1KJ2R/+h9EKU7Fiu0IYfE
 TVxFUZEoSxoiuQ0jjFDT1EX2u0FYdpT6xRLraA7LFz6toNMxuT7mBgyEQB6h1TjKTz
 e2QyAVCGEvloDDKWH6QV9pe9LwAhtX8mhNWxJQ4jCC/na7aTn4zlHwOpiSQAUHxkTI
 IVQiWiU7Oex8A==
From: Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <9fed506d-b780-55cd-45a4-9bd2407c910f@gmail.com>
References: <9fed506d-b780-55cd-45a4-9bd2407c910f@gmail.com>
Subject: Re: [PATCH] ASoC: sh: rz-ssi: Check return value of
 pm_runtime_resume_and_get()
Message-Id: <164005505000.2647792.12532978696685822145.b4-ty@kernel.org>
Date: Tue, 21 Dec 2021 02:50:50 +0000
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

On Fri, 17 Dec 2021 10:22:31 +0100, Heiner Kallweit wrote:
> The return value of pm_runtime_resume_and_get() needs to be checked to
> avoid a usage count imbalance in the error case. This fix is basically
> the same as 92c959bae2e5 ("reset: renesas: Fix Runtime PM usage"),
> and the last step before pm_runtime_resume_and_get() can be annotated
> as __must_check.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()
      commit: f04b4fb47d83b110a5b007fb2eddea862cfeb151

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
