Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DDC4727E
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:47:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AF621D42
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G3+lp1AR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu7OqcPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AF621D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A05251941;
	Fri, 25 Sep 2020 22:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A05251941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601066841;
	bh=+4al6pagugF66uVaMI40JCvZvv0PlvcfCKSRy+WGfZY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3+lp1ARaZl3+BvXJ80SpqCRYxy466w8Ey+bPyeWX2ZAgnCNx0D3VwocSr4Dsxi1M
	 0ONVK5FiLZyW8fuaPlickWFMxLPO2L+2KIz4GknDHUS+cqMROfrg00ZpzUKPSr+WZ7
	 qwOB8ekUt4PWB8tOzGkHaQQ/HOO1+c2nLdKCjd7U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42AFBF802F9;
	Fri, 25 Sep 2020 22:43:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBED8F802E8; Fri, 25 Sep 2020 22:42:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C63ECF802DC
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 22:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C63ECF802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Fu7OqcPP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8DDE221E5;
 Fri, 25 Sep 2020 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601066566;
 bh=+4al6pagugF66uVaMI40JCvZvv0PlvcfCKSRy+WGfZY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Fu7OqcPP4P+rE8SSiIyZYBvHPz4Z4b7b1o1hK1r54C2GMpoFL4ctKRZEhXjocAp/+
 2Ggfy9Bo4yjDs+nNPULI2f9jvGCUxsKMohBMnTVgKvdbB/FCge2lYbJFnca9JjOIfG
 3kxFqOP0ImEnXPYUzVMlX7ymeIdll0RSyOXc30jE=
Date: Fri, 25 Sep 2020 21:41:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20200925091830.7675-1-rf@opensource.cirrus.com>
References: <20200925091830.7675-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
Message-Id: <160106647647.2866.8685096288506841458.b4-ty@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

On Fri, 25 Sep 2020 10:18:29 +0100, Richard Fitzgerald wrote:
> EPOUT is always mono so should have a permanent routing through the
> HPOUT1 Mono Mux.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
      commit: 64952377548517a14d0a6521856dde9fd8356c90
[2/2] ASoC: cs47l35: Fix EPOUT->HPOUT1 Mono Mux routing
      commit: b03acae25e4a4ad600e91a8737c7eff2efe7d66a

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
