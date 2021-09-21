Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CCCC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:27:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989DE61186
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 989DE61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDA6B1655;
	Tue, 21 Sep 2021 17:26:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDA6B1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632238068;
	bh=5mGV+nCp9l2zmcCGt8WiEpj+RJfDrXbHM11DF0P27xA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUfSGTlvhIByagXOeIOLoVHgmAOFobaLFZ3ct1p97/1TnTdBhG2VMuDkf+P3e6Tr7
	 YrsVicUq7vMP77OFrB31eYBdWpym/Ms+bsKN99mo88HEi7AwkZF5k5W+JyPVOBUDtF
	 6mCMY8RKbCAF9McZT5b+OdwNgx2H89mqJQ1tsq5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 140D0F804D8;
	Tue, 21 Sep 2021 17:26:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A91DF804BD; Tue, 21 Sep 2021 17:26:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6051F802BE
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 17:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6051F802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Zx7FtSy5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 471E5611C6;
 Tue, 21 Sep 2021 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632237961;
 bh=5mGV+nCp9l2zmcCGt8WiEpj+RJfDrXbHM11DF0P27xA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zx7FtSy5mQEQnDq1Rg2VU1fb65Y1ouLG0i+J4T7X2VyjI9BxhPv2FbKA5OUItp81S
 3CF4NMi3X0/suvLs1T1paaR/Zsb/qi/IPItXNXjHZvrUyQwtWqwbLhnVv9VNuinh9O
 LZesLwzTETwFBUEmUlXnfJA4e6cjgfijMMAS7x7YcQwuzXe8kG91Avlkfsq6MYe10Y
 dFfVRrHquZg65TgGBFKVrYoqYQVvevbJoKeFagJFdnshKfFfzd22LP3xTC3dWr9pEi
 r77GUxIoWjAGjbIrOZO8kfhABqPJPekxvfl6cLBliFnLh6BQgrv+E8z/jVxdngDCdQ
 pPe2GYCCFFwZA==
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2
 registers
Date: Tue, 21 Sep 2021 16:25:09 +0100
Message-Id: <163223651319.32236.308889133436007639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Kirill Marinushkin <kmarinushkin@birdec.com>, Mark Brown <broonie@kernel.org>
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

On Mon, 20 Sep 2021 16:49:39 +0200, Peter Rosin wrote:
> From 625f858894af2b7e547cc723b97361081438b123 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> 
> Commit 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
> breaks the TSE-850 device, which is using a pcm5142 in I2S and
> CBM_CFS mode (maybe not relevant). Without this fix, the result
> is:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2 registers
      commit: 3f4b57ad07d9237acf1b8cff3f8bf530cacef87a

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
