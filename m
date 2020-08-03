Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B84C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:54:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B656520825
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eV1U+sUA";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wUuxdpcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B656520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EB981663;
	Mon,  3 Aug 2020 17:53:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EB981663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596470079;
	bh=5aMdHW/QjKBwDvG3cXAmnZL14ajVDCMGw+1/8WBZAOE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eV1U+sUAJb2K+CUIo/J3Iz7HfdjHF4Zhhrqj1PupGKjjtBoYpaCq8shsfLhjyhO/O
	 hbogR+foOxRtXAFDnaYDG/CzzevTKV5F9E8kTND0dGbsJFrrN9ORLU3SUD8ryRQX76
	 TqrrrTF8LCI23yIqloSp24+Gxyf8Be4f2US8XjuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 117F9F80249;
	Mon,  3 Aug 2020 17:52:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73442F80218; Mon,  3 Aug 2020 17:52:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D0DBF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 17:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D0DBF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wUuxdpcr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99AD12072A;
 Mon,  3 Aug 2020 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596469961;
 bh=5aMdHW/QjKBwDvG3cXAmnZL14ajVDCMGw+1/8WBZAOE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=wUuxdpcrF1DJlDJ/quKCKXbqwP5M5zRibTtrAytQIarOuSxmHwZkpGwbw+UkcRvZe
 vVkGuW5ctBb6cl5tRL5XYQXgGUsXeHZV2FlLfkrd1kHQZbK8TX9XCznz2ZSQObJOSC
 /wHLeIImje58dqhjytutoLUCI0wohi3gHCm2fIyc=
Date: Mon, 03 Aug 2020 16:52:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20200803144630.9615-1-tiwai@suse.de>
References: <20200803144630.9615-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: fsl: Fix unused variable warning
Message-Id: <159646994088.2524.5722262510882497723.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Mon, 3 Aug 2020 16:46:30 +0200, Takashi Iwai wrote:
> The variable rtd was left unused in psc_dma_free(), even unnoticed
> during conversion to a new style:
>   sound/soc/fsl/mpc5200_dma.c:342:30: warning: unused variable 'rtd' [-Wunused-variable]
> 
> Drop the superfluous one.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Fix unused variable warning
      commit: 9493755d7c1156b00b58376752d4c3df7c0a01ec

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
