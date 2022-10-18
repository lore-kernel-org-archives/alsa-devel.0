Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B7C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Oct 2022 11:31:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 517979BFF;
	Tue, 18 Oct 2022 13:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 517979BFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666092665;
	bh=MMbIi4XiIRLL68KRwXTv6wyCk9bH5P5UWxHFp1vLzmI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHagnlUAiKKAUImKexmwLEei/S+g2p5fbbGpUAigo5WfFcnhKHzFRRaTVF3zX3jRa
	 yZ4HjSdvACqRT6YQ40irOQRCNxecNsg6Gf1N8Ambr9hD2x/iJXibUHqmv11jUT057K
	 U2zRIH3Y1kUTyRyDJt3nVslmvjpr4PaOuWhvQfBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D3CDF8057B;
	Tue, 18 Oct 2022 13:28:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC5E4F8057C; Tue, 18 Oct 2022 13:28:36 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E4E9F80567
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2022 13:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E4E9F80567
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W+lxVJiZ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 97EDEB81EA5;
 Tue, 18 Oct 2022 11:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D3DC433C1;
 Tue, 18 Oct 2022 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666092508;
 bh=MMbIi4XiIRLL68KRwXTv6wyCk9bH5P5UWxHFp1vLzmI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=W+lxVJiZoef5Mjowb1GBEF3Oiv6xO5r8CzRLIt1LNBbOko7az261SEta+okkT+fYC
 PqgEEUz1VPd0OR6b+FrraTgvl43bo1DQaGLTmCNdtqWHQzXTfGPcZ6APvtjBEm34AC
 V9AwLzfVgWURQhq54vGXb/kcIO+jRnh8MNxeHI8+vJE5sRd69A7XuyCisqXv/Wycqm
 TEWxZpoyd4PTUSyttHyASH/+UN9hI0gzhwYuLc99fnGR3sA1WWbg93Cecuuo1oYywh
 1IUBvpKHHXWQaeYqDHmr087RuPHYVskhgAWPV6UWWuaHgUcBxEDhB8OfDIuNNalgOG
 mZi6HqIP1Bfsw==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Andrew Lunn <andrew@lunn.ch>, Pali Rohár <pali@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Marcin Wojtas <mw@semihalf.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220926110533.13475-1-pali@kernel.org>
References: <20220920132648.2008-2-pali@kernel.org>
 <20220926110533.13475-1-pali@kernel.org>
Subject: Re: [PATCH v2] ASoC: kirkwood: enable Kirkwood driver for Armada 38x
 platforms
Message-Id: <166609250652.155136.11660451667799721440.b4-ty@kernel.org>
Date: Tue, 18 Oct 2022 12:28:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Mon, 26 Sep 2022 13:05:33 +0200, Pali Rohár wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
> other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
> driver can be used to support it and this commit adds new compatible string
> to identify Armada 38x variant.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
      commit: 2adfc688777e58f22f691d08728dd74d76177fd9

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
