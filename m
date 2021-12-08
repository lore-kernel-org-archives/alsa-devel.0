Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BFCC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 16:49:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30A5716B1;
	Wed,  8 Dec 2021 17:48:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30A5716B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638982164;
	bh=YbISJnQzsM5eSFYYtdFrdjLSHXTJxn8bZGcYAqUmR/I=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esQ1Sq4I5966zwzoo0pUaDEuFDb/CN6w2NPcwng2yXaAmdjb6iCm0a9/icXQKEykD
	 50mtw+DLhwZBLd7PGjatI9hzYFhHW6kTHKzvrp4seIskjw1SUHjdEdjhRi3UJwafeN
	 U8EEivcjf3btShJAHtUhTNEtIYKgaS8F0gLYISq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EAB8F80518;
	Wed,  8 Dec 2021 17:47:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9213F8051A; Wed,  8 Dec 2021 17:47:03 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1DC4F80510
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 17:46:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1DC4F80510
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bItQBn8p"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B830ACE225F;
 Wed,  8 Dec 2021 16:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0393C341C6;
 Wed,  8 Dec 2021 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638982010;
 bh=YbISJnQzsM5eSFYYtdFrdjLSHXTJxn8bZGcYAqUmR/I=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bItQBn8pbfa7oDy5ZiiWmR2FClwuQuyfDLIOsvPZBtBnWmhdJTrnry+FjkZXOqPuD
 9sS2wqp9BdkhUu7mvA/34kGOVfJ8T+LRcBLgn55RpzdQX0304A4KHdOMGT2jJC2nnC
 MSoCWdmn/iXoOH9QUEuvyVx5Q/0n2pkOewHpw13Mwg18/1geYjzevZ41vtvPB6CQnn
 d8V/CBsyg6ddAOR6pcPzMhMh0idF3THL15R7VFi4hR1XTyknp9rxgbZ3ccsVJBm6iF
 71+Ll3udOH/TiMQnvOzczhlkpg64filkhQNrTiz8WBg/vYqXy0M7XlVHTV/QqxOp65
 /c4zDFFnNOnjQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, shumingf@realtek.com
In-Reply-To: <20211208101718.28945-1-shumingf@realtek.com>
References: <20211208101718.28945-1-shumingf@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: rt5682s: add delay time to fix pop sound issue
Message-Id: <163898200870.3880815.10610236665541967384.b4-ty@kernel.org>
Date: Wed, 08 Dec 2021 16:46:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 Trevor.Wu@mediatek.com, flove@realtek.com
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

On Wed, 8 Dec 2021 18:17:18 +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> There is a pop noise at the beginning of the capture data.
> This patch adds the delay time before stereo1 ADC unmute to fix the pop sound issue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: rt5682s: add delay time to fix pop sound issue
      commit: 7cfa3d00730a4c0694b55fb1974823baeab8815b

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
