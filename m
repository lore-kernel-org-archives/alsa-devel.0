Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A5FC77B75
	for <alsa-devel@archiver.kernel.org>; Tue,  9 May 2023 05:45:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33241135;
	Tue,  9 May 2023 07:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33241135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683611149;
	bh=BHjVGIukBgoK+CmqFhhYd0En5hML1F44t+AhacSIdS0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=X/O4gJy4dpOgtGM2ZGooU4TqEV+CD1XvwYrr+M/rSBAMpOI08DgiF1C1/0682SzBN
	 1ZI7LKt8zibBMPBlkpNZvrCBn1ikDrr8pWqpokhGDo78rbxe/AIg5xff20Tzw3j9GY
	 JGQl4LcjZXSTOwPtJIXy2P7iIX9uE/YZmfOtrTpQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 868A0F8032D;
	Tue,  9 May 2023 07:44:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D75DF8032D; Tue,  9 May 2023 07:43:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 909CAF80217
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2023 07:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 909CAF80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PsJpDp+R
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 50B476442F;
	Tue,  9 May 2023 05:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF24FC433EF;
	Tue,  9 May 2023 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683611008;
	bh=BHjVGIukBgoK+CmqFhhYd0En5hML1F44t+AhacSIdS0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PsJpDp+RRGSpjMf9SvOivDlyCqHh1gqXZZMd7EUL1fpcPdY2HQ5cLRTDpZQ5Rxe1c
	 dZCwir2Kr98oQU0p+bVsAuawAxoIIeDKlNceQDqNQaxNVOkjoO6INcKPU5roWQBsl4
	 Ije1iZNFpBvmbGev+V0Sk6jS8WtrqnUQ1/Q65g/dln+vzCMARQOa67tlwsIKiYJCKa
	 VlKzad0gISZFYQZ+WrnXo7fFvviH8xsplBqOefRgJuu8tJkG4++zdiXaPgXIypOygF
	 nRZOGIX6Evbvup7kHb5uEZaiPz74JnrDbASEm1NF8DnaLiSiVg57lBZ5dQQhM1Mo29
	 R8M3qmcW3h7ZQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1683540996-6136-1-git-send-email-shengjiu.wang@nxp.com>
References: <1683540996-6136-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix error handler with
 pm_runtime_enable
Message-Id: <168361090204.282894.7680884514075566269.b4-ty@kernel.org>
Date: Tue, 09 May 2023 14:41:42 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: H5D23IH4FZDFII36FELCQJGEIOK3AHUU
X-Message-ID-Hash: H5D23IH4FZDFII36FELCQJGEIOK3AHUU
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H5D23IH4FZDFII36FELCQJGEIOK3AHUU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 08 May 2023 18:16:36 +0800, Shengjiu Wang wrote:
> There is error message when defer probe happens:
> 
> fsl-micfil-dai 30ca0000.micfil: Unbalanced pm_runtime_enable!
> 
> Fix the error handler with pm_runtime_enable and add
> fsl_micfil_remove() for pm_runtime_disable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: Fix error handler with pm_runtime_enable
      commit: 17955aba7877a4494d8093ae5498e19469b01d57

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

