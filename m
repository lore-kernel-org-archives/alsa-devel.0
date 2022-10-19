Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A5CC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 12:07:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EFE2A824;
	Wed, 19 Oct 2022 14:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EFE2A824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666181219;
	bh=a+Q3SW2Du7YQqCKcu2M+v4HbHHDjTVuzUncjGaTdCTo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ayn4tWtRX/vpzuG8d1hOygZdaN9gwndiBNIB2xKB/hTD4FxKPUNvWPYYQ9ikNfRAt
	 RrAVgrwIZOk1FBrox1AX/egzzNnLHNk+dlmzvViqqa+Mq5A8LWfSeAhyJrk5tl1e/B
	 yhAJrKwbphcEBStWB5L4k/Ewdnn5YG4oF/T4zmaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BD80F80552;
	Wed, 19 Oct 2022 14:05:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B8B1F8053C; Wed, 19 Oct 2022 14:05:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC965F80087
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 14:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC965F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WKCU9deq"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5B14161772;
 Wed, 19 Oct 2022 12:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F69C433C1;
 Wed, 19 Oct 2022 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666181110;
 bh=a+Q3SW2Du7YQqCKcu2M+v4HbHHDjTVuzUncjGaTdCTo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=WKCU9deq3FM4gdIaBD9s22EbAKxA663mbS2SbG9x5hUXOzx8sB3bf8qHTx20AYwfM
 mYlHt86qJHfYh2jCedM2/7ei7Uj71FBvpKzakQutXr7M8lKXesEagWm0SMCPmw29+4
 g5xdVN8e6gwMK63HgJGGyeig2yGw0m6bOeLl8cFfaQ0eO6/FbHhM3lQHvPlhmV2NQf
 ETmVVsIa1sUzubtNJ2I7X2ZJYmHXkSJNXToj4whlbZgKSnycZUK9j1cCoODCCYtGON
 wVeA9vy+ZbBi9svnjS+Pr5V4gugBZuQZPhaigbHmCky/zX1Fn1FYsGa0vVeFOjorzE
 eah3YSI2dTB9A==
From: Mark Brown <broonie@kernel.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20221018122711.2559452-1-venkataprasad.potturu@amd.com>
References: <20221018122711.2559452-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASOC: amd: acp: Add TDM slots setting support for ACP I2S
 controller
Message-Id: <166618110801.80223.1404138981256305349.b4-ty@kernel.org>
Date: Wed, 19 Oct 2022 13:05:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Vijendar.Mukunda@amd.com,
 vsujithkumar.reddy@amd.com
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

On Tue, 18 Oct 2022 17:57:06 +0530, Venkata Prasad Potturu wrote:
> Modify set tdm slot function to set ACP I2S controller slots
> in tdm mode based on number of slots.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASOC: amd: acp: Add TDM slots setting support for ACP I2S controller
      commit: bdde278a77d3220ba7991e6ff5e992716981ae30

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
