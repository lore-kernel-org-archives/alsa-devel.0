Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD99C2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:42:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F620759
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MfG0qYqR";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2QFoAHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7E62181B;
	Thu, 12 Nov 2020 20:41:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7E62181B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605210137;
	bh=kh3nAQV22I+QzfsKJUiPjiXFj5pv+uKvrht35jK83iA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfG0qYqRvAnvaf3Ut3tqwwmMHT0mRmsX7QHfL8WKbl7+S1LapEgjsDRrgjCqSO0XF
	 dN77SjEbFJzmsweSiJ2wbKW6yLfywC9Fl0ea3EBj/KnOcuL3hUN+Vx0OgL7RWATB40
	 G5ibWn3ZdA1RASIvolIiylN8/yezR0gVL3hUBw24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E6A7F804EB;
	Thu, 12 Nov 2020 20:39:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 422BBF804EC; Thu, 12 Nov 2020 20:39:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF4F5F804E7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 20:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF4F5F804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R2QFoAHm"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99AEA2223F;
 Thu, 12 Nov 2020 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605209953;
 bh=kh3nAQV22I+QzfsKJUiPjiXFj5pv+uKvrht35jK83iA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=R2QFoAHmthBNXEp0MlUGDrH13a3hRmGztpv4DCS53GxRxR/uQDdoph6OllJYZx3Yw
 cWjaJ9FifSY5b3jynPjLvolqX3utC9rVvia64CGyiaeBkw4iy582BWkiPjN6rkV7zj
 Lv76e/BL0GsZzwFrqXkEDUWU+OrMj3XjQgPw/J8M=
Date: Thu, 12 Nov 2020 19:38:57 +0000
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20201112164425.25603-1-pierre-louis.bossart@linux.intel.com>
References: <20201112164425.25603-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ASoC: SOF: Kconfig corrections
Message-Id: <160520990389.38586.7655538641803522711.b4-ty@kernel.org>
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

On Thu, 12 Nov 2020 10:44:21 -0600, Pierre-Louis Bossart wrote:
> Three cosmetic patches and a fix for a randconfig issue.
> 
> v2: rebase to remove git am issue (worked with --3way before)
> 
> Pierre-Louis Bossart (1):
>   ASoC: SOF: Intel: fix Kconfig dependency for SND_INTEL_DSP_CONFIG
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: imx: fix Kconfig punctuation
      commit: 724d53f6a0f318390630a50ee713fa19a927fa23
[2/4] ASoC: SOF: Kconfig: fix Kconfig punctuation and wording
      commit: aff581aee84079b89e796d6ab26560c88d1dcd7a
[3/4] ASoC: SOF: Intel: fix Kconfig punctuation and wording
      commit: 66e1b65128c2bf884d39589a8308dd115c5eba67
[4/4] ASoC: SOF: Intel: fix Kconfig dependency for SND_INTEL_DSP_CONFIG
      commit: 358f0ac1f2791c80c19cc26706cf34664c9fd756

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
