Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F5EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 18:22:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68D0F16B9;
	Fri, 10 Jun 2022 20:21:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68D0F16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654885343;
	bh=ctmexQLdnglHp49NgMIN8gOm5562B67YT7yIGnPgkdQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPx+q/qUVk9AYTxQv9pXbReicRTPJ+dsZNLfrfkYpmXWvLKSmWk6ruuS8yT7uacPR
	 U83VlF6fAX306YEnXkpeVPq69Vq/MOB734X0voyQedU3DIDAjNe8hhMsjZYsp639Hr
	 oIZ/btxzxh44sk03Rty2nGqD0cz33clv4J4CnEJ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E066EF800C7;
	Fri, 10 Jun 2022 20:21:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A4A0F800E5; Fri, 10 Jun 2022 20:21:31 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90B44F800E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 20:21:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90B44F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ra/iDnL2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 93814B83471;
 Fri, 10 Jun 2022 18:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E404C34114;
 Fri, 10 Jun 2022 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654885284;
 bh=ctmexQLdnglHp49NgMIN8gOm5562B67YT7yIGnPgkdQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ra/iDnL2H9ob90ivzwAJJAVKHHVFNhkAjyQ/Dc2UhfpVoOv9z5yVtg7NMBZs1EwAP
 zlc1ttXsIKwxy6YNl90MUc1QsODQzrfxzyARx5hvIF27dxfluL1BclP1qM1Vh2nL11
 W7zxuicLkdiU4ZlE4g84xAkXaurPvUZyt4lgq0jMJW9yM3mmXBjd3J9tBLUhjKqtl4
 ZI7O5t3dqbfiMcTqg8mpi9+YW2/eBSdGwOJ2aYRFWUj6yZlsoAlWpPXD/NksAlWNyM
 FLHNMEF4toZS+mv2wXT89cnN/X/VI+OQrkaoWLmbPYT9bB7I2Pc3FTUZ7Wv/RJpC+T
 1IrVH/aifM/Lw==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 amadeuszx.slawinski@linux.intel.com
In-Reply-To: <20220610124257.4160658-1-amadeuszx.slawinski@linux.intel.com>
References: <20220610124257.4160658-1-amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: avs: Fix parsing UUIDs in topology
Message-Id: <165488528271.2064162.5038484220213087257.b4-ty@kernel.org>
Date: Fri, 10 Jun 2022 19:21:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.com
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

On Fri, 10 Jun 2022 14:42:57 +0200, Amadeusz Sławiński wrote:
> Use correct type for parsing UUIDs, this eliminates warning present,
> when compiling with W=1.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: Fix parsing UUIDs in topology
      commit: 46c80e72c16adff20f61240f887c4842e80cb6ec

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
