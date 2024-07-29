Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6553DC3DA61
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jul 2024 18:30:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DB91843;
	Mon, 29 Jul 2024 20:30:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DB91843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722277840;
	bh=feFjL61VY6k6DILxtWSL1BYBFj1CfxSdHr6gcy+dSH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uhx20xILxjlfp6OrkN4Gx3CenpmWwz79fCd7FQy4L1pk6ZoBSqM0/S8slW3wQHC6e
	 BaYNu+sUx8U3LBauDunA27zORfX/yaKpm9dAHRo+05UmC0I1i+Rf/RkA/ZAxhT9yJX
	 OTJPt6DzHwk/M/I5XP1QiFIQtuZvVmxa+8tSm+ZA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEC56F805BD; Mon, 29 Jul 2024 20:29:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DA9B6F805E3;
	Mon, 29 Jul 2024 20:29:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81662F80579; Mon, 29 Jul 2024 19:17:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E68EAF8007E
	for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2024 19:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E68EAF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qrkGTrFM
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70FDC61B8D;
	Mon, 29 Jul 2024 17:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45E4C4AF09;
	Mon, 29 Jul 2024 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273458;
	bh=feFjL61VY6k6DILxtWSL1BYBFj1CfxSdHr6gcy+dSH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qrkGTrFMdGi2XRKS52G1LE7tfUAx+XFh1wIiplavzpbVCfJUDZYkXOrddmJea4SWK
	 QjfBVR9Vq9TKyR6J3tC1gx9aJpbt/dX8eB+EJu/D4PQbX88YCtaPNfhk796O5fCVSX
	 VhRBQZL9DxpgPwt/iuc9pm27U1wOCRH4gBnzETcYFncJgbvq+AJ9JuWoeyPK4a4QRP
	 XPLIfLg+rSuVCo9vsoGf6jHRgoDcspXMGQb/e0X+Zvf56Az3m1OL0KQ3PF/BVaOf8w
	 rcy+gr6oGHTwQUCM4H1EubJhqevKcgPwW4NfN5lDf8bvART9Fiah6rT7v5ptEZDVFa
	 tRuGCr00SzCBA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Zhang Yi <zhangyi@everest-semi.com>
Cc: tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
 yangxiaohua@everest-semi.com, zhuning@everest-semi.com
In-Reply-To: <20240726031002.35055-1-zhangyi@everest-semi.com>
References: <20240726031002.35055-1-zhangyi@everest-semi.com>
Subject: Re: [RESEND] ASoC: codecs: ES8326: suspend issue
Message-Id: <172227345665.109775.4878116647111928082.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: TW63GNVSI2ZGFCSJ3MOQO4XDCT4KZA6H
X-Message-ID-Hash: TW63GNVSI2ZGFCSJ3MOQO4XDCT4KZA6H
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TW63GNVSI2ZGFCSJ3MOQO4XDCT4KZA6H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 26 Jul 2024 11:10:02 +0800, Zhang Yi wrote:
> We find that we need to disable micbias for the codec to enter suspend
> So We modify the trigger conditions for enable_micbias and disable_micbias
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ES8326: suspend issue
      commit: 6024f3429fd1ac4948bac9610ecd4d0139088f0b

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

