Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D9DC432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 18:17:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF4F61053
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 18:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECF4F61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13131179F;
	Wed,  1 Sep 2021 20:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13131179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630520260;
	bh=KlzFo2zJ7NhBhc9QV4PwhjlNPkGGI6TKBTxxQka9D2c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvHBpEtzyZ6hOIBS3+IR4uv1bXizZ7tV8EmQ7xqT54w1o9AsCWH/M11/Y+vp601z1
	 +3qQsl6bt7K1ZYkPWKwyaN8mtgzuZZPgy1t9qx6uC4zp0MBq13+WRogG1Dh36ibLBj
	 6klhLNmgFcH1uDKD7HwKzo1a0btve+KbxWHo2ixU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51098F804E5;
	Wed,  1 Sep 2021 20:15:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FC2FF804EB; Wed,  1 Sep 2021 20:15:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAD68F8020D
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 20:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAD68F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="td+0Ls7h"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D33B8610FF;
 Wed,  1 Sep 2021 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630520130;
 bh=KlzFo2zJ7NhBhc9QV4PwhjlNPkGGI6TKBTxxQka9D2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=td+0Ls7hAihHu5SrrX8RkJXcstpMehCWWuTyQ3Wi8Lru0k7YOrHRriSZyMC4iEUj9
 j9N2U8Lg6mP5eMgaTP4/hZlSDhnzcNpIAxuSQgxJvDASZggSXhMtFRNSk9Ao3rER3W
 zUWbGJpOk5borZ9bsvwPCJ438S7i5R041P8bcTpw+8NbWM6YEjAJIs5V+R/q7AA3sE
 Qaxrf0sEQpi18oZMjOR13haEMp/szJQv1YMrMebUd1iTZBS1w1R5tTevRf1rK8GNJf
 ordDqAj1bywlEtGAEkZjuVXTpiwo8FwtABY3sUys2w9ocZQaZbW09YH8SEEEUDc0VN
 AlO+8KC1q0SAA==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt5682: fix headset background noise when S3 state
Date: Wed,  1 Sep 2021 19:14:45 +0100
Message-Id: <163051912510.21630.7840903335943166080.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210901100754.21045-1-shumingf@realtek.com>
References: <20210901100754.21045-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, Mark Brown <broonie@kernel.org>,
 derek.fang@realtek.com, flove@realtek.com
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

On Wed, 1 Sep 2021 18:07:54 +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> Remove CBJ power off setting to avoid floating state.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: fix headset background noise when S3 state
      commit: 0866d645b76d062b7d55091fd6fb80f058d0c384

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
