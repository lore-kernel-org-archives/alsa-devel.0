Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CCCD611E
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Oct 2023 18:38:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4CFCEE7;
	Mon,  9 Oct 2023 20:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4CFCEE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696876726;
	bh=+QPgU7tZbSjlQmBiszLV/gnTedCkn+UeSkKgZ9idR64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VCtXlyKj7AjIbsNgbo1MJMcBCjY710RFyHtkSFUgq+RWPIHqe+rT3/EzMYItwwHGe
	 3BPq6mZoa87YZI930RzaDlO80Yp6mREDvJ0qHG6Nm0xGK6cui7Tr9566u9ggnCHAU5
	 L2PReUSxgDc8BaXaMotqgcfPX3bJ9vTGZ5UnMzuI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C787F805A0; Mon,  9 Oct 2023 20:36:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F14E5F805A0;
	Mon,  9 Oct 2023 20:36:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EE01F80310; Mon,  9 Oct 2023 20:36:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 317C3F802BE
	for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2023 20:36:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 317C3F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HLmYl8yZ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 307FE61313;
	Mon,  9 Oct 2023 18:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B6C433C9;
	Mon,  9 Oct 2023 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696876586;
	bh=+QPgU7tZbSjlQmBiszLV/gnTedCkn+UeSkKgZ9idR64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HLmYl8yZrRs0G/Gqaiaz/D17bfLM+vyMebeuSGyKhdBjifE8CfnY8RG60C/OoC0cL
	 HkwecJvwi1H6ATEJpvHoLR7oDXFfAusKzgDvdFIVGF6+spiH6zA2BVgl4WYrt5JTw/
	 KGj2KuMWyMa1y+XeJSX+lfiDwT8zWHF3dQkZU1/1io0Y+DwkDCKCbVZQhmle38Lyy2
	 qbbaWvaPQ9Gh6uDE2DkgCI1hRT2EioNC5rkOiSgzC3wcGriwknptLpnlNvb36tIyBy
	 er9tmGpSet75PSLVl1X4b8Mkx9etSi16npbEb7JD2PYHXTAxRpJeQBsXU07qv8z4o9
	 XJWc1Kh6NQ9ug==
From: Mark Brown <broonie@kernel.org>
To: Daniel Mack <daniel@zonque.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
In-Reply-To: <84ac2313-1420-471a-b2cb-3269a2e12a7c@moroto.mountain>
References: <84ac2313-1420-471a-b2cb-3269a2e12a7c@moroto.mountain>
Subject: Re: [PATCH] ASoC: pxa: fix a memory leak in probe()
Message-Id: <169687658335.138823.2904268371010439072.b4-ty@kernel.org>
Date: Mon, 09 Oct 2023 19:36:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: YEZO2VPCOQZJDI3GGTGZD6G2YUIGEBR4
X-Message-ID-Hash: YEZO2VPCOQZJDI3GGTGZD6G2YUIGEBR4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YEZO2VPCOQZJDI3GGTGZD6G2YUIGEBR4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 05 Oct 2023 17:00:24 +0300, Dan Carpenter wrote:
> Free the "priv" pointer before returning the error code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pxa: fix a memory leak in probe()
      commit: aa6464edbd51af4a2f8db43df866a7642b244b5f

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

