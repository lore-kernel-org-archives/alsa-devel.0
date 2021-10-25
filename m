Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED135C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:43:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0ED60F6F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F0ED60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D96BD16D7;
	Mon, 25 Oct 2021 18:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D96BD16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180215;
	bh=UVa8mcC1T1uq8wTq8Zf9Ga1vu6jyFkHWhopPaZoEcUY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uV0ospA3B62P6OtWNkhkAKyOROIyS9f47NCe7RzaVIdfBkmi0uLX47VOPmGmE/pKJ
	 h5/do2BCj8w86Fqftl7N+Pg1ZJVrtLVskw70YYoUKFuDLMxar1++A1H10r28PdFF7s
	 qN5vIQ+mCEWHYUH86lhOb6eQcYB8qP1KACSQznng=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F4E7F8051C;
	Mon, 25 Oct 2021 18:40:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B69EF8051E; Mon, 25 Oct 2021 18:40:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78154F80518
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:39:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78154F80518
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="s02xi/8A"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C07660EB9;
 Mon, 25 Oct 2021 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179993;
 bh=UVa8mcC1T1uq8wTq8Zf9Ga1vu6jyFkHWhopPaZoEcUY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s02xi/8A6AwRVsntBYMQe1zS/U5Hkuap5wxkL1IlxU3PTlnK2rzVjWQMiFzK073nw
 GMIzZvQHcZZIqvO+0okNAig8sQHsYIGjlPCdUEsbp191/jGkiNqC1tlAuCuC5Co5p6
 CzXV3hKI2l8CPASfVAad6ylnoOHbP+9UxR+VHNDNAyiQBhGU9cClldHl27Ajzb3/E/
 9betUhY9j+5rBWixzoH5gqEzu8Psc4U33olRP1zCqpxGG3kR7Ag6+ngEsbEJXcVOUy
 yX5bfoGXje9boU6xNCH4LLfH/2gHXvYgTDyGQ5h3ONpXXLevNMIKY3a5fcdpLfFT0k
 YU6xPH647asrQ==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, Julian Braha <julianbraha@gmail.com>,
 yang.jie@linux.intel.com, liam.r.girdwood@linux.intel.com, perex@perex.cz,
 tiwai@suse.com, cezary.rojewski@intel.com
Subject: Re: [PATCH] ASoC: fix unmet dependency on GPIOLIB for
 SND_SOC_MAX98357A
Date: Mon, 25 Oct 2021 17:39:27 +0100
Message-Id: <163517996155.3558038.1204649439375343197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025010615.10070-1-julianbraha@gmail.com>
References: <20211025010615.10070-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Sun, 24 Oct 2021 21:06:15 -0400, Julian Braha wrote:
> When SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is selected,
> and GPIOLIB is not selected, Kbuild gives the
> following warnings:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependency on GPIOLIB for SND_SOC_MAX98357A
      commit: 3e701151feefc58c5194e1d9eb5af98568574f2d

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
