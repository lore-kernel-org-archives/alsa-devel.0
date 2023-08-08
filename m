Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017FC04A6A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 17:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D05E82B;
	Tue,  8 Aug 2023 19:57:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D05E82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691517512;
	bh=fxNUVsKaeQuDaNmEYFmUW5cF3Ql6fnpv65y8XNm1bAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G/vzswz9qfmG3j176yCwM8JHHJsaUcNC/mubF8HSk9n/+31ZoBOLpUkXoC1E9vLEQ
	 qt36ZXvQJwnqnH1y3QSnLAXrjHtVZZGP4MzpLJUcyuhBTlMqAuW2WgYIdhiSCoZl/W
	 E2A693dOiR7GhNvtQN2K6BcNomLg2LUq40DzqIao=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F20BF80552; Tue,  8 Aug 2023 19:57:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7F47F800FE;
	Tue,  8 Aug 2023 19:57:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9CC7F80544; Tue,  8 Aug 2023 19:57:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 82A56F800FE;
	Tue,  8 Aug 2023 19:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82A56F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MNGhQPbn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1172262920;
	Tue,  8 Aug 2023 17:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E78C433C8;
	Tue,  8 Aug 2023 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691517421;
	bh=fxNUVsKaeQuDaNmEYFmUW5cF3Ql6fnpv65y8XNm1bAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MNGhQPbnGp6RYTX1sEpHizYe9zXimTpDeHN2HC509+oaAGQzh3gHOIJ7z5fNlGz2C
	 0lrLNW45H80FGULM+RtltFSuLWQLW+UDfMdciKitUgubYl5sd8W7q73OcYpt5w7deh
	 w5tn+/c527nsl8vsCPcK8GW8R2csiVLzhMdfpNsvvIpWWUN7XuR3IcBGgvhzOf1UHY
	 K4+2Yrzq8mQ//n/vf9WztyTrhaeJ8SS/6b0jWs3Vn1ZoRAiAoCA51aANYkdH5VR7hP
	 i/p1TwZ2DZz0hHlOIx1gBmAvJpfk2i7H32h0b4Y5UwUP5Oc1yITjFOmkCpZcKbJb/J
	 9Xggof5moOD6Q==
From: Mark Brown <broonie@kernel.org>
To: sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
 Yang Yingliang <yangyingliang@huawei.com>
Cc: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20230725120247.509422-1-yangyingliang@huawei.com>
References: <20230725120247.509422-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: ipc3-dtrace: Switch to
 memdup_user_nul() helper
Message-Id: <169151741885.78353.12212893962339908389.b4-ty@kernel.org>
Date: Tue, 08 Aug 2023 18:56:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: BGU73DTB3ZX64KHQKKZDUMM7DVCONAWE
X-Message-ID-Hash: BGU73DTB3ZX64KHQKKZDUMM7DVCONAWE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BGU73DTB3ZX64KHQKKZDUMM7DVCONAWE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 25 Jul 2023 20:02:47 +0800, Yang Yingliang wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-dtrace: Switch to memdup_user_nul() helper
      commit: 93fd2be6eb80fe37570fbd87652ec07a4f7c5b5a

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

