Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C205EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:12:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169462371F
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169462371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6642518DB;
	Thu, 21 Jan 2021 01:11:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6642518DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611187948;
	bh=CH+pY4Va0MCe0xn1lwnpTiAE17DBzHissyzpbhiBDas=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nGz0K4fid2weAJL/0DMJdJADkNmHG5px8EMKuo8Cqw+frxZ/ACCx9vBQXGiyLAeQa
	 1vihm3NZi1V9OFIK3iPfH1e8O6v4q3vlehn3ChUSzaJE61dEz3btfSOt9Iirld7d1U
	 rZAzGu8X0p1s4ySA4ABUAz1LCmV9H1PUCCDIlln4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FA98F8051C;
	Thu, 21 Jan 2021 01:07:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94FF1F80524; Thu, 21 Jan 2021 01:07:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48A68F8051C
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 01:07:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48A68F8051C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B2H7uQ1h"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF17A2376E;
 Thu, 21 Jan 2021 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611187659;
 bh=CH+pY4Va0MCe0xn1lwnpTiAE17DBzHissyzpbhiBDas=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=B2H7uQ1hy70q5VBD1FFs9Kd2OcC9mMirzzcZXEIlbQF9KYC+LHcy3LDGcjxOsUqBh
 2DbgEol8O/6Tmt/ovCq2L9u7Z2bHRsVP1LZablVtalkxtOIwO6odtUiPgBZTswIhaJ
 mTSNs/gWJpqMmW6u1DPFSqr7Q43NpKmGbjXEHWze4dlFN1NpujNXTbJh1bf9sFyR8H
 sx5U4JJIVmF9O2eFGjfiJs4TQ33u/eQXS/kjAJLQzApckDanGwAHFGyyZoQVZhCUjn
 Ialwe8lJUKk/ZAsM62gNiKAmKoMkIplzMi2ZfZ4H0WNz7dbf5d+E6PIytYbQzwfJKs
 Y+Z7oBgQ16pXA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <YAf+8QZoOv+ct526@mwanda>
References: <YAf+8QZoOv+ct526@mwanda>
Subject: Re: [PATCH] ASoC: topology: Fix memory corruption in
 soc_tplg_denum_create_values()
Message-Id: <161118753484.45718.1419483152294927470.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

On Wed, 20 Jan 2021 12:59:13 +0300, Dan Carpenter wrote:
> The allocation uses sizeof(u32) when it should use sizeof(unsigned long)
> so it leads to memory corruption later in the function when the data is
> initialized.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix memory corruption in soc_tplg_denum_create_values()
      commit: 543466ef3571069b8eb13a8ff7c7cfc8d8a75c43

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
