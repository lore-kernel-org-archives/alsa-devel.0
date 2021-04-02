Return-Path: <SRS0=kQrV=I7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4EC433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 16:46:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3E861163
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 16:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3E861163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4424316BD;
	Fri,  2 Apr 2021 18:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4424316BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617381999;
	bh=ufvuiUCSbqwXDHJgd0eKNOPHGm73oKqeMOFMZz6eaSE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODVuNlIu67uwich5w4gQY/b8Z9EvnYZDtNV9v71g4Vl0CJJtt2DJ0HjQTsH5IXffE
	 88NCT0FsaF9t9w6Hh5G16+KA65ah+rPBu0MBMWkAXTV58wX8CUuMt4vfe15mstg1Yg
	 u3Ifb+R9NPf5VQLjFXvvRkdjmgEDY1d6nyLpKIDg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6092F8016E;
	Fri,  2 Apr 2021 18:45:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AF1DF8016E; Fri,  2 Apr 2021 18:45:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B6F5F8013F
 for <alsa-devel@alsa-project.org>; Fri,  2 Apr 2021 18:45:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B6F5F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Zmrkmopb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAA061163;
 Fri,  2 Apr 2021 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617381940;
 bh=ufvuiUCSbqwXDHJgd0eKNOPHGm73oKqeMOFMZz6eaSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZmrkmopbJHILHkb7W+VaEsjnNQi0OE+nhcC6f5QPef4PvQ/OtY+tNB99sqhHfImRb
 jejcZ1Y5xFdoeLPahmUxGzKluSzaTTqxIRb0wDVxq0lkonHQmB+rQebA57M5wSHW3M
 6IiGPkNPIY/3mQ1sjsxvi3KXyxkM8CygncoCvUqppOT2Vqp5pQqd6GcRYA/vK5fiRD
 iyJNTS9wsAFx4gBTwyrfDpNR5AOQvUnpH3RdIFL4ujwmYOUNzKuIBW8oxLaGDDvizF
 uwYfX7Dw0e20reBO74dK3wmPxslH0/9wbKsNIq0rpyTpXm+m78x1SnSs4AxvbCm9wD
 TjH/Q9DTClysQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/6] ASoC: rt5670/Intel: Add support for Bay Trail CR /
 Dell Venue 10 Pro 5055 tablet
Date: Fri,  2 Apr 2021 17:45:22 +0100
Message-Id: <161738082582.46021.13400835725838307642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210402140747.174716-1-hdegoede@redhat.com>
References: <20210402140747.174716-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Bard Liao <bard.liao@intel.com>
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

On Fri, 2 Apr 2021 16:07:41 +0200, Hans de Goede wrote:
> Here is a patch series to enable sound on the Dell Venue 10 Pro 5055 tablet
> this series also includes 2 generic improvements to rt5672 support:
> 
> 1. Add support for boards using Bay Trail CR (SSP0) in combination with a rt5672 codec
> 2. Set the card's components string based on the DMI info, so that we don't need to
> duplicate the DMI quirks in userspace (in the UCM profile)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: Intel: Unify the thinkpad10 and aegex10 byt-match quirks
      commit: ebbb165d2c0c44ffbf480e209f745ed4b0d5560a
[2/6] ASoC: Intel: Baytrail: Add quirk for the Dell Venue 10 Pro 5055 tablet
      commit: 17d49b07a8bb3fdc630a44240c7d7e2a18e14b93
[3/6] ASoC: Intel: cht_bsw_rt5672: Add support for Bay Trail CR / SSP0
      commit: c9b3c63392e578ea74411b29a720ace77ae9041f
[4/6] ASoC: rt5670: Add a quirk for the Dell Venue 10 Pro 5055
      commit: 84cb0d5581b6a7bd5d96013f67e9f2eb0c7b4378
[5/6] ASoC: rt5670: Add a rt5670_components() helper
      commit: 3d534537648bd7d7a82f2becc9ded99a4b228a6a
[6/6] ASoC: Intel: cht_bsw_rt5672: Set card.components string
      commit: e992a51b1d14317f414d4b9935966dca96ac0b36

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
