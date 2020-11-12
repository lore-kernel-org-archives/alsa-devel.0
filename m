Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4992BC2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:39:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828C12223F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qyKHuPO7";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITA3dQmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828C12223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36F67183F;
	Thu, 12 Nov 2020 20:38:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36F67183F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605209979;
	bh=IYavR0vcV2dauzFgNAIQmmgd7YC/zTETEuomdRU8fzg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qyKHuPO7LQ85uxbodXQX62I4QD3WBlZDm6OQ10pOGQSlqJghdYs20tYbvObO1ls4H
	 qfhULjQ+yO6hmos/xXMuhNlMM6EBldg4rd4EtWO0rApCosjOLCbgvlWC6taOxlDT9f
	 8a6w6pEiz37OwnLB2bYsVwOWwOrR9AT2u6HRAbt8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02850F80161;
	Thu, 12 Nov 2020 20:38:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54FB4F801D5; Thu, 12 Nov 2020 20:38:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25C3AF800D1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 20:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25C3AF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ITA3dQmy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07EE020B80;
 Thu, 12 Nov 2020 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605209919;
 bh=IYavR0vcV2dauzFgNAIQmmgd7YC/zTETEuomdRU8fzg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ITA3dQmyIK3tY7gI7mK03FXBjVB9+1UV1lKHs9PtRALfiGWa1DpSUtxGPJjadDN1R
 uhN27ek07ED2yuu3LxDUXl417zqHjnAR1twrXtb5xS84ABcDsCrAzWVbz4OyPgPmy3
 pwD3oVjggTzxIZrBcm4zfTBF/DgIL627Q8ovtjzw=
Date: Thu, 12 Nov 2020 19:38:23 +0000
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, rf@opensource.cirrus.com, perex@perex.cz,
 lgirdwood@gmail.com, Zhang Qilong <zhangqilong3@huawei.com>
In-Reply-To: <20201111130923.220186-1-zhangqilong3@huawei.com>
References: <20201111130923.220186-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH v2 0/4] ASoC: Fix error handling in wm899x
Message-Id: <160520990386.38586.11702916614765427693.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
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

On Wed, 11 Nov 2020 21:09:19 +0800, Zhang Qilong wrote:
> The first patch fixed a wrong free in wm8997_probe. The
> remaining three patches fixed PM disable depth imbalance
> on error handling.
> 
> Zhang Qilong (4):
>   ASoC: arizona: Fix a wrong free in wm8997_probe
>   ASoC: arizona: Fix PM disable depth imbalance on error
>   ASoC: wm8994: Fix PM disable depth imbalance on error
>   ASoC: wm8998: Fix PM disable depth imbalance on error
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: arizona: Fix a wrong free in wm8997_probe
      commit: 5e7aace13df24ff72511f29c14ebbfe638ef733c

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
