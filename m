Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F547C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 11:52:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8B32189C;
	Mon, 20 Jun 2022 13:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8B32189C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655725938;
	bh=SuVDCNHEbOlC2PLzJ5QaCIgC0aer/NGwULiY+KDStas=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tr7b6IJ3GZX+s6Y5TGd4FC+kQdU1Wa66MpA+skYuZFJXsp6on9Vffo/XH3cazwj7P
	 hsr7f51rqkhHK2cirrdFORj0OEIj9Szx116kuG9Y89y7PfD/CGPbv29zHGlHYRsBfX
	 w7Etv8U6hHQoGuU+YzUmcpj0JJ7tz+NAJ0yWcukQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69F49F800CB;
	Mon, 20 Jun 2022 13:51:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 715F6F804D2; Mon, 20 Jun 2022 13:51:26 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E637AF800CB
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:51:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E637AF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oqZnxDXd"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CBD52B810DE;
 Mon, 20 Jun 2022 11:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95909C3411B;
 Mon, 20 Jun 2022 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655725881;
 bh=SuVDCNHEbOlC2PLzJ5QaCIgC0aer/NGwULiY+KDStas=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=oqZnxDXdymuW3DXJZY+tYQW2OfXQ+EB7rKbjv75TayzceXTqgFFgJV09XbmtwT/bK
 L83oAwW9bMFf0O/D9bQBd0W5Z2RVzey0jjgF7P6+sX2Dg0plBXEtaaxXgIOFFZWtUU
 O8GrCaHTM+8kdRbbu9/svjfZ/TXoaLY3AI0ZLzEImlGF+CJOvf2+/j8VPxl9uVIwvL
 PN5NW9+RrD91IBWo3ry5FTksOEcnJEgKTY3f4ngaRsrHkojJubFppxvgFzvMVgE+/S
 vovEVgvYSJdPgVXvRRXJ5Sbj67ukQiXsmXfYMAvVlYNnJ0zphRuVnsVxQyA3NzlKVB
 wxFFU1ChtYN7Q==
From: Mark Brown <broonie@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
In-Reply-To: <20220617120133.4011846-1-s.hauer@pengutronix.de>
References: <20220617120133.4011846-1-s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: Use dmaengine_terminate_async()
Message-Id: <165572588033.132065.9906162568287485506.b4-ty@kernel.org>
Date: Mon, 20 Jun 2022 12:51:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: shengjiu.wang@gmail.com, kernel@pengutronix.de, Xiubo.Lee@gmail.com
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

On Fri, 17 Jun 2022 14:01:33 +0200, Sascha Hauer wrote:
> dmaengine_terminate_all() is deprecated and should no longer be used.
> Use dmaengine_terminate_async() instead. This involves no functional change
> since both functions do the same.
> After dmaengine_terminate_async() dmaengine_synchronize() must be called
> to make sure the channel has really stopped before the underlying memory
> is freed. This is done implicitly by dma_release_channel() called from
> the .hw_free hook.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: Use dmaengine_terminate_async()
      commit: 289a3ec0b5b9a2de6fc75633aa81f017792ecc99

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
