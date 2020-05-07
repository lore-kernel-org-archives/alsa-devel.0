Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81255C38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1027B2083B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VGdV4SAh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK0D+fq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1027B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F3A817A9;
	Thu,  7 May 2020 14:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F3A817A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588854056;
	bh=Js9/awTZzh+OeRtcxFlm+yNdowkxwrmyoTMI6joGIvU=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VGdV4SAhpJYYTlrnfd7I5NbG1OXehxBMqQ37T0sNSvo6pvaUxg3vIbXZ/oZDuEWmW
	 miV/gxkukZ3p5ZlyuqfMPSNSNaPdYvGwIN6z2QR9EXvO/dJ/fBfOFXGuLZl8BbVZzj
	 JA+kDoOwSguigXppf5kQo7qrFMM41YiWWetIEKiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A52E0F80277;
	Thu,  7 May 2020 14:18:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1D02F8027B; Thu,  7 May 2020 14:18:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A24DF800F6
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 14:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A24DF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fK0D+fq8"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 390262083B;
 Thu,  7 May 2020 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588853907;
 bh=Js9/awTZzh+OeRtcxFlm+yNdowkxwrmyoTMI6joGIvU=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fK0D+fq8RErGdn181z2tKDqdJ12yT0eHTKXhhy6kzSsoNRFb4E+YOQw7+HL/nscPZ
 f3TY+6tVdDuaJ3msXOlWFilgAz0eyn3uKMyP3aWAV8Jka6mm0WqRwCEBibQaprb9Op
 zXVi3cb4MszGnG0qdnx0HXqImrt5FErUQHv1yTYs=
Date: Thu, 07 May 2020 13:18:25 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Oder Chiou <oder_chiou@realtek.com>
In-Reply-To: <20200507021539.7133-1-oder_chiou@realtek.com>
References: <20200507021539.7133-1-oder_chiou@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt1016: Add the rt1016 support
Message-Id: <158885389338.38935.16607717193603040508.b4-ty@kernel.org>
Cc: shumingf@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 derek.fang@realtek.com, flove@realtek.com
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

On Thu, 7 May 2020 10:15:38 +0800, Oder Chiou wrote:
> The patch adds the rt1016 support.
> 
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>  sound/soc/codecs/rt1016.c | 695 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/rt1016.h | 232 +++++++++++++
>  2 files changed, 927 insertions(+)
>  create mode 100644 sound/soc/codecs/rt1016.c
>  create mode 100644 sound/soc/codecs/rt1016.h
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/2] ASoC: rt1016: Add the rt1016 support
      commit: 79a4b670b4b4dddfdb2e946139a88306e3b2ca09
[2/2] ASoC: rt1016: Add the devicetree file for the rt1016
      commit: 7ae07308e40cb008ef3cc930a02450183a024b9f

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
