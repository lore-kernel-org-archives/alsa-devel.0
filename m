Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E42C27C79
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jun 2024 11:48:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF0C4E80;
	Thu, 20 Jun 2024 13:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF0C4E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718884103;
	bh=rbeOxems1FuSby3UK5MmTHjuVfReL3BNUB/fTrMgsSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bIM69AhOXTv8Cr4GYUV97IIc4p4aALq4CVl0WkD5ccGSO9wJ/SNJxKw9G5jgKmR8G
	 /Qoxdt6gUGFlD7pYYia8QlQnjcWZywg07lzIH7BlxrP6yvx3HcB38ko2xQzeJ9IbZS
	 Em1sZt73Ubn7O9B0Hrf9BNoqDFIhaOvu3aKqkGXk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FD40F805B5; Thu, 20 Jun 2024 13:47:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07C1EF805B6;
	Thu, 20 Jun 2024 13:47:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC0ADF8023A; Thu, 20 Jun 2024 13:47:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4DF9F801EB
	for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2024 13:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4DF9F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ND7yUXF0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A0756218E;
	Thu, 20 Jun 2024 11:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6EC4AF0B;
	Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718884044;
	bh=rbeOxems1FuSby3UK5MmTHjuVfReL3BNUB/fTrMgsSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ND7yUXF05VcA9LHJDB+fZ/aK7w4Kib15dQY470C2WchRa7f6li1bXbBO7PlFuwsEu
	 N9j3Su5Ul3f0pdNS6FH5Xv3s76ln1SFife/y2RYbFklB++NE5XJGKAgAWA7LR3X+5E
	 d5KhaDN2vba9O0Dxsk9olM8EFYgl8sQUi4JGJ4HDskgJuFIVMfN+aWygBQP6BWoCX5
	 AlWAeW0knBdARv3YUpkTnpC5LaG9OdRFkUHW2E5RFC6rXp+yIRC7X2fwxzj2iTPRV7
	 50D2ixnxkLzb0UCm2k11DBNUSEj/aAjvD8DK7o/4xsb4fubk8T6c4GQzerB5GF3ACL
	 nokANLX6c73Rg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
References: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/8] ASoC: amd: acp: add a null check for
 chip_pdev structure
Message-Id: <171888404167.51171.12647863943133504224.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 12:47:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: P2F7BJKSRVZLOELBZLSONSU5VKLHEQ5G
X-Message-ID-Hash: P2F7BJKSRVZLOELBZLSONSU5VKLHEQ5G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P2F7BJKSRVZLOELBZLSONSU5VKLHEQ5G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 17 Jun 2024 12:58:34 +0530, Vijendar Mukunda wrote:
> When acp platform device creation is skipped, chip->chip_pdev value will
> remain NULL. Add NULL check for chip->chip_pdev structure in
> snd_acp_resume() function to avoid null pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: amd: acp: add a null check for chip_pdev structure
      commit: 98d919dfee1cc402ca29d45da642852d7c9a2301
[2/8] ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()
      commit: 70fa3900c3ed92158628710e81d274e5cb52f92b
[3/8] ASoC: amd: acp: move chip->flag variable assignment
      commit: 379bcd2c9197bf2c429434e8a01cea0ee1852316

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

