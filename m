Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC75820760
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YEMud/uy";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAxCMucR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC75820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 780CF16D2;
	Fri,  3 Jul 2020 19:05:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 780CF16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593795973;
	bh=avVmBYE85HqmZGz24vFbJj580KfAPUe9Qy5+/5Manoc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YEMud/uyajHxV8BzPQooW2jVQuDfgvBnAbQWvvVkPDHblvMAxAKbaGONHH/tvxs5o
	 A9Wq6MzZhU9zkyqFON/C0aDDAxzdwiJhvswmt7Ejmb/47ardaFv13domKW3AQP8Jfb
	 Nw137efwXegCt/EQavp2+JlCHYdEak5FvrU/jnkE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC5A3F8028A;
	Fri,  3 Jul 2020 19:03:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F600F802A9; Fri,  3 Jul 2020 19:03:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF100F8028A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 19:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF100F8028A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kAxCMucR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2B5A20870;
 Fri,  3 Jul 2020 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593795831;
 bh=avVmBYE85HqmZGz24vFbJj580KfAPUe9Qy5+/5Manoc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=kAxCMucRahfO2ghUeJK+MEqOP+R0sb8agJKsi5oXJcHuMs4fZ6Ol7ftUCaB5qerV1
 gO7asNnUfNJ9DL/jfAdBrO1MlU6niawzdHr4C2MS9vF84zwDWKMmOdnJK6DQo0eaA3
 qkEHs36FuA9MxZpytVjmfm9EfEzEnd01vTyCN2qI=
Date: Fri, 03 Jul 2020 18:03:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Colin King <colin.king@canonical.com>,
 Brent Lu <brent.lu@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200702114835.37889-1-colin.king@canonical.com>
References: <20200702114835.37889-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL
 on unrecognized speaker amplifier
Message-Id: <159379581380.55795.4909094479360848314.b4-ty@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 2 Jul 2020 12:48:35 +0100, Colin King wrote:
> Currently if the ctx->spkamp is not recognized an error message is
> reported but the code continues to set up the device with uninitialized
> variables such as the number of widgets.  Fix this by returning -EINVAL
> for unrecognized speaker amplifier types.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL on unrecognized speaker amplifier
      commit: c950e9fcc79b8fedd3126ede4dcd70add8ea5339

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
