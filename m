Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE88C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2604460EE2
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2604460EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B180116D3;
	Mon, 27 Sep 2021 19:52:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B180116D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765203;
	bh=GXD0MKnQbsqDqDA9NKW0c4ulynZfF1zuEy1IS/3pgIw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oXpnWh4TVGWdXijMrMUr4SI2TSWN8fp+Fkp9jrpEY2MwCHnEn51zXBm0Ol+BlSTg/
	 M04Zj2b5nVNFgbiKzcKVfZ95wkHuh7InXPJsONwgGnBZRUwUWPr0eDOGPwFj9BEGM6
	 8MQKB21mrQoVBdH7mCFm+5vdlD+nuRx1WuavGX/4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D63CF80551;
	Mon, 27 Sep 2021 19:48:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4211EF8053C; Mon, 27 Sep 2021 19:47:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FE18F8052E
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FE18F8052E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f8KUpsvu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 003A361074;
 Mon, 27 Sep 2021 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764864;
 bh=GXD0MKnQbsqDqDA9NKW0c4ulynZfF1zuEy1IS/3pgIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f8KUpsvuRNAVe56DgeTNL//a17Ns0gQQ9ZMg/gBneWwY027gin1T0yAkduWONlIqz
 VpgF2Dl0tIfUXlXHmb9UN2+aVvUnmwcrMD86I1SFkVgjVn3KNLRK7VY9W7wD7XJux4
 VZzOWhetaEzwstrruH3pzsQJ/bTXS9uFtpXhyNQnk6Phb6l9MHRuQ4fnKqY/WASQrl
 eIVgn2l+JkNVHNx2uPqUuu2rcgHWUs7VZFZTixx9QDpVo0aqvXBLfMyAtCEzYOYzS0
 Muu7yoYm5zZss2O90ZNvOS8ael5f6keLyXxcCd1Sdxa+uoDxei1UROMmTVwQ4r1veg
 jdJHc/mRxHdPQ==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: pcm179x: Add missing entries SPI to device ID table
Date: Mon, 27 Sep 2021 18:45:39 +0100
Message-Id: <163276442023.18200.2903645887827926931.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924194956.46079-1-broonie@kernel.org>
References: <20210924194956.46079-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Fri, 24 Sep 2021 20:49:56 +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding SPI IDs for parts that
> only have a compatible listed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm179x: Add missing entries SPI to device ID table
      commit: ceef3240f9b7e592dd8d10d619c312c7336117fa

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
