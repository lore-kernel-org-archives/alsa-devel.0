Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB41C6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:52:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 823D52318;
	Tue, 26 Mar 2024 13:52:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 823D52318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711457542;
	bh=Hnsmw4cSlCWFWusJgFgXB9IFNQHqwcx52ZbhZkS1BMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SaFxSQ+L8VUpRwBHgWOUsraNF7kulNkbhYfAkWponyFmLgIVwUyTMQXg39ZDy8Sxo
	 Rk1MW016XwtEeJ7Dy2xObvACYxuAL57GAOdS1TNebnBxdcH0bY4hSrUuSoHy4pEh8u
	 ZDALQQIs/C1mEVcSumNN7+Gpe9ZWpc5qbHYzXbDE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69BBAF805C6; Tue, 26 Mar 2024 13:51:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34DC3F805D4;
	Tue, 26 Mar 2024 13:51:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42071F80093; Tue, 26 Mar 2024 13:51:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5EA7F80093
	for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2024 13:51:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5EA7F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sEPxM8BV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C39A36100C;
	Tue, 26 Mar 2024 12:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C07FC43394;
	Tue, 26 Mar 2024 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711457474;
	bh=Hnsmw4cSlCWFWusJgFgXB9IFNQHqwcx52ZbhZkS1BMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sEPxM8BVbQ07kjm4amF/00CiTgh1i2KSrruwCtk1gy5l57g81+eu/IVT1/qPM6PCt
	 6C7ar8Me3JW30/ZCq8HNP5Gxzu0Q5lFimE3pAh1S6KHchXGQygXkKp4MHyBcfCsHDB
	 aamnyV2tG/zleVfYnqAf6knJ9SMbX2+xb8LXr1U89fFxtf+dl57q6BG3o8zy1/m2KL
	 u43T+2gL2C5qq1jv4rxNcm9D5aGE88x4XKp6iPP0GfFEQsJz0ForRWeP+xAiqam/Sh
	 HMPA3Qal319cQxp+Hj/EWNEw+E+bJlDQIeOWAQr5oNUI5c4dCFpxCVWucPQ+4ouIEx
	 PETXvB7mo3aXQ==
From: Mark Brown <broonie@kernel.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20240325191341.3977321-1-andriy.shevchenko@linux.intel.com>
References: <20240325191341.3977321-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: fsl: imx-es8328: Remove leftover gpio
 initialisation
Message-Id: <171145746963.70451.9741731830919913816.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:51:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: XB7XI6AO2O66S3NU7AE3J7T4Y5W55IHZ
X-Message-ID-Hash: XB7XI6AO2O66S3NU7AE3J7T4Y5W55IHZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XB7XI6AO2O66S3NU7AE3J7T4Y5W55IHZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 25 Mar 2024 21:13:41 +0200, Andy Shevchenko wrote:
> The gpio field is not used anymore, remove the leftover.
> This also fixes the compilation error after the ...
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-es8328: Remove leftover gpio initialisation
      commit: 6a92834166b16babd70e99c3e0ce9262893ad6ae

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

