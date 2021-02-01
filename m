Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9EC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:48:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C5164EA8
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C5164EA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E6C2175C;
	Mon,  1 Feb 2021 17:47:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E6C2175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612198101;
	bh=rnfT7QC1QylsfBHlTLq503WKQd1AGk542dN4U3+Qa+w=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hWAO4hu0uNMe9Anf2KlvH5Wluzc37PkL0Fso645m4FjEyLZ7Uue02vddnybJTWrHy
	 s5lbalm5+pHna0f+PWl0V6Ew1TH1gswTwlEJuep6GCWrCQ5FMct4tkZdqGoFs4/14c
	 +Vwg1YhARCnBTcpzwMDZtveJqTecxAAmvGAKllHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C82DF80155;
	Mon,  1 Feb 2021 17:46:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57B9DF80155; Mon,  1 Feb 2021 17:46:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BABC7F80152
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 17:46:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BABC7F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nP7mncKo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6873464DA5;
 Mon,  1 Feb 2021 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612197991;
 bh=rnfT7QC1QylsfBHlTLq503WKQd1AGk542dN4U3+Qa+w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=nP7mncKo6tpJ+dPF1HascPqMRADMqPbHpiJvvLU4U8esPVyaqJe1OaRKi3qLn4KuL
 //BSDcCV1J1S+LkJk5Otc++esTcn7MdY3ddpJ5G+c85ERtessJTvHZcZ0IvA6uMAol
 +vv/9QHJE3GNbMHmiEvY51Rbo5/4lCVSUSwkQS6GCFswOQZvHkeEIXCeX3HbIoftVR
 JXEiHH2mCnU/hH/FwHvDY7VdGMo7+5ulZeZEaMi+03BnXqKx1qbAZpZPPJNT6/4lVA
 p7fqkEVrV4YCn6oFjlmAUevfZT7F31PcRgil9Z3hQvjtYljKWsTF3m06LEAR//Jmt8
 4aBCNdDS6BaSw==
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
 lgirdwood@gmail.com, robh+dt@kernel.org
In-Reply-To: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
References: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v2 0/9] Tegra186 and Tegra194 audio graph card
Message-Id: <161219793995.46194.8766382899018359652.b4-ty@kernel.org>
Date: Mon, 01 Feb 2021 16:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org
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

On Fri, 29 Jan 2021 23:57:37 +0530, Sameer Pujar wrote:
> This series adds support for audio graph based solution on Tegra186 and
> Tegra194. This enables audio paths for I2S, DMIC and DSPK modules.
> 
> Depending on the platform Jetson TX2 or Jetson AGX Xavier, required I/O
> module instances are enabled. Since the latter board has on board audio
> codec, DT support for the same is enabled and external audio playback and
> capture can be used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: dt-bindings: rt5659: Update binding doc
      commit: 6bbb859012e905736c852b518be16c653e451967
[2/9] ASoC: dt-bindings: tegra: Add iommus property to Tegra graph card
      commit: 70f0bc65f6cf757fa4cca2d6fcb84f613bc0d8cc
[3/9] ASoC: audio-graph-card: Add clocks property to endpoint node
      commit: 531e5b7abbde3c190aeff5b13c17f7ef3e0f3543
[4/9] ASoC: rt5659: Add Kconfig prompt
      commit: 563c2681d4313f55b9b1d9a8f635946cd4972170

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
