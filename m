Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D98ECAAD1
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Sep 2022 13:04:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55F461630;
	Thu,  1 Sep 2022 15:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55F461630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662037495;
	bh=90Pu4Z0995xDSMUAbDdhc76aEoKg03ejpjrv0Doj9I4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e0rXGYvuC4jtFEZ/gnI2IV4oVpugVCYWnm21zyx0tnjnasAy9uommQG5QjTpjowly
	 1Y2QKyV7u+UVTjfpwgjK5DB8FXsjA2Xzjyuf1H99aDbkz86WHhc/hgacI4qlQ5JNMR
	 bwQgA16uSGEgGNKL9tUrA3Q9AEtLgBD51pxzvvXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAE13F8026A;
	Thu,  1 Sep 2022 15:04:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70004F8026D; Thu,  1 Sep 2022 15:04:03 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF778F800EB
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2022 15:03:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF778F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FBK7hgZs"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 78E84B82566;
 Thu,  1 Sep 2022 13:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BBC433D6;
 Thu,  1 Sep 2022 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662037428;
 bh=90Pu4Z0995xDSMUAbDdhc76aEoKg03ejpjrv0Doj9I4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=FBK7hgZsdA+O5pr1NwvSIynPqfNnuMlgbe5zK4vUQdsKhp5Vz4ym9Gjrck1eyTNQi
 kWzRXOCY9G/1dIqOwItDAAcBBzh5b8l4yItefGPPxUKdU4rl0b4VigzCQSmBjSr9WL
 hqTEdP8izC2H3R5i4svNsQ1Y9G3e4nU4Cq/Vs4+bSjaVwLcfHr6/HCnCf28b16UQ9f
 rZv/PL9/QX/avS9CHNIgFkFrjZKNiYtBSmwh2zc286cwJoZe+kXKDC4vLCn6dRCe3h
 2YUFbX52qqKPPoQg2xblYM/7CdFeEEAK3JrkVXCF+ccrMQVVZdmwo09lKieuiyFTOr
 bdWpsCZBp6szQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Martin Povišer <povik+lin@cutebit.org>
In-Reply-To: <20220901113415.27449-1-povik+lin@cutebit.org>
References: <20220901113415.27449-1-povik+lin@cutebit.org>
Subject: Re: [PATCH 1/2] ASoC: apple: mca: Unselect COMMON_CLK in Kconfig
Message-Id: <166203742666.66780.529814779896263080.b4-ty@kernel.org>
Date: Thu, 01 Sep 2022 14:03:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Cc: alsa-devel@alsa-project.org, asahi@lists.linux.dev,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
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

On Thu, 1 Sep 2022 13:34:14 +0200, Martin Povišer wrote:
> The MCA driver selects COMMON_CLK, which leads to misconfiguration
> on platforms with HAVE_LEGACY_CLK (under compile test). Kconfig catches
> the conflict with the following warning:
> 
>   WARNING: unmet direct dependencies detected for COMMON_CLK
>   Depends on [n]: !HAVE_LEGACY_CLK [=y]
>   Selected by [m]:
>   - SND_SOC_APPLE_MCA [=m] && SOUND [=m] && !UML && SND [=m] &&
>     SND_SOC [=m] && (ARCH_APPLE || COMPILE_TEST [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: apple: mca: Unselect COMMON_CLK in Kconfig
      commit: 7d2497b7fd3bf45706360bfe289f19d61d37f536
[2/2] MAINTAINERS: Fix file pattern for ARM/APPLE MACHINE SOUND DRIVERS
      commit: 55e2bd9c41e800638676dce3f19dcfd16b309a08

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
