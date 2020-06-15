Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC0C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:08:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBA22063A
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mtTe22wM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKaRawTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBA22063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48B2486E;
	Mon, 15 Jun 2020 17:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48B2486E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592233709;
	bh=zPiwW2ddojRxptWmrxHVSWKri79W0j8jIOBtmNYk3g8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtTe22wMSgQzMcmFPOZ91ISQfx8NE/fGWnAhF0aiyd3fKR4W/zKfXz1YkDFT/xgrx
	 7SNMW1y6bsUT64KHaaFdIof9scKHUqXLXxjaV+xIxDAnt5zEdY9yZsJ/jrrDMP8iTJ
	 wERwuZZYTMR6ocQnPSI7ESUCOz+MstpHVnfFaQ+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E41CFF802C4;
	Mon, 15 Jun 2020 17:05:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CE73F802C4; Mon, 15 Jun 2020 17:05:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37133F802A9;
 Mon, 15 Jun 2020 17:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37133F802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TKaRawTV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6350D2074D;
 Mon, 15 Jun 2020 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592233547;
 bh=zPiwW2ddojRxptWmrxHVSWKri79W0j8jIOBtmNYk3g8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=TKaRawTVR+cp+9/iub94hwHc0uK5Hl1JUkY07rJcNPdOQ7A5nU0Nxpr0m3/RiKV8v
 mPYH2HEDBa60a1Fdy9uq2oExYyionykWuFwo1No0EBF51Tns0HrcEVBCa1A6w/d5b4
 InecRH3V0m3grK3lmaq9wYVmA2UqJcwsTOsgM/uw=
Date: Mon, 15 Jun 2020 16:05:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
References: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v3] ASoC: SOF: Intel: hda: Clear RIRB status before
 reading WP
Message-Id: <159223353043.8967.4528383001962229795.b4-ty@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Keyon Jie <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

On Fri, 12 Jun 2020 18:50:48 +0800, Brent Lu wrote:
> Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> WP") from legacy HDA driver to fix the get response timeout issue.
> Current SOF driver does not suffer from this issue because sync write
> is enabled in hda_init. The issue will come back if the sync write is
> disabled for some reason.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: Clear RIRB status before reading WP
      commit: 40e2c465894e5b79b49f55d9574dbcda4ac0f08f

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
