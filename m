Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB8C28CBC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 16:22:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168C9208DB
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vQ8zuy5Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGE2eW/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168C9208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 596BC1743;
	Wed,  6 May 2020 18:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 596BC1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588782153;
	bh=6ody89kj779DuishSNc4WgF9or+Kp0PLl0WI/a3+U/A=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQ8zuy5YL2GPqXxbciYPPKZoRXjs1dbEkJnNvNBXUPbe8orprXjE12chvwHBSSCkE
	 aY0uncyEQQW4BBgPdjpOL+7QP+vhW4qamUwsxaGrwsXDzMZq4r4Om7Bz2GVRgNwG3O
	 C+H4uHZ+qlG3abXZ97B1dJ92Okwelif27/VmjB9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCD3FF80234;
	Wed,  6 May 2020 18:21:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32BAAF80249; Wed,  6 May 2020 18:21:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B3E2F800DE
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 18:21:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B3E2F800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RGE2eW/C"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E66FC206B9;
 Wed,  6 May 2020 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588782092;
 bh=6ody89kj779DuishSNc4WgF9or+Kp0PLl0WI/a3+U/A=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RGE2eW/Cz9xWNS1o5nnQYukGWNJcSMJfUsYggG+0/vYsv6z34wu6QBkuIkz4wnCf/
 EKrJmh4wz5E6nomgBilmxcDZttODl3Qz7c7Hhd/gbhpfju9+D/v8T+D7ud9S0b4+Go
 medJkHZ+WxBZInnfINiQGI6Jmsr/53YJfggmvroU=
Date: Wed, 06 May 2020 17:21:29 +0100
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, matthias.bgg@gmail.com,
 Tang Bin <tangbin@cmss.chinamobile.com>, lgirdwood@gmail.com
In-Reply-To: <20200506143009.13368-1-tangbin@cmss.chinamobile.com>
References: <20200506143009.13368-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling
Message-Id: <158878208991.2264.6627359892180140797.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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

On Wed, 6 May 2020 22:30:09 +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative value
> returned will not be detected here. So fix error handling in
> mt6797_afe_pcm_dev_probe(). And when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant
> message here.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: mediatek: Fix error handling
      commit: adb69968074a22376074aaa7f7971d93636b4332

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
