Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF726EE6457
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 12:20:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA7B2A4E;
	Fri, 15 Sep 2023 14:20:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA7B2A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694780452;
	bh=FoDCC8b+yNrvOVCKMMKtaidkTMNGEtdcrNvpPRAZyoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lCgjBjC090iA/6P0Bsd48Rol66oUZXhY7IoqBCCsC4VkIS3DYN9S+ap3Wm8fUpI+p
	 R+pysEo5+NsyQzx068Hc5N+6gXOFw3LiiWYpGaHqau11Ojs4nXj3r1x/wha480u+7R
	 PPsYvFS9NUkoJE9YmTxYAboRJL6jD56t83/0Iazw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A462BF805A8; Fri, 15 Sep 2023 14:18:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37A81F80588;
	Fri, 15 Sep 2023 14:18:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 515D6F8055A; Fri, 15 Sep 2023 14:18:48 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7196EF8047D
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 14:18:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7196EF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s/5wD1ve
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id C7588CE2B61;
	Fri, 15 Sep 2023 12:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C982C433CA;
	Fri, 15 Sep 2023 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694780319;
	bh=FoDCC8b+yNrvOVCKMMKtaidkTMNGEtdcrNvpPRAZyoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/5wD1ve2x8Qc4YNoLvOHH/Z9dBHkncCw+nF+g0h57uchYQWQJfPrwRIXRxgDcMlN
	 nLdKTDuzM3cEIowJ0KTady4iGJeuZkmssXdP9OqutkwANwwTwSAjXAS3d2VnpHEtvm
	 hURBthFLIJiCd4gIml/GwOpkz6NPx/wbyuTyB7N3gFK6NiBlyq9yD6SlxlwiioUHpQ
	 ujBDGLRozdeTDrzDf1XucWNiKxVsVX0UBPzfptJvJGuCcjGWtmVMi365wnRXG34flH
	 CvY9KvAb1P/sh57AtGtNnl4G8Le60fnNzTqh9m1SCKDa+Hbv/tqriRF62BJJWedFLB
	 VODNiNjXR3HsA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com
In-Reply-To: <20230914125115.30904-1-peter.ujfalusi@linux.intel.com>
References: <20230914125115.30904-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4: Dump the payload also when
 set_get_data fails
Message-Id: <169478031619.22068.12580878564050317780.b4-ty@kernel.org>
Date: Fri, 15 Sep 2023 13:18:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: YLVVZBABC2DHLPZ3SVR2VDK4UMYEZMIH
X-Message-ID-Hash: YLVVZBABC2DHLPZ3SVR2VDK4UMYEZMIH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YLVVZBABC2DHLPZ3SVR2VDK4UMYEZMIH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 14 Sep 2023 15:51:15 +0300, Peter Ujfalusi wrote:
> Move the out label to dump the message payload when the IPC message fails.
> The payload contains important information on what might have caused the
> error in firmware.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4: Dump the payload also when set_get_data fails
      commit: f7d67a9c254829930355d675e989c0dfa884242c

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

