Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AAFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 20:43:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 377FE1775;
	Mon,  7 Mar 2022 21:42:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 377FE1775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646685796;
	bh=kfRKFupuLhzforhTOfYrOlnEcnMRt1cRf4Jr2UuaEzk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqjXU5zIiK3QiJK/CoquitF5KKSmosVPAOeE8pjbiFP+5wdaGSbR6QGwKzJM459q6
	 +r/vg+4ilFh+sFoPBAnt0njv0dRqn1QPV2QXVNT3jwM+hYPsrU5+k0OSdQms6hJ0HR
	 752TIodxsim1MsQS8xP0MivvUirMcJSqAsOudwPs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 512F6F80553;
	Mon,  7 Mar 2022 21:39:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA92DF80542; Mon,  7 Mar 2022 21:39:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43FFEF8053E
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 21:39:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43FFEF8053E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k9vaLGfp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B12E56151F;
 Mon,  7 Mar 2022 20:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51622C340E9;
 Mon,  7 Mar 2022 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646685558;
 bh=kfRKFupuLhzforhTOfYrOlnEcnMRt1cRf4Jr2UuaEzk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=k9vaLGfp6eL7dBGmy0wsTzzeZk52nprOXcKgBXka3S6jh7jC51F85NRzpEf9BQhnb
 cjFsfy0Q28gZfGYLPAGeaU+TJQH+d5gJWZB8yE9TyBdKL3NY49ZicG0j1bv7CcI9SF
 wgHoh6i+vWovxkX/g9Iu08Jcmv7bFoWPLBelLLEhYcg9XPV7POwWLdVXx4lgQu0J+E
 PAsEyMc9qxJW7wC4eI/hY6OwbjhQBtxKEUEG+uvUsf7FN2CyvFLDJvMQ8qMxfKtSRA
 we8tX9pvjFApmaSMIouM3toICelnY3tAxQftCR+8ZTc/u0GIopXVvppghy/GCF7SF3
 il6YO4L+FmTHA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Meng Tang <tangmeng@uniontech.com>
In-Reply-To: <20220304131449.GC28739@kili>
References: <20220304131449.GC28739@kili>
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Fix signedness bug in
 renoir_audio_probe()
Message-Id: <164668555706.3137316.278603309577942240.b4-ty@kernel.org>
Date: Mon, 07 Mar 2022 20:39:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
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

On Fri, 4 Mar 2022 16:14:49 +0300, Dan Carpenter wrote:
> The "adata->i2s_irq" is unsigned so this error handling will not
> work.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Fix signedness bug in renoir_audio_probe()
      commit: 899a9a7f624b5a9d100c9ac6b3f0960981f0e4c5
[2/4] ASoC: amd: pcm-dma: Fix signedness bug in acp_pdm_audio_probe()
      commit: 00925272f166db31fed73f3c00c151eb5f7ce1d8
[4/4] ASoC: amd: pcm-dma: Fix signedness bug in acp3x_audio_probe()
      commit: 9a33f5632ca573e512c49fa46cc7131cbc83d4c9

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
