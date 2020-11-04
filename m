Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2308C388F7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:44:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03520825
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="amBdi8aD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOS8mXkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7303F1682;
	Wed,  4 Nov 2020 21:43:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7303F1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604522643;
	bh=qHG+qglNHl7EPko96pTWFo/vpVvFsDwd7t26z3aXLJc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=amBdi8aDpich45Pf3KvpPyjMbatPxfwhIujwQ1/lz5BkQIdPF0paaoj0q2tLo2S3c
	 L/Qrhwpb45vghW5cdKiSo8F+wbUV/H2gdWzXcZYWuvIay3lD4tfph6x5nmC5HygZ+5
	 PB42SnhHfhua7q6sA4vfbuYOiDHKxpv3DKIe+WZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0830AF80232;
	Wed,  4 Nov 2020 21:43:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A18AAF80234; Wed,  4 Nov 2020 21:43:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90601F800EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 21:43:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90601F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DOS8mXkc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE27220637;
 Wed,  4 Nov 2020 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604522585;
 bh=qHG+qglNHl7EPko96pTWFo/vpVvFsDwd7t26z3aXLJc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=DOS8mXkcDZNKMUjg+ZIQqDOAwtHelZak+3QSk6S4F39enXPIJ718WG2AOBUxNJRB7
 XbUkby8jGhOE1J0RrQypWuPdNV4d0auEe+7+L0J7gFVcElF6JDKiC5Z12/C6ilAef6
 nhXRYEvEyGFlFxdChviPRbiomgXa3oX1txwFMauY=
Date: Wed, 04 Nov 2020 20:42:54 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, tiwai@suse.com, robh+dt@kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, p.zabel@pengutronix.de, matthias.bgg@gmail.com
In-Reply-To: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v4 0/9] ASoC: Mediatek: Add support for MT8192 SoC
Message-Id: <160452257414.7226.8411635930831702201.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: shane.chien@mediatek.com, Bicycle.Tsai@mediatek.com, Trevor.Wu@mediatek.com,
 kuninori.morimoto.gx@renesas.com
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

On Tue, 3 Nov 2020 15:59:29 +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE for MT8192 SoC. At the same
> time, the calibration function of MT6359 is completed with real machine driver.
> The patch is based on broonie tree "for-next" branch.
> 
> Change since v3:
>   - use normal conditional statements to improve legiblity in [v3,3/9]
>   - remove mtk_i2s_hd_en_event as there's trace in the core
>   - impove mt8192_i2s_enum and mt8192_adda_enum
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: mediatek: mt6359: add the calibration functions
      commit: 682c5a72a2bb0745da73211bed5f47ccccd84025
[2/9] ASoC: mediatek: mt8192: add platform driver
      commit: 125ab5d588b0b3b842064c4d53a666ca74521ae8
[3/9] ASoC: mediatek: mt8192: support i2s in platform driver
      commit: 2c37b4ed730bc45e936794031a2fa13d75fb4572
[4/9] ASoC: mediatek: mt8192: support adda in platform driver
      commit: 607ac48595640d549a769f0dde0732e69c3a6c03
[5/9] ASoC: mediatek: mt8192: support pcm in platform driver
      commit: c63b7866011e63038d32bc37f3abd0deabbc34f6
[6/9] ASoC: mediatek: mt8192: support tdm in platform driver
      commit: 52fcd65414abfcf31206d9d8ac6dba9cc1cbbf85
[7/9] dt-bindings: mediatek: mt8192: add audio afe document
      commit: 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec
[8/9] ASoC: mediatek: mt8192: add machine driver with mt6359, rt1015 and rt5682
      commit: 18b13ff23fab34a9d35cec60ed19aceab61dc3f9
[9/9] dt-bindings: mediatek: mt8192: add mt8192-mt6358-rt1015-rt5682 document
      commit: 4a232122124bcbc241b8099c2f98a62c79699324

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
