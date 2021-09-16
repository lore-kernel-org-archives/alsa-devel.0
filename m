Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F314BC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:19:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2B760F4A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F2B760F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1852918AD;
	Thu, 16 Sep 2021 17:18:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1852918AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805563;
	bh=VEVfjolQS4SaknyqXaEyww4smoa3TbcX0NOXn6mQXc4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+BnWKDHEnNzPuqjFwEi1WyT0NOj67dU6T8YkGVzFVV3iwrumD3e/g/BnQlFcvyoS
	 fjmTeT67yzU1EcqMB1Lf6ufyRhV7PxzTkXZX1XfFTntTkiUrhtcNnZsTg0X8v6hevH
	 ExgDXCc1qLrPzNwqtfoSicE4z5NWgcU8KPoFz23U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D8A7F8051B;
	Thu, 16 Sep 2021 17:15:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E580EF8050F; Thu, 16 Sep 2021 17:15:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB922F800D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB922F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DPPxbNt1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91236124E;
 Thu, 16 Sep 2021 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805341;
 bh=VEVfjolQS4SaknyqXaEyww4smoa3TbcX0NOXn6mQXc4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DPPxbNt1ZGquzUQZKqLerZz2NQwhIQ7grTrYLQm5ZWzpqxt33Z+XFxjpfquToFtk8
 wVpF2FLr7vJNiuGzCMaXhOPJC/alKvZECFaATyrWOcOxBJ+ceyNpzs2TdQ4fryZJSi
 d3bfwWLJr3gdApclHNQzyHrMFhuCaB9pB7KF76nWn1HPWExVoUqi4Q5G2W4TsO0ppR
 p9tZUTp1YpeexbNEJAj9pB8iZgV9k/fMQ9ykleJ9NkkeNswUgXfQmuu5GsSH7557do
 m/JCxfaMxeeNJjLwSAMKB1bZeri1z2meKnrCN0udJXO6YvMA5rWetl2eSbWcXcTFmI
 MFLl/3FYArDbw==
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: atmel: Convert to new style DAI format
 definitions
Date: Thu, 16 Sep 2021 16:14:37 +0100
Message-Id: <163180495859.19842.13793794460073791883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915181048.40070-1-broonie@kernel.org>
References: <20210915181048.40070-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
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

On Wed, 15 Sep 2021 19:10:48 +0100, Mark Brown wrote:
> Convert the Atmel drivers to use the new style defines for clocking in DAI
> formats.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: Convert to new style DAI format definitions
      commit: 4a8cf938d5b6ee22c5a0bec84efb4b8068410ff4

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
