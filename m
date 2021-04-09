Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366BC433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:25:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A11A610A7
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A11A610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 186CB168A;
	Fri,  9 Apr 2021 18:24:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 186CB168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617985528;
	bh=4THxi9Gmmsw/c0HXapMxqrYnTfey6Tgb5ZUkkxV6TDM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SYFPY/0QVr1bUmc/J0zIUu7Ev1qTHbkWaed4uFyJudCh+jzBZhDqdaXRpAUHKjyHL
	 lNXxOsY+2lhBC6xwMbOKSiGYYNxqO5ZHhAguxljQJSMIwdk52oyfWkshz1NzN2469M
	 b8nf5325p1o9ElNE4Z8G4wYB/QAeXaA0fA2ewUYA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A300F8042F;
	Fri,  9 Apr 2021 18:24:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DD15F80425; Fri,  9 Apr 2021 18:23:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71C89F80260
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 18:23:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71C89F80260
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TLUeCRyZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D84E76105A;
 Fri,  9 Apr 2021 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617985423;
 bh=4THxi9Gmmsw/c0HXapMxqrYnTfey6Tgb5ZUkkxV6TDM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TLUeCRyZdfzv647wURLa1tjFWOIZKWjyYxO1B6yDLsuVKxrAcMP/XgZU4hQp7P6RH
 yXLRVEMHYl3gSGLzyUcsC/ep5Z6JLPIPXI6X+kSPUnqPpmSm6HJ3eWdS0Bhx/AWfIE
 AQraxEMtT7t7EQdq2PTdWyyXBHq+gWT47HPMdC93OnLNP6z5qEKPvx2bYHzf5rDuL4
 FONIhcBtpwA1s+gCD/DXm6i1NzJNfWX7x3Qq4CQpblR1wDJArknmPKGJIyzRlR6b+2
 0IVzV/rAogHr/j4UsBBjkBjJYXWELo/UT7d8LA035lhkKdLiv3MLbIIpIgElMVEsfa
 uiuJRwkw05e1Q==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ye Bin <yebin10@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH -next] ASoC: wcd934x: constify static struct
 snd_soc_dai_ops
Date: Fri,  9 Apr 2021 17:22:48 +0100
Message-Id: <161798344183.47643.7944011356113525244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062648.803227-1-yebin10@huawei.com>
References: <20210408062648.803227-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Thu, 8 Apr 2021 14:26:48 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd934x: constify static struct snd_soc_dai_ops
      commit: e994cf82689465ddae2dfa9c9bc69616a0003649

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
