Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D19C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:03:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E4D60C3D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4D60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74A561607;
	Mon, 22 Mar 2021 14:02:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74A561607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616418199;
	bh=jOfZ1oiP6ZdAt5RXa8U5mFsaqC8Jcdc1244PePt1skI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5hf19bscThXsHltYxCQ/Ip+3jU6TXXC1y/IW0bJZhPp6GWE9A68nBuD5MI9t9hVs
	 vbzyFsp+W5YeoeegxMCsuSokbMBdzdzeJ9bmReB+Mx66UMpEObe+6XiDCJtI2JXuJl
	 117yQT3WN2X41qBKB1kjwdxQ26QRdBHKLXvAHYoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68F66F80431;
	Mon, 22 Mar 2021 14:00:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 941F8F80425; Mon, 22 Mar 2021 14:00:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5E22F8025F
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:00:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5E22F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kdljQfZU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B747961998;
 Mon, 22 Mar 2021 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616418047;
 bh=jOfZ1oiP6ZdAt5RXa8U5mFsaqC8Jcdc1244PePt1skI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kdljQfZUyLBIend9rTcIIvYM1uZBtK+XBPLzCcYp9qbu1AuPccEQIrIyyZSigd6U3
 pQ2Tb0/tco7eg3MAeL7ys+uaW694tSSp2rAyhheke71fGQELFPJC9rwrgiuRTLcY76
 aL/PeXPicWf0H01SkQH3J0LSlGI97RjwVc3qOpWU2hFx1omWwBIFCR14Nwj8mdRwm4
 6mNYPbNpMA3+IlRCgw+zi9CZ2/qtlibsSGDMiGSIQFmxNgM9m5PDK2DcytKftC40BZ
 iW6wM1Nfb3FbPHf9eyd5X7nkqU2nIl0oqu0QSx+F5JKPTPCXaz8QrKkF0AuRRAoTGd
 eUeaH2EHiWwnQ==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: SOF: add a helper to get topology configured
 mclk
Date: Mon, 22 Mar 2021 13:00:32 +0000
Message-Id: <161641797252.25992.4839900873396011247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319124950.3853994-1-kai.vehmanen@linux.intel.com>
References: <20210319124950.3853994-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 cezary.rojewski@intel.com, yung-chuan.liao@linux.intel.com,
 daniel.baluta@nxp.com, Keyon Jie <yang.jie@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com
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

On Fri, 19 Mar 2021 14:49:49 +0200, Kai Vehmanen wrote:
> Add helper sof_dai_ssp_mclk to get the topology configured MCLK from a
> pcm_runtime, return 0 if it is not available, and error if the dai type
> is not SSP at the moment.
> 
> Export the helper for external use, e.g. from machine drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: add a helper to get topology configured mclk
      commit: b951b51e2ca4d37dc9781e14d8a49d2f2b7e715b
[2/2] ASoC: intel: sof_rt5682: use the topology mclk
      commit: bf939446c357242b3306e88c5f48976940d29679

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
