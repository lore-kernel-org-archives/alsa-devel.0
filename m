Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1057CC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 13:13:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21ABF1683;
	Wed, 23 Nov 2022 14:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21ABF1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669209184;
	bh=6N8VLx5XLFcx0UnyHnQhdCl3xgM1JMvEbDLVhm+Xgp0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQgo+MA1pKAPF2MkMH6GxYeSgHl/xwmjiVCJlgCTHDAQ7V1aXFB0Q6+Fv8GDfUqs1
	 tCfOjWcrF4SfVZ3MbuIu/PpEEMCSokE7yHO3Eh/7U+PzzlArTvAiiK7QWC3G8hUxoy
	 xkH/p5IkV9P5wKw0RgkTxUKL5tPuWC6hXDuzY9yA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1602DF8055B;
	Wed, 23 Nov 2022 14:11:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDBA8F8049C; Wed, 23 Nov 2022 14:11:44 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 214B5F800BB
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 14:11:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 214B5F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XCvOXAKE"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id EBE93CE2157;
 Wed, 23 Nov 2022 13:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B265C433B5;
 Wed, 23 Nov 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669209092;
 bh=6N8VLx5XLFcx0UnyHnQhdCl3xgM1JMvEbDLVhm+Xgp0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=XCvOXAKEmpGuWXt72Juj0FAFdXzQqY45WIRWmfGovvaAw/cEEaEYZ5nvSDhL/WWd0
 8oQHzo13m3WSgkq6A0uZOvEUAWyaoGRso7GNyGBEjM71qmcz1TBYrew1xeuYsdvX1J
 M7t2mrlc067PKgJQqQXJn+lipg9wlMWZJF+/bI6Lz0HM30aoZJbDT2dmGcSvTeVpZy
 zZBN8TJ5ajvWp00mxg+aeaMhLkEd4QO78wLQpTL1PM6XZy9/r33nIXXNVgtpgx2aQ8
 cwKodOtmxO08IdkEf4nrVGTgjRZfYmASjgex5LrqpH4mX6IQLQg1iA1+B1lgGWruku
 MbmqcgE3pw+CA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20221104160252.166114-1-rf@opensource.cirrus.com>
References: <20221104160252.166114-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-dai: Do not call
 snd_soc_link_be_hw_params_fixup() twice
Message-Id: <166920909090.125457.3717205173938547905.b4-ty@kernel.org>
Date: Wed, 23 Nov 2022 13:11:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

On Fri, 4 Nov 2022 16:02:52 +0000, Richard Fitzgerald wrote:
> For a BE link snd_soc_link_be_hw_params_fixup() is called by
> dpcm_be_dai_hw_params() to initialize the params before it passes them
> to __soc_pcm_hw_params(). Then __soc_pcm_hw_params() refines params to
> match the BE codec and passes that to snd_soc_dai_hw_params().
> 
> The second call of snd_soc_link_be_hw_params_fixup() within
> snd_soc_dai_hw_params() was overwriting the refined params with the
> original BE CPU DAI params. This would then lead to various problems,
> for example passing an invalid number of channels to the codec driver
> hw_params(), or enabling more AIF widgets on the codec than are actually
> mapped by TDM slots.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai: Do not call snd_soc_link_be_hw_params_fixup() twice
      commit: 3115be55138afb9fb9ae1b4e99378da34bcfd164

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
