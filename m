Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851A1C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 04:09:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB7F91959;
	Wed, 23 Feb 2022 05:09:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB7F91959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645589397;
	bh=chHr6Hi6/ljF9MKppMHTjh511Ke4P0ALuSXD4iHjEDY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4Khgm2Y/ZqLb/ksGjk/MRCvmjA0XrKzLk6XC+Bzb5e+HOnKqEVfaMfa8XDGeFhyA
	 eCDwOQbEw8fJNMRldXx29uuuYRgfSyIxMjO0RIDzEsjMatCJL7ebQWFM3XBu12YOwe
	 u7JQF9YN3+HBQvIQKDiX2dkPDb7mtTMpIZwhwa6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F2DBF80517;
	Wed, 23 Feb 2022 05:08:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC6DCF80237; Wed, 23 Feb 2022 05:08:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D374F8019D
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 05:08:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D374F8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OKlPxFYS"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B680A60AB2;
 Wed, 23 Feb 2022 04:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1ABC340E7;
 Wed, 23 Feb 2022 04:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645589295;
 bh=chHr6Hi6/ljF9MKppMHTjh511Ke4P0ALuSXD4iHjEDY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=OKlPxFYSSapEKrPD9S4F7Nic9law6V+xiPcLbPSUTJ/D2R7IutSzUUunxxVMPxf+R
 E+SNm2YYN3o7jhCdk5TWsDSdrKdAvHJnVXm3nV8Qdjx4vUMnnCIqlEhgyLH8HJeK5m
 XlK+kH1wmCiCQbyS0DUWjdnaKw9nepXzmJejiVfhGHYrTDcNOeyzXbFBfQgKBYHhkQ
 4GrxLhkYYCWGXA4kSZND5b3rfd30sZmgW7rirHCmA1fiW5h7e43sEnUZ3YCR5UWd53
 zgLCtk3JU4kmZ74DBwzp7RkZPtK8X4nqc/qNTm/R8WIp4nJL+dzImhN0JCKbHvU5eW
 zxS12pq8FoUlQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>
In-Reply-To: <20220223011913.2753938-1-broonie@kernel.org>
References: <20220223011913.2753938-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sc7280: Really depends on SOUNDWIRE
Message-Id: <164558929424.1665056.16734918253890057955.b4-ty@kernel.org>
Date: Wed, 23 Feb 2022 04:08:14 +0000
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

On Wed, 23 Feb 2022 01:19:12 +0000, Mark Brown wrote:
> The sc7280 driver really does depend on SOUNDWIRE since it calls various
> sdw_ functions (eg, sdw_enable_stream(), sdw_prepare_stream()) which do
> not have stubs when that is disabled so we can't build with COMPILE_TEST.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sc7280: Really depends on SOUNDWIRE
      commit: b83eb8be4f2ca9d6beb1a8b66f666ef7039b7a64

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
