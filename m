Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1AC433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:08:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21D961221
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21D961221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19034186C;
	Wed, 12 May 2021 19:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19034186C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620839323;
	bh=McpoRHLvMNh7o2t4R0tgVJ81OfdHjOJvOW40DSLsONA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtlKoszFYtdCv86kHOg9zabR5QdrHiJPUyjjyq9zpl7JJLZuMkZjH5Sufi29BeKv1
	 iJaS/VTocTzKDHY5znXAkAm1F972ebS1vm/QVu78JFh7Nv5e3beu9+ZmZML9Eyqleo
	 CUvXh0y9hW5XaNjsjVQxHc8AoCskDT7kDZSDQnDc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3E7AF804AE;
	Wed, 12 May 2021 19:05:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1A97F80431; Wed, 12 May 2021 19:05:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B42F3F8026F
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 19:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B42F3F8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="l7xcXoM8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D7F86134F;
 Wed, 12 May 2021 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620839150;
 bh=McpoRHLvMNh7o2t4R0tgVJ81OfdHjOJvOW40DSLsONA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l7xcXoM8zOMHdtaZmk5zK+SKwdtBjgQ0F6jnyeEf6kePqhGPY1iPVwo4oz6VDm70w
 Hg5y0IpuzkqyakYgb1VAyZxGUF+txoilBGAWQvPokMl+e3ntgbot/FBFbQyW3t+Bmo
 a5Y0WIph0a+V25+nHhnTdbH6u0SFvBsUsFI5pUZjuH+uKQgg0WxodP0XISJqyfSAmz
 DzCj+ARha8iOsJXBjqjlJayBMDSgsnUwSXePS2btIR7ku5bJuBvi1694rsy7UY7JZb
 +/hb3GAM+xkaa19uz/ZnH4cu7b4ZWEGQfkxxuYbV4jqrZuZ5OYNCF04AXT4oU7edHF
 UEgtBfMPhXpRw==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
Date: Wed, 12 May 2021 18:04:45 +0100
Message-Id: <162083892845.44734.6387839662389398582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511145220.125760-1-vitalyr@opensource.cirrus.com>
References: <20210511145220.125760-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, 11 May 2021 15:52:20 +0100, Vitaly Rodionov wrote:
> HSBIAS_SENSE_EN configures HSBIAS output current sense through
> the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
> the potential pop noise during the headset plug out slowly. But on some
> platforms ESD voltage will affect it causing test to fail, especially
> with CTIA headset type. For different hardware setups, a designer might
> want to tweak default behavior.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
      commit: c9f2e3c3ddab87d93cde99f6da10dd00c1d1edb9

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
