Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2409C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:01:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386AD61931
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386AD61931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC96B10E;
	Mon, 22 Mar 2021 14:00:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC96B10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616418103;
	bh=1N873xOm+BUwFJb0Tu0A86MT3BedjAGG18g6TSMXyHI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgpTyS2ybB8FajPUqSq6haWjJLEU3/ZFm2+tehGSF5KoBMaOKELLZmLjmixp1air7
	 vJ6DsA8HWzzw8P5fcRHas1AHrA/kM9KLHAlx/r8B7GRPWfbqbGaeh3BH9DgPWCsVbp
	 8EXAo24StLRT5vjfYc6l/ki3E2d73tJaPEoDBtC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4628F80155;
	Mon, 22 Mar 2021 14:00:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FC1AF801D5; Mon, 22 Mar 2021 14:00:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABEAFF80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:00:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABEAFF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rKgdRnjb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017916187E;
 Mon, 22 Mar 2021 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616418038;
 bh=1N873xOm+BUwFJb0Tu0A86MT3BedjAGG18g6TSMXyHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rKgdRnjbRrquvRzRBHFvhYQ7fldAnwV3oQRL5BfHR0eMEnj5hawtfM2Y9GrSi3cOU
 y0e8JGzYlCoUo55GaOjWqgvHpu0Bt8OsaUuM984F5vRyJ09UsXcPnPoiAlyrXrRx+b
 ibtAJ2MzHn2ZkxnCk+M/khQ6BBKjFMUVGQL4Nz0UYg/04Zp9RLpZSW1rO1LnLeRxPV
 ZSs97BqQFvmzb4DKfHDkxyhTW4/y3u5DxEnfmk40jPWRhKJryuj+HipjxPVHaKUzwk
 Lx9gkWjpJFrYzcOSPPG11zZmyXtVDivOzutJJs1uNF06NQkOff4/S8H8qczOFHatQB
 ZLOF2UVPS4nkQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 1/2] ASoC: amd: Add support for RT5682 codec in machine
 driver
Date: Mon, 22 Mar 2021 13:00:29 +0000
Message-Id: <161641797251.25992.13651573999583683966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sunil-kumar.Dommati@amd.com, Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Chuhong Yuan <hslester96@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, shumingf@realtek.com,
 Alexander.Deucher@amd.com, flove@realtek.com
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

On Thu, 18 Mar 2021 02:03:46 +0530, Vijendar Mukunda wrote:
> Add support for RT5682 codec in machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Add support for RT5682 codec in machine driver
      commit: 7e71b48f9e27e437ca523432ea285c2585a539dc

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
