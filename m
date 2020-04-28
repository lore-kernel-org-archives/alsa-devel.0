Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0DEC83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:43:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479C720575
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yw9aY2xL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aapNIP/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A07921687;
	Tue, 28 Apr 2020 17:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A07921687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588088637;
	bh=BKDKvSn8LUzBEdgCRA0cYEIBFBCWglHXGBbtNkpxGq8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yw9aY2xLgmVopkgpEecWjUtIjuhD7Yg1l7do91LbEOtLid3oSoExRqlngZAH4SIvk
	 OtIVi1e7JjzWPHdoBS4KcuLIgSD1HN0QBtK2hcCaVLuV2csKHYUFxnHYMv9eN+Yge2
	 P+qtEWkBqL8YGEhrKg9lx2KjAdXPIzEXsF6x2R04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC74FF80268;
	Tue, 28 Apr 2020 17:41:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 394A4F8028C; Tue, 28 Apr 2020 17:41:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C2E2F8028C
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 17:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C2E2F8028C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aapNIP/E"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5196D20746;
 Tue, 28 Apr 2020 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588088482;
 bh=BKDKvSn8LUzBEdgCRA0cYEIBFBCWglHXGBbtNkpxGq8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=aapNIP/EMASZ2QIesqJaqb1QgQeGZ9IFVIohyszfgsnkCN2v1/oXbhMOlNOPW3tgJ
 jZ0C81LjMBuvEIOz6NBAMs4PMlLGRh9Fe4SWx0a5PyCcyqMhRX1mLWOEIGGMerOicg
 vN+3/pHkBMtuApknJSHk8ZPsCTEUvQhI5ua/4b9M=
Date: Tue, 28 Apr 2020 16:41:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v2 0/3] add channel constraint for BDW machine drivers
Message-Id: <158808847385.38342.17676813183484650913.b4-ty@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>
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

On Tue, 28 Apr 2020 01:13:31 +0800, Brent Lu wrote:
> The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
> recording while other two drivers support only 2-channel recording. HW
> constraints are implemented to reflect the hardware limitation on BDW
> platform.
> 
> Changes since v1:
> - Change the patch title.
> - Remove the DUAL_CHANNEL and QUAD_CHANNEL macros which are too obvious.
> - Follow the naming convertion, using 'bdw_rt5650_' and 'bdw_rt5677_' to
>   name startup functions.
> - Refine the comments in startup functions.
> - Redesign the bdw_rt5650_fe_startup() function for readability.
> - Add an assignment to initialize runtime->hw.channels_max variable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: bdw-rt5677: add channel constraint
      commit: e241f8e77958de2b7708e72d7159952d2bd1f0fe
[2/3] ASoC: bdw-rt5650: add channel constraint
      commit: 08d6713a4056cab5b29eb135eecb2e97492fc8d8
[3/3] ASoC: broadwell: add channel constraint
      commit: ad18763f46835b768714ac6de6dcf42384a261ca

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
