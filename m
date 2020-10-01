Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B6C4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:49:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6205220739
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Oe6hTerd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI9xx8yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6205220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFA9A1AED;
	Fri,  2 Oct 2020 00:48:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFA9A1AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601592549;
	bh=Nw0bQWyAnCws4gXfnM3e/umkSOc68t+yKD9KWMksTaM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oe6hTerd7Qc751foio0W8gBgK1knapdzLZcCS0cGs0uEtvRX6mrd1WpmVQkKwqcJQ
	 ffRcCzm6Zy8OMt5KS+NJ8DotROXvVxSElVxGPjwqwXMyI4fxUDGuKafY5pboYhM6vU
	 42tl7bAJAQBtZ5LbKHWNDWTPx6RCGHlaMz1VNaQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2526F8022D;
	Fri,  2 Oct 2020 00:47:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AA95F801F5; Fri,  2 Oct 2020 00:47:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58997F80105
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 00:47:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58997F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cI9xx8yz"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 13E772074B;
 Thu,  1 Oct 2020 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601592439;
 bh=Nw0bQWyAnCws4gXfnM3e/umkSOc68t+yKD9KWMksTaM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=cI9xx8yzuCkVJClCAlKB3q8snrQNK03n71jWh4k5blrpkfEtjhRDrkhbry21yQGPl
 qEKUEGMqJ70lLE66uIHWVeABc+LW6knNFv3/WxncMjrH+MSQ7sNGv1HAG58hyOoQfJ
 HDVPadMg6MqPRhqKb6Qy8Ckbr+QSnKL6ce9DuIQY=
Date: Thu, 01 Oct 2020 23:46:20 +0100
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org, lgirdwood@gmail.com,
 Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check in
 fsl_spdif_probe()
Message-Id: <160159237545.44588.9742249781960285327.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
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

On Wed, 26 Aug 2020 23:09:18 +0800, Tang Bin wrote:
> The function fsl_spdif_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix unnecessary check in fsl_spdif_probe()
      commit: 601fd3a7d849cf8a5dbd3628b3c29af9e5377961

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
