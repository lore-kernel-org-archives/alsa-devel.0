Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C4C3DA6E
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Dec 2023 13:21:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08E731FA;
	Wed, 20 Dec 2023 14:20:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08E731FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703078461;
	bh=rApjkj+L6vz2oCRYYXZO6keQHYvcgud+xsmIf0zo2Yg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=D5wIm04LWXX4um4L3dF2SY10v0LBKu4ZkQboeoQ/2Yzbj4ubutRubH05nI28h+jDh
	 anVi7rjZrPh9XA3BXwDifceSUzEiPyI+5C2TGj/kox3dc7jt/1XcXRG9T4VZioPuQg
	 djeWG7vv0eep/7I/ceGI7Jcup0oBbZKovcG2FYKk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E98DF8057A; Wed, 20 Dec 2023 14:20:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9461DF8059F;
	Wed, 20 Dec 2023 14:20:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87691F80425; Wed, 20 Dec 2023 14:20:24 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E05BF8016E
	for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2023 14:20:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E05BF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vKe0TYfW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 58347CE1D1F;
	Wed, 20 Dec 2023 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D651C433CB;
	Wed, 20 Dec 2023 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703078411;
	bh=rApjkj+L6vz2oCRYYXZO6keQHYvcgud+xsmIf0zo2Yg=;
	h=From:To:Cc:Subject:Date:From;
	b=vKe0TYfWH98SpyNIL/5qSQcFmZQjlnymGtcV0kfmtO6s8kncQQU2uVOSxrwHI4uH3
	 o912qNHqBh1w89UzKbRGEhS0DnZkxBCvMAicWkC/hCrqeqTM6gnitGjjK7sF1YWKq4
	 sYeQRJNI3v04Jeirw1vSzSdjxZ6pO9pGPKs3RwV0JF6W/pYs6w4PCkzfraz9P+krXw
	 t7eByFI09rL6fh3Kx3gufskgeR3nJQuL3KyDNZ7lM4aIKCRzNSIoeTJz8XTpF53m+T
	 eUCj0PFX5NyccjwhGayRcR3dtXlQrJp706z3VFs9G0Qz77LTT1cyvklqzkqC2ZysBa
	 mYSqksUfxW/Og==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.7-rc7
Date: Wed, 20 Dec 2023 13:20:03 +0000
Message-Id: <20231220132011.3D651C433CB@smtp.kernel.org>
Message-ID-Hash: S3QFM4XZYKF2YM6KV47NAKZ2SCED6W6R
X-Message-ID-Hash: S3QFM4XZYKF2YM6KV47NAKZ2SCED6W6R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3QFM4XZYKF2YM6KV47NAKZ2SCED6W6R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 0a10d15280a385e5971fb58a6d2eddbf7c0aa9f3:

  ASoC: qcom: Limit Digital gains on speaker (2023-12-04 21:42:29 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.7-rc7

for you to fetch changes up to 8f0f01647550daf9cd8752c1656dcb0136d79ce1:

  ASoC: fsl_sai: Fix channel swap issue on i.MX8MP (2023-12-19 13:23:39 +0000)

----------------------------------------------------------------
ASoC: Fixes for v6.7

Quite a big collection of fixes, as ever mostly in drivers.  There's one
framework fix for the HDMI CODEC where it wasn't handling startup
properly for some controllers, and one new x86 quirk, but otherwise all
local fixes or dropping things we don't want to see in a release.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: cs42l43: Don't enable bias sense during type detect

Curtis Malainey (1):
      ASoC: SOF: mediatek: mt8186: Revert Add Google Steelix topology compatible

Gergo Koteles (1):
      ASoC: tas2781: check the validity of prm_no/cfg_no

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346
      ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk

Jerome Brunet (1):
      ASoC: hdmi-codec: fix missing report for jack initial status

Ricardo Rivera-Matos (3):
      ASoC: cs35l45: Use modern pm_ops
      ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
      ASoC: cs35l45: Prevents spinning during runtime suspend

Richard Fitzgerald (1):
      ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56 prefixes to AMPn

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix channel swap issue on i.MX8MP

 sound/soc/codecs/cs35l45-i2c.c                    |  2 +-
 sound/soc/codecs/cs35l45-spi.c                    |  2 +-
 sound/soc/codecs/cs35l45.c                        | 56 +++++++++++++++++++++--
 sound/soc/codecs/cs42l43-jack.c                   | 23 +++++-----
 sound/soc/codecs/hdmi-codec.c                     | 12 ++++-
 sound/soc/codecs/tas2781-fmwlib.c                 | 14 +++---
 sound/soc/fsl/fsl_sai.c                           |  3 ++
 sound/soc/intel/boards/bytcr_rt5640.c             | 31 ++++++++++---
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |  8 ++--
 sound/soc/sof/mediatek/mt8186/mt8186.c            |  3 --
 10 files changed, 115 insertions(+), 39 deletions(-)
