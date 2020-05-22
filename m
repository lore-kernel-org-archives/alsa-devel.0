Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA00C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 19:01:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADDB2070A
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 19:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pYsJaYP2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2KgpT1ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADDB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FCF31887;
	Fri, 22 May 2020 21:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FCF31887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590174099;
	bh=cZksGg1oeYNuGZ1ChsW09N1isYUNMgsbYUB9aXYGbBc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYsJaYP2wDvCtcujJn5jUSfQIpOrbS8dZ3Mkyfo8qIB/j5Wyp5GNIP6/trtnCCmDz
	 SQwGBlRmwUBCgdW4DdZfbRwDaiNCoaQ0oz7S65bc+02X0QHt01iqA0vccKRGRJzuTU
	 UzTEcXlMftdKF78V0P9+xfDoPCbNB344BnXxVJ74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98032F801DA;
	Fri, 22 May 2020 21:00:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11C1AF801F9; Fri, 22 May 2020 21:00:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54C38F80121
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 21:00:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54C38F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2KgpT1ak"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 661F32070A;
 Fri, 22 May 2020 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590174041;
 bh=cZksGg1oeYNuGZ1ChsW09N1isYUNMgsbYUB9aXYGbBc=;
 h=Date:From:List-Id:To:Cc:In-Reply-To:References:Subject:From;
 b=2KgpT1akwW1t15sCSCOFuWDlpc8/796efM9j7xc69wnypaV7uSN+DwZ+t1bRKiABi
 Yhj3h/fcV5W6MLUMCGDMazcgsW74HKk4unGiSQbBsZFFZtuMl1mIvkujnhMsT+2AmN
 kArnXHIAlLuGEYnOkTFsZ9QlMMi/1qh4OOwsyEg0=
Date: Fri, 22 May 2020 20:00:38 +0100
From: Mark Brown <broonie@kernel.org>
List-Id: <soc.lore.kernel.org>
To: soc@kernel.org, Daniel Mack <daniel@zonque.org>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>
In-Reply-To: <20200521185140.27276-1-robert.jarzmik@free.fr>
References: <20200521185140.27276-1-robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 1/3] ARM: pxa: remove Compulab pxa2xx boards
Message-Id: <159017403821.20813.3053695214331756106.b4-ty@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
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

On Thu, 21 May 2020 20:51:37 +0200, Robert Jarzmik wrote:
> As these boards have no more users nor testers, and patching them has
> become a burden, be that because of the PCI part or the MTD NAND
> support, let's remove them.
> 
> The cm-x300 will for now remain and represent Compulab boards at its
> best in the PXA department.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pxa: remove Compulab pxa2xx boards
      commit: 168aac9de09551bb0ac9bd3b7a311cd681894fc3

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
