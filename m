Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E898C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA41B2078C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EnRKwfN2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej0s0UsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA41B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACA73836;
	Mon,  4 May 2020 16:37:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACA73836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588603084;
	bh=NohOeRtNeFL0lR06T1iUMWsfGmgd9V5Dape+sY5k6V8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EnRKwfN2HSXHbMt749hCLoILF6+CTy3anWWI7QaUCZha9FkwIrwoa7Wws7fGlOyVb
	 g7qics2v5bOMntllfRmw9OA5ItQGUUCzKwUjxP6WvBeBK9OD8jvoK4HcQ6vSatkQx+
	 L77Ota6hVNo7IjjQWv4Um8FZgejgWcmoKFHQv7i4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3471DF800EE;
	Mon,  4 May 2020 16:37:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3FCDF80249; Mon,  4 May 2020 16:37:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C3F1F800E5
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 16:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C3F1F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ej0s0UsM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1645F2078C;
 Mon,  4 May 2020 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588603020;
 bh=NohOeRtNeFL0lR06T1iUMWsfGmgd9V5Dape+sY5k6V8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Ej0s0UsMGR4QmPEzFKoy08PdT82NkplV0WJj+jiheFp1GR4IdpbzaF8WaE1Krkt3l
 FPpDrR65A7PtYbt1gkvNhDoiO5LJa34+AGifQMJ23xsrUIHPu4+JKSTQrAMNIwoRJt
 eESr4Ps+6TN4454QCVy/2G+0sa11B2UD7gd7CIhU=
Date: Mon, 04 May 2020 15:36:58 +0100
From: Mark Brown <broonie@kernel.org>
To: "chris.d.garren@gmail.com" <chris.d.garren@gmail.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <1588599820-57994-1-git-send-email-cdgarren@indesign-llc.com>
References: <1588599820-57994-1-git-send-email-cdgarren@indesign-llc.com>
Subject: Re: [PATCH] Mark the ADAU7118 reset register as volatile.
Message-Id: <158860301792.1354.15832150395972220632.b4-ty@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Chris Garren <cdgarren@indesign-llc.com>
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

On Mon, 4 May 2020 09:43:20 -0400, chris.d.garren@gmail.com wrote:
> From: Chris Garren <cdgarren@indesign-llc.com>
> 
> Without this the previously written value was written to this reg,
> which caused the different configuration registers to be reset.
> 
> Signed-off-by: Chris Garren <cdgarren@indesign-llc.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: adau7118: Mark the ADAU7118 reset register as volatile
      commit: f2b1e1cbd352129cfdbc1af52059482d74b4e81a

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
