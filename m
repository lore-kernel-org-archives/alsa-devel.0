Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40049C47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7069961028
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7069961028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E37016E1;
	Tue,  1 Jun 2021 19:40:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E37016E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622569293;
	bh=+nPjaSYf2jAkLUxPL/kyjKJJSVXdCLkfPNaKAIs/mdI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DzaIJTHmXlkIsiEY6e2x1YONzNZB08Mx+ZAhGgRSOaKsV2EkJ/yt5/TWMEdx8ikLr
	 agJZEfjHb/WGDSWtHti2VqzlB9bwDAhgfuTjbmbaTJ12wB2lYuxwQicxhwy1/USy9l
	 rr8YNyqKTjrDnes12O6BAlvuqR2tlYz1dqeqSqBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53B66F804C3;
	Tue,  1 Jun 2021 19:39:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BA29F804C3; Tue,  1 Jun 2021 19:39:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A416F800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:39:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A416F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JzMx62HN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E7A61042;
 Tue,  1 Jun 2021 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622569138;
 bh=+nPjaSYf2jAkLUxPL/kyjKJJSVXdCLkfPNaKAIs/mdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JzMx62HNQLZme4iBjeeNaEbpRg12XN8fLoWrjqdL7sc2+ulm0seM749m+u1a9awXx
 3MwOqYkC5iyAhVIGcN6TQOnNp3iVVQERzYRl7Zy62CuTPc7NHOiGBmQytmTQ2lVxan
 w67MavJV7o3E5vmbWGh9KCvcAUUJudnL/PQnJJax1JMi7Lcmixx/Wgi6D0s+XjHxQd
 /lJX9PmsdKQljvzB/rZb0dCqCt5cdDfMdQhsPuG/h7J95Zl97Qjr++4XWwgwHLE2/Z
 Vp59mHpBQKj3qzqc/KKM4d7mkmEc8kRtlkiUApYWYhJtXovFnGc6udVcG7N1dxWXko
 dAGGdf2OuVqOw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Fabio Estevam <festevam@gmail.com>,
 Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Set .owner attribute when
 registering card.
Date: Tue,  1 Jun 2021 18:38:12 +0100
Message-Id: <162256892744.19919.16538295874685762857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
References: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Thu, 27 May 2021 18:34:09 +0200, Nicolas Cavallari wrote:
> Otherwise, when compiled as module, a WARN_ON is triggered:
> 
> WARNING: CPU: 0 PID: 5 at sound/core/init.c:208 snd_card_new+0x310/0x39c [snd]
> [...]
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.39 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events deferred_probe_work_func
> [<c0111988>] (unwind_backtrace) from [<c010c8ac>] (show_stack+0x10/0x14)
> [<c010c8ac>] (show_stack) from [<c092784c>] (dump_stack+0xdc/0x104)
> [<c092784c>] (dump_stack) from [<c0129710>] (__warn+0xd8/0x114)
> [<c0129710>] (__warn) from [<c0922a48>] (warn_slowpath_fmt+0x5c/0xc4)
> [<c0922a48>] (warn_slowpath_fmt) from [<bf0496f8>] (snd_card_new+0x310/0x39c [snd])
> [<bf0496f8>] (snd_card_new [snd]) from [<bf1d7df8>] (snd_soc_bind_card+0x334/0x9c4 [snd_soc_core])
> [<bf1d7df8>] (snd_soc_bind_card [snd_soc_core]) from [<bf1e9cd8>] (devm_snd_soc_register_card+0x30/0x6c [snd_soc_core])
> [<bf1e9cd8>] (devm_snd_soc_register_card [snd_soc_core]) from [<bf22d964>] (fsl_asoc_card_probe+0x550/0xcc8 [snd_soc_fsl_asoc_card])
> [<bf22d964>] (fsl_asoc_card_probe [snd_soc_fsl_asoc_card]) from [<c060c930>] (platform_drv_probe+0x48/0x98)
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Set .owner attribute when registering card.
      commit: a8437f05384cb472518ec21bf4fffbe8f0a47378

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
