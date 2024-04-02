Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B562CD1284
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 20:47:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6C0B2C53;
	Tue,  2 Apr 2024 22:47:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6C0B2C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712090853;
	bh=fI/CaMVBYChveJa/iIQLP89C++1G/8BlVLsm+Ayr/qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Pjh8xd6NZ6P+rWG32EZfbK6NX9ZLku8pteybkY46eeqEAJcM/9muNxlOBSqM8cmmr
	 Gb9FsaBiKLGCWBNr7g2dRjGVO2EOhkX39pcswlu67FzGvZvogfCv5Q/Y/N+usFrSAf
	 Gpv0nJ+ICp9f4eJrXDLgSNFLLMIr2Tu+FumbGPUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C81DFF80588; Tue,  2 Apr 2024 22:47:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ADC93F80236;
	Tue,  2 Apr 2024 22:47:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E295F8020D; Tue,  2 Apr 2024 22:46:56 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8F7C8F80007
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 22:46:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F7C8F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fCF5/n50
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C4201CE1DD5;
	Tue,  2 Apr 2024 20:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7AFC433C7;
	Tue,  2 Apr 2024 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712090804;
	bh=fI/CaMVBYChveJa/iIQLP89C++1G/8BlVLsm+Ayr/qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fCF5/n50GPp1hbVO131ye2u/sS6GvlY8k/8bg8Xb1HG27VHBlv6cDJhQ+ETcXBhp+
	 XmBSdGYNul1YPgF9TVjYNLNYO43YHz7aCfD4JiniFhOEh4A393YRbJGUZheerOhCk2
	 9YACfU81HlScYnYG4kVa2tLr7ypgbml6ky9QjCVmddIgGqybhTSXa60tK5N2C0Dp+k
	 4Baj+egZTm1T/aZgA3ZQfv5c/s4TNgHjuZO/NNs8KxnhFcemhayun9gTcktFYjlqaH
	 snGgJMIVDo7+at2NMYST9gIxRLNzv//kxrNzIJczPaX+IoGUUR9uzKoOoZZQqovy1r
	 fUUuJs+1s2dcA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Zhang Yi <zhangyi@everest-semi.com>
Cc: tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
 yangxiaohua@everest-semi.com, zhuning@everest-semi.com
In-Reply-To: <20240402062043.20608-1-zhangyi@everest-semi.com>
References: <20240402062043.20608-1-zhangyi@everest-semi.com>
Subject: Re: [PATCH 0/4] ASoC: codecs: ES8326: solve some hp issues and
Message-Id: <171209080263.207842.1668928934082850047.b4-ty@kernel.org>
Date: Tue, 02 Apr 2024 21:46:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: KXNX55ZL35M6NXRCYAX5BZWUDBBXOZVA
X-Message-ID-Hash: KXNX55ZL35M6NXRCYAX5BZWUDBBXOZVA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KXNX55ZL35M6NXRCYAX5BZWUDBBXOZVA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 02 Apr 2024 14:20:39 +0800, Zhang Yi wrote:
> We solved some issues related to headphone detection.And for using
> the same configuration in different power conditions,we modified the
> clock table
> 
> Zhang Yi (4):
>   ASoC: codecs: ES8326: Solve error interruption issue
>   ASoC: codecs: ES8326: modify clock table
>   ASoC: codecs: ES8326: Solve a headphone detection issue after suspend
>     and resume
>   ASoC: codecs: ES8326: Removing the control of ADC_SCALE
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: codecs: ES8326: Solve error interruption issue
      commit: 8a655cee6c9d4588570ad0cb099c5660f9a44a12
[2/4] ASoC: codecs: ES8326: modify clock table
      commit: 4581468d071b64a2e3c2ae333fff82dc0391a306
[3/4] ASoC: codecs: ES8326: Solve a headphone detection issue after suspend and resume
      commit: 6e5f5bf894eb9260f07ad0da4e2dd2efd616ed59
[4/4] ASoC: codecs: ES8326: Removing the control of ADC_SCALE
      commit: fec9c7f668ac5dd107f4da5a3b18379e07ec1a41

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

