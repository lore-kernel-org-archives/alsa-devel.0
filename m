Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99FEC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 11:20:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAA141742;
	Fri, 20 May 2022 13:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAA141742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653045624;
	bh=Sit1fCFqMaM4rxCfPkNfKul9KDtnUhSTtyPhp+iJFWI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+ssEAV3gHpvpyNs+mRp+7m19yxk6mXCyFdgb++7G3KsG/bSvEqcvu4d7R1So/Pyk
	 VF8yuuHc6qCVElOTnarrM2Wf3DkxNg5gbboaWrNAZGFQ8d7ezbPS5teGsZBOqW/BlI
	 63hCPa/BlBfu3zI1JRsa001C5dMIwMF4e0/qNquA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3758F8051B;
	Fri, 20 May 2022 13:18:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BD61F804BD; Fri, 20 May 2022 13:18:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E9D6F80240
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 13:18:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E9D6F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lwCbtanr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 14AE061D18;
 Fri, 20 May 2022 11:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D8BC385AA;
 Fri, 20 May 2022 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653045521;
 bh=Sit1fCFqMaM4rxCfPkNfKul9KDtnUhSTtyPhp+iJFWI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=lwCbtanrbuvPb4V5XdKe3fCg35uG55k3JlIMBPRVHOptzWUaWoDPUkzC58OJmlsar
 qLzF2GzKnHdAn3/ZBMzoO+OndPiD1iJu8DryAh/97UtR0UtcBxJyYTe0Mbmo2wliAE
 SKf+TKK/pJ3S0PG9xQg47Yi61ZBHjA6l1LGl97VCZrFBvtZ9jRi5wKosBiIaHLM7bh
 Ci/PKJ/+NKvWktuL3Zw9xAOAG+msPdNh0oZQhlQ+q33gU4mCIjx1p5X/JYaUZeJCr0
 91QuNdsxs2fvJnRYAhKAiwnvX316YhCTp+mczeLEOpt8kCAzkZJKhiLuFmOgE5NkUB
 MDoQpZ/PgTBWQ==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
In-Reply-To: <20220517172647.468244-1-pierre-louis.bossart@linux.intel.com>
References: <20220517172647.468244-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: remove two unnecessary gpiolib dependencies
Message-Id: <165304552054.45439.4256486357672468570.b4-ty@kernel.org>
Date: Fri, 20 May 2022 12:18:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de
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

On Tue, 17 May 2022 12:26:45 -0500, Pierre-Louis Bossart wrote:
> Remove two dependencies - issues reported by Intel kernel test bot.
> 
> Pierre-Louis Bossart (2):
>   ASoC: max98357a: remove dependency on GPIOLIB
>   ASoC: rt1015p: remove dependency on GPIOLIB
> 
> sound/soc/codecs/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98357a: remove dependency on GPIOLIB
      commit: 21ca3274333f5c1cbbf9d91e5b33f4f2463859b2
[2/2] ASoC: rt1015p: remove dependency on GPIOLIB
      commit: b390c25c6757b9d56cecdfbf6d55f15fc89a6386

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
