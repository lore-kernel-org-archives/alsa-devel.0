Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB70C83F1A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jul 2025 12:33:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC55060213;
	Thu, 17 Jul 2025 14:33:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC55060213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752755635;
	bh=mdSrV0SjOqyBrOqulbqj38t3aeIUQAuXgVXm8NXV6a8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JLm30CNYfFuQVRIxSf21Dh1DXoi2BuyOjVcPrh96QdsjRVTJ48w2lCC50KIIoEQV4
	 LkFXqLysp2rkb6LKWZJLZU1/t44+8w0kVGeeg02vEr7/Eb5IcZQOqAvC/FYdNi2dUA
	 BOmYlPToerZZTLp2/pYUvfA3uz47Hw4lFVUvyAx4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C96AF805F3; Thu, 17 Jul 2025 14:33:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A3F6F805F5;
	Thu, 17 Jul 2025 14:33:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 557F1F80217; Thu, 17 Jul 2025 14:33:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EB87F800F3
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2025 14:33:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EB87F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i48JQ7h1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 659B3601F9;
	Thu, 17 Jul 2025 12:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90B5C4CEE3;
	Thu, 17 Jul 2025 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755574;
	bh=mdSrV0SjOqyBrOqulbqj38t3aeIUQAuXgVXm8NXV6a8=;
	h=From:To:Cc:Subject:Date:From;
	b=i48JQ7h1nsn41RHcEIeh0DLPKxekseEq3m9kf9OQsN3iwepjtLKGGaCCjMkRRkChR
	 3DlmZ5PHy/eMf+zPZQ12a/bMDq09ve95Ore3NXVrfjt2pRVJXMKSp4H9iJ/RKbmxgA
	 X1NyZbLKMCdvWauTd7CCIbXpWEzHh17bHpBTZ1rVppnfjuMtRjQ9SFU+aLjU7HQ7Cj
	 GwEr6XfhTaNJaDH0rgDed2pOBAlyigD8hiP0Yl1+duFUCWLnFwQr+vf+idTVxqL5RZ
	 gwdY5hHt11hC19VIvF1b3J8vJRFclU0oMXt8piZptUSr5ExtmX1iLLVLP6cagRrhTW
	 9+pOyG7bWqgsw==
Message-ID: <1d784c862857c2d2f3870c0e140863da.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.16-rc6
Date: Thu, 17 Jul 2025 13:32:44 +0100
Message-ID-Hash: FIZPUQMZZWWWANPEPLJTK7XVZSISAAUC
X-Message-ID-Hash: FIZPUQMZZWWWANPEPLJTK7XVZSISAAUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FIZPUQMZZWWWANPEPLJTK7XVZSISAAUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 3b3312f28ee2d9c386602f8521e419cfc69f4823:

  ASoC: cs35l56: probe() should fail if the device ID is not recognized (2025-07-03 12:22:27 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.16-rc6

for you to fetch changes up to 7bab1bd9fdf15b9fa7e6a4b0151deab93df3c80d:

  ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx (2025-07-16 11:50:33 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.16

A relatively large set of changes, but most of them are quirk
information for various x86 systems.  There is one more substantial fix
for a NULL pointer dereference when removing the AVS driver, plus one
for Kconfig dependencies.

----------------------------------------------------------------
Adam Queler (1):
      ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx

Alexandru Andries (1):
      ASoC: amd: yc: add DMI quirk for ASUS M6501RM

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix NULL ptr deref on rmmod

Arnd Bergmann (1):
      ASoC: Intel: fix SND_SOC_SOF dependencies

Bard Liao (1):
      ASoC: Intel: soc-acpi: add support for HP Omen14 ARL

Lane Odenbach (1):
      ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx

Oder Chiou (1):
      ASoC: rt5660: Fix the dmic data source from GPIO2

 sound/soc/amd/yc/acp6x-mach.c                     | 21 ++++++++++++++++
 sound/soc/codecs/rt5660.c                         |  7 ++++--
 sound/soc/intel/avs/pcm.c                         |  4 +++-
 sound/soc/intel/boards/Kconfig                    |  2 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c | 29 +++++++++++++++++++++++
 5 files changed, 59 insertions(+), 4 deletions(-)
