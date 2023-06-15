Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F229EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jun 2023 11:44:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE63F6C1;
	Thu, 15 Jun 2023 13:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE63F6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686829472;
	bh=gyNtIfPP6YV91XPVJ+Xan7OVmXyA9+clJ2/flwv1YNA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=V1xcszcgCIftxr47zxgbeeb+GY9TuSVd+MUFmBrwX4D/4aWdRDc4SGoo4+gToV73C
	 uFUg5EWcU2ZhuHVwsIExvRdee9QVAHL56X5wbThnGD/WKJSfRi6iQ4N91po4FYg1b2
	 MdS/3kIJfuutiU6LfJnEtJ8NAKwaMB2G8JzjA4nQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91A84F800ED; Thu, 15 Jun 2023 13:43:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15F4BF80149;
	Thu, 15 Jun 2023 13:43:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF665F80149; Thu, 15 Jun 2023 13:43:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4328DF800BA
	for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2023 13:43:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4328DF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aI3wBKAx
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 81FF063B26;
	Thu, 15 Jun 2023 11:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91292C433C8;
	Thu, 15 Jun 2023 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829382;
	bh=gyNtIfPP6YV91XPVJ+Xan7OVmXyA9+clJ2/flwv1YNA=;
	h=From:To:Cc:Subject:Date:From;
	b=aI3wBKAxnsA/ODor78AkJ0Y8ikat7ie/16dO7ALkk9PFYs1bJcyx5UltIo6UCs5f0
	 2z4UDjM7/fBTxKc2lgjbFKPXH8gZZcLntr3UBuWQM+GVmKCGHy2UyFI4Az45bVA8yg
	 2CJe49OWTzN2nIhhAAYDKuZyKawM1rU91Wlc6cx6uswKOWsXbdMH+hDQ4HCgRCWwX0
	 aNF7t/asnXA35T0z1n6OSHXKLg/mzuDXhK54zf2gJ+132pEatISN04Z7IOdhYmr7mP
	 tk6l/BecSqEIoLm7WYGUVNezU9EjonD8n8nsBPEFNNFQx3XVr7xEfpfEkQnfHSJ9e+
	 6sqgsoXMiGsPQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.4-rc6-2
Date: Thu, 15 Jun 2023 12:42:52 +0100
Message-Id: <20230615114301.91292C433C8@smtp.kernel.org>
Message-ID-Hash: LR6Y7EXSPLYPYOMRDOYFT6C5HNJU3LH4
X-Message-ID-Hash: LR6Y7EXSPLYPYOMRDOYFT6C5HNJU3LH4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LR6Y7EXSPLYPYOMRDOYFT6C5HNJU3LH4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 32cf0046a652116d6a216d575f3049a9ff9dd80d:

  ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted (2023-06-02 12:54:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.4-rc6-2

for you to fetch changes up to f9fd804aa0a36f15a35ca070ec4c52650876cc29:

  ASoC: tegra: Fix Master Volume Control (2023-06-13 12:10:56 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.4

A couple more fixes for v6.4, one fixing a misleading error log and
another stopping us seeing spurious failures setting the master volume
on some Tegra systems introduced by a change to how we calculate delay
times.

----------------------------------------------------------------
Jon Hunter (1):
      ASoC: tegra: Fix Master Volume Control

Richard Fitzgerald (1):
      firmware: cs_dsp: Log correct region name in bin error messages

 drivers/firmware/cirrus/cs_dsp.c | 5 +++--
 sound/soc/tegra/tegra_pcm.c      | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)
