Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A848C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:50:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E6660698
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E6660698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 139601691;
	Mon, 12 Jul 2021 12:49:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 139601691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626087013;
	bh=uRqilg7CCTiXiMk2e657oj18CYOzh/zfcgwLHSndPMQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyRaL/hS28rhX4PsnIhsJAPw6+svOmvTpl3KxPhAC8KAT0Njo2guYgUXEDsd2DF47
	 Ap3jHq9Wa5ehOvaMmQTaGc0I3ppSf61suPUks6aVkzD1dmbtbPlZiO7bR79g/n6FVl
	 rlSnfhSiNoO2mL5A02iyZesMGzon4BOKHssusHvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE155F804E1;
	Mon, 12 Jul 2021 12:47:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B5C4F80253; Mon, 12 Jul 2021 12:47:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D308F800EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:47:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D308F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PKOxR9gV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DBD61106;
 Mon, 12 Jul 2021 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086867;
 bh=uRqilg7CCTiXiMk2e657oj18CYOzh/zfcgwLHSndPMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PKOxR9gVyRb/aKDarMb/OT2NEcDK9yFr2DEwpzFEDPFyQ/aQJAcIyCICNQRs/e8EV
 0SmE0cWC5yYdSb98+kyVV4/H9Xs9pycosczh12IikVberE9L3J20FbituhvfHI238v
 GzrkpG69UOm1Bes627oVpbIgkGJganlb7bdEwE7qLK5D4GLoR9a9qE4+rgU+fvoXxt
 u7JoTitIAku8r99u35O2Ncp2+Q5pT97h/QRE/sjYF1yWw/cyUP3lOjr4TUPy2iTenC
 kPv/gu3q2lZlTYv5YpRqIo2Lx0b2XiGq8lG4SPxdPb0QH1eaFiImLDfLcetDUNIVtm
 LJB7cHe0GukcQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
Date: Mon, 12 Jul 2021 11:46:00 +0100
Message-Id: <162608623152.3192.2676358338088676059.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210707214752.3831-1-rdunlap@infradead.org>
References: <20210707214752.3831-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

On Wed, 7 Jul 2021 14:47:52 -0700, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> needed. Dropping it eliminates the kconfig warnings and still builds
> with no problems reported.
> 
> Fix the following kconfig warnings:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: ATMEL drivers don't need HAS_DMA
      commit: 6c5c659dfe3f02e08054a6c20019e3886618b512

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
