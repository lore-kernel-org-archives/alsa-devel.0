Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A44010FC45A
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:20:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B95F560207;
	Thu,  9 Apr 2026 00:20:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B95F560207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775686818;
	bh=1tOYVE+w3uMQ+EqlDxAz1buO2eF+iMKzJJkAk8cPpM8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=d/cezv0LMPQP2NiLuTv7ctWXaz0eyYCTI89QFL+C75rnJb4FSgzgpvG2uk+wK+Mte
	 WjCa6h2t/VZMy9UQ345+xgv2mS89UTEdB6dMfVAD+EIAvTrePIPuTrSrgXAa26k5lF
	 NlLO7BvoJ2WX1OUSlJnp4Z8piNoOSMlncPCJ0+9g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EBFFF805F0; Thu,  9 Apr 2026 00:19:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5CF2F805E8;
	Thu,  9 Apr 2026 00:19:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D54FFF800BA; Thu,  9 Apr 2026 00:19:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89BA1F800BA
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 00:19:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89BA1F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FsUiYRAQ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A70743C5C;
	Wed,  8 Apr 2026 22:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C3C19421;
	Wed,  8 Apr 2026 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686767;
	bh=1tOYVE+w3uMQ+EqlDxAz1buO2eF+iMKzJJkAk8cPpM8=;
	h=From:To:Cc:Subject:Date:From;
	b=FsUiYRAQd8GbSG1xn1ZSzrdPVfNN6FaBvEgY7v1grai3J1qEG4z9L0jUkzS/KdjbE
	 XlVZRUq6Nt2a8kw81KEI4Tot4e4J3gdWT/0UgnkP7PyeGzaEfhZaZz6+f9yoZLmzV8
	 MDkipJRAWY7AtzGGkzdFzKrQpVfv/51DFA6F0b1B4bRckBgNaOGno7OAeXtlhc13s/
	 AYLqDNnRzGnw3X7v6M0tik8dOl5F2VFGRoXshieCa9ca/lZBWWWHrnwXureR6IMmQO
	 qYZ17iCwqTA1++zf6i/d/1TZt9fameqbnupaXiScafOCo2ePBEO2ujTYakasHK9Bq7
	 jNC4gThGy1kIA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6194F1AC52C7; Wed, 08 Apr 2026 23:19:22 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.0-rc7
Date: Wed, 08 Apr 2026 23:19:17 +0100
Message-Id: <20260408221922.6194F1AC52C7@finisterre.sirena.org.uk>
Message-ID-Hash: HNT3UKXAK7E5SAMCBK7TJE5VB7HBFP63
X-Message-ID-Hash: HNT3UKXAK7E5SAMCBK7TJE5VB7HBFP63
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HNT3UKXAK7E5SAMCBK7TJE5VB7HBFP63/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2:

  Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc7

for you to fetch changes up to 6b6f7263d626886a96fce6352f94dfab7a24c339:

  ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms (2026-04-08 17:04:47 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.0

A somewhat larger set of fixes than I'd like unfortunatey, not from any
one place but rather spread out over different drivers.  We've got a
bunch more fixes for the SDCA interrupt support, several relatively
minor SOF fixes, a few more driver specific fixes and a couple more AMD
quirks.

----------------------------------------------------------------
Cezary Rojewski (1):
      ASoC: Intel: avs: Fix memory leak in avs_register_i2s_test_boards()

Charles Keepax (1):
      ASoC: SDCA: Fix errors in IRQ cleanup

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: modify period size constraints for ACE4

Maciej Strozek (4):
      ASoC: SOF: Intel: Fix endpoint index if endpoints are missing
      ASoC: SOF: Intel: fix iteration in is_endpoint_present()
      ASoC: SDCA: Fix overwritten var within for loop
      ASoC: SDCA: mask Function_Status value

Marek Vasut (1):
      ASoC: dt-bindings: ti,tas2552: Add sound-dai-cells

Mark Brown (1):
      ASoC: SOF: Intel: Fixes for find_acpi_adr_device() when some endpoints are missing

Mark Pearson (1):
      ASoC: amd: acp: add Lenovo P16s G5 AMD quirk for legacy SDW machine

Neo Chang (1):
      ASoC: nau8325: Add software reset during probe

Richard Fitzgerald (1):
      ASoC: SDCA: Unregister IRQ handlers on module remove

Syed Saba Kareem (1):
      ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms

Tomasz Merta (1):
      ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

 .../devicetree/bindings/sound/ti,tas2552.yaml      | 13 +++-
 include/sound/sdca_interrupts.h                    |  5 ++
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            | 24 +++++--
 sound/soc/codecs/nau8325.c                         |  9 ++-
 sound/soc/intel/avs/board_selection.c              |  9 ++-
 sound/soc/sdca/sdca_class_function.c               | 17 +++++
 sound/soc/sdca/sdca_interrupts.c                   | 82 +++++++++++++++++++---
 sound/soc/sof/intel/hda-pcm.c                      | 14 +++-
 sound/soc/sof/intel/hda.c                          | 10 ++-
 sound/soc/stm/stm32_sai_sub.c                      |  3 +
 10 files changed, 159 insertions(+), 27 deletions(-)
