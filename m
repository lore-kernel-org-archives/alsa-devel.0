Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F49FC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 13:00:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC98E610C8
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 13:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC98E610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9F8916AA;
	Thu, 28 Oct 2021 15:00:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9F8916AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635426054;
	bh=PpOMr9WHPMjBQJ5Nh0GGwww06NPoVEpkKwQXu6AK/0Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LqlfVIs03yTFz1JYj7Bwflk2eGc3SLs60CKbyPg3XrjE5Bvyycz5XM/ajeRh6t09q
	 0tsZLch9z/mJlqms3k2FTp8KnljZpgW6Joxe0nMLRuJncKwAsg1SpPnfZw5Bwtz77D
	 wjzVSoBCnh852i/or21IimH/a+5d4STzuxVcwOTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFE1CF802C8;
	Thu, 28 Oct 2021 14:59:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F3C2F8014E; Thu, 28 Oct 2021 14:59:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6305EF8014E
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 14:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6305EF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rt+M0r+V"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC8B760FC4;
 Thu, 28 Oct 2021 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635425951;
 bh=PpOMr9WHPMjBQJ5Nh0GGwww06NPoVEpkKwQXu6AK/0Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=rt+M0r+V2lr8vSdp9UQAFQn40iuD60oKQ5aNE5/WUh/QIxQvtMD6e0RiVU907OTAL
 qquZwhm/83EYfuK6Z7lLtA7fIa4jreh4QJXH/WF71Kw5KDttKhHb0v7PNG+Cvvg6Df
 fM//Gfo2Xw8lbSa6BcmIPzvgF3DXmtSFMYksUieplcwbKtYphJWMhT6QrUMEQtajfD
 usf9bMzRhAxnexw6erwBYpLFvZ8O5sSCcs6rErCed8s4YpReq9Bwm5/wKSni8VSpaV
 IOgcwNp3wyLxYt4vnS5P9jXk0UmTXbEkzlCPWKNOvQoSc+aHGwQaxZoB4FBHp5nGIv
 F1PsCBJVRzE7g==
From: Mark Brown <broonie@kernel.org>
To: Vijendar.Mukunda@amd.com, perex@perex.cz,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
 Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20211027184835.112916-1-julianbraha@gmail.com>
References: <20211027184835.112916-1-julianbraha@gmail.com>
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for
 SND_SOC_DMIC
Message-Id: <163542594951.950250.6416745784322716952.b4-ty@kernel.org>
Date: Thu, 28 Oct 2021 13:59:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, fazilyildiran@gmail.com,
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

On Wed, 27 Oct 2021 14:48:35 -0400, Julian Braha wrote:
> When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
> are selected, and GPIOLIB is not selected, Kbuild gives
> the following warnings, respectively:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_AMD_RENOIR_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_RENOIR [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
      commit: 5c7dee4407dcd3522a133acdd90d64bf41d00986

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
