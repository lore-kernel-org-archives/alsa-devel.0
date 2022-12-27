Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CFC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Dec 2022 11:59:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B5DF228A;
	Tue, 27 Dec 2022 12:58:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B5DF228A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672142372;
	bh=9yRIVQ65k8q4rK77nuqyCqsGjJFDzWQnam3WVa2/TQ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NvF8xmPZ+upd72vdMG1UnstMjwmeKA0GS601R+LyKNcgkR2VCeC/bZIJ7uVK/y0bw
	 VPAJvyfytYLR0pPAEFvrZl4K12MH1QyXITZdThVq7R/34WKDAtaMxNm4pQ+gxTUSOn
	 isQ8YFTvFv8FoQ2sa7Yif2YvV75TPtAyNTvhUWMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF4D4F8055B;
	Tue, 27 Dec 2022 12:57:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC315F80548; Tue, 27 Dec 2022 12:57:11 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53979F8053C
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2022 12:57:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53979F8053C
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=e7nCMJ2a
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E564DB80F93;
 Tue, 27 Dec 2022 11:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E1C433F0;
 Tue, 27 Dec 2022 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672142228;
 bh=9yRIVQ65k8q4rK77nuqyCqsGjJFDzWQnam3WVa2/TQ8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=e7nCMJ2aesGgwFOSYVCAPwx6emOAW3+srdwf/DTfNrKVPHYDV0qlXaabeJEJKnGmN
 TfBntyP9pZu9i+SheVqUs9I06XmPcyilMmYJ9mELp/VBmRNVa70YwacXRCLO+eqQ52
 dtigi30WgXPpJ45r/5lxZVYzsF2WUa4523P2yH/cPknVLv9wvvilKu+CDRweNxFmkQ
 xwd04f/xVA1+zzWpLsH3vQ0Orr1L+vzULhkRspBTNTk71CGem9swjs8pwFEt/a5Ppd
 ziw8Q3Q5aTsWxxENkgbsyNuwNA5IEPycWcNCAKj6fq4RqI041BzjNoPHx46TJzR9FG
 M0V+fSM85U88A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Stephen Kitt <steve@sk2.org>, Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20221214123743.3713843-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
Subject: Re: (subset) [PATCH 0/4] ASoC: Fixes for WM8940 codec
Message-Id: <167214222620.82924.12796043478765095977.b4-ty@kernel.org>
Date: Tue, 27 Dec 2022 11:57:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 14 Dec 2022 13:37:39 +0100, Lukasz Majewski wrote:
> This patch series provides fixes for WM8940 codec.
> 
> The most notable change is the clock rewrite, so this driver now
> can either generate proper clock frequency by itself or use one
> provided from the clock subsystem of the SoC.
> 
> Lukasz Majewski (4):
>   ASoC: wm8940: Remove warning when no plat data present
>   ASoC: wm8940: Rewrite code to set proper clocks
>   ASoC: wm8940: Mute also the speaker output
>   ASoC: wm8940: Read chip ID when wm8940 codec probing
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: wm8940: Remove warning when no plat data present
      commit: 5dc5e76b4c41fc8cdd9ed77653b2ce453974fb30
[4/4] ASoC: wm8940: Read chip ID when wm8940 codec probing
      commit: a5c26ee572d94337baf9c944b7b4881a2db62d37

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
