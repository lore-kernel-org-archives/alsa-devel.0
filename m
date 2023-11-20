Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F09FC197A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 16:34:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1803ABC0;
	Mon, 20 Nov 2023 17:33:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1803ABC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700498040;
	bh=Eg3tImi0mkQCJ6HTRCQEvLgTbOvveHdT1JhyGy7bH0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OP2ASAFnSbFUTuVnO/BBtZnm1vArUOFsTF14/3ANKoErSGd5IvWLF6BbLN83i6IXb
	 0w0BhYQRxBfBBm6RoyWAMcGDj6ESc2y4IgwT/+mU1XH9u8d5hedwZL2/byjXFCJdn5
	 2w/ZxDrm+jOxr6QAwvD7nCSVkTvFIGVEnLMUbeeU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47106F80310; Mon, 20 Nov 2023 17:32:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42E41F80254;
	Mon, 20 Nov 2023 17:32:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C392DF80254; Mon, 20 Nov 2023 17:32:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD7C9F80093
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 17:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD7C9F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HUHEghF6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 899B56131B;
	Mon, 20 Nov 2023 16:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E810C433C7;
	Mon, 20 Nov 2023 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700497945;
	bh=Eg3tImi0mkQCJ6HTRCQEvLgTbOvveHdT1JhyGy7bH0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HUHEghF6E+qzSd15aJUyYWeSJUKsr1IzS9i9+xZxN4m8pOdmEhBkgF/ISiGsBlND+
	 dCcapm+e1iIIJnU51NzBR3P2CPc1AO2o08miWDdxmUJikvKrUFmPlioKQXTKcFuayc
	 cKOxL4Rqeg22g3QB+syVToGk/e9mVk0uTjfnjWXTqGIuOhodjPLJGcKNEfpO/QUm6B
	 +3tMTN4WAErI05g0qQzuQvCJVjmtRgAiCreuUUVcb0DTKKB5xLdkjVXMdOBzhm92QT
	 Tp54ztVpTQ3lXxbn6EGSAXN3XJK8wX26PYZzvO79/IgAIlcDEV9scCG9r0BYNo1PZd
	 3emMAV6c/euTA==
From: Mark Brown <broonie@kernel.org>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1700474735-3863-1-git-send-email-shengjiu.wang@nxp.com>
References: <1700474735-3863-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix no frame sync clock issue on
 i.MX8MP
Message-Id: <170049794283.439381.10112729019532929436.b4-ty@kernel.org>
Date: Mon, 20 Nov 2023 16:32:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: LKLMHLMEZSYARERNQ5IPWSXCCEHM5W5V
X-Message-ID-Hash: LKLMHLMEZSYARERNQ5IPWSXCCEHM5W5V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LKLMHLMEZSYARERNQ5IPWSXCCEHM5W5V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 20 Nov 2023 18:05:35 +0800, Shengjiu Wang wrote:
> On i.MX8MP, when the TERE and FSD_MSTR enabled before configuring
> the word width, there will be no frame sync clock issue, because
> old word width impact the generation of frame sync.
> 
> TERE enabled earlier only for i.MX8MP case for the hardware limitation,
> So need to disable FSD_MSTR before configuring word width, then enable
> FSD_MSTR bit for this specific case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix no frame sync clock issue on i.MX8MP
      commit: 14e8442e0789598514f3c9de014950de9feda7a4

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

