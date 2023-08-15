Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03256C001B0
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 16:48:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85C60827;
	Tue, 15 Aug 2023 18:47:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85C60827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692118101;
	bh=M6PNbvz4/GYULuPj8abS/YUPV2aBlFIyXVHihMaPLyQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=X2lHGctte150d1ohXhQh2BcEEMMXMSjiiYTB9mJBATJW/QwvAxQr54OGYFA+3MV4l
	 sa6Xjh4P0ayZyORWcM4ARuxAF/b5EuS25/Bg2x9MW2wJi7gkSP7ZAc50X1fOxdTK0V
	 gm4Y/1tA8L3JdLozBcVtAw6MOvJ5gBHO1HsVAnYE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBD3DF80536; Tue, 15 Aug 2023 18:47:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 609C8F80027;
	Tue, 15 Aug 2023 18:47:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EF2CF8016D; Tue, 15 Aug 2023 18:46:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A378F80074
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 18:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A378F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BNZge8YR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B29DE65D44;
	Tue, 15 Aug 2023 16:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FFC433C8;
	Tue, 15 Aug 2023 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692118004;
	bh=M6PNbvz4/GYULuPj8abS/YUPV2aBlFIyXVHihMaPLyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BNZge8YRY9F5yRvCoDgGLpdpMDZq60V3NF4hCYYipUkKP6kCR3z2GWTFk71S9QtFP
	 9vARUcpYWxXoAU6GO6n8Blvv2e5B8BcWRD/BjG0tOQR67J7J9C1+YKcbH9ocGaj4i2
	 NKTiiYUCPxZcWCJJOsGwbHnhTuA4I+GPpfFcDK9EnOkHQDPdTdRMjaghEO5ZDeLQBF
	 ya+5qxmnoohmKLb4JvfR50/MsVOTINXa+OoTAUCGUos7IuPF6Y0S0yWmA935egbk10
	 eq5PdrDDC+p35xTt4RhNKwOiUBp44oG0XKYAxuzd9lunUcuBNQJhLTfFNx6LXu2xeJ
	 4+53OSITHryEw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.5-rc6
Date: Tue, 15 Aug 2023 17:46:35 +0100
Message-Id: <20230815164643.B31FFC433C8@smtp.kernel.org>
Message-ID-Hash: F2254GN3HG2V2ER7T5U4ZTHTEI34EBYE
X-Message-ID-Hash: F2254GN3HG2V2ER7T5U4ZTHTEI34EBYE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F2254GN3HG2V2ER7T5U4ZTHTEI34EBYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.5-rc6

for you to fetch changes up to 37aba3190891d4de189bd5192ee95220e295f34d:

  ASoC: rt1308-sdw: fix random louder sound (2023-08-13 18:16:32 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.5

A fairly large collection of fixes here, mostly SOF and Intel related.
The one core fix is Hans' change which reduces the log spam when working
out new use cases for DPCM.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: max98363: don't return on success reading revision ID

Daniel Baluta (1):
      ASoC: fsl: micfil: Use dual license micfil code

Hans de Goede (1):
      ASoC: lower "no backend DAIs enabled for ... Port" log severity

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Update the basecfg for copier earlier

Pierre-Louis Bossart (1):
      ASoC: Intel: sof-sdw: update jack detection quirk for LunarLake RVP

Ranjani Sridharan (1):
      ASoC: SOF: intel: hda: Clean up link DMA for IPC3 during stop

Shuming Fan (1):
      ASoC: rt1308-sdw: fix random louder sound

Xia Fukun (1):
      ASoC: SOF: Fix incorrect use of sizeof in sof_ipc3_do_rx_work()

Zhang Shurong (1):
      ASoC: rt5665: add missed regulator_bulk_disable

jairaj-arava (1):
      ASoC: Intel: sof-sdw-cs42142: fix for codec button mapping

 sound/soc/codecs/max98363.c              |  9 ++++---
 sound/soc/codecs/rt1308-sdw.c            | 13 +++++++++-
 sound/soc/codecs/rt5665.c                |  2 ++
 sound/soc/fsl/fsl_micfil.c               |  4 +--
 sound/soc/fsl/fsl_micfil.h               |  2 +-
 sound/soc/intel/boards/sof_sdw.c         |  2 +-
 sound/soc/intel/boards/sof_sdw_cs42l42.c |  6 ++---
 sound/soc/meson/axg-tdm-formatter.c      | 42 ++++++++++++++++++++------------
 sound/soc/soc-pcm.c                      |  8 ++++--
 sound/soc/sof/intel/hda-dai-ops.c        | 11 ++++++++-
 sound/soc/sof/intel/hda-dai.c            |  5 ++--
 sound/soc/sof/intel/hda.h                |  2 ++
 sound/soc/sof/ipc3.c                     |  2 +-
 sound/soc/sof/ipc4-topology.c            |  6 ++---
 14 files changed, 76 insertions(+), 38 deletions(-)
