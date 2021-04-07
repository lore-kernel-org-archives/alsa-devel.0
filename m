Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39183C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 20:27:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7D8611CC
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 20:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7D8611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A4C01662;
	Wed,  7 Apr 2021 22:26:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A4C01662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617827268;
	bh=hhSwEIiRpS2DqdUTQ61WIoCRvLh6PsG+8huacQb3mew=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vfd7zXOSlJNIDukCkWsfOq7msa2nRkft5S69RRCf/RqEhyvS9wYDm4tJ7MgJWTwes
	 MTN/LE8dL1as0Oo+OaF4qXv0lln29LUqQgO/U0cnAuSsWSAOWjriU0f39nKqyOedM8
	 pkehyFmLJ0ZBRBqWGcAkdCj3yo+FY8nzQb0wBElw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5C0DF8016A;
	Wed,  7 Apr 2021 22:26:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4671F8016A; Wed,  7 Apr 2021 22:26:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A498F80124
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 22:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A498F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MfUNOg/D"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF06D611C1;
 Wed,  7 Apr 2021 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617827211;
 bh=hhSwEIiRpS2DqdUTQ61WIoCRvLh6PsG+8huacQb3mew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MfUNOg/DryAKcb+XuiDNOZsFxcFaABotIU+7EjRUqKSJTyXyzcnwwOuCccSFOOx01
 P+rD4vL6w0EkcMp8RKLN4eRDB2zkqkK/RPOPAy8JwAUyaUYXKB1L8VsY5KZ+loNM7H
 pTuJlSzA40pVLY6mu9sCczApMz1FkZZ0DL8uoN07qwaaVdlfO3W9wtGL8OBiFE7UaR
 6CbD1FTd/tlE4bmQTLA4CAyltFIpwp1ROhlS/Ny6yyuCkjnR1MrMHPBD3veGp8+NvA
 VwZV32xBRnGp3fLpIOeX6s2udf9NyNA1ATfx4DcBlShP6ZiEdoMshrXoWYqFteZVbu
 O+mZk72Pg0UvA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-frddr: set fifo depth according to the
 period
Date: Wed,  7 Apr 2021 21:26:21 +0100
Message-Id: <161782703231.42756.1997457817107247439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407145714.311138-1-jbrunet@baylibre.com>
References: <20210407145714.311138-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
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

On Wed, 7 Apr 2021 16:57:14 +0200, Jerome Brunet wrote:
> When the period is small, using all the FRDDR fifo depth increases the
> latency of the playback because the following device won't start pulling
> data until the fifo reaches the depth set. We can adjust this depth so trim
> it down for small periods.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-frddr: set fifo depth according to the period
      commit: 6f68accaa8641b70b698da659216f82f87537869

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
