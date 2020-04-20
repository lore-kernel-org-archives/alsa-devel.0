Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA131C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF7B20735
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hpN0Bb6J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch9lIrqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF7B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7FD21678;
	Mon, 20 Apr 2020 16:29:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7FD21678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587392997;
	bh=IyynnK8UeratkZoR39Dsyukzq1BV8ghVhci6oQBjUb4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpN0Bb6JPYrm0eQfHS7FLQ1wR15BaLj5f+M5JzlU9xEH89AWAsuscH+CFrolV7bZ/
	 w+DY010KvEGCiQKFv8f2HVJQm3G3LMlxw6DLc7ZRHgYWU7sncuE/kfR0lmV9O1/xGY
	 UfjHvjHREr4lsfp38Qx+eGpjpCP4FUeoUkhENklQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84126F80278;
	Mon, 20 Apr 2020 16:27:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE352F8028B; Mon, 20 Apr 2020 16:27:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CBC9F8021C
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 16:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CBC9F8021C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ch9lIrqr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83A4D21D79;
 Mon, 20 Apr 2020 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587392852;
 bh=IyynnK8UeratkZoR39Dsyukzq1BV8ghVhci6oQBjUb4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ch9lIrqr1zDGiwJLRoVegmOQq4icxhS0s3aoRK7NrJ1NUHioZ79cQJCnp+75/ztPe
 64QpOa0eaSQnE1A4PSmMtkl77rhFfdn3A/aDPPVgdz8siIPRKByOFI+K2qi73EF45T
 chjCB23u5KNA19JbQx+VBQfI5mIlXJKOMoLPbIlE=
Date: Mon, 20 Apr 2020 15:27:29 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, linux-kernel@vger.kernel.org,
 Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, perex@perex.cz
In-Reply-To: <20200420042833.19116-1-yanaijie@huawei.com>
References: <20200420042833.19116-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: wcd934x: remove unnecessary comparisons to bool
Message-Id: <158739283775.7647.6482976074027263195.b4-ty@kernel.org>
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

On Mon, 20 Apr 2020 12:28:33 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/codecs/wcd934x.c:3881:8-17: WARNING: Comparison of 0/1 to bool
> variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wcd934x: remove unnecessary comparisons to bool
      commit: 836cca3a2658e9ea2a252ef78a24fdb002a9f5ba

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
