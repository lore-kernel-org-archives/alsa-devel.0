Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F32165229
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32165229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A8A318D0;
	Mon,  8 Mar 2021 17:10:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A8A318D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219863;
	bh=dp5CLRZ/qcCLRBLFiX1Elejcb5Arx4EDlbEp0HHDH1Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTjSJBY2wRdJvfufmuD4Owt8KYZiH/EzxvDojFa5qvD681Vy8iTfvA7YnOhxFKcMS
	 FoLe/qNVLc3/ZeQ4gmWB4Kg9rBK5wYS5x9utk5LRQkoQmg5HdotlTtkuNWBXPIlP1e
	 0M8UMgveXtWwON67hylYSj7xe1M7Mlp2HpD9iXcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8200F800ED;
	Mon,  8 Mar 2021 17:08:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A96CF804AB; Mon,  8 Mar 2021 17:08:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EAE7F80482
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EAE7F80482
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LfdzLPPb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EE6E65210;
 Mon,  8 Mar 2021 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615219707;
 bh=dp5CLRZ/qcCLRBLFiX1Elejcb5Arx4EDlbEp0HHDH1Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=LfdzLPPbq9W7CZ7v8EHQghN3CFK/Zuhx8Ptho+UIORomAXGE68s+X9ZyN4SceEvh1
 8Br2eVy6SLaJb0vC7ecRnFhW++wAvubKpCz42XKOablLrp73rEVHca9J6/dMgr6zGR
 2Fyy2H0/RTOfVG3jkCVcfSiLYjYCAoH5MXTA+xRVLnkeUeOZ4YOwuCOJGT/sWsvURn
 wuh1Wc7dDzKQitA5V3AO41N1U/CyYFGcHJhZNTPj3AIGSrfuAOwXh9oi5XtB/QdyGn
 MDNCyBiceExcVP9s9Um6vT2rp3sTFJjMu2M1abXdD6g1WHdkGeCxzgEi59002NVdG5
 jpuMJEOK7JsDA==
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz, timur@kernel.org,
 nicoleotsuka@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
In-Reply-To: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
References: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Use
 devm_platform_ioremap_resource_byname() to simplify code
Message-Id: <161521960849.9621.15073900533403359434.b4-ty@kernel.org>
Date: Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
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

On Tue, 2 Mar 2021 20:50:02 +0800, Tang Bin wrote:
> In this function, devm_platform_ioremap_resource_byname() should be
> suitable to simplify code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Use devm_platform_ioremap_resource_byname() to simplify code
      commit: c5f48a78e0cb950eb821af36b8790b794cc745b1

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
