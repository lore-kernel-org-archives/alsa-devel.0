Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44558C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 20:03:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F17233EE
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 20:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F17233EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B9EB16B9;
	Thu,  7 Jan 2021 21:02:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B9EB16B9
Authentication-Results: alsa0.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCYTbaVS"
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BABDFF80096;
	Thu,  7 Jan 2021 21:01:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAD12F802C4; Thu,  7 Jan 2021 21:01:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6C67F80096
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 21:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6C67F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LCYTbaVS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B95223433;
 Thu,  7 Jan 2021 20:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610049683;
 bh=HGSx0opZPu5oWyiq/8ePuSyFXNVhUsYrLd4tA1Ak4MA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=LCYTbaVSVj6VHYYzhkW84HOvIQ5ML6N9xZtey4TGOu8Ra7/dVHfwJJar3AaV4VFHp
 JaxRfzLAZyT+ZoAMFyglgjdP7gsPv6Avnlbz+IepT/vB5oODFaaSTCI2CMaAIr0Tl/
 Nn/3GdeYgyiWXOuAFiMoe4DcURq6T4iZXsbNRauQP7KzypC9qUUIMxqHBOlDSTikwJ
 lQ4We7RpgFo/+hp1ev7Ezz1UQ39p7KM8a6+wMR20rQAqjlD9rmXUIQ5yY/tGPZrCo7
 otol50bI1i5QOKKcEj0EPDi9nXXR4qg2MnLHX3BmLofAbCXscnfLMYhWV8yHoRK2dJ
 amx16kBvbuJmg==
From: Mark Brown <broonie@kernel.org>
To: 朱灿灿 <zhucancan@vivo.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com
In-Reply-To: <AAoArwDfDnoefyxzy2wyiaqm.1.1608885766936.Hmail.zhucancan@vivo.com>
References: <AAoArwDfDnoefyxzy2wyiaqm.1.1608885766936.Hmail.zhucancan@vivo.com>
Subject: Re: ASoC: soc-pcm: disconnect BEs if the FE is not ready
Message-Id: <161004964961.33461.16112121160261528738.b4-ty@kernel.org>
Date: Thu, 07 Jan 2021 20:00:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel@vivo.com, trivial@kernel.org
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

On Fri, 25 Dec 2020 16:42:46 +0800 (GMT+08:00), 朱灿灿 wrote:
> FE is connected to two BEs, BE1 is active, BE2 is deactive.
> When closing BE1, FE/BE1 is in HW_FREE state, then BE2 is
> startup by mixer runtime update.
> 
> For FE is in HW_FREE state, dpcm_run_update_startup() will skip
> BE2's startup because FE's state is HW_FREE, BE2 stays in FE's
> be_clients list.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: disconnect BEs if the FE is not ready
      commit: 2c1382840c194533399818d0ed39dfc94f906187

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
