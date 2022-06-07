Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEF7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 10:50:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B72CD1A6C;
	Tue,  7 Jun 2022 12:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B72CD1A6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654599054;
	bh=Eocg/WoOnQVMhqStjfFE/PhpXRbg8Zb2eiWsjThJltc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLExiAsbUkAODtaifDSAUERp4QzImGnlxfe86ckUK9lROw3sfypzJf3WbdzprUahd
	 tfPwzyY0mgL7lOdXu4hAc2s1h+toTI/jDsfzuFoTJk79kxHUuTMHGlWHDYyKqzIYjl
	 BVhK/mJL4CtB5jpPgde/4ouQkiLU73Y9lOrlSNRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FCB9F805BB;
	Tue,  7 Jun 2022 12:46:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20CE7F805B0; Tue,  7 Jun 2022 12:46:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C641F805A0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 12:45:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C641F805A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ckdl49Uv"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B49B46155A;
 Tue,  7 Jun 2022 10:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A11AC34115;
 Tue,  7 Jun 2022 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654598755;
 bh=Eocg/WoOnQVMhqStjfFE/PhpXRbg8Zb2eiWsjThJltc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Ckdl49UvCo61Zyd8mCyUGIRIMZRz/pgoBGpt+QuNEcqnUL6ACZwOKKN4TXWMtGE/N
 jXrELyMqRQ84iBSCRqBRTUazycuGeaoMdU1ny9P509iT2vUozx8I6mnWUuCOhpb3ko
 +dZ5ykX3ZP+I84PPuE8Y3UZ3mfRap1UOKTeZ6SBpNJ6KGf9By8TKBJcU50UmSDn8bN
 7YX4PEtvBRhuQ+QfxgMIXyeXbKSOgTs86fxYUDiRe+Y3ZYWbVK8FiqUk9oU3ucmkO9
 xersV2FmDUJ+/8lE35PO7PvEg7cTWsZtFfbnzbpeOz5SxbKQiTMhfO+42fqKE2XpEX
 jIUNg9PFSKGFA==
From: Mark Brown <broonie@kernel.org>
To: peda@axentia.se, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220602125812.3551947-1-broonie@kernel.org>
References: <20220602125812.3551947-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max9860: Use modern ASoC DAI format terminology
Message-Id: <165459875402.301808.2484874876011374521.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 11:45:54 +0100
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

On Thu, 2 Jun 2022 14:58:12 +0200, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the max9860 driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max9860: Use modern ASoC DAI format terminology
      commit: 8366d8ca0f7805be6cffe1e242822565aed509ae

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
