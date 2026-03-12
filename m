Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72DB105A583
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:54:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 210FD60207;
	Thu, 12 Mar 2026 12:54:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 210FD60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773316452;
	bh=uQY9enfkNqKpgB2Qn7Yjbi+2wxHTc8VNqKlk7AQ/uyk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TP5MIsn8vLLWAUZ8ACPsSBiR4ZahE5ZFCdEaxalYrTNXuPwEKBXJauOMcobnWtMRd
	 jRAAnR9aZeV5jeqLoEp7U/Q25ck9svNQWQwi2G1UbJ640fnu8DqxQmQtvUh8S28r1t
	 ZwFyXaOzVXof/TL+PC92BXgViRniwdetX8WeQe5E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB37AF805E6; Thu, 12 Mar 2026 12:53:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22998F805E9;
	Thu, 12 Mar 2026 12:53:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7E3BF8045D; Thu, 12 Mar 2026 12:53:30 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1DBCFF8016E
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2026 12:53:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DBCFF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PekKSxHD
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 968A0443D7;
	Thu, 12 Mar 2026 11:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC20CC2BC9E;
	Thu, 12 Mar 2026 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773316405;
	bh=uQY9enfkNqKpgB2Qn7Yjbi+2wxHTc8VNqKlk7AQ/uyk=;
	h=From:To:Cc:Subject:Date:From;
	b=PekKSxHDtvPopt5fAaqWR0/GU7NKTfcWj41MhM08zE1BkLPUhNDMuBW8RX5b+V7yT
	 b/FP2TvGZ0Y7dlVX8C6pAR0KrJir3weIN1axMi0nWA6uZITH2vsDgk4uQ6WXtZFTWQ
	 vgGNCJydXuoSnpW2Lz8Y49lcp5ovhyEszxTGkg0rkDyNszOi9wDfky0rUsyTTDR3uq
	 9lqHvvjeg6FC47iMcL40bay16TU2WHcPJLyma4FsOpUvGtbAmr5+F9cvLTVRb2Rrz9
	 h9voBM+okqyso5aTtr1niJ3gGThQNKXSEFod9PA+fINJh0Xfms4z0UNat2YubpmQzF
	 64SoPv54EEtVw==
Message-ID: <eb05b65e322575e31cd3566b267c5686@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.0-rc3
Date: Thu, 12 Mar 2026 11:53:15 +0000
Message-ID-Hash: ESHGMZYZ2SHCCYGCRFGY5GS74YMLPUR3
X-Message-ID-Hash: ESHGMZYZ2SHCCYGCRFGY5GS74YMLPUR3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ESHGMZYZ2SHCCYGCRFGY5GS74YMLPUR3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc3

for you to fetch changes up to 30c64fb9839949f085c8eb55b979cbd8a4c51f00:

  ASoC: amd: acp-mach-common: Add missing error check for clock acquisition (2026-03-11 19:18:17 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.0

Quite a large pull request, but nothing too concerning here - everything
is fairly small.  We've got a couple of smaller core fixes for races on
card teardown from Matteo Cotifava, a fix for handling dodgy DMI
information generated by u-boot, some driver specific fixes and some new
device IDs for Tegra.

----------------------------------------------------------------
Casey Connolly (1):
      ASoC: detect empty DMI strings

Chen Ni (2):
      ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
      ASoC: amd: acp-mach-common: Add missing error check for clock acquisition

Mark Brown (1):
      ASoC: tegra: Add Tegra238 sound card support

Peter Ujfalusi (1):
      ASoC: codecs: rt1011: Use component to get the dapm context in spk_mode_put

Ravi Hothi (1):
      ASoC: qcom: qdsp6: Fix q6apm remove ordering during ADSP stop and start

Richard Fitzgerald (1):
      firmware: cs_dsp: Fix fragmentation regression in firmware download

Sen Wang (1):
      ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays

Sheetal (1):
      ASoC: tegra: Add support for Tegra238 soundcard

matteo.cotifava (2):
      ASoC: soc-core: drop delayed_work_pending() check before flush
      ASoC: soc-core: flush delayed work before removing DAIs and widgets

 drivers/firmware/cirrus/cs_dsp.c         | 24 ++++++++++++++++++------
 sound/soc/amd/acp/acp-mach-common.c      | 18 ++++++++++++++----
 sound/soc/amd/acp3x-rt5682-max9836.c     |  9 +++++++--
 sound/soc/codecs/rt1011.c                |  2 +-
 sound/soc/generic/simple-card-utils.c    | 12 ++++++++----
 sound/soc/qcom/qdsp6/q6apm-dai.c         |  1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c  |  1 +
 sound/soc/qcom/qdsp6/q6apm.c             |  1 +
 sound/soc/soc-core.c                     | 11 ++++++++---
 sound/soc/tegra/tegra_audio_graph_card.c | 11 +++++++++++
 10 files changed, 70 insertions(+), 20 deletions(-)
