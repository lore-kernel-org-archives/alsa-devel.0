Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668FCFF8867
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2026 05:43:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3088601EF;
	Wed, 29 Apr 2026 07:43:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3088601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777441408;
	bh=iy+pKVRIEhGd/OGXEiMAk1gH/Bc+GjNZpgxmXTv4kt0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aGQCDD5B84cPQU0YGJpkDibtnwEZa1P+YqtnoD6kynWXjQL+Q5JuZ6c5ujLdT4zYg
	 tJImmXhkBYIT8AkG/FFcysZwCdlseTmc1Ks5iPqCRaKzUkx+e+zKKQSpu0xcTC3i2r
	 Z4RMZQe7w76vdNfcmG0H0oiFwHclte5JklvQcCcE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CCAFF805EE; Wed, 29 Apr 2026 07:42:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B418F805EE;
	Wed, 29 Apr 2026 07:42:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26AA1F80544; Wed, 29 Apr 2026 07:42:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2A1B2F80073
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 07:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A1B2F80073
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q+5I21zZ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C916760018;
	Wed, 29 Apr 2026 05:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6413CC19425;
	Wed, 29 Apr 2026 05:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777441357;
	bh=iy+pKVRIEhGd/OGXEiMAk1gH/Bc+GjNZpgxmXTv4kt0=;
	h=From:To:Cc:Subject:Date:From;
	b=Q+5I21zZnlwfr68+545EGi/hOsK1NgRuZI+fBjcAtJXsY4E30SZRY4DtFOM750MDY
	 1fpCRIpZuwuKUliBs2ieQ8DwOpFYFy90Ba+NVWF8ue18mGOYW/il6XiT2mkLTAz3Xg
	 uH6vF7bhPTVSVerCf8AYxV7KwEqSvY3slg68weCTkPT2oBh3mGLmPBz1JyrMqk5EJV
	 N1Txe8IBX02KLV8Vkq0UxnwRexlS8sFWkMG8Lvw/rWUcbBzEsngzx+4o89flTiAIE2
	 ly/0taduPDMurWK6mTJr2sJwOUgemOD6w1EWxHUeULIF27g4OxZHrqS5CYQA7ktieB
	 MdDvLlk3Ayo1g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id CBC321AC5855; Wed, 29 Apr 2026 06:42:34 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc1
Date: Wed, 29 Apr 2026 14:42:28 +0900
Message-Id: <20260429054234.CBC321AC5855@finisterre.sirena.org.uk>
Message-ID-Hash: NFKU45UBNXBMDW7LJ23CYLW5JTMHGIAJ
X-Message-ID-Hash: NFKU45UBNXBMDW7LJ23CYLW5JTMHGIAJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NFKU45UBNXBMDW7LJ23CYLW5JTMHGIAJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc1

for you to fetch changes up to 03dcb5b68a96b51157ec2d17042fa2f0106828ae:

  ASoC: spacemit: adjust FIFO trigger threshold to half FIFO size (2026-04-29 11:41:32 +0900)

----------------------------------------------------------------
ASoC: Fixes for v7.1

We've had quite a lot of fixes come in this past week, all driver stuff
rather than any broad systematic issue.  All quite routine stuff.

----------------------------------------------------------------
Ajay Kumar Nandam (1):
      ASoC: codecs: wcd937x: fix AUX PA sequencing and mixer controls

Bard Liao (1):
      ASoC: SOF: Intel: add an empty adr_link

Christian A. Ehrhardt (1):
      ASoC: codecs: ab8500: Fix casting of private data

Cássio Gabriel (1):
      ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error

Guilherme G. Piccoli (1):
      ASoC: amd: acp: Add DMI quirk for Valve Steam Deck OLED

James Calligeros (2):
      ASoC: tas2764: Mark die temp register as volatile
      ASoC: tas2770: Fix order of operations for temperature calculation

Li Jian (1):
      ASoC: ES8389: convert to devm_clk_get_optional() to get clock

Richard Fitzgerald (1):
      ASoC: cs35l56: Fix illegal writes to OTP_MEM registers

Sasha Levin (1):
      ASoC: tegra: Remove stale snd-soc-tegra-utils composite module definition

Troy Mitchell (2):
      ASoC: spacemit: move hw constraints from hw_params to startup
      ASoC: spacemit: adjust FIFO trigger threshold to half FIFO size

wangdicheng (1):
      ASoC: aw88395: Fix kernel panic caused by invalid GPIO error pointer

 sound/soc/amd/acp/acp-legacy-mach.c   |  2 +-
 sound/soc/amd/acp/acp-mach-common.c   | 22 +++++++++++++---
 sound/soc/amd/acp/acp-mach.h          |  4 +++
 sound/soc/amd/acp/acp-sof-mach.c      |  2 +-
 sound/soc/codecs/ab8500-codec.c       |  6 ++---
 sound/soc/codecs/aw88395/aw88395.c    |  9 +++----
 sound/soc/codecs/cs35l56-shared.c     |  7 +++--
 sound/soc/codecs/es8389.c             |  2 +-
 sound/soc/codecs/tas2764.c            |  1 +
 sound/soc/codecs/tas2770.c            |  4 +--
 sound/soc/codecs/wcd937x.c            | 26 ++++++++++++++++++-
 sound/soc/intel/boards/bytcr_wm5102.c |  1 +
 sound/soc/sof/intel/hda.c             |  3 ++-
 sound/soc/spacemit/k1_i2s.c           | 49 ++++++++++++++++++++++++-----------
 sound/soc/tegra/Makefile              |  1 -
 15 files changed, 101 insertions(+), 38 deletions(-)
