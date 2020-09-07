Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49956C433E2
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDB5206B5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZQX6ukOg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5w3wL4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDB5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F6FF17CF;
	Mon,  7 Sep 2020 20:08:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F6FF17CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599502170;
	bh=kQx1n0wiA1AOHZa0bgXD1ERswBDInvHAo+u2PUb7JAM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQX6ukOgYpRYRGeUSrzXhpITDw8ytub5O5tEQqts/iDuuX7pLGhqrFxlfc6mPaQaj
	 97fuUzPV3n9fSqWaILu3aa1N6are6GioXqQAE1g9EqIJ2iKbXiNVRu5rg59T58P5u3
	 MaR0jVN5nrn+tg9MN4glXFc0AS03c7A/VwdudJgE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F417F802E0;
	Mon,  7 Sep 2020 20:06:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1736FF802DF; Mon,  7 Sep 2020 20:06:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B65FBF802DD
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 20:06:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B65FBF802DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="C5w3wL4X"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE49E206B5;
 Mon,  7 Sep 2020 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599501982;
 bh=kQx1n0wiA1AOHZa0bgXD1ERswBDInvHAo+u2PUb7JAM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=C5w3wL4XwX/GcnMJRYFWZmdFVKZedCu/emD0LUVm0E3wtFIE6M32A18ibuoHXz+0t
 1Hmow6qLz4DSki7oheINH1Q2NIAH3/4fsYXE+V5At6lLtVRNShWFG42EawIsKf/ykx
 X1J5b6QogdMWHmq7a3WP0shu30xLILZPFQdOn+fU=
Date: Mon, 07 Sep 2020 19:05:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
Subject: Re: [PATCH 0/9] ASoC: sun8i-codec driver cleanup
Message-Id: <159950192274.52707.8359144994628782541.b4-ty@kernel.org>
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Sun, 30 Aug 2020 22:48:43 -0500, Samuel Holland wrote:
> Now that the fixes series is merged, here is a series of small cleanups
> to the sun8i-codec driver. These help shorten the patch stack for the
> next series, which will add support for the other two DAIs in this
> codec: AIF2 and AIF3.
> 
> Samuel Holland (9):
>   ASoC: sun8i-codec: Remove extraneous widgets
>   ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
>   ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
>   ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
>   ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
>   ASoC: sun8i-codec: Fix field bit number indentation
>   ASoC: sun8i-codec: Sort masks in a consistent order
>   ASoC: sun8i-codec: Attach the bus clock to the regmap
>   ASoC: sun8i-codec: Manage module clock via DAPM
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: sun8i-codec: Remove extraneous widgets
      commit: b8cbb1cab70342756725c1beded6b81031a95762
[2/9] ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
      commit: 2455e37adef39bf7fd12df963b86fa7f313f1ad4
[3/9] ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
      commit: fa5c0ca1f90aaadb6539ec6c407221f2ab7b7608
[4/9] ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
      commit: 0ba95493023de45744962af41ef5ad90bad7d8bb
[5/9] ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
      commit: 30aff91ec7840fb72daef7ce389a9414e5db4075
[6/9] ASoC: sun8i-codec: Fix field bit number indentation
      commit: fcb7b39ee3d877e4eb79fb2abf15644d1b36285c
[7/9] ASoC: sun8i-codec: Sort masks in a consistent order
      commit: f30ef55c332935c1d7c5f4ae3d084bec8d05712e
[8/9] ASoC: sun8i-codec: Attach the bus clock to the regmap
      commit: efb736fb9eceac6ce335bbaa3d788a05649160b5
[9/9] ASoC: sun8i-codec: Manage module clock via DAPM
      commit: 6b3bb3c82b94521d6d61c1bf7c766c8c3bddacf5

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
