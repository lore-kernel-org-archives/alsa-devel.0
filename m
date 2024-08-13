Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D22C52D7C
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:51:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 061402346;
	Tue, 13 Aug 2024 17:51:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 061402346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723564274;
	bh=rsziEHP/+mLvNBlOON3UZ6Yo3R/yAwQ9GkBwk8w8g5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BVCcHk8ZqkStc/XmMIMb8CxCSaveR1Q/gAbR2HdTzL3ssVwG26Hd52+cobKX2Mfht
	 y4aWkW04p+dxCxZh9fSNgpXw+15aonRHkSfb6rI0hfjlv65DfsvSMONUN0ZC1XNBlD
	 0+2+x1ur7ML6K6hb0vCky3mMoT35kc9Wnjq4WUxw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9801EF800B0; Tue, 13 Aug 2024 17:50:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD423F805BA;
	Tue, 13 Aug 2024 17:50:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E30C3F800BF; Tue, 13 Aug 2024 17:39:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B205CF800BF;
	Tue, 13 Aug 2024 17:38:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B205CF800BF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q00kgZGs
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A3AD61775;
	Tue, 13 Aug 2024 15:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE917C4AF0B;
	Tue, 13 Aug 2024 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562380;
	bh=rsziEHP/+mLvNBlOON3UZ6Yo3R/yAwQ9GkBwk8w8g5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q00kgZGsYj1y49e049T5MON3QZYB+/8iHm5YTS91WCfUPee3QTbjwW084sff0BMjh
	 Rkjai0s/iXiwYdag9p22P3EpXE/WHPNEPnm55ebFnys54yi5/4RPQXoejp5kfHIFqC
	 VBfMSuUT66Ne6wO5p3aGrMKp2quIxTvDUfn7ddmqPkRwyrJbt+ccwGowqK6tfaC88X
	 A/MtN9JDFHzNi2FLFDh3fK7CbafpITHEPHz/+Qn7UU7XDFcI6LjTE0nWYw+4J2Nv6H
	 88goqr9I+pM/kTYDGJ7/zNWHieaPfrDNPbQ78G3rgHrFIyXNoc3EO08RtLjuX1RqX6
	 a74niExdX3mKQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813080850.3107409-1-Vijendar.Mukunda@amd.com>
References: <20240813080850.3107409-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: add legacy driver support for ACP7.1
 based platforms
Message-Id: <172356237845.72636.13426868316582938253.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:19:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: VRQCVUQ77JYFL2BKEDOAAVEPFJGCIXWP
X-Message-ID-Hash: VRQCVUQ77JYFL2BKEDOAAVEPFJGCIXWP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VRQCVUQ77JYFL2BKEDOAAVEPFJGCIXWP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 13 Aug 2024 13:38:50 +0530, Vijendar Mukunda wrote:
> Add acp pci driver and machine driver changes for ACP7.1 based platforms
> for legacy stack.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: add legacy driver support for ACP7.1 based platforms
      commit: c6f3abbbdc99930f831d5c76dac32ddbd9b88fa1

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

