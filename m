Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995BC433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:53:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669B6207DF
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GC//Pcr3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm4UIVpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669B6207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D84731899;
	Fri, 28 Aug 2020 16:52:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D84731899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598626392;
	bh=tYgV+FBYe1Z6jN+MAv7hfYtP2hXvmNwxY+Gt1pXHABI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GC//Pcr3c6+m/Q2NhnzcMhe7M4Ye6BkKxclH3L0iNP8VmKVeBHJdQNloEDoXoQxAD
	 voyRFilkTCwOORAXXgrMWpRR6Eth9+WXvfupcBkQmZgdnxqAOwOO007Y2VJY20T9ba
	 CKf6bcL18G6rkm/7tUjUv0t6VoCrW8wERRwiwvlk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37B44F8020C;
	Fri, 28 Aug 2020 16:51:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73586F8016F; Fri, 28 Aug 2020 16:51:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10A58F80105
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 16:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10A58F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Fm4UIVpP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4417420848;
 Fri, 28 Aug 2020 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598626275;
 bh=tYgV+FBYe1Z6jN+MAv7hfYtP2hXvmNwxY+Gt1pXHABI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Fm4UIVpPsATiFzzlVYRYNdoZ6ROoTuq4/1WSb1YxgMGinj0LSzfoqVLfypYTKOvTp
 OSR265HcdMgWAFSS7sjBj5ZUfeEElwft/BRMMlE7/mQAFlJiMcBrYiAgI8yOv8dldQ
 MNzAXpN0JGtgDwZiEHh/QTIlWr6DLobJ2OYTTsdI=
Date: Fri, 28 Aug 2020 15:50:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, tiwai@suse.com
In-Reply-To: <20200828112855.10112-1-dmurphy@ti.com>
References: <20200828112855.10112-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add digital mic channel enable
 routing
Message-Id: <159862623263.40815.9298257186480426843.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 28 Aug 2020 06:28:55 -0500, Dan Murphy wrote:
> Add the audio routing map to enable the digital mic paths when the
> analog mic paths are not enabled.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Add digital mic channel enable routing
      commit: ece2a74c5913d244e13c42c61ca2e162932fa3b4

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
