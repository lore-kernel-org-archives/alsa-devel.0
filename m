Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D2EB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jun 2023 22:31:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AE1286E;
	Tue, 20 Jun 2023 00:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AE1286E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687213876;
	bh=ggV5dGReqx2CliDuDBzcUnnMkrhUzkfRPwClhzbhVKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OGtbGavEbj6hn/CDsGo8iE3TUreG58Lp+rB3Pz/HjJMNRJGanjBoDMylFE+VUZf/X
	 XHpzP3Bo7t1DUC15FX0FQz5N60bKZGJ9tyoNzPl6Q49evx1f5A8dFTz9kMJxOclPsC
	 jxZgUvE0I6sBrN0hcLYuDDbd3opNRC3wqLzKuCa4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E93BBF80564; Tue, 20 Jun 2023 00:29:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DBA3F80564;
	Tue, 20 Jun 2023 00:29:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C927F80169; Tue, 20 Jun 2023 00:29:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0FDC2F80130
	for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2023 00:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FDC2F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vCCGNyLw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7716560F19;
	Mon, 19 Jun 2023 22:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5353CC433C9;
	Mon, 19 Jun 2023 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687213749;
	bh=ggV5dGReqx2CliDuDBzcUnnMkrhUzkfRPwClhzbhVKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vCCGNyLwcD2Q6aYvYVAWKyAnoJsB4XA/dYqVxVMXvCeNGoseF7jZqzcund3FFm8II
	 HvDyk3iCK91pwL/Ywna/dzFaUwMF2TP8XUwQHYGknkwnqMo24mPiIAosKsFPklAyOJ
	 s1NTYXaA/3ds3eStCyydZmMpMgr8kWm+hh4ka2QxQ2w/O3ODBX/r5HnjrxY9kese5m
	 EJhImTmdgNwJ51f5L5VsZ/nRN3uAiB5hf4G5v1p3NBDqiwJbhsaTWIRG9Wdjbilz5Q
	 AFXCraWWjg9uwRgVHFCicg22UBywsVhOeji8JEFnqnQZixlcodqTyHSU0GM/P0dvgV
	 SOe/SCbGvP/eA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, YingKun Meng <mengyingkun@loongson.cn>
Cc: harshit.m.mogalapalli@oracle.com, krzysztof.kozlowski@linaro.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
In-Reply-To: <20230619074649.3608726-1-mengyingkun@loongson.cn>
References: <20230619074649.3608726-1-mengyingkun@loongson.cn>
Subject: Re: [PATCH v1] ASoC: loongson: change the type of variable irq to
 int
Message-Id: <168721374806.200161.17284971848100516046.b4-ty@kernel.org>
Date: Mon, 19 Jun 2023 23:29:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: 2ZMWX7WWHUQYRFQTUGHANYYGEZTM2RFJ
X-Message-ID-Hash: 2ZMWX7WWHUQYRFQTUGHANYYGEZTM2RFJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2ZMWX7WWHUQYRFQTUGHANYYGEZTM2RFJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 19 Jun 2023 15:46:49 +0800, YingKun Meng wrote:
> We use variable 'irq' to store the return value of fwnode_get_irq_byname().
> A negative value indicates that the operation failed. If the type of 'irq'
> is unsigned int, we never know if the operation failed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: change the type of variable irq to int
      commit: 1650e8a8818d516219b2c0cbc203f53cc6cd77a0

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

