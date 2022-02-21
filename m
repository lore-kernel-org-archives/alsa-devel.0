Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C1CC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Feb 2022 15:26:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57ECC1749;
	Mon, 21 Feb 2022 16:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57ECC1749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645457162;
	bh=vfiV1Qm1/MHU0lksy3rapa4k1HrN7kyCz4nC8r4epk0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsJ3FvFbG7ktNG5QIBqi9ElBey5zhPrB9DIbg51279Q7V+7HpLt43XwMpz9RcRfYx
	 xxbyqIEZOyoapNMCWg2RsxGvgBXugE4sfdoOhSZ+aCxup7+fjFASs3a/S5zA3woDbo
	 ZSm240Zc0MFkoxUmTZxQDiqFg1eCyPKi9HEK/DME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB525F80517;
	Mon, 21 Feb 2022 16:24:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 027E8F80518; Mon, 21 Feb 2022 16:24:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F48DF80118
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 16:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F48DF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JF/QiYig"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB0C61050;
 Mon, 21 Feb 2022 15:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13CEC340E9;
 Mon, 21 Feb 2022 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645457063;
 bh=vfiV1Qm1/MHU0lksy3rapa4k1HrN7kyCz4nC8r4epk0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JF/QiYigsSz+pDmwfxF75oFVURELZH86roMYRIxPV2sXjLtCr8j7QaJ+DYY262j71
 N5G4zXCg6UYzFKY/S7tD/bO5roVrmGYUN17dYEaOORamn/93HQr9WCBjGcAQy25wm4
 74HVL4u9SWjnMCo0yaJ7EpBzoidHCyGnCpf6pYj5guyRmx9rveRWzeK/lmNYZhFyJZ
 J9mCNS3pHnDNpB8jx3bSEGOg/DssqZxVGNeayKqcObShy3ycFAfX+M3OO4ga1Q+yYS
 Xsx8vOW1g/kUMTkcAIXceXoHyTJ8iY/UunYYno0cFj+Gj4znXpnjsrTERBXCKcOHFJ
 G78z2xTWfEH8A==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>
In-Reply-To: <20220221055716.18580-1-trevor.wu@mediatek.com>
References: <20220221055716.18580-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: enable apll tuner
Message-Id: <164545706169.730905.15839904852131851975.b4-ty@kernel.org>
Date: Mon, 21 Feb 2022 15:24:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, bicycle.tsai@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 yc.hung@mediatek.com, linux-arm-kernel@lists.infradead.org
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

On Mon, 21 Feb 2022 13:57:16 +0800, Trevor Wu wrote:
> Normally, the clock source of audio module is either 26M or APLL1/APLL2,
> but APLL1/APLL2 are not the multiple of 26M.
> 
> In the patch, APLL1 and APLL2 tuners are enabled to handle sample rate
> mismatch when the data path crosses two different clock domains.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: enable apll tuner
      commit: ff5a90173d981934e1134d28af3625acaab01d80

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
