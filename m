Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97730C4320A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:30:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA06D60E9B
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA06D60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53EF21F4E;
	Thu, 29 Jul 2021 01:29:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53EF21F4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627515025;
	bh=aCPvxUVC7sC7xkD083hqVMmZpqx0oNjLQU9EOelj4C8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUWyYqBdhOpl1y4cEYY3LpznFxgQF+yqDRJA2CipS+scu3OAqwormXjsZVsxUWbxJ
	 KB44ac5F/OBOqBOaANObEoklVBDQaLIMQnMeGlBCFUpOooz9rUl+k4f0NcH1UpDSxe
	 xd61rUxi5XorRLNGj1Fu7Mi/xyl2RE+qx4almKGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA72F802A9;
	Thu, 29 Jul 2021 01:28:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F3ECF8025E; Thu, 29 Jul 2021 01:28:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18A6AF80253
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 01:28:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18A6AF80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T7iS53jp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E85461040;
 Wed, 28 Jul 2021 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627514901;
 bh=aCPvxUVC7sC7xkD083hqVMmZpqx0oNjLQU9EOelj4C8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T7iS53jp8DkySFkh75HpDk4O/YQBWCGhGMBQwjBM/CrZSCaxX6Ld+vvwWinxjgzn7
 2YnZumMAZ8SO52JEl/46oLx9Y2LgkWHVoSnyUNX61jULnMAe9tAs4YF6vXeR9HtwiL
 bOBQHYfzq6Mbgfj2bwxDccU05tEmk1KWtHOkmApVITAyr8iRBndCk2ryQx8tk8UFMz
 OEPlQ/559MpHxBtUxyk7WGg7nNjeVeUQEeDC0hvbMrMJzxhbmsUltkGE+8DBkarxMu
 WXKkqCTu4nG7021CMsRB2cB9C+1OrNCgFNDOd8ZFYRSPUWCou5NhQzSIJ2ycaLfcXq
 wgbGiOz18QuCQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: component: Remove misplaced prefix handling in pin
 control functions
Date: Thu, 29 Jul 2021 00:27:56 +0100
Message-Id: <162751391069.10122.272051946830261204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726194123.54585-1-broonie@kernel.org>
References: <20210726194123.54585-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, alsa-devel@alsa-project.org
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

On Mon, 26 Jul 2021 20:41:23 +0100, Mark Brown wrote:
> When the component level pin control functions were added they for some
> no longer obvious reason handled adding prefixing of widget names. This
> meant that when the lack of prefix handling in the DAPM level pin
> operations was fixed by ae4fc532244b3bb4d (ASoC: dapm: use component
> prefix when checking widget names) the one device using the component
> level API ended up with the prefix being applied twice, causing all
> lookups to fail.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: component: Remove misplaced prefix handling in pin control functions
      commit: 31428c78748cafdd9352e1f622eb89bf453d9700

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
