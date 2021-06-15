Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59991C49361
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 17:33:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ABF61414
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ABF61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63E0D16AE;
	Tue, 15 Jun 2021 19:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63E0D16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623778379;
	bh=SdONMFRJs7Ih+OqCLHPKOjGOo6+vcLRW40A4/iSbxzU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n7AQ1M7OBWhojTpkygLj2J2fOW8wI3LD4WdIpyqy2DNndF4jSyrERmumFFQjIxCOQ
	 oBw96sZX5r/9PvTW0obDokZNISjLN4x0t+pP2eCC16ednXm6c62j6pBDHRsZKQtXt/
	 1+nABj/LcTMove6alKiRrt0tgihNs+mtMcYgwrYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42380F804E0;
	Tue, 15 Jun 2021 19:30:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10B40F8025A; Tue, 15 Jun 2021 19:30:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3714F8025E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 19:30:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3714F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="My/AzXud"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B51361403;
 Tue, 15 Jun 2021 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623778198;
 bh=SdONMFRJs7Ih+OqCLHPKOjGOo6+vcLRW40A4/iSbxzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=My/AzXudtPgjPxNE3pkwlv9Ni3jGESjXpfpUicUM+TTyr6QUmlyQbJMUovaMqjNGo
 NqffrS1qp+WcqS9ooEUfC+2OMFs04OUiSGjQETRx4uV8qRc4nCTiPx8PdYHWImf2ES
 RUhVnweyAUkQjuo8xrTI+vxxQGeLkaqgJpwC034c9fXHSIf1TquswOBWf68BrDKdYh
 Z6mhmujHUCDketUjhexzn9ejGpT0t5RHne9+ejIr6yfsQp1Muzdp5mPZB2s4dXgiBl
 0HAkdvL8CvE7FtJyPB4bZLVHYjq+Ygaz80FkgdCtztu1WYXRrb6LCSfJNa1G2p63uL
 zkti5omBNs7sw==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: jz4740-i2s: Use
 devm_platform_get_and_ioremap_resource()
Date: Tue, 15 Jun 2021 18:29:22 +0100
Message-Id: <162377763945.21612.3642505677079279664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615135627.1665168-1-yangyingliang@huawei.com>
References: <20210615135627.1665168-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: paul@crapouillou.net, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
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

On Tue, 15 Jun 2021 21:56:27 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: jz4740-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 50484d14ac3c9d93de0da5b8c546b1cb86df3d31

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
