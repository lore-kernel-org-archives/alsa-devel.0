Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD98C83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:41:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4048B206C0
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qg1xIbAI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w3N52jYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4048B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 900401680;
	Tue, 28 Apr 2020 17:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 900401680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588088512;
	bh=UwOEbjuqqZnNh4bPD15G3mJ8BwNUK3zuC+NFaXG/Wis=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qg1xIbAIx4Ub3WRtwQYQ1RunZvDpEZQl9PpMVqj3y9hzKoVjLBdkokagnc7yrNKse
	 XpH7/gLgcdYI57wY9hOE15k0L2ps1VqWWrH8msKALcSl9sUtqW0TF7IjQszlKnExfy
	 SGO3bV/sFpI1BYZ9Wq23K6CmmfFUhB0dA95AWYhw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B61FF80136;
	Tue, 28 Apr 2020 17:41:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DF99F8010A; Tue, 28 Apr 2020 17:41:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DA39F8010A
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 17:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DA39F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="w3N52jYR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22D4D206C0;
 Tue, 28 Apr 2020 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588088455;
 bh=UwOEbjuqqZnNh4bPD15G3mJ8BwNUK3zuC+NFaXG/Wis=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=w3N52jYR2mcAMUn0+EKOk0EMrIElOdRAwiiSyJI3ihKNop9LbAETyeJVJzf0O97gm
 1bIO0GPYRulEi2FuLf242QJnLmxgxbkvwVdT0FY7y4iZcDJSXK2M47h/HVfqb0VtML
 1OAfpVXA5yM7Bmk6uCMQEhe26h848wq4NdrJOyuA=
Date: Tue, 28 Apr 2020 16:40:53 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>, perex@perex.cz,
 tiwai@suse.com
In-Reply-To: <20200427203608.7031-1-dmurphy@ti.com>
References: <20200427203608.7031-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix mic gain registers
Message-Id: <158808845301.38316.11380096383404552191.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

On Mon, 27 Apr 2020 15:36:08 -0500, Dan Murphy wrote:
> Fix the mic gain registers for channels 2-4.
> The incorret register was being set as it was touching the CH1 config
> registers.
> 
> Fixes: 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Cc: stable@vger.kernel.org
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: tlv320adcx140: Fix mic gain registers
      commit: be8499c48f115b912f5747c420f66a5e2c31defe

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
