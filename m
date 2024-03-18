Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1749C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:07:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 136832235;
	Mon, 18 Mar 2024 18:06:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 136832235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710781622;
	bh=RMu+UgtWOoWOd40qpPWbxTK8o8oT/Dhw5wdWdscpVC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lE60RYAPGqGE+fEOVG8+srM9r/C+SbMUMSdNxzqrwtcQrOAL9k4JWACEvO8Xnvir9
	 trxKU8ip3ux+Eto8uewhP/kHkCzvr37dFervjmygC7BwdC5RktcdamRmLphLiTYmvI
	 fADI56oSBun0v/DwRI8ShK84YvTcllqYy/+JA4OU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC487F805AC; Mon, 18 Mar 2024 18:06:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED54AF805AA;
	Mon, 18 Mar 2024 18:06:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC2FAF804E7; Mon, 18 Mar 2024 18:06:15 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5AC2F8010B
	for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2024 18:06:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5AC2F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=I3vdb6NI
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 54D33CE0AF4;
	Mon, 18 Mar 2024 17:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF234C433F1;
	Mon, 18 Mar 2024 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710781558;
	bh=RMu+UgtWOoWOd40qpPWbxTK8o8oT/Dhw5wdWdscpVC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I3vdb6NIMZ5k+EUETXe6wgll2bT6s8O/DyFEwdaUsYB6Tvi7eEra8o3xggZUqaPXR
	 M3fVj4aLzWkJ4l2/hILhc+deIAZspqYnePzG6WhsWLxszVZhJHbJT0IEURAFJcX6xM
	 2IRUFPgTwYaojNdxc1j7Eg3zQTXbtxGA/5u8K71ynodT8qiYClwJLMecygIDAi7xNT
	 PZF+iusEQBUUxkUB3UahjC6F/Um1NhsKWWcoTZRCK1f7AJI0+XsvnUnUA3hkkbTz/N
	 ryjgHqSaxFGvLIda7/nai9BM/FQnaVYBTdMOqxzUxQ/nZ9I6dR2XCsgiPj9DrWDO8L
	 HPEeFAmSsdFrA==
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Raghu Bankapur <quic_rbankapu@quicinc.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shalini Manjunatha <quic_c_shalma@quicinc.com>
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
Subject: Re: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM
 locking
Message-Id: <171078155643.88150.1151704190402668326.b4-ty@kernel.org>
Date: Mon, 18 Mar 2024 17:05:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c
Message-ID-Hash: KPNUGCF32E6MEFJCRLHA6GE7U24TK52D
X-Message-ID-Hash: KPNUGCF32E6MEFJCRLHA6GE7U24TK52D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KPNUGCF32E6MEFJCRLHA6GE7U24TK52D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 06 Mar 2024 16:23:19 +0530, Shalini Manjunatha wrote:
> We find mising DPCM locking inside soc_compr_set_params_fe()
> before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
> which cause lockdep assert for DPCM lock not held in
> __soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
> when ever we play compress offload audio playback use case.
> 
> To fix this issue added DPCM lock and unlock in both places of
> above code flow mentioned.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Fix and add DPCM locking
      commit: 9a8b202f8cb7ebebc71f1f2a353a21c76d3063a8

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

