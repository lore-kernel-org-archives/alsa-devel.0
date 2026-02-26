Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679E6FC593D
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Feb 2026 12:17:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8118601E9;
	Thu, 26 Feb 2026 13:17:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8118601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772108225;
	bh=7BAdmPyOKJ1QEM3M9r0UGakTNfKtugYYuFz2Cro/YVs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fgfe4rZquwn2FLszRsluZ5Egithj59y3iKNui3aEqi58ZRFyUH392F3slzKvCFc5B
	 fxekViA5vIGxiZF6S7N8T+vVDKNYdC+p9Cj1/SpTMQNq4wbk7QvwvFDq9ZbHDOjhFx
	 CxW6/nLAeBQ+A6XP8aJNv+ck91DxoHdmZzbWrFfs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C532F805DF; Thu, 26 Feb 2026 13:16:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 40402F805DF;
	Thu, 26 Feb 2026 13:16:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A6E7F8051E; Thu, 26 Feb 2026 13:13:49 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EDCDFF802DB
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2026 13:13:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDCDFF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i93GaD4x
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3068C442E4;
	Thu, 26 Feb 2026 12:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15CC116C6;
	Thu, 26 Feb 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108023;
	bh=7BAdmPyOKJ1QEM3M9r0UGakTNfKtugYYuFz2Cro/YVs=;
	h=From:To:Cc:Subject:Date:From;
	b=i93GaD4x5JDXwPzqxpRulW598AKfONVUkIVk5TtsfABMJnWqjHSHF7iWRneVhNOUu
	 cE4kWZwKgqMisCRFWUdD8nR2WIB5VsL8ValIFPRcZ9bqt9udnRJTGbqU2LBkuki0w2
	 cC6FrZs5N51WgpWl1vhEBQajkSErE+jzZUnO4jPpz8xID8QZ11eodE2rW43I8kG8xe
	 zV2FhevD0YfRUfhh7P2/+rVP5u3dxiX4jmq0Z0pR1Gw56YNSzBCzfRLTCDhn2qF/mO
	 znOVoPGzyId1LCJPGsN8/3iEYiDWM9sVu14X7FiUn5meVZay7+Yw4rtOv/+47v9lnu
	 DTU0mO+TKMrug==
Message-ID: <de64faa8c22aa935fb62b898f33f7f58@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.0-rc1
Date: Thu, 26 Feb 2026 12:13:35 +0000
Message-ID-Hash: Y46PVWARF35NRTCIQHHF7CBKFZ5REPIA
X-Message-ID-Hash: Y46PVWARF35NRTCIQHHF7CBKFZ5REPIA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y46PVWARF35NRTCIQHHF7CBKFZ5REPIA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc1

for you to fetch changes up to 32fc4168fa56f6301d858c778a3d712774e9657e:

  ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table (2026-02-23 14:52:11 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.0

One quirk and a fix for handling of exotic peripherals on cs42l43.

----------------------------------------------------------------
Azamat Almazbek uulu (1):
      ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table

Charles Keepax (1):
      ASoC: cs42l43: Report insert for exotic peripherals

 sound/soc/amd/yc/acp6x-mach.c   | 7 +++++++
 sound/soc/codecs/cs42l43-jack.c | 1 +
 2 files changed, 8 insertions(+)
