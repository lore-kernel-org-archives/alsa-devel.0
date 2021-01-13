Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9907DC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:30:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB522339F
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB522339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2736E173B;
	Wed, 13 Jan 2021 16:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2736E173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610551802;
	bh=dyauwb24INGNpF0q813+eq0KQ0oxo8bW0ttTQIXtB5s=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pQN6oPAQv3XNAglpmIpH7sOUKG7ySP7K7pbdj6ieCFvh8fztOm9bk3qoG4N06Llty
	 2NtBP/q8uWMCjC4ZG4w6a6JBjfPHUVjLtPg4EXz8LJhrY1geo/pgyNHlr2S8Qm8h1+
	 1ixjzu6sImJX0+eu+rd+8MU5EL9rcHK0/1Z2yv8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3E5BF804E3;
	Wed, 13 Jan 2021 16:27:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32FCEF804E4; Wed, 13 Jan 2021 16:27:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FDD1F804E2
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 16:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FDD1F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kNJwRoXS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D255E23382;
 Wed, 13 Jan 2021 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610551659;
 bh=dyauwb24INGNpF0q813+eq0KQ0oxo8bW0ttTQIXtB5s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kNJwRoXSdtCaNh4a8zxvqHb/iTzgTTK8LuWCdH9f23whKWIXQgMsxPOqvmNo14Qau
 bPvai+BMAJM8VyUCOqvNFTOtZ4//pQKLOjlJJabD8xzodQu3hVNaRmXfDwBTJSSUIK
 UwKQmZb2agG+yZwoPM6B8HfOpa1flznv6H57K/pHFhss3kM8dzEqQu3vJL0wdggJgF
 3GCNA5kau+E5lbVk22ljJpfKv6kJQ9NXgNDe7obS+bTDH8fYHbqLJXt+vQPWHoNyz3
 qyB0jdzfoD0qO1ZQvL9SzFXPTdmRCK2zQSAF7Iu/G7vi4fUTveKd1bDqqJOwNypceT
 xF1NtEw/139dA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
In-Reply-To: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
References: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH 0/2] Enable DMA mode on Intel Keem Bay platform
Message-Id: <161055160365.21623.8772802884649174403.b4-ty@kernel.org>
Date: Wed, 13 Jan 2021 15:26:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, lars@metafoo.de,
 pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com
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

On Tue, 15 Dec 2020 13:33:05 +0800, Michael Sit Wei Hong wrote:
> Michael Sit Wei Hong (2):
>   dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
>   ASoC: Intel: KMB: Enable DMA transfer mode
> 
>  .../bindings/sound/intel,keembay-i2s.yaml     |  14 ++
>  sound/soc/intel/Kconfig                       |   2 +
>  sound/soc/intel/keembay/kmb_platform.c        | 157 ++++++++++++++++--
>  sound/soc/intel/keembay/kmb_platform.h        |   9 +
>  4 files changed, 167 insertions(+), 15 deletions(-)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
      commit: 9ddaa1e6181b3d33080f2ed7c27cb0bba819e562
[2/2] ASoC: Intel: KMB: Enable DMA transfer mode
      commit: 11b943c06a1c1baafb0325896e666d77f5ac78b8

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
