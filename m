Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EE5CA5FD4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:36:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99DF60294;
	Fri,  2 Oct 2026 14:36:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99DF60294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790944596;
	bh=cKlpFm+ZRop2reJaXu0njUKTkQbR7hNkQvVg6oiGwRA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qRvvcD9te2fy0mLcAEaIp/sa6jIyjzyUW7I/0qDFym++lnprXfyafIGFicgksXEGF
	 BKuMJRmQVrgysDA0YKoKCQdbtBC3PomhgAf70ezPYI6G8mvllR7zduxas0khWj8wAd
	 sRklzJqSxfljw3F5kKql61zM9KU2rIw2z0Bf2zHo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EEC7F80622; Fri,  2 Oct 2026 14:35:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2BCAF8062E;
	Fri,  2 Oct 2026 14:35:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5BE2F8060D; Fri,  2 Oct 2026 14:35:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790944548;
	b=NF1YQgMa4d8SX4Uy0dv57BTkURJre58gdMP1fAxV4Rf50dAZh3zVXP/essbQGipI4gb3
	 9/fujQI0O6sG9m68UiPUJIvI/yyhVRkyNUPEOQRvfUdc3ptQ2oJyQJrbSzlgt/GiEe9KT
	 +Xh2OO1YiMos20E1nXbD9koDKxnjCMIQO1XDUVgmQBqR8M9eImU7U1Qd9VX+xrZskEzH2
	 dWfYy6MB173RkDxBrOekJRp3XDBF8LkBZUf7CAFeTAhVFl9B7Bnh+fcQ7sMbYKziLoIVe
	 rYzzYJJT7XQk3L7tIU9weEb9ECTLavmnw49HH5mXG4ND1zP0Gu0z17tEP0CjtvSezCQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790944548;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=cKlpFm+ZRop2reJaXu0njUKTkQbR7hNkQvVg6oiGwRA=;
	b=Tr8u+4JOPVpHoe8/FfkiC8Ml6lyLGBVcyT/nUhGbjKDTvcqyrIYLgbmyq6Gy16jnT28Q
	 hfUVb75t8UvYqsCsq5xLLZP+2K51+x8HFmJ7vtAmZ9vjgMH2Jf1TqHGSYBy2o4oGTSTL0
	 nr4oyBFU0sG7Nxzym2SAoA7H6kom0xrX5F04Wnb91UpAHaJQKhF9Wfo2w3Ps59LozBgAs
	 pT4ar5X3H+oQyyNU4S61isl11z5prfujYu7SyYiOTNqEyyM91NRWJSFRl/KlmrXS8nOM4
	 dBo0zQL3DqlKY9X3Zlg4kiq4iZBsLjPv/6p9g8MlNLlFGCFFxrsO4H2BByj2AjWpyyw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JA6fyseZ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 85889F8060B
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85889F8060B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JA6fyseZ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 9A60160A93;
	Fri,  2 Oct 2026 12:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BF3C61F00893;
	Fri,  2 Oct 2026 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790944546;
	bh=iq7OODU+HlVaqh5q9K4r3eGlByYqRCkLrjDga6KBjYg=;
	h=From:To:Cc:Subject:Date;
	b=JA6fyseZHhTDbXuqnw0qbbmR/qWoGWl+80KednVGkzDC5mk/kO7sFQveCHdhbmlLY
	 zxa8qsEdCrvpmFb2WJ8aM+2ECNLRQIhW7SNe8hthuz/TAu6TknDNNZbMOatpmsNJJU
	 tww53fgozh4QpVJdveNocq3xl0sYz8wn6kDQ5cSXJ/6mI3NL4JTG6MNu09328bC/Un
	 C0bA5LpS780Xd0CO8Ll0yni0nq1vsQRmhRZtrclF976SpIAK2tQyvSr9GzSIBZog5i
	 WC0PoWOTX3ZsOYmTwSGgKanRto7QqMR3bbE/vLWzY3sMyEsWdPu5B5YvZME8nqmQkG
	 ZE/VHe4jlGeww==
Message-ID: <ac1f5abe5b1f49157574990efcd4eaf2@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc5
Date: Fri, 02 Oct 2026 13:35:32 +0100
Message-ID-Hash: Z3SX23TPNB2QC7QCYCUAAKCBQPQWPVVA
X-Message-ID-Hash: Z3SX23TPNB2QC7QCYCUAAKCBQPQWPVVA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z3SX23TPNB2QC7QCYCUAAKCBQPQWPVVA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc5

for you to fetch changes up to cad16d850e3759dd82cd869f739b56e9844a1fee:

  spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260 (2026-10-01 16:38:05 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.3

A bigger collection of fixes than usual due to your vacation but nothing
hugely remarkable here, just fairly standard quirks and driver specific
bugfixes.

----------------------------------------------------------------
Arnd Bergmann (1):
      ASoC: rt766: fix HID dependency for SND_SOC_SDCA_HID

Cezary Rojewski (2):
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate

Charles Keepax (1):
      ASoC: Intel: Add quirk to block match table for Lenovo Yoga Slim 7

Daniel Ortiz (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 G6 ARP

HyeongJun An (1):
      ASoC: wm8903: Move the DRC QR threshold to the register that holds it

Jasper Firth (1):
      ASoC: Intel: bytcr_rt5651: Add quirk for Chuwi Hi8 with generic DMI strings

Jiangshan Yi (2):
      ASoC: codecs: max98363: fix uninitialized stream_config->type
      ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type

Liviu Nicoara (1):
      ASoC: codecs: lpass-wsa-macro: rewrite the interpolator volume after enabling clocks

Maciej Strozek (2):
      ASoC: SDCA: Set suspended flag after resuming within system suspend
      ASoC: SDCA: Add better pm_runtime error handling in func probe

Mark Brown (1):
      ASoC: SDCA: Power management fixes for the class function driver

Richard Fitzgerald (1):
      spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Sheetal (1):
      ASoC: tegra: Fix ASRC Stream6 input threshold control

Syed Saba Kareem (1):
      ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire machine

Zhang Heng (2):
      ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 14ASP9
      ASoC: amd: acp-config: Add ACP70 DMI quirk for ASUS UM5406GA

Zimeng Li (1):
      ASoC: qcom: lpass-cpu: use DAI table index for playback constraints

 drivers/spi/spi-cs42l43.c                          | 97 ++++++++++++++++++++++
 sound/soc/amd/acp-config.c                         | 14 ++++
 sound/soc/amd/acp/Kconfig                          |  1 +
 sound/soc/amd/acp/amd-acp70-acpi-match.c           | 20 +++++
 sound/soc/amd/yc/acp6x-mach.c                      | 14 ++++
 sound/soc/codecs/Kconfig                           |  4 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |  3 +
 sound/soc/codecs/max98363.c                        |  2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 | 27 ++----
 sound/soc/codecs/rt274.c                           |  4 +-
 sound/soc/codecs/rt286.c                           |  2 +-
 sound/soc/codecs/wm8903.c                          |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c              | 17 ++++
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |  1 +
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.c  | 16 ++++
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.h  |  1 +
 sound/soc/qcom/lpass-cpu.c                         |  4 +-
 sound/soc/sdca/sdca_class_function.c               | 19 +++--
 sound/soc/tegra/tegra186_asrc.c                    |  2 +-
 19 files changed, 215 insertions(+), 35 deletions(-)
