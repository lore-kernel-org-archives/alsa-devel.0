Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61832C30653
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:20:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34E6FE7F;
	Thu,  4 Jul 2024 19:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34E6FE7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720113643;
	bh=QsRR+QkcQnz+CcB5BiL0FhB+Lkjx7vr/PorGDV4G7Fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kAO1oCsyck3GZtMcN3/Ig3aUSQmpVCmdL+bJQRD2vw7lLvw/SIBLTUecIhIgABVlj
	 V4L05joBe1yKnLSAT/cJJK92KEL/QCXTyAjydexSe/sWwPCtrBcq8E10J5EWIKsXwO
	 9ItnS1m5VTZZ21p7io8Sagdlea7knRGhvZaeedgM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD633F805BD; Thu,  4 Jul 2024 19:20:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56EBDF805B4;
	Thu,  4 Jul 2024 19:20:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 371C4F80272; Thu,  4 Jul 2024 19:19:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C556F800FE
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 19:19:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C556F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Pggm54G+
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1D8C660347;
	Thu,  4 Jul 2024 17:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F1C3277B;
	Thu,  4 Jul 2024 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720113541;
	bh=QsRR+QkcQnz+CcB5BiL0FhB+Lkjx7vr/PorGDV4G7Fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pggm54G+30JWgXgOmjWhEMkylZ85ZrQ2guzoMflYeiVWSyioQytE9QbI8F2p8zksv
	 cF7hrVZIG6ksUCchvtggjv+pyaQu2aKJkF3Nn7Qfv3wbjgNRMac6mAOwLQPzA59N5Z
	 hKhbpej1rFD0Uf7YRvuwHXSHfeKcah76xWUzzU7e6GTvHQ1hFJ9xt8V546LKR9pMB1
	 UBiT9UI6tKDimcmOlZKiwfJMdfKNjYtTHqljYa+HdoGPGGhVs7Z/xXyuICPy021uiz
	 102Kiub4IhBGNT2OtvijwNt14Jqu6lPAv64vFxMsysBMyAWAeWV1+wckfjqEwd7vDv
	 oygMBssMoMXPA==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20240704085708.371414-1-pierre-louis.bossart@linux.intel.com>
References: <20240704085708.371414-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: fix null deref on system
 suspend entry
Message-Id: <172011354031.90743.5979596814986431326.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 18:19:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: ZOTXWKFNFTAOIWCEFMKVHIFLE463NSZJ
X-Message-ID-Hash: ZOTXWKFNFTAOIWCEFMKVHIFLE463NSZJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZOTXWKFNFTAOIWCEFMKVHIFLE463NSZJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 04 Jul 2024 10:57:08 +0200, Pierre-Louis Bossart wrote:
> When system enters suspend with an active stream, SOF core
> calls hw_params_upon_resume(). On Intel platforms with HDA DMA used
> to manage the link DMA, this leads to call chain of
> 
>    hda_dsp_set_hw_params_upon_resume()
>  -> hda_dsp_dais_suspend()
>  -> hda_dai_suspend()
>  -> hda_ipc4_post_trigger()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: fix null deref on system suspend entry
      commit: 9065693dcc13f287b9e4991f43aee70cf5538fdd

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

