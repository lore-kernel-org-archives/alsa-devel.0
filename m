Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66654C4363C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:42:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2305423A61
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="toe591re";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9BjRmSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2305423A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AAF316C2;
	Mon, 21 Sep 2020 23:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AAF316C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600724552;
	bh=CnYDBVW2rYjgRoaGJx/XhCKqd7MzAZDqUTLvs1cvdDU=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=toe591reElWijinNk4o8xLS3WgIYVa7Kb2uMN0Q6wGhQRMSPE2dB4oJau36ymAzWV
	 q6VpngbIXJgiC9A1eOj2ulQO7e2+zoLRpdph/B/RGAzu75sVt+oyc2N5gB+lN5dOXb
	 +3WOHrcHRfN7Uo7kTEJYhn6ZNwP+6sFxuFrWQuG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3912F80161;
	Mon, 21 Sep 2020 23:41:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A0C0F80162; Mon, 21 Sep 2020 23:41:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B7B7F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 23:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B7B7F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n9BjRmSc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 906FD23A60;
 Mon, 21 Sep 2020 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600724494;
 bh=CnYDBVW2rYjgRoaGJx/XhCKqd7MzAZDqUTLvs1cvdDU=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=n9BjRmScECzUdhuU2SJpgQAUggFS/xhcv1JB9RcwcrTWLnOGK3KEIXpEzB2RR4iYP
 0G1kXTcDgykM3OU4z8YlGA9DMin2EL3PpX/H6HyrsM5oP8Z6XvCNZuQ+ibb4NFd0pa
 GjO01Kbr5GhtGczG4h1tvHr2LI8b+D4CzRlh5OZY=
Date: Mon, 21 Sep 2020 22:40:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 0/3] tlv320aic3xx4 updates
Message-Id: <160072444039.56872.6911878141107050314.b4-ty@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Fri, 11 Sep 2020 19:31:37 +0200, Miquel Raynal wrote:
> While doing a kernel update on a sama5-based board I figured out the
> sound system was not working anymore, the debug session led me to the
> following commits. As I am not an audio expert at all, I am fully open
> to comments and suggestions.
> 
> Thanks,
> Miquèl
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: tlv320aic32x4: Ensure a minimum delay before clock stabilization
      commit: 5b4458ebb4c8007dae7eaeb88cb52b2bb4879894
[2/3] ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
      commit: 40b37136287ba6b34aa2f1f6123f3d6d205dc2f0
[3/3] ASoC: tlv320aic32x4: Enable fast charge
      commit: ec96690de82cee2cb028c07b1e72cb4a446ad03a

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
