Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284EAC56208
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:50:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EF2C60238;
	Thu,  6 Aug 2026 13:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EF2C60238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786017018;
	bh=/XkgsjRjoYk1np3ff3dGW03R0+MiJS/WNX3DIVVg75Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=K9RdL8xcvdUNPVOpiCjeNBh2L7zIQAZhLmZMZ9ON+qklEYEswVbRCVZUmjFwNAFXf
	 UoY1R3OwU98Zp636hf1UrVJA6T/WB3kTGB93RInVhTvtleVcw+lOl0qThnIFaISgZ2
	 uZZNoLYnPPnFawFCwzYvhRzKVFZi/UjhwNV7QWC8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22FFFF805ED; Thu,  6 Aug 2026 13:49:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E3CBF805FA;
	Thu,  6 Aug 2026 13:49:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99D9AF8055A; Thu,  6 Aug 2026 13:49:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786016977;
	b=cvSMr4i/ZY9bkZfPRmpLopiGwfvUV7Ha6uofeMnfo5UeAt5CbPAPUS0aFp7IVWFjP/Xf
	 foLoN27qqnZPnYet77eT2TCawNtCEqNbRg0TKV4yjjaM9eEM2Qqp+MIt3DKfZ/04F8emv
	 VsS6bMaKk0PhoWDFzCvJKpU/iZBTUSwLm8lrMbU0etE0Tve8S8S/Kh2tQBx7I/Tc1rRy6
	 0qjbCRYcLC7M0mx4TAclBHrqKAWOmUj61VFWvxr/kr8X47ILDAwoooVh5pDwsQc+03hZT
	 33UxKPHPtps07T72y6W7+8FqkuGCNSl2EG3OKCtm98wnWEGGxUWK4RezijFkxJVicAg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786016977;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=/XkgsjRjoYk1np3ff3dGW03R0+MiJS/WNX3DIVVg75Q=;
	b=UcH10A2sa2lDVxyUh1nS6awovm15mwTeVvgMERXEa0FQ8AScu02N72AQY9VEtpXpsfwX
	 Q/wZjCMNB7t/C7FkARRqvV4P7yIdjYo77tFv5/G9CE3UjSY8zwgE5qH4hEcvbXcByCPOC
	 pfwPGVS6s9I1Gu+SfRfQ7r9qazex6IUOmShMtmMVPoX4zcQk4lzK36eQL3ZyYKkNbCHhQ
	 O0HAxf7S5FA7rnoMVIH0e+s26iLVwRwVFJ18NLt5XXaCan2/tRcIM4v4jImpMXbrpFlsN
	 KctyR17VSj7yhpNV3hL7aP4IGdxU4JRu2A8wTDenLIHyaQaDlq6CmEgH4hPd7fSJVHA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NYFv9uAp;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id B31D4F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 13:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B31D4F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NYFv9uAp
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 0D2C3401DF;
	Thu,  6 Aug 2026 11:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 63C801F000E9;
	Thu,  6 Aug 2026 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016973;
	bh=M1QM8PzIzcPMjE7kwflyMtKkaeSv4taEsNGbvr2voZ4=;
	h=From:To:Cc:Subject:Date;
	b=NYFv9uApCGS9XiuunnAD/hul+OrnVbuL2tIKzDSpNCV5X5nyTx1/woS/BJUfk2tCl
	 egx1Ev8o49BZK6HNsZwN+6oPbLEbB2dpxwWfg3MlMc9Cjn4wI7YkgzFR3MiJUt8AbZ
	 v3/y+/9vaJOtRQAp+nYyKtMzt6CDUTk9RC7caGnuKgUIJB8NgPSbkTSFwJzzfZhXd1
	 TUADO3jyzzclH89Xl99U0MijG4DRXIs0Pud6bIdjUPVmY0Jx1GkCEHm7ijYq2/URcs
	 BWvkFEmZ50+qhQbievNPFlqu7LUe8L/pMk8AwPn1Xif1th1i/b3QBEkGFjlD2l2JMg
	 E+2zqjLZR+AGQ==
Message-ID: <2f848fd70985d9c1bbee65eb39a99b4f@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc6
Date: Thu, 06 Aug 2026 12:49:27 +0100
Message-ID-Hash: 7F3T4VFJFAFEIVWOK5VEPLK6U3XRTBGC
X-Message-ID-Hash: 7F3T4VFJFAFEIVWOK5VEPLK6U3XRTBGC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7F3T4VFJFAFEIVWOK5VEPLK6U3XRTBGC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc6

for you to fetch changes up to 33c5aaf693d3fb78f6b8a9658939b72b7638243d:

  ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults tables (2026-08-05 13:34:37 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

A moderately large set of fixes, but mostly unremarkable:

 - A series of robustness fixes for the SOF code that came from testing.
 - Fixes for user visible issues with some of the Qualcomm controls.
 - Fixes to the register default tables in Cirrus drivers which ensure
   correcy syncing on resume.  This is a wider problem which will be
   fixed with a regmap core change but I'd already applied these, the
   rest of the fixes will come in the merge window.
 - Making the existing RT645 driver user selectable so it can be used
   with more machines.
 - Quite a few new AMD laptop quirks.
 - A MAINTAINERS update for SpacemiT.

----------------------------------------------------------------
Bard Liao (2):
      ASoC: SOF: topology: Use acpi mach from the machine driver
      ASoC/soundwire: Intel: reset the PCMSyCM registers in hda_sdw_bpt_close

Dawid Wróbel (2):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
      ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Mark Brown (2):
      ASoC: codecs: lpass-{tx,wsa}-macro: fix enum kcontrol accesses
      ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults tables

Peter Ujfalusi (6):
      ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
      ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
      ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout
      ASoC: cs35l41: sort the register default table
      ASoC: cs35l45: sort the register default table
      ASoC: cs4265: sort the register default table

Rudi Heitbaum (1):
      ASoC: rt5645: Make the Kconfig symbol user selectable

Troy Mitchell (1):
      MAINTAINERS: add SpacemiT K1/K3 I2S entry

Zhang Heng (3):
      ASoC: amd: yc: Add DMI quirk for HP Victus Laptop 16-e1xxx
      ASoC: amd: yc: Add DMI quirk for Xiaomi RedmiBook 16 2025
      ASoC: amd: yc: Add DMI quirk for MSI Raider A18 HX A7VHG

 MAINTAINERS                                        |  6 ++++
 drivers/soundwire/intel_ace2x.c                    |  4 ++-
 include/sound/hda-sdw-bpt.h                        |  5 ++--
 sound/soc/amd/yc/acp6x-mach.c                      | 22 ++++++++++++++-
 sound/soc/codecs/Kconfig                           |  2 +-
 sound/soc/codecs/cs35l41-lib.c                     |  2 +-
 sound/soc/codecs/cs35l45-tables.c                  | 32 ++++++++++-----------
 sound/soc/codecs/cs4265.c                          |  4 +--
 sound/soc/codecs/lpass-tx-macro.c                  |  4 +--
 sound/soc/codecs/lpass-wsa-macro.c                 |  8 +++---
 sound/soc/intel/common/sof-function-topology-lib.c |  7 ++++-
 sound/soc/sof/intel/hda-sdw-bpt.c                  | 31 ++++++++++++++++++--
 sound/soc/sof/ipc4-pcm.c                           | 25 ++++++++++++----
 sound/soc/sof/ipc4-topology.c                      | 33 ++++++++++++++++++++++
 sound/soc/sof/sof-audio.c                          |  9 +++---
 15 files changed, 149 insertions(+), 45 deletions(-)
