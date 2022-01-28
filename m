Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5CDC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jan 2022 23:47:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B87D01696;
	Sat, 29 Jan 2022 00:46:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B87D01696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643413669;
	bh=SHqir1PFEnkYonJwx2o+eKoTwpazoWYclufz5pnLxio=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bwmfdk0Fq/m5/bR66yJcQJHUVkUB1B2Vr0HQ+WLknhqIjkRgdm2U863b1jvasQum6
	 HV4hI6fCgfpYih1VID6+KKT3+6HyjGXNkFzFIUwOw/LbHrJdc9x3xthQu3AiRWaFlP
	 y2T47n2zOduH63p1qFA/ECfdfzc4tuTEDjo58Syo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 563CFF80118;
	Sat, 29 Jan 2022 00:46:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1098CF80118; Sat, 29 Jan 2022 00:46:55 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5281CF80118
 for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2022 00:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5281CF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WTjan7NO"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 435FACE281B;
 Fri, 28 Jan 2022 23:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856CCC340E7;
 Fri, 28 Jan 2022 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643413605;
 bh=SHqir1PFEnkYonJwx2o+eKoTwpazoWYclufz5pnLxio=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=WTjan7NOmv/yAld42FYjz5W9fbWvNGPKh9SdCU5JvkZpFziFDIWAx8lEOF4js7M0X
 6XlWiKonRiMt/a/JFTmbULlPLR1BkioOynaU1tRBn+ZUZBLukzR35ilL82YR6Rhx6z
 tQAtV5coPJjIluiZsOyHipWKWRzJSaw+BovxI1b6RMlyZE+8xlaGmi1HqnQJIYUFtv
 34fAN2FxBZN18E1ybll6FPZTL4qa8MWin4y3eDDmOTEJ4fCm8Ih9A+1zyYiRQwLXxz
 k4VVB1MD7e7P0gbFgKQbLKV39vllMrSSdWamzRvjMsmdFbvxeR8K6HVIqrSV0hrIIo
 xAyDOrGB2B4mA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20220113141858.10904-1-tiwai@suse.de>
References: <20220113141858.10904-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: soc-pcm: Fix DPCM lockdep warning due to nested
 stream locks
Message-Id: <164341360424.694662.16808828094222567575.b4-ty@kernel.org>
Date: Fri, 28 Jan 2022 23:46:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Thu, 13 Jan 2022 15:18:58 +0100, Takashi Iwai wrote:
> The recent change for DPCM locking caused spurious lockdep warnings.
> Actually the warnings are false-positive, as those are triggered due
> to the nested stream locks for FE and BE.  Since both locks belong to
> the same lock class, lockdep sees it as if a deadlock.
> 
> For fixing this, we need take PCM stream locks for BE with the nested
> lock primitives.  Since currently snd_pcm_stream_lock*() helper
> assumes only the top-level single locking, a new helper function
> snd_pcm_stream_lock_irqsave_nested() is defined for a single-depth
> nested lock, which is now used in the BE DAI trigger that is always
> performed inside a FE stream lock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: soc-pcm: Fix DPCM lockdep warning due to nested stream locks
      commit: 3c75c0ea5da749bd1efebd1387f2e5011b8c7d78

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
