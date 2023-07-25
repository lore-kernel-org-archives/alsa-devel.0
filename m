Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75459C001DE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 16:51:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35492868;
	Tue, 25 Jul 2023 18:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35492868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690303863;
	bh=xy3Ze5YBX+iv50qQUIiI8+Gxg3wKHEvbLsS6Pzbm2D8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z0IAU0WluVNE3+7EZKTw0favanz5nvWow82YSFaEcHB6UpySehjPzfM2bwa6q6goT
	 ZsoNIY38zLTcEz1xQHxTRH3ujzmxzVicPlCdPpRnEaJky4Zupf5qL9vkhXM+Zag83T
	 418bhFZY9J8hvU7Z9cDrTCKA7VZ73GkxSb64yUQg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EFBFF80558; Tue, 25 Jul 2023 18:49:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76CB0F80549;
	Tue, 25 Jul 2023 18:49:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D11F1F801F5; Tue, 25 Jul 2023 18:49:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA4ABF80153
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 18:49:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA4ABF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GWq6Cxqo
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 79CD861804;
	Tue, 25 Jul 2023 16:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2380DC433C9;
	Tue, 25 Jul 2023 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690303754;
	bh=xy3Ze5YBX+iv50qQUIiI8+Gxg3wKHEvbLsS6Pzbm2D8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GWq6CxqoOPS4i08H5HuKEMFMTLHYRwbNN13/YpJYCknAKXCvCqk1Q7UYmJNNtIJTY
	 Cg4MOdWj/E6tZJ8BoDoSLg4wgQih5Hp20vjgxX1ATzrTUzYmi/mNI4GlKg3aJhcglL
	 p5ymNq3SzIQAaQLcJlWEfr+qTMIpUs35svVIAPGHhCB83Nvz2SS5Exktu1GqVlOOFJ
	 MZcecqQdtuQskRtB6ASS6Y9VmcUwBEQY6jAIdcraOQB+/GiV71yzOHub9VYvdCGHXQ
	 adSny97SnFTWSXMTXNEsPAmX9JuBXtkgXqcHQ2AzlhD4dqi30nYesWOhyev1UY3Cbm
	 Bj71N0eQm2unA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, derek.fang@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, jack.yu@realtek.com, shumingf@realtek.com,
 bard.liao@intel.com
In-Reply-To: <20230718084238.3692-1-derek.fang@realtek.com>
References: <20230718084238.3692-1-derek.fang@realtek.com>
Subject: Re: [PATCH] ASoC: rt1017: Add RT1017 SDCA amplifier driver
Message-Id: <169030375286.1462400.16076827880447479234.b4-ty@kernel.org>
Date: Tue, 25 Jul 2023 17:49:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: D3X4FVKRQYADBWCZ2G2UMGGM6N55BUB5
X-Message-ID-Hash: D3X4FVKRQYADBWCZ2G2UMGGM6N55BUB5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D3X4FVKRQYADBWCZ2G2UMGGM6N55BUB5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Jul 2023 16:42:38 +0800, derek.fang@realtek.com wrote:
> This is the initial amplifier driver for rt1017 SDCA version.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1017: Add RT1017 SDCA amplifier driver
      commit: 2b7aecd58528551e6e3da58091ff7ceb4718e6be

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

