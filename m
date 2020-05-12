Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A444C54E4A
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 15:11:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EBF20674
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="skYRtr/H";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg+xeYoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EBF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 439D61696;
	Tue, 12 May 2020 17:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 439D61696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589296310;
	bh=tlXenyHh2qBd8PLkqJt5BwboI/alL6CtUk3u0RByxx4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=skYRtr/HkM9rICg/0WuXiJU6SfbhrxFnsnZk3osES4edKRxjrTSXSv7ickCpCqxw3
	 0duT4OFSZV8hZ5Wxvx0n5MTAg7z64QLla0Ki7oj9fZ+HboS1EOhHjLt6g2KYiYlDAI
	 AxdnX4ToiZ/Wcra5czEpBfPARnkk1d8W9eTIJIKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A06A5F80112;
	Tue, 12 May 2020 17:10:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0310F8014C; Tue, 12 May 2020 17:10:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCB3BF800AA
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 17:10:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCB3BF800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mg+xeYoO"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80F8C20674;
 Tue, 12 May 2020 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589296251;
 bh=tlXenyHh2qBd8PLkqJt5BwboI/alL6CtUk3u0RByxx4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=mg+xeYoOpTwftq0R5HikzRghhkANk4WIFDsAkTN9ccfzvWGhqtF7ox0Uqw4e68wTS
 FM4A2EFgIyfMoICyU94dRtd47YEBxmkHfWI47EnQJrCa+gT2vO6cw7dh4wpL38UXq/
 0jEW/ie12dyNF74djno+deKnruglxo3iD7dD5AnU=
Date: Tue, 12 May 2020 16:10:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>
In-Reply-To: <20200507133405.32251-1-amadeuszx.slawinski@linux.intel.com>
References: <20200507133405.32251-1-amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: baytrail: Fix register access
Message-Id: <158929624852.48167.8952887672884538174.b4-ty@kernel.org>
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

On Thu, 7 May 2020 09:34:04 -0400, Amadeusz Sławiński wrote:
> Baytrail has 64 bit registers, so we should use *read64* to read from it
> and then use proper mask values to check status.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/2] ASoC: Intel: baytrail: Fix register access
      commit: 6a5d6fd332624e4eee9a450bb3d18f761548822f
[2/2] ASoC: Intel: Use readq to read 64 bit registers
      commit: 6c47660e3c3acad9401f8fe1d288d4234f05549c

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
