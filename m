Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266F0EE6432
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Dec 2025 12:49:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DD79601F7;
	Wed, 31 Dec 2025 13:49:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DD79601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767185371;
	bh=92DGvW4v0/TjB7+EyS9EarMBsTnxxFlypJStYlGMhrs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oigciSAeHGlN45FI+vTgVneho8BGMhtuTV1DfwtFmpt63J0BMwCo0O+NaXFV/xb/x
	 VlaLCxN9utnAmglQ/NtxChaHEwAsH/a1zXBNq7DrOVkFtgK1n2ek5BNJn65pTeornk
	 HrtiYjHsof6PcX8v7HxViQmukhrRsI0OQpb3NysQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F21DF805E4; Wed, 31 Dec 2025 13:48:58 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09AA9F805D7;
	Wed, 31 Dec 2025 13:48:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D586BF80240; Wed, 31 Dec 2025 13:48:49 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CE803F80162
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2025 13:48:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE803F80162
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BoK0pwTh
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A9A3A407BF;
	Wed, 31 Dec 2025 12:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF1CC113D0;
	Wed, 31 Dec 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767185322;
	bh=92DGvW4v0/TjB7+EyS9EarMBsTnxxFlypJStYlGMhrs=;
	h=From:To:Cc:Subject:Date:From;
	b=BoK0pwThWTbObIma0pFbpsFUXCxU5rlz/pALe2aGPL7P+lc4X/21kExVjtYUY1RhI
	 wU2WyvhQoUam+To0FX5Rk7kDTYvC58yMCy+DuittpqRqC8Pls0bi1jJ1eAydCai5jb
	 +82L9ouCC8ca2hwt6e5f+jnEEZhI+AWAtt3bCTZXSyn4uOKnJcZBbvKXillDLK0mCj
	 88dNqcrYkM+J8WMe3JkIIjn3AvHFTkgTV+J6G/0cBdP0wIN8KDQnJnX1MIqyeOENYH
	 lP3chqUX3mFWS8eEFYO4VOxy5KCIj9/2sI5L3q5LtOE65TL9D/a0dlQwEbDtBOvxd1
	 2sImLviwl8i7A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id C972C1AC5681; Wed, 31 Dec 2025 21:48:37 +0900 (JST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.19-rc3
Date: Wed, 31 Dec 2025 12:48:31 +0000
Message-Id: <20251231124837.C972C1AC5681@finisterre.sirena.org.uk>
Message-ID-Hash: 3VTC4KTGK7QZGR6SHLJUXZXR3KGDJFVO
X-Message-ID-Hash: 3VTC4KTGK7QZGR6SHLJUXZXR3KGDJFVO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3VTC4KTGK7QZGR6SHLJUXZXR3KGDJFVO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 56d953a8d0da5e53c2594edde23465ec49385b1c:

  ASoC: Intel: mtl-match: Add 6-amp matches for CS35L56 (2025-12-19 13:25:16 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.19-rc3

for you to fetch changes up to 3572ad82201baeed840f1959787e0e1281e7f937:

  ASoC: drop bogus container_of() error handling (2025-12-22 22:13:03 +0000)

----------------------------------------------------------------
ASoC: Fixes for v6.19

A small collection of driver speciifc fixes, mostly relatively minor,
plus an adjustment to the topology file naming for Intel systems with
Bluetooth required for disambiguation.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: SOF: Intel: add -bt tplg suffix if BT is present

Chen-Yu Tsai (1):
      ASoC: sun4i-spdif: Add missing kerneldoc fields for sun4i_spdif_quirks

Johan Hovold (4):
      ASoC: codecs: pm4125: drop bogus container_of() error handling
      ASoC: codecs: wcd937x: drop bogus container_of() error handling
      ASoC: soc_sdw_utils: drop bogus container_of() error handling
      ASoC: codecs: pm4125: clean up bind() device reference handling

Mac Chiang (1):
      ASoC: Intel: sof_sdw: shift SSP BT mask bits.

Mark Brown (1):
      ASoC: drop bogus container_of() error handling

 sound/soc/codecs/pm4125.c               | 17 ++---------------
 sound/soc/codecs/wcd937x.c              |  5 -----
 sound/soc/intel/boards/sof_sdw_common.h |  6 +++---
 sound/soc/sdw_utils/soc_sdw_utils.c     |  4 ----
 sound/soc/sof/intel/hda.c               | 14 +++++++++++++-
 sound/soc/sunxi/sun4i-spdif.c           |  2 ++
 6 files changed, 20 insertions(+), 28 deletions(-)
