Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB89C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 13:15:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8411C16AB;
	Wed, 16 Nov 2022 14:14:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8411C16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668604523;
	bh=Vl5Y+oCFpdFMde5JG76G/MQkV5p0baSY7FjfWPKT+AU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QY/qxV7x0wD5AZ+pkUuqzPtM1lhvQx5+I68oGk6/FXzT1pTZ4ERg4MxP3tL5Q8WES
	 sTuhNvN2t/xoX90rSDiMWhiZSiSFvR0aWzc5+TrmzhYX7twmlLudjWMImR6A4AdoQq
	 gM9YH+mM2n+Gj63u+8aWrBx1bmnHr3oRf6qqe9Hw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4474BF8032D;
	Wed, 16 Nov 2022 14:14:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F6DAF8032D; Wed, 16 Nov 2022 14:14:12 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 478FBF800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 14:14:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 478FBF800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Swlt0xx6"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 64E28B81D50;
 Wed, 16 Nov 2022 13:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA8C433D7;
 Wed, 16 Nov 2022 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668604443;
 bh=Vl5Y+oCFpdFMde5JG76G/MQkV5p0baSY7FjfWPKT+AU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Swlt0xx60+vPWrM1O8Wpi6B8MbE4UeJT+42eWOSZZecI6OtCmE69vkXgcKSxJ6n2A
 GUQdFoCe3yJcG8FN1ud46Pce+OUJJqL4xXRCuuyxrGxn7Gk6U/pQh9eZe2LpcgBb5W
 B6NAkayMCoZ1q3eDChlXpBP9amo5/X0Xsv0oupN0tZ8QuA0x0soEK24NvAf/ChIX8i
 7IqmQuNyUZ2fr0t7/pGmY9/xKVit1RXzfsPI0RCaMh1wcquZPAdA2FTGoiyXboqhTB
 z6cBuoNm85WjoeyqXuzgf2uNVIS9o4KXZamzFug91BFlHnoLt+AINDDxvWrTb2MTpT
 pxh5+9TQ1oyvQ==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20221108092727.13011-1-shumingf@realtek.com>
References: <20221108092727.13011-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt1318: Add RT1318 SDCA vendor-specific driver
Message-Id: <166860444033.370630.1895748998696414772.b4-ty@kernel.org>
Date: Wed, 16 Nov 2022 13:14:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, flove@realtek.com,
 bard.liao@intel.com, pierre-louis.bossart@intel.com
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

On Tue, 8 Nov 2022 17:27:27 +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> This is the initial amplifier driver for rt1318 SDCA version.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1318: Add RT1318 SDCA vendor-specific driver
      commit: 6ad73a2b42ea6d43fc5bf32033e8f6b21df3109e

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
