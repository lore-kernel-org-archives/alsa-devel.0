Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0530C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 20:20:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEAE516A4;
	Mon, 27 Jun 2022 22:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEAE516A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656361203;
	bh=AopzUSqPXSHo18J552vDhBqM08Y7dy8OrW6rgjrW1ls=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NdiOZPcSQB9V6hLoJDYWLMA1B6PNb+ULnTlkxpE6J2a9I/xD122D20V7vMEP5xSIu
	 QSvFGP3tvBHPSCR9dl/QTJAqmW3pHWuKtU/vwD7kLQZ/0bIQkzlRpjmTvRlS7lK57/
	 fT173mKul6QnS3IT7FJ7S8sZSrU+1KKN4yQPOVHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C6FFF8012F;
	Mon, 27 Jun 2022 22:19:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB216F8028B; Mon, 27 Jun 2022 22:19:10 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 545C1F800E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 22:19:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 545C1F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KFg2cZmY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 18441B81AAA;
 Mon, 27 Jun 2022 20:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1BC34115;
 Mon, 27 Jun 2022 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656361145;
 bh=AopzUSqPXSHo18J552vDhBqM08Y7dy8OrW6rgjrW1ls=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=KFg2cZmYg7/VfA3qIVivStEeALhJmdSxXC1sSadEFNECvuw6kH64Abzr6oC2Axgx9
 OvllhhpKWzuLcCYsW9U+ezDd47fKWowLKdxg3l6xHRsv4gqo99UR1myo8KwOx7Jbwg
 AXNbr5khSBuwfLl+YbaVsvgMLIKsIqTUrrOG4VKThelwywvqso1fNIfPfRrXWvId1j
 C8XgKI1/5IHtf9UAztqg57ON2NzLPg1lWxBC0DwWOvFI0VvEr35PggCfG0ANRyydvg
 z2VNYQ1xqVT36Hehrs8N0j7QZEbEUzFstompjvy15ecfPhaSIqgAJ/7aCd7VgLM6gm
 KukB1AaUpc74Q==
From: Mark Brown <broonie@kernel.org>
To: jarkko.nikula@bitmer.com, tiwai@suse.com, perex@perex.cz,
 peter.ujfalusi@gmail.com, lgirdwood@gmail.com, dowens@precisionplanting.com
In-Reply-To: <20220615150955.4140789-1-dowens@precisionplanting.com>
References: <20220615150955.4140789-1-dowens@precisionplanting.com>
Subject: Re: [PATCH v2] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-Id: <165636114384.3997797.13146235738897882917.b4-ty@kernel.org>
Date: Mon, 27 Jun 2022 21:19:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
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

On Wed, 15 Jun 2022 10:09:55 -0500, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requsted
> probe deferral:
> 
> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-mcbsp: duplicate sysfs error
      commit: 6d31e225742a1955db8a0c6f6f52beb748a2895e

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
