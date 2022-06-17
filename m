Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6281DC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jun 2022 23:21:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BB461ED7;
	Sat, 18 Jun 2022 01:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BB461ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655508083;
	bh=0/gO3abdMtjXJJpqM36aCEMHAeb67MB4T5VdLEmQPhU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=klNEq6pB/9JdnRjek9ed/WOtEQLyPmMjywx6wqSx1ASRGoWFfO2TkAjTgu7x0pQYK
	 SQlOgxCgsYWC4X2mc4L3pfIRZVQWRHx40W1bTvbaKGN6llsQXA/Lzbq8Q/rO9Vqw+O
	 tw1AGtGq3ZXxguyvrDvpLDSefeNJ2b0uU/rxkH90=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06CE2F80538;
	Sat, 18 Jun 2022 01:19:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D28AEF8053A; Sat, 18 Jun 2022 01:19:54 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 352D3F80536
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2022 01:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 352D3F80536
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mSYB4A8v"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E563CB82C09;
 Fri, 17 Jun 2022 23:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B984C3411D;
 Fri, 17 Jun 2022 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655507985;
 bh=0/gO3abdMtjXJJpqM36aCEMHAeb67MB4T5VdLEmQPhU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=mSYB4A8vVI8/80VKW+wQI60aipjNbjGuov8aEaeV3xzY0qi+mC1IsiMJlrSyx2mcu
 7tgluN/XY6yo1SBCnBgB4ZGnckTjbQMxu7tuwyPKm0E+6Tz2TWP66lT1QfRraSLtHs
 8iz9aXtIeDFQlh0JV8hEwAyc0FQWdR1W3REhmkGYayAm7OFCO50HmRrIq8PiLP6BCV
 +TOnacjJxVxcCl+DC5vFEIYdoyv8hWiA5rvY2sSJX/36lENJjIBfqe7zVHSplywl+W
 gcPoT1cuH8XPRDWTUGocZhKUufUszJyxqfEBrr6Ze4WB1J9SZ9fEn3Mt+93EkJfBON
 DoBIr/62K9WRg==
From: Mark Brown <broonie@kernel.org>
To: jiaxin.yu@mediatek.com, fshao@chromium.org
In-Reply-To: <20220617111003.2014395-1-fshao@chromium.org>
References: <20220617111003.2014395-1-fshao@chromium.org>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8186: Fix mutex double unlock in
 GPIO request
Message-Id: <165550798423.994018.10916752817659523759.b4-ty@kernel.org>
Date: Sat, 18 Jun 2022 00:19:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 17 Jun 2022 19:10:04 +0800, Fei Shao wrote:
> The lockdep mechanism revealed an unbalanced unlocking on MT8186:
> 
>   [    2.993966] WARNING: bad unlock balance detected!
>   [    2.993978] -------------------------------------
>   [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request_mutex) at:
>   [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
>   [    2.994012] but there are no more locks to release!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
      commit: 6c9e9046e1ff356bda66661213735d33c6cfea53

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
