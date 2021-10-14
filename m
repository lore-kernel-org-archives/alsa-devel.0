Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA69C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:19:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2FF610CC
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C2FF610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD11882E;
	Thu, 14 Oct 2021 15:18:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD11882E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634217565;
	bh=auGL29uOG0r1S8n7blEYC3BWsg1IMZCKnXJmreGBf9c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uzIxTgJo0CH6cji+kz4vMaFfXQ9VtaOpgrsVlM1TJrS/e+dLGPYkiPitQQ0Ruuf4g
	 4h4TzO4gldpqjm3rM6ZC3UMQWVKYiZNkX+p+d4v/wR4HdTw6894bFRnLMao2UGJbdY
	 MuAfgk1u0GuceUxo7R/oUOVmfrPctFfFoRX+ihuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43E32F801F7;
	Thu, 14 Oct 2021 15:18:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A60A2F80212; Thu, 14 Oct 2021 15:18:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B1F7F8016C
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 15:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B1F7F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZLJr/hz0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73B53610E7;
 Thu, 14 Oct 2021 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634217505;
 bh=auGL29uOG0r1S8n7blEYC3BWsg1IMZCKnXJmreGBf9c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZLJr/hz09S/oFbtb0+zrKyCZM+3akWSk4HtIqRKeSPvhvLllxs2/jCnNu7w4Wf2v7
 70s3Iit1tLbMEoTPwWsjbBE2IE8osMf8NbsKqgReP6l+7BCvXnUREWmEOkKNeGZN7P
 n4QQ/io5+Q8mx045TOa52+ZSRZSGCGeQ3UuxCn+Ub+sPW58pARvpMO5V8LyFh9jQcW
 C6S4Of4ODOffP+uk3jdWaepGY0cg3QRGGacxvoRaKp7+r1Wq5703y3oHPQhkRluA8H
 ISu+7EHrvUZfhLDLOVJoZsaSrsr/hS+LlOgTiSxrgUgDaQSFEUKdkPGVf0tj1zsP1j
 KwRElePYBIaUA==
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt5682: fix a little pop while playback
Date: Thu, 14 Oct 2021 14:18:16 +0100
Message-Id: <163421747887.2468192.18189874831753774527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014094054.811-1-derek.fang@realtek.com>
References: <20211014094054.811-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, Mark Brown <broonie@kernel.org>,
 kevin_chen_ym@realtek.com, shumingf@realtek.com, flove@realtek.com
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

On Thu, 14 Oct 2021 17:40:54 +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
> 
> A little pop can be heard obviously from HP while playing a silent.
> This patch fixes it by using two functions:
> 1. Enable HP 1bit output mode.
> 2. Change the charge pump switch size during playback on and off.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: fix a little pop while playback
      commit: 4b19e4a77cc6baa0f840e8bae62ab974667f6207

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
