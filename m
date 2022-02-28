Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56D1C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 19:16:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3F481856;
	Mon, 28 Feb 2022 20:15:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3F481856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646075804;
	bh=n970wkhNzvihLndN2akyxgfz7VyjYmRetDNKF1oA1d0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbg5IP29NKC1YQhmTbp1CKDGqvUuSCXN1ZneAvpuWEGO1MjIpKHZ3OsZueTRGjsUA
	 2pJaCtnlrUlFiwusVTQgpae5mMAxI+zSkrbBpOfmRe22GowbHaE01dsmnlhI8nuWMc
	 JM0Gz3BMGKXTeereY8LsP0cbPp1tsdj7I5WmPtQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2EC3F8015B;
	Mon, 28 Feb 2022 20:15:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE717F80154; Mon, 28 Feb 2022 20:15:19 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43A27F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 20:15:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43A27F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZGw1hBcT"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 763E7B81629;
 Mon, 28 Feb 2022 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5683EC340F4;
 Mon, 28 Feb 2022 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646075714;
 bh=n970wkhNzvihLndN2akyxgfz7VyjYmRetDNKF1oA1d0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ZGw1hBcTs7nylEOt18ILXhUaIPuZJ8yRFjpU85zyLZxCDBvrtH0jrx4APDRZ+i97V
 tbPACgrkv/TDPUCMg4wPzKcn62jWaypbp354XAQhUvlKtn20OHzKoyeFya+MSHFR6A
 8efluzZSJ7eaY9V8x0Elbn8T2UBVmUKQ7urw4fX0Xbi7UmyjOLHwzxv/aIecOl61H9
 aOsWEPkNSFur0574JHXWdaXd6CHZJpFb0wDBN6RXrJJX2YY8B2sSWUdfGDPtsNetCS
 8B6poSWCh2F/WOITaBi0EJbUJctZb8Rdfhq5Bb4HgNJbGmIjEiXO6BABmSmzmxVUtG
 wyDDWr9jNKQ9w==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220222223300.3120298-1-broonie@kernel.org>
References: <20220222223300.3120298-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: es7241: Use modern ASoC DAI format terminology
Message-Id: <164607571306.3538791.6510062200954637756.b4-ty@kernel.org>
Date: Mon, 28 Feb 2022 19:15:13 +0000
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

On Tue, 22 Feb 2022 22:33:00 +0000, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the es7241 driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es7241: Use modern ASoC DAI format terminology
      commit: 316cd9412679fb36a0d4bcc6f4a045da467334e9

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
