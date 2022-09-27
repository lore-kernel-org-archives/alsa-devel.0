Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C5C07E9D
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 14:49:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9FBF829;
	Tue, 27 Sep 2022 16:48:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9FBF829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664290178;
	bh=ZeMk/3E0OzkkDISoQSihxyFtSKw+qjaaKWkV6nZIzEo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5U0cgeF/b1VSrHT/XDDCMWJOA7Ry1/Tsny7UNXMJoHvmbT9TEGE5gGuu7ZBrdDqG
	 PI6v+no52vAfNlCyNFHqj8GHm2X978NpoUxghM+zmcmbnD1ApfVjXiTHITeeGkq7/q
	 7/opDubyNC7l96CbeXy+FnKX58ZJ7yvyJRe7ILes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71DFAF8024C;
	Tue, 27 Sep 2022 16:48:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06F77F80496; Tue, 27 Sep 2022 16:48:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4393F800AA
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 16:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4393F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TG8UvWh2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9B2E3619E4;
 Tue, 27 Sep 2022 14:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C4AC433C1;
 Tue, 27 Sep 2022 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664290121;
 bh=ZeMk/3E0OzkkDISoQSihxyFtSKw+qjaaKWkV6nZIzEo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=TG8UvWh22vkK/rZywCv916Cwq36ZrOfVIkggJbi8zN0YWz5hgBfEScU8bmQMwtth6
 Y6OoRpY5zzib6stCysGC5QMoSvOcYpeKExGtZtgPH4FlB/o6yMVF/BctIFdCRlKqYT
 eNrR2gODD8kuIhm/FUg/iuyj2rRTzmXCN70pNtlSt/Ft4e7CRfNwzFh0TM6288xdps
 aNoRwxXK/i5ZppbRFm3MZsEH7afxwVuRdY6r2RDCIp5FzZtRJ1WDRtrvd8RIaNBCV5
 Qx4o27hLdzxPqTAMbZBNag8BqtKYXCgJn0ic4NknRFCaL2CMXyKnwe/fht5oHXGF39
 8knVGMYfhLwXA==
From: Mark Brown <broonie@kernel.org>
To: Martin Povišer <povik+lin@cutebit.org>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220927113426.49724-1-povik+lin@cutebit.org>
References: <20220927113426.49724-1-povik+lin@cutebit.org>
Subject: Re: [PATCH 1/3] ASoC: apple: mca: Trigger, not deassert,
 the peripheral reset
Message-Id: <166429011948.444806.10905154613892329863.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 15:48:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev
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

On Tue, 27 Sep 2022 13:34:24 +0200, Martin Povišer wrote:
> Replace the deassertion of the peripheral's shared reset with the
> triggering of a pulse on it. This is what we should have been using all
> along as the platform's custom is not leaving the reset asserted on
> unused peripherals.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: apple: mca: Trigger, not deassert, the peripheral reset
      commit: d584e73e7310971cc226ef0e2a1bc0526da0d582
[2/3] ASoC: apple: mca: Remove stale release of DMA channels
      commit: e92e50e4263f5cf9c731ef5593c31f94dc3b7b8c
[3/3] ASoC: apple: mca: Adjust timing of component unregister
      commit: db6ae79a7e4f729457ec42db5d6d0fbe0e35784c

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
