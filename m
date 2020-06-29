Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C836C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:16:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915B7255A0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="paaWrz60";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x50Faqq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915B7255A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14A50847;
	Mon, 29 Jun 2020 20:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14A50847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593454575;
	bh=IPwYZWpcmEBmGKzpEn32o92vTbK48d5Td6bDmd7aHCk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=paaWrz60AUEqXADLD/jp1XmXOyqO5nnI6xcblR+RRD6/n4l+8DK9I84iE35jOos2/
	 kvw4aWVTQwXR52LI8YrU+CmimYId3UpHzgPHh9GXvE7q2V3olCX3XStqkCXsKlY7o5
	 wfpXdr3v1j3qWPln9twN+3ktoGBu+7MnBqyyaW4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 989F7F8021D;
	Mon, 29 Jun 2020 20:15:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEF6DF80229; Mon, 29 Jun 2020 20:15:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5569CF80096
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 20:15:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5569CF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="x50Faqq+"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 839F52559D;
 Mon, 29 Jun 2020 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593454509;
 bh=IPwYZWpcmEBmGKzpEn32o92vTbK48d5Td6bDmd7aHCk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=x50Faqq+gwSwcZygE4OE7sGOF5idPSWZfmTac/xIZCdD30VFEN8bXJfD0PR9m8yor
 812VR2ZzMHMwlsxjVuWfDx5o0dokYrjQPYvnAm9MAbUB46uLKU1po2wdDUb5dkVbIF
 u3KZ0Wv3I1T9cf0J0Z72E9+K9Fu8zBNmX4FjoZHU=
Date: Mon, 29 Jun 2020 19:15:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Rohit kumar <rohitkr@codeaurora.org>
In-Reply-To: <20200629122443.21736-1-geert@linux-m68k.org>
References: <20200629122443.21736-1-geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: qcom: Drop HAS_DMA dependency to fix link failure
Message-Id: <159345450676.54191.5667484527733224439.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Mon, 29 Jun 2020 14:24:43 +0200, Geert Uytterhoeven wrote:
> When building on allyesconfig kernel for a NO_DMA=y platform (e.g.
> Sun-3), CONFIG_SND_SOC_QCOM_COMMON=y, but CONFIG_SND_SOC_QDSP6_AFE=n,
> leading to a link failure:
> 
>     sound/soc/qcom/common.o: In function `qcom_snd_parse_of':
>     common.c:(.text+0x2e2): undefined reference to `q6afe_is_rx_port'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Drop HAS_DMA dependency to fix link failure
      commit: b6aa06de7757667bac88997a8807b143b8436035

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
