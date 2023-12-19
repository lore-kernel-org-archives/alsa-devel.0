Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80429C41535
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA06D844;
	Tue, 19 Dec 2023 17:06:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA06D844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703002013;
	bh=dFfTW4Ywg/AnVhHHspPjP/ls8JhEBJSKWAKuZw3hh00=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=W9/9LYED+IYxxea5pxtemPPIowAPeJUlfLIx+N0+XEvGrs+DOdS66L2Ae2meA2AwJ
	 HRLGP8aMdO4kuz7ffrTRjzP/27pewePxq1j08L+xRePQnElB/9W944xfg++avK80Hs
	 fi1xm2iDutmXuBzEVIAGEt6EMS+r0mt5vUb1EfhM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79BD9F805CB; Tue, 19 Dec 2023 17:06:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 045ECF80580;
	Tue, 19 Dec 2023 17:06:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6CAD6F80212; Tue, 19 Dec 2023 17:05:57 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4741DF800D2
	for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2023 17:05:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4741DF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EZwCGzKC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B8D2961403;
	Tue, 19 Dec 2023 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394FBC433CA;
	Tue, 19 Dec 2023 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001943;
	bh=dFfTW4Ywg/AnVhHHspPjP/ls8JhEBJSKWAKuZw3hh00=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EZwCGzKC1l35Wk38SgOiMAWDej7vsInLJWFf/Frx6JArZxgiihEL+axeTVAJsz8T9
	 BF2WyoDd3J8XObr7sn6XbhFCj1GaPxJvsuOB26BoXIGsM5dqyxOEDgwtZpxIoN4wwi
	 Oau/Dh7rsZIAH7WPof7tDf+Y1jGRB0L/WgyF5mMM6P7cOcok1IMlwib1ptQK178ZCz
	 wb+qf/ORQBpg1stzbdAc6tDWW4c8dxskTSMSnScN/3C73rgJFvyPbCXNHFHnGDEv6A
	 1EuZx2G/QCEhRZ/HFwGlwV/SZNullZWiCAkrbsClFSf3rJdxOHoipDbqoN3QooPE/Y
	 ZLIdkrUJ5KF4w==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
References: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
Message-Id: <170300194095.59057.18227409280630031139.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:05:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: XXFPQVHXAIYY4GEIUAVQCMDKIGSZEBE3
X-Message-ID-Hash: XXFPQVHXAIYY4GEIUAVQCMDKIGSZEBE3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XXFPQVHXAIYY4GEIUAVQCMDKIGSZEBE3/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 19 Dec 2023 10:30:57 +0800, Shengjiu Wang wrote:
> When flag mclk_with_tere and mclk_direction_output enabled,
> The SAI transmitter or receiver will be enabled in very early
> stage, that if FSL_SAI_xMR is set by previous case,
> for example previous case is one channel, current case is
> two channels, then current case started with wrong xMR in
> the beginning, then channel swap happen.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
      commit: 8f0f01647550daf9cd8752c1656dcb0136d79ce1

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

