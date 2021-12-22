Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D95C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Dec 2021 15:34:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E76EB16DB;
	Wed, 22 Dec 2021 16:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E76EB16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640187285;
	bh=byBGhTV5Xn9KAFDJW7bstvlAYTSSq6UwsroZt5WEVuM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bh/ESr1RHLR0KAdCDoxMGUDQdGqDI8aLz5Ju9LMVh1pba2dZ9v9iPc39GF75C2kNK
	 uUxD9jGpsYzhARjTNUXIrtd5m731quOm620Ay8KLapAIuqVczByqsJHT0ozLv/kfZy
	 0lNg2koa6w+beBnmRdnRuE8UE7xwip+7fyfOo7D0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C41DF800B5;
	Wed, 22 Dec 2021 16:33:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52B89F80109; Wed, 22 Dec 2021 16:33:52 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DFCAF800B5
 for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2021 16:33:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DFCAF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CGaDy/hd"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F21C5B81D01;
 Wed, 22 Dec 2021 15:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABBC36AE8;
 Wed, 22 Dec 2021 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640187220;
 bh=byBGhTV5Xn9KAFDJW7bstvlAYTSSq6UwsroZt5WEVuM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CGaDy/hd8YWDB2zS8FGwC2cQ5x7PzkGnh53U+thvI4CtD+8TAcS2p5rWyFswWAd7c
 ujz8PcqG56G6/WW6oDfz/zI7I8Us3gG3A3922zYoQ4vsa2g2T1dcUCUL/gfl4yjuLI
 1GUygCb5kuZsYTFaWqRFwdJM+MQ6Ad4b54IYzB6TPeE93a5STz/isRUfH+M2qdd9ze
 YNPsDmtEyHovkgwFklAq81mg8ZuSaW1oyTRLwC/BXPpH5VywDGwIBD+ke9z2MSrapV
 35CzHmgGsWBpdb6HIUEt9vhOJo5Ettbg56aKy4iUJ7QteyNNUxKUvwgtnDmdhavYi6
 dvBn5mo4AmKkg==
From: Mark Brown <broonie@kernel.org>
To: Vincent Knecht <vincent.knecht@mailoo.org>
In-Reply-To: <20211222135403.2991657-1-vincent.knecht@mailoo.org>
References: <20211222135403.2991657-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH] ASoC: codecs: ak4375: Change invert controls to a stereo
 switch
Message-Id: <164018721921.257503.2890165869395844521.b4-ty@kernel.org>
Date: Wed, 22 Dec 2021 15:33:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
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

On Wed, 22 Dec 2021 14:54:03 +0100, Vincent Knecht wrote:
> Don't use enums for DACL/DACR Signal Invert controls,
> and change them into a stereo "DAC Signal Invert Switch" control.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ak4375: Change invert controls to a stereo switch
      commit: 37daf8d9e0bd85a2859721aec28e1eb6e9973262

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
