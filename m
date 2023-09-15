Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C37EED616
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 16:15:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A529F846;
	Fri, 15 Sep 2023 18:14:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A529F846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694794509;
	bh=iNKMq8pQmi1xurRTgo9Yv30Q912F1svy9/M2MmUxALg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=b4FyvWhGV5Lp4Y/4QDeceFoFR5xzFc5q1B9nCq7gi9l9yln6dhqjpeZld5xOLWjuE
	 AIEJJ0KeXkSIBZ9bl+a3fyeNqzfgQCrx8IvCnLLGgioMTP8p5VLQPmI9aYJcTlC+fI
	 aaF6NaX9Yq2cdgNLNIMbiClFJNoPSyXjzp5CiyUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5C57F80537; Fri, 15 Sep 2023 18:13:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D7E8F80425;
	Fri, 15 Sep 2023 18:13:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF381F80425; Fri, 15 Sep 2023 18:13:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3EA4CF801F5
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 18:13:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EA4CF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B0CxjdTm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5811D620E5;
	Fri, 15 Sep 2023 16:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DEC433C8;
	Fri, 15 Sep 2023 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694794412;
	bh=iNKMq8pQmi1xurRTgo9Yv30Q912F1svy9/M2MmUxALg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=B0CxjdTmKQ3QyOnISup33+DTuKAuN7MOookDWNbwjVRVmOgorLjl6x+gzqYLRqXDS
	 ko4kjD3Y+1rkBa5dlqyMQq/WIf0OAbx91itA8T5pw8B+lpwydmgXJNfc3LpQyXJhQE
	 fMgPe7BlStiajx885jBtB0IjwLflfHCsH6Wxe5WUoj/8EgxjYY4Tzm9SMG0YZCKX16
	 hGDc9dlE7mBiEuQHM3P1v73RPWmkRK8s/LVTwGF0R10gQl935X6ijsunkeK561BA9g
	 xhveRZFOnKWYSNn2bOaHZw8zBLU0lWswGHDgKWGC35lezyqDmSeJ998M58f8JkrTF3
	 NMY27gWpd9RJw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
References: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-audmix: Fix return error with devm_clk_get()
Message-Id: <169479441018.352295.3740215215305425642.b4-ty@kernel.org>
Date: Fri, 15 Sep 2023 17:13:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: K3QWOEQFTXCOE6ECN4R2NLT7EDE3N5CJ
X-Message-ID-Hash: K3QWOEQFTXCOE6ECN4R2NLT7EDE3N5CJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K3QWOEQFTXCOE6ECN4R2NLT7EDE3N5CJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 Sep 2023 14:02:11 +0800, Shengjiu Wang wrote:
> The devm_clk_get() can return -EPROBE_DEFER error,
> modify the error code to be -EINVAL is not correct, which
> cause the -EPROBE_DEFER error is not correctly handled.
> 
> This patch is to fix the return error code.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmix: Fix return error with devm_clk_get()
      commit: b19a5733de255cabba5feecabf6e900638b582d1

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

