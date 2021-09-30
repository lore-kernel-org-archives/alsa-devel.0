Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA46C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:01:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D318961A02
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D318961A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0E5F16B8;
	Thu, 30 Sep 2021 17:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0E5F16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014058;
	bh=sJWGYBZqf8BOTrR9dSgrjAtHv/8U3zZk2TqxtbmT4TI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3ERp1S2Kz+XTz2xr6zl8/OmFYrAMmaoSJFbIFUgWf0ij1Uruf2ilDfTRi4jNfKO1
	 Y+etDSmvpK5RxKW/elfwNjE7Mlc/ziHpih19U9xwZl3JAszI8k3kj14hjwkdveVTKP
	 ctNjVD1qlzUO5zH4t1lPvM9ftojrjY7l/yrLNNnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 198E9F804AD;
	Thu, 30 Sep 2021 17:00:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54AA0F8032C; Thu, 30 Sep 2021 17:00:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00992F80113
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 16:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00992F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oyKVbQhI"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B5461994;
 Thu, 30 Sep 2021 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633013995;
 bh=sJWGYBZqf8BOTrR9dSgrjAtHv/8U3zZk2TqxtbmT4TI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oyKVbQhI+wpI4I50CEi9giUcePcyqeIUJGG0tRVlo0Fy26bk/vJwvGQdWtHmbHHZj
 ckg4jrgIQ1JbuR/RD1fAEA3qP04fRvINMaS6sB0J5BB9aBnap+ri+kj4MLhnybrrxH
 PsCpoJ7v1Jt5x2Y+ZdQ/zoHwc962I+5y9tl5mEu5Ol0iXBu44YQwSilQILzdSjlt5f
 WTLbvwWhMTbC4kPJ1mij25RpF4aEM+iLKv2FjJb29G9dGvQHowDX90F9PDuvkBLNYK
 URO4GVzVk6zb0ysBgQV3NfSPsVrEfh0STbBuF0d1WcOxb4LAYc5+FSMUscOhdVE2It
 CTF7X1CSNWlNw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Guo Zhengkui <guozhengkui@vivo.com>,
 linux-kernel@vger.kernel.org, Simon Trimmer <simont@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: remove a repeated including
Date: Thu, 30 Sep 2021 15:58:51 +0100
Message-Id: <163301248178.43045.154919758702051466.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929123217.5240-1-guozhengkui@vivo.com>
References: <20210929123217.5240-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel@vivo.com, Mark Brown <broonie@kernel.org>
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

On Wed, 29 Sep 2021 20:32:15 +0800, Guo Zhengkui wrote:
> Remove a repeated "#include <linux/firmware.h>" in line 32.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: remove a repeated including
      commit: 626605a3dfb5c538256e737a7a7ae3e18f3368ec

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
