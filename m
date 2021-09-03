Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1AFC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 18:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFF561057
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 18:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EFF561057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F7A818DA;
	Fri,  3 Sep 2021 20:05:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F7A818DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630692395;
	bh=AYCTypw36ptHgabLcJlokFD5oklyEoCNON6TkiELR0c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhGnAbFBoZe4HbvVgOm03raGmcfzSy3MK6ZDg1l/uG1eVwLZErOf1cnES1ilU5S6G
	 jcgrQy86aG/Nrb8juJjAx8091zsVclkfoujP0rnMC5QYM74c5fpwtMuX3G6OZe9s/Z
	 +CZAM4H9TgDMXMe+R98fSsJySytvvpkwvRT7T30Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6CBDF802E0;
	Fri,  3 Sep 2021 20:05:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C0D2F802E3; Fri,  3 Sep 2021 20:05:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4860F80254
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 20:04:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4860F80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lk9RGXY9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E91610A1;
 Fri,  3 Sep 2021 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630692295;
 bh=AYCTypw36ptHgabLcJlokFD5oklyEoCNON6TkiELR0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lk9RGXY9AVswYmZWtt1rE1/CavCQsvnNbMv2JGR71HazCSpK4RiR0+haWbqts9/D1
 LO7x2ocAa8NFCqGVcy8WNXRs4q+vF4tB6DOzUhT7e1pPRKCnmdDhNo44WgYPyGowvA
 md5bT1JflLrXWSLUOBJ1vGD/21QUtrd7Cc2hKdet7pTvzhT7Hu87DBjaIgFOk9YKU+
 tslioRp3Kd/ws5LH/SvYxfcWmH2I5k6EMLDNz5YwHlVs0vn4bQelO8W5FKuKzCS/8j
 ki7168sdJs86xPhj/sWdICaLo7VSDwqupNWXrNknBvJawC3UnXqufthq4KV6HeY73X
 ybTNrX1qPjUZg==
From: Mark Brown <broonie@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>,
	heiko@sntech.de
Subject: Re: [PATCH v3] ASoC: rockchip: i2s: Fix concurrency between tx/rx
Date: Fri,  3 Sep 2021 19:04:19 +0100
Message-Id: <163069197835.35101.4150427867250097515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630674434-650-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1630674434-650-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 3 Sep 2021 21:07:14 +0800, Sugar Zhang wrote:
> This patch adds lock to fix comcurrency between tx/rx
> to fix 'rockchip-i2s ff070000.i2s; fail to clear'
> 
> Considering the situation;
> 
>        tx stream              rx stream
>            |                      |
>            |                   disable
>          enable                   |
>            |                    reset
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix concurrency between tx/rx
      commit: fcb958ee8e832e9cdf43408535207e15f14af755

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
