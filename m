Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8CBC6FA90
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 10:35:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C51B850;
	Tue, 27 Sep 2022 12:34:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C51B850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664274938;
	bh=fMlySmBZd6W9Q/MO9s/CdXwQ8wXWkT6Xhs8cfcFXLDg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t44OiQiOlxN1KMSsem/uWo4uHrY+xeKQSrSF55KDL/C703iVK6u4S5TacyL6YEgtL
	 nh3ZZFYZKQvSyl9luWaWIUKX69kd2Qwd271wuAQpKaQ2H6iyJl1FjD+4J1rr8kj0k/
	 Hu8Q4I7B5zLkR2YCyHMCNAbcZ6tSRYvMm8UFRxxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E6F5F804D0;
	Tue, 27 Sep 2022 12:34:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85AFAF804D0; Tue, 27 Sep 2022 12:34:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7746F8011C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 12:34:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7746F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gWLBrHRL"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D738617AE;
 Tue, 27 Sep 2022 10:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A550C43150;
 Tue, 27 Sep 2022 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664274858;
 bh=fMlySmBZd6W9Q/MO9s/CdXwQ8wXWkT6Xhs8cfcFXLDg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gWLBrHRLl/BDmeIF+akpURlYd/yWjlMcpFgIsv97EttXTZTstBCMwlH+RLn+uqzoy
 FyVJJy5IZMpkb8veJgBg5lj0XulYjXsHuzv6WlNokMr6tXkS+Sn2IYJkbWRSmxNVN8
 Tdgw8KM4PM5uvB8JCjH9wnS5XqNQcu5yWjFWrsdc+xOAGqbpFsKw+6YO7JGLy+M44B
 yS9t+0rm7vlrV9luAR2MLpCx5ifE0dTcb+r/GdQrOmTHmRqHmC8HL4EHLTo+eXHjp/
 Ls8lhw24r0cbJIhlYtMO4Q4ggOYmGRStEPpD57aWSeE69a7m7IiXI0lRXCyd8RyCFV
 spbRwml461u1w==
From: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20220920025804.1788667-1-dmitry.torokhov@gmail.com>
References: <20220920025804.1788667-1-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ssm2518: drop support for platform data
Message-Id: <166427485628.60697.9485122465766721682.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 11:34:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Nuno Sá <nuno.sa@analog.com>
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

On Mon, 19 Sep 2022 19:58:03 -0700, Dmitry Torokhov wrote:
> There are currently no users of this driver's platform data in the
> mainline kernel, so let's drop it.
> 
> Newer devices should use DT, ACPI, or static software properties to
> describe the hardware.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ssm2518: drop support for platform data
      commit: 1e1f26635e5459db4134952369b76b8d59c50438
[2/2] ASoC: ssm2518: switch to using gpiod API
      commit: 179f69fa37bb4ba7e5e6ecd04096cdec53c2fe12

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
