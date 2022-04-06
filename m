Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C0C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Apr 2022 13:29:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0457316E8;
	Wed,  6 Apr 2022 15:28:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0457316E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649251777;
	bh=3TaUT9+vHV4ELLBDNt7fqMxEWQnqlwB843HZYhfTDRA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/UsljoLXeQUYrMZjvAMuq0kfcUXfC5s/AaFR3P6E+ja9a7RLN8eeaLR2HVuvVkgK
	 so8QnVvBfCLvSLj6YP3hHdDMUj9dMc1Va4rvHYybpvj6kiDsB1TD4fY0nQyvBMh+KB
	 wQ/lTgxhgEFZO3Fripj9WkF4DMQJviSu//iLVNsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DCFAF80161;
	Wed,  6 Apr 2022 15:28:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA2A6F80161; Wed,  6 Apr 2022 15:28:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8382F800D2
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2022 15:28:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8382F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="haGlb+m6"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C73446152F;
 Wed,  6 Apr 2022 13:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA7C385A1;
 Wed,  6 Apr 2022 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649251717;
 bh=3TaUT9+vHV4ELLBDNt7fqMxEWQnqlwB843HZYhfTDRA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=haGlb+m6YgipxJXICWTCIYl1FoJLlr8OZtDtWQHpLqBNGZnhi0ngescr0UOO145uV
 pHFtXDt6/fUB+LZm83p2CKAk2PpepQtoV58737tBb528RF80NjB3xJU6oykPG1WzEY
 wLwr8SM7O7XG1aYtOPbvD/nzpvc3PsTIo8WEs5mCT4oTlX8P3a2NjHJADCwKNNlzKS
 Nmf4P4VaOpj5ZZUpxchTS85Ydv1daX7rvGLutAETEals5/83NqNvXqXQcCFeaN80Mj
 afGodjZJp+w24QgAvaly1854bJy08sc+g0sL3fg9Bl8azzP/XJc7dhUgms/0mTdlq2
 H+opc/K5wc18A==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, rf@opensource.cirrus.com
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ASoC: Add a driver for the Cirrus Logic CS35L45 Smart
 Amplifier
Message-Id: <164925171568.83821.4847181026901086960.b4-ty@kernel.org>
Date: Wed, 06 Apr 2022 14:28:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Fri, 18 Mar 2022 16:29:38 +0000, Richard Fitzgerald wrote:
> This adds basic audio support for the Cirrus Logic CS35L45 amplifier.
> 
> The first two patches add two generic helpers to ASoC, and patch 3 is
> a kunit test for patch 2.
> 
> James Schulman (1):
>   ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc.h: Add SOC_SINGLE_S_TLV() macro
      commit: bc8cb02976cd602b8d7631a6f4a54a9cf305d38c
[2/5] ASoC: soc-utils: Add helper to calculate BCLK from TDM info
      commit: 1ef34dd2b90d78a9830398441801658ef86eee9d
[3/5] ASoC: soc-utils: Add kunit test for snd_soc_tdm_params_to_bclk()
      commit: 89342fa38bbaade51584f255eee5cd43621f4e10
[4/5] ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45 Smart Amp
      commit: 72661ff7662acc00d51976d4b2d2d13eb5628385
[5/5] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
      commit: 0d463d016000d68d7e982720b5e4380b2d83409a

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
