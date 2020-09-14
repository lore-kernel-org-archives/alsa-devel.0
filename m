Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63311C43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C092A20829
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nsazANVG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9y3mI3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C092A20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44EFE168A;
	Mon, 14 Sep 2020 16:55:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44EFE168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600095383;
	bh=GQgg18t6IepIuJqTo3WsF4/hmvzz/TMRvii6j1KD30Y=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nsazANVGBkYdaNvqJuH4266lQ98krCTspOpj4hRQHpMefknfWcZpNPXNxOqS3Jw4i
	 7ySeFJMrnIklnUQiZ7rpPvPMZ91Gv2ptrQ5NGVeHpkLYHCDMOsKJp6gmMeBrg1tna5
	 dPQU8lfWPmZCoKB2ljJLP7ms5dTShnwAwbxvZ5F8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37E89F802EC;
	Mon, 14 Sep 2020 16:52:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9E24F802F7; Mon, 14 Sep 2020 16:52:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40A5AF802EB
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 16:52:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40A5AF802EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="u9y3mI3X"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34E9F20829;
 Mon, 14 Sep 2020 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600095143;
 bh=GQgg18t6IepIuJqTo3WsF4/hmvzz/TMRvii6j1KD30Y=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=u9y3mI3XJtOX4+vJ75aLGyvyxZE4LegTudHJMJrLNFeaYEYJQGxB7qqDRQ9b0D7Td
 uH3XuaMImDCfSH2JmmA+cBDZpcVsevdGtEoUnv+Z8vPbuSKXP1XGeBttCW4Y+LUkmv
 rYKgOrbvLREvO9EnnkMzY5q3UZQYrl/EUU1ZXbSg=
Date: Mon, 14 Sep 2020 15:51:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
References: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: SOF: DSP core management fixes for 5.10
Message-Id: <160009506912.439.5239831825478892470.b4-ty@kernel.org>
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com
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

On Thu, 10 Sep 2020 19:41:21 +0300, Kai Vehmanen wrote:
> This series contains some improvements to how DSP core management
> is done in SOF, and adds a distinction between cores managed by
> the host versus cores managed by the DSP.
> 
> Pierre-Louis Bossart (1):
>   ASoC: SOF: Intel: hda-loader: s/master/primary
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: rename cores_mask to host_managed_cores_mask
      commit: 64b969177c744a76142f45823dd9d94c38f79cd0
[2/4] ASoC: SOF: Intel: hda: modify core_power_up/down op
      commit: 914fab3b43633d03eb40e3216cc2857864589c60
[3/4] ASoC: SOF: Intel: remove the HDA_DSP_CORE_MASK() macro
      commit: fde106552845b7c369c2385b27062b1c2130a4dd
[4/4] ASoC: SOF: Intel: hda-loader: s/master/primary
      commit: 52e4d0ae6255446efaaaa2a7a1da7cc1640f78b5

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
