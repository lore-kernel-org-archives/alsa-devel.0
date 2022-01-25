Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B334C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 10:21:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 178DC2074;
	Tue, 25 Jan 2022 11:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 178DC2074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643106065;
	bh=nJhy+qOwVi2cuvhFT1z4Bk/6ubjHdACKLf5hmIX9cbQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xn2k3hJ545qniui6vNYHCU9X3tPxm4k5Z+YjnZtJMxhMlminIBsEs76GMQvEJWflw
	 dPkj08l0KwLOsDUXECct3rmGJmt5P6VkjVYVrEPM8lkbinVg0WIUgccxtUYA1U9x0p
	 JuvZ7T03xjYjKslOXCyCS8Ln4PP+Dc3PTzVlF0oM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8262F80161;
	Tue, 25 Jan 2022 11:20:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 580E1F804CF; Tue, 25 Jan 2022 11:20:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1E92F80169
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 11:20:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1E92F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TuVNIz4b"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 33F7D61614;
 Tue, 25 Jan 2022 10:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79750C340E0;
 Tue, 25 Jan 2022 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643106003;
 bh=nJhy+qOwVi2cuvhFT1z4Bk/6ubjHdACKLf5hmIX9cbQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=TuVNIz4bXFcXHLeO+/nQGAidSWhSr4Ah9Q6oLeO9/O1+4oFj+Yl5MpKfS9ADcfx6J
 UQEjYTge2711+ePf1TZWq5vRuvx0e9rxgo/WSrj+nhKcDQ+AuhrtAjElomrXRCkT5z
 21iiuM9RjCjnx+PEL6JGPJkhSID8NQa3NgdOI8gQ4SdcUtXyeBMRcRvvAUjA1wiV32
 Wv/9wG7sEBkQmyubyxAnhUVHulwX8gOh19pjT09OyDXd84wk7axmHyv+MiODI4QxuR
 0r6P3lVM5W+T481TZNcia9u+h+EPtB1+NOGJKTu8mawd4ygwVl/5qZMBwIoV8NL7+1
 tEjukBPY/ajXg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <20220120133605.476138-1-AjitKumar.Pandey@amd.com>
References: <20220120133605.476138-1-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices
Message-Id: <164310600119.74817.7303379317708830215.b4-ty@kernel.org>
Date: Tue, 25 Jan 2022 10:20:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 V sujith kumar Reddy <vsujithkumar.reddy@amd.com>, Vijendar.Mukunda@amd.com,
 Alexander.Deucher@amd.com
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

On Thu, 20 Jan 2022 19:06:01 +0530, Ajit Kumar Pandey wrote:
> We're setting wrong card codec conf for rt1019 amp devices in our
> machine driver. Due to this left and right amp channels data are
> reversed in our machines as wrong device prefix results in wrong
> value for "Mono LR Select" rt1019 mixer control. Reverse dev ids
> in codec conf with Left and Right name_prefix to fix such issue.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices
      commit: 248be352bbae1a0f14d0d3511a5b0bb9665097f5

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
