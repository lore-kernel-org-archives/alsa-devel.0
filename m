Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73518C433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB0F2073E
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rc31Z+Ea";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9GITpcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB0F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CAC2820;
	Tue,  7 Jul 2020 16:21:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CAC2820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594131735;
	bh=TK5Cmeh9M/MUfKwtkEO+yW3fxeLeyY7PEeljzDxg6Ss=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rc31Z+Eak011/JwqQ+HmYJlkMWsddqMiMCDZNOqEYTSkJ2pnOY1fFbF1qqlEu/Qb/
	 0dISacQvm+LC2b1ssjhZG5TwjaIGaL5Apm2BvuP53k977+rxVAXpD2FjlPBDXiQ5jh
	 zgrFqCccLzgXUQDarSejSVmNDoojAyZ0diIHss6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2057FF802F7;
	Tue,  7 Jul 2020 16:17:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 715F8F802F8; Tue,  7 Jul 2020 16:17:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08EE2F802E8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:17:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08EE2F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S9GITpcS"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C28220771;
 Tue,  7 Jul 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594131459;
 bh=TK5Cmeh9M/MUfKwtkEO+yW3fxeLeyY7PEeljzDxg6Ss=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=S9GITpcSEv1WJqH3IKUE+Ppu4DyA6YBHZG1krJj2NErR/mlM0kb8OXdjllSTmX+WB
 30TKI4qU9XgipwupbpksKfiQpKe8Y9RgZvh0ooOYlIRiuAtBlBwO2ccRvty9Ew0zbS
 jFz8/dT3SqtISBb0Wxp4w2LJLW7ANSCuFjGXP1sg=
Date: Tue, 07 Jul 2020 15:17:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
In-Reply-To: <20200707045829.10002-1-nicoleotsuka@gmail.com>
References: <20200707045829.10002-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Shengjiu to reviewer list of
 sound/soc/fsl
Message-Id: <159413142466.34737.3295058697996171604.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@nxp.com, linuxppc-dev@lists.ozlabs.org, timur@tabi.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
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

On Mon, 6 Jul 2020 21:58:29 -0700, Nicolin Chen wrote:
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
      commit: 503ed52225ed3d369c8e0dedf13556a7bc1e5c2b

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
