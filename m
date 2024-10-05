Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E06CF8869
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2024 03:52:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0E6B827;
	Sat,  5 Oct 2024 05:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0E6B827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1728100357;
	bh=xnB03o5wj5wkk+9w0FLxKpxojhy1VFJSSIfAcXclIOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gDTAuRA60I8SYBIip4GxIZyDBRW2wJe8j55HZ1Yr4UBG837CaEq5i27O2oEehi2P/
	 p8AvrnhO1C4Ptdcsy6dah9zzydsX/pZ9e1SMzh6IXXH+dpIG4pFeuWYbbN3UtnL/9y
	 0B5OM4W7bqWbeeLEDlDcoJkRiyDXUvunPaAWZaQQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 078ADF805F3; Sat,  5 Oct 2024 05:51:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E7F2F805FD;
	Sat,  5 Oct 2024 05:51:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 026CFF80517; Sat,  5 Oct 2024 05:51:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D2B7F80107
	for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2024 05:51:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D2B7F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L+vn+RW4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B9B65C5D6A;
	Sat,  5 Oct 2024 03:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76559C4CECF;
	Sat,  5 Oct 2024 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728100284;
	bh=xnB03o5wj5wkk+9w0FLxKpxojhy1VFJSSIfAcXclIOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L+vn+RW4m7vTnlDWpM6dhmh6kl6uSlhKXTvZTL8kgKxSlVTmM7K+LUmnAqPoyhSrE
	 mxiZRDPOR4kWv13mNhxmqTHa7dEGj8ZP5KeYMKBJ75K78L+aA/gW/KWonHWK+hbhK1
	 AfVwQ18grQRL6bVsZvFTlNjkp/QQ6yQT0ObsOt9Z4J83PfByfe/ls3AZXwugObDyQI
	 Ea9YIQCTgQ5W9pHTHxDxmN8LnLyCAzv1X6Lzch4zAykHeOepSz1VBh0vt6IAiXAIb+
	 Xc6E1I0I52o6TKwj41lk7p0CapnYRz5hBhX5bT9xVzoX9t76BFL+S0Z52kc15rRnBr
	 Rhg075je05X7A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, hayashi.kunihiko@socionext.com,
 mhiramat@kernel.org,
 =?utf-8?q?=28=ED=95=99=EC=83=9D=29_=EC=9E=A5=EC=9D=B8=EA=B7=9C_=28=EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EA=B3=BC=29?=
 <ingyujang25@unist.ac.kr>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: 
 <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
References: 
 <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] sound: soc: uniphier: Handle regmap_write errors in
 aio_src_set_param()
Message-Id: <172810028220.832098.12998489877950324784.b4-ty@kernel.org>
Date: Sat, 05 Oct 2024 04:51:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: SL6H3WEBEPHDDGRCOIAOS7UTLYV7LWKY
X-Message-ID-Hash: SL6H3WEBEPHDDGRCOIAOS7UTLYV7LWKY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SL6H3WEBEPHDDGRCOIAOS7UTLYV7LWKY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 26 Sep 2024 21:15:18 +0000, (학생) 장인규 (컴퓨터공학과) wrote:
> The aio_src_set_param() function did not previously check the return
> values of regmap_write() and regmap_update_bits().
> If these functions fail, it could lead to silent failures when
> configuring the sample rate converter (SRC), causing improper behavior
> in audio processing without any indication of an error.
> 
> This patch modifies aio_src_set_param to check the return values of
> regmap_write() and regmap_update_bits().
> If either function returns an error, the error code is propagated back
> to the caller to ensure proper error handling.
> This change aligns with the existing error-handling behavior in
> functions like uniphier_aio_prepare(), where a failure in a sub-function
> should result in an immediate return of the error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: uniphier: Handle regmap_write errors in aio_src_set_param()
      commit: 23fa0b04d3fd4b8277083e9a8abb1a975a05c837

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

