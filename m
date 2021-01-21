Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F320C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:10:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8396B23716
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8396B23716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C8BE18AB;
	Thu, 21 Jan 2021 01:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C8BE18AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611187830;
	bh=UUKzBQxLkBhYjym818Hr0vGurpuNCZqXyHa55eogA14=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dkt8NcwDfpl+OgDWb1DWMGQIuDkXhNtH3smqRjgP4Ni8rF33w03ZxrFtwDrgZwKYi
	 PSGSI48GXOP1Y+rcSUhTzK3znGTZ7uRvcLH2BNONiBqaybrGP890xIZhuyXXnPjG6L
	 31hKrZ70S659ojiVUQqt1DaINevmKDiVneliuvKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C411F804FA;
	Thu, 21 Jan 2021 01:07:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD3EFF804FC; Thu, 21 Jan 2021 01:07:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0748AF804F2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 01:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0748AF804F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fViAopOo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B70B32054F;
 Thu, 21 Jan 2021 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611187627;
 bh=UUKzBQxLkBhYjym818Hr0vGurpuNCZqXyHa55eogA14=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=fViAopOoAexLJGAd+U1pDwCk/ujh6INeub8C31Wte83Cm2//fdqeanJ84NzrYEQB8
 uNR+e3TystfROvpU2N7JhtlYRpw74bTXhp3bz0XsYZfO8XZc//F5iCDMQmsmH1RPjQ
 DCvQs/rGsLl202+07lW8Cwz3EUlaLCtuaKLNWRhddbE2svs7YwU+fnc3Hzf1tNdcA4
 AbYlcMcJ36kU3NuuTY0MPzlERiPR14pGzzXPjyZtoijGaZr0snA2uqwgW2QHGvR4PM
 1D04eauUxeSdf0u9yerfq8lo4/E+0n12SfkkgNtyWybFkbN8BoMEcL9ftZGfSkYfpY
 el9ZCw6F6HSOQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
In-Reply-To: <20210114133337.1039-1-tiwai@suse.de>
References: <20210114133337.1039-1-tiwai@suse.de>
Subject: Re: [PATCH 0/3] ASoC: Simplify with dma_set_mask_and_coherent()
Message-Id: <161118753483.45718.7168616825847385991.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 14 Jan 2021 14:33:34 +0100, Takashi Iwai wrote:
> Simple conversions from two dma_set_mask*() calls into the single
> dma_set_mask_and_coherent().
> 
> Just a minor code refactoring, no functional changes.
> 
> 
> Takashi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: intel: skl: Simplify with dma_set_mask_and_coherent()
      commit: d3afb00220becf81bc2d9016f04e05949dfd5bb2
[2/3] ASoC: SOF: intel: Simplify with dma_set_mask_and_coherent()
      commit: ab152afa2427bb3e4eea7c9f21c4393287838774
[3/3] ASoC: tegra: Simplify with dma_set_mask_and_coherent()
      commit: 7cc206bff69b52be24fa13ee2c9afde3320c6cf6

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
