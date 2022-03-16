Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3987EC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 20:38:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 684B317FD;
	Wed, 16 Mar 2022 21:37:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 684B317FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647463100;
	bh=sSmYovsFHsxJowFY16qDsSiycqauxL0/A4pfSMRYnhM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hJ8y9ZaICRnLoPpehPPb4LIiNNuiFqhsgRO7lRADcNR+UBCiEiQrXqSKj3Egk+ujz
	 +LY/TVa7JElXHjFPsxdbmJNtN3KNY0J1uZGmC8q9qSJZ1cbv5eJCe1rOLNmkw8PW+V
	 COCLpLNtLkq2E8mMxJOKRTeiHMBB1lLZdpVOmOMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6279F80520;
	Wed, 16 Mar 2022 21:36:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4ECBF8051A; Wed, 16 Mar 2022 21:36:00 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30E3DF80240
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 21:35:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30E3DF80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oO5Tg+Bh"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9493461423;
 Wed, 16 Mar 2022 20:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74908C340EC;
 Wed, 16 Mar 2022 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647462947;
 bh=sSmYovsFHsxJowFY16qDsSiycqauxL0/A4pfSMRYnhM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=oO5Tg+Bh/lK2n1GQXTUfAHfQI2LcNt0yuITPy1C6EmNccqgyTzVI/XeX1SDOAnhvv
 3vfCJz/cjZhIQ4RKY8UredPcrY70757eUjkw/77GOoOqPuLhMehPFDlawoMdiyVYTI
 +wkFXw36IGnUtkoja5+retctMw39SNxdhq29XsT5RpnSZPeXpB8ghGv/RkQ28qT0Do
 Ygqf4jD++X2WvYgHebUB3uUxbzPAhwH6V/4hwZGEm+LDw6eyKklhZcj1IOYd5s1rR+
 JH9+jjXLy7Us5Z9cFztRw1bq16SCaNMXPKun8i3rIZ7BS7rLvdLYkWAE9b4JlJrMRI
 kYlmx9KCE4Pbw==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20220315093740.12008-1-shumingf@realtek.com>
References: <20220315093740.12008-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt1308-sdw: get calibration params after power on
Message-Id: <164746294519.1220201.15348737312378976341.b4-ty@kernel.org>
Date: Wed, 16 Mar 2022 20:35:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, jfmiranda@gmail.com,
 flove@realtek.com, pierre-louis.bossart@intel.com
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

On Tue, 15 Mar 2022 17:37:40 +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> It will be safe when getting the calibration params after power-on.
> All powers are ready to read the calibration params from EFUSE.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1308-sdw: get calibration params after power on
      commit: abed17fdf92e4b3bfe336f7872270e0924cc4463

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
