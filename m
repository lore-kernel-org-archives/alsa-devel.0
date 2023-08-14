Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF51CEB64DD
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 00:34:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C439B827;
	Mon, 14 Aug 2023 02:33:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C439B827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691973281;
	bh=BSOgeaaa/rkDTCUeAcW/EfLZzcXl6AUS4RHq7HRWbzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D1ymZrUyKgGQkinTPg/wpnbT9WvJNTpUS2pF4eeaoVVSnK0yvGOS5BNuYOJYQDbiC
	 JGSm0V0nvYKSsir/vLujl4MyEoLBJ+buTsDsBELxD0zXkt2YWe0Vx69P7mFiIZUE/u
	 EwAIHvvZLW4FC/g51wqV5ucFOksxYD+On7LPKfHE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D7DAF80551; Mon, 14 Aug 2023 02:33:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81FA2F80074;
	Mon, 14 Aug 2023 02:33:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64B5EF80290; Mon, 14 Aug 2023 02:33:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01E9BF800EE
	for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2023 02:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01E9BF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=crg3fayL
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7B25D625F2;
	Mon, 14 Aug 2023 00:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF27C433C8;
	Mon, 14 Aug 2023 00:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691973196;
	bh=BSOgeaaa/rkDTCUeAcW/EfLZzcXl6AUS4RHq7HRWbzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=crg3fayLrBYlTGWmu4Kiafg1CjqODXSB/BJxgoTyAai/oplmBo98RRBJ+t4oBlYuy
	 j1odiZzt/5jUTVEBkAdA1wP8KLvNNxIJSZrggTSPGcOFu3yA4hCbHrlgFJV5ch4QTQ
	 YXaeKZhVaX+X9TM3LlcA/F2J0ItBAMseaC1gLL/S/VZYYvl8d9djDApYTcohO7YJTj
	 EXKkhwX4T/xV9voyL4AUVPuPfPX/abiYSH2jIPjwcbHYSut2NZGJS8TbvAFldQ9lcX
	 fBW0ABZJqTFZOkE6/eDDeAyXxtlQ4i27GCdh5QLzursp4hD+JP7DyR5Uq08SSnZJZi
	 8p/g5PlrHeBaQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, rjui@broadcom.com,
 sbranden@broadcom.com, Yue Haibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230811110021.31656-1-yuehaibing@huawei.com>
References: <20230811110021.31656-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: cygnus: Remove unused declarations
Message-Id: <169197319402.2741913.18936577918580743.b4-ty@kernel.org>
Date: Mon, 14 Aug 2023 01:33:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: 2PO6GSPYJPUUUM3VLIDRFNPHRSBRPNGM
X-Message-ID-Hash: 2PO6GSPYJPUUUM3VLIDRFNPHRSBRPNGM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2PO6GSPYJPUUUM3VLIDRFNPHRSBRPNGM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 11 Aug 2023 19:00:21 +0800, Yue Haibing wrote:
> Commit a6ee05d94e8f ("ASoC: cygnus: Add Cygnus audio DAI driver")
> declared but never implemented these.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cygnus: Remove unused declarations
      commit: 8acf4de30668a5a1517f99f26df31d57593a548e

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

