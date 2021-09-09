Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60029C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 15:41:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D6561101
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 15:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97D6561101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E454316BA;
	Thu,  9 Sep 2021 17:40:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E454316BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631202078;
	bh=iLbwmwP2Lt6HapFkY338gAPIBAFOl7Xi7VTkIA83tys=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4UyK79ceeQ16pnzG9RjGJycinnWpy3aw7zR9/r+8j1SLBAk7iFZ+hZquXhZ3glog
	 KS4PCx0ZPGAItPAoR7HfmIeM3TgXHMraT4D86KMfoMuC2KcahfTxbVqpBFmjpgGy19
	 OKHLshaqyHntkm137TQNARmK7MFlcHL+kHVSdAY0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A185F804CF;
	Thu,  9 Sep 2021 17:39:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA63AF80224; Thu,  9 Sep 2021 17:39:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85AE1F800C7
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 17:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85AE1F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ruTm9io9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949456113A;
 Thu,  9 Sep 2021 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631201971;
 bh=iLbwmwP2Lt6HapFkY338gAPIBAFOl7Xi7VTkIA83tys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ruTm9io9P3MjjQwTtDIv3/nYcJGxFstt1ek5625XltNBDpZQgIdXpFy9M2rl+cp0j
 CcIU+1dwEh02XK/+xZfPKBE/kXiDBbBN2+uXp2MnKQYZuKexKMOh8XOfhZ3oDm0f/+
 79qgav5OL3NU0CJrxw5xxgI6Q1mNRbIjraoPG24zkr7osONgHSO6Gxg5x5t4bZvjW+
 xxSfnwyehAs5IDin13Kd7JuO65px40gsFRAXmhLWv26JEUViDEKUrwEWyEMYw+Ko9f
 1hEsPKPG79ZO17W9VQa0ZvyGbByCbyzYqdAa4k2ixNnchzsnVUG+jnpp+xaLTjvfe2
 49NTlVVKAKHsA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: tag SoundWire BEs as non-atomic
Date: Thu,  9 Sep 2021 16:38:50 +0100
Message-Id: <163120168199.50116.15367885056330333546.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907184436.33152-1-pierre-louis.bossart@linux.intel.com>
References: <20210907184436.33152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>, Bard Liao <bard.liao@intel.com>
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

On Tue, 7 Sep 2021 13:44:36 -0500, Pierre-Louis Bossart wrote:
> The SoundWire BEs make use of 'stream' functions for .prepare and
> .trigger. These functions will in turn force a Bank Switch, which
> implies a wait operation.
> 
> Mark SoundWire BEs as nonatomic for consistency, but keep all other
> types of BEs as is. The initialization of .nonatomic is done outside
> of the create_sdw_dailink helper to avoid adding more parameters to
> deal with a single exception to the rule that BEs are atomic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: tag SoundWire BEs as non-atomic
      commit: 58eafe1ff52ee1ce255759fc15729519af180cbb

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
