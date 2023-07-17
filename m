Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4009EB64DC
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jul 2023 22:01:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 279F6850;
	Tue, 18 Jul 2023 00:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 279F6850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689631266;
	bh=OWdGYkH1Y1wnTjNRzoIEt/5CVyG2Gp3bhfXqsNkoW0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MpKM6MtRhe1Ymp9MQsIUbffvUSzPLuU3OAFl8dtEnuju2LUT9U56ySfUQ18LWhf6j
	 ce/+5DN5u7iC5bK4y2VnWp4tBAwn/QGK1/9cvrq52JkivcY6SiLLcDyy7vKlmIM0Vm
	 xDMNX5YpD2YTaGdImFJ48TH6MZxOiBx7vxr955PA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2B3BF80535; Mon, 17 Jul 2023 23:59:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A902F8007E;
	Mon, 17 Jul 2023 23:59:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90725F804DA; Mon, 17 Jul 2023 23:59:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09657F8007E
	for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2023 23:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09657F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NDRrpCzx
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 626EE612AF;
	Mon, 17 Jul 2023 21:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7A9C433C8;
	Mon, 17 Jul 2023 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689631174;
	bh=OWdGYkH1Y1wnTjNRzoIEt/5CVyG2Gp3bhfXqsNkoW0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NDRrpCzxZK/xlB9IdhsJCV4cGza+0iHlqW6RUVfMWZhecHzkSehwR0EMqqACY5PPS
	 Tj84brPayTvK+JmCFrMAbAr0AtHOmOPqMPDcCecfoMMFeuLBUh0MXvzEFHg75LR6Sp
	 9MKOr3JJNEvxOv2q/hmpEcEgd6jn4LSlDA3ZcLeb4R/QWl9nTMazRSpMXeHb65NXEH
	 Ecc3yV7A1ZBJPpae+ymy4Z45uH5T775qrCJyS9txlaT5clcv9usUw8zIF4gumgWzHG
	 zEz3j/Tcoj7R6r5Bv2FZazbPYM2y0iLzjPzgCXci43p8Pv7IG/x9EHZp8UX8O+p2Fy
	 6LaFK4dLMRmOA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Yangtao Li <frank.li@vivo.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230711034846.69437-1-frank.li@vivo.com>
References: <20230711034846.69437-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/5] ASoC: bcm: bcm63xx-i2s-whistler: Convert to
 devm_platform_ioremap_resource()
Message-Id: <168963117327.522208.7041227342789834630.b4-ty@kernel.org>
Date: Mon, 17 Jul 2023 22:59:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: WF6PYNRSKMXM5IOMJASJM524PWHTTX6Z
X-Message-ID-Hash: WF6PYNRSKMXM5IOMJASJM524PWHTTX6Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WF6PYNRSKMXM5IOMJASJM524PWHTTX6Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 11 Jul 2023 11:48:41 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: bcm: bcm63xx-i2s-whistler: Convert to devm_platform_ioremap_resource()
      commit: 7562539e15f1376577d7b62e904b509d17c4bc3f
[2/5] ASoC: ti: Convert to devm_platform_ioremap_resource_byname()
      commit: c8b04f008fc33ab2b902a1780c205810d157c849
[3/5] ASoC: mediatek: mt8186: Convert to devm_platform_ioremap_resource()
      commit: e1537b59633cc0e30305e498ba9eead45e762910
[4/5] ASoC: pxa: Use devm_platform_get_and_ioremap_resource()
      commit: 97b19db1cfb34303101a3f30c26ef0e2ede07d89
[5/5] ASoC: tegra: tegra20_ac97: Use devm_platform_get_and_ioremap_resource()
      commit: 976201dd5f597b7c25b9fc5ebeee382b5e6bf8fb

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

