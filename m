Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BFAC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 17:09:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 763BF1856;
	Tue, 26 Apr 2022 19:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 763BF1856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650992974;
	bh=+9z73QY1tSXjGZlSMe8gRpW+oZ+tKb0Nxc66fcrc0dI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XPoB7KT9SaM9pclVYCIEPGlDyIlmrvCXDqvzM+jBIh4rHeRpQzxcVmyyoZe9cVcMX
	 g3SotIGTeKdF8KZUaWHvf4h8IXwF5OfNqLEoIGktKErpN6a1gQU9kpUtd9neDprdEf
	 H2SVJQMgvb9djFRi72NcZm4SPbL2iZa4FeIKRSM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13AEBF80516;
	Tue, 26 Apr 2022 19:08:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29E4AF80516; Tue, 26 Apr 2022 19:08:04 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CD68F80507
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 19:07:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CD68F80507
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HGr4J02X"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E07C5B81FE5;
 Tue, 26 Apr 2022 17:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A48BC385A0;
 Tue, 26 Apr 2022 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650992872;
 bh=+9z73QY1tSXjGZlSMe8gRpW+oZ+tKb0Nxc66fcrc0dI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HGr4J02XWt0VcoQk4zhdtMsMDQYuSb5fSlbKBf/OvZLvt3WhppP2/900DuCZJu8t1
 PDMlKvhvAYjJO1PwhtT/o2DtzLH3q8s6QZbQJcuYt/6x3xtpuUzBJKDfmI8TRqUwCZ
 xSDQbp1pZbPqdvehnN9d0z8S6G8bJf6rdROrn3MTfSRKi8AIQMQqQ8rYpKg49YyWs1
 zTuLn6VAMZn3pjqQkswCjUfXFlxUvci7bp24Iy+jCKt5c7AaQ5L1JViXvBUxkqc164
 7U6AljWv3Iiu5UziCYqZdp9cbPIKlq+VRxQgTdkU53aHB2uQhgCjY4ah5KHjLsOs4k
 8X0L3T2Pu0kqQ==
From: Mark Brown <broonie@kernel.org>
To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220425193206.61710-1-u.kleine-koenig@pengutronix.de>
References: <20220425193206.61710-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: tas6424: Return zero in remove callback
Message-Id: <165099287128.2323572.11976051626827246932.b4-ty@kernel.org>
Date: Tue, 26 Apr 2022 18:07:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 kernel@pengutronix.de
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

On Mon, 25 Apr 2022 21:32:06 +0200, Uwe Kleine-König wrote:
> The only effect of returning an error code in an i2c remove callback
> (compared to returning zero) is that the i2c core emits a generic
> warning. The device is still removed.
> 
> So even if disabling the regulators fails it's sensible to return zero
> to suppress the additional generic and little helpful error message.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas6424: Return zero in remove callback
      commit: 0e631e065bcb92cc97b38a82e41695952145751d

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
