Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F0C43214
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F251D610A0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F251D610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 888631743;
	Wed,  4 Aug 2021 00:37:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 888631743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628030323;
	bh=itzEvpfQl30/cXcBzgEf8EEtRC4VYD4DYNiKCZ3vOGg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rP4+a0OC6jL1Qi1AiKNNFYGSBO5BEh6oq6agPg3lFYNw8IG9KCxFy9ogIzkjccWbg
	 o9jlGy9YrAoWuPvY1SDScHJdSmB3i59kqvBjLftPpi9FYiTsqiey1CFz5zPdULYSrH
	 erScXMPEf9LJKKhi9BX6PtnerAnZ+wh9k1hxdMkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ACB1F804F2;
	Wed,  4 Aug 2021 00:36:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13C27F804F1; Wed,  4 Aug 2021 00:36:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00312F804E3
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 00:36:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00312F804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="foRO6o1E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 042896103C;
 Tue,  3 Aug 2021 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628030183;
 bh=itzEvpfQl30/cXcBzgEf8EEtRC4VYD4DYNiKCZ3vOGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=foRO6o1EZx7gXIkzctHRZgj38RJq8ES+P+LemUCu1nTlw3N2ccFJTX8io4WqKmc6Q
 LR0zjB/9x70CQYbDODAWOejaEzOQlgipFtdR/xW11wX7ITL1vhqOBbZ/28Xl3mTU1c
 mSgcSvY2J7SiITiioaH+EIgdw2riXJwtZMxWILTjrVMRsQrrWfhaS0PTbPYBuHQXek
 ib14HiOtpXEvwBkFGlPbyfj0gbRGbmxgaENn/oNjo+4IpZMgzhXKzzZ0VAeD30b+i2
 evLgNGvldVzzx1E7DqzJ03HBXJlHtHjOf9Ek7+BZG8zagT88wEW9DzEPVn9e1DDfj6
 /0VIrx/IMog+g==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-ipc: fix reply size checking
Date: Tue,  3 Aug 2021 23:35:39 +0100
Message-Id: <162802985540.42099.7162137224505669472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802151749.15417-1-pierre-louis.bossart@linux.intel.com>
References: <20210802151749.15417-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Mon, 2 Aug 2021 10:17:49 -0500, Pierre-Louis Bossart wrote:
> Checking that two values don't have common bits makes no sense,
> strict equality is meant.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-ipc: fix reply size checking
      commit: 973b393fdf073a4ebd8d82ef6edea99fedc74af9

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
