Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FD4CCF9E3
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Oct 2025 11:34:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EA756021C;
	Thu, 30 Oct 2025 12:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EA756021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1761824064;
	bh=A2EXzEfFIDj3kCbeKHlD4mRCBPWGMPgbKkBT9SNZlXU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=E5VXS3TKboxz55RFOV5EpZXUDBUXgwhNIumlzzAKS2ql19lZyKr96fOn49wgWAP05
	 O5GH9nDLnv71ntYVeCQfw/Hhc1ZTvZYNPdfxK2+x5la7F5Hi6pfQYnBitBRPRT+G7w
	 nfpWqhpkpmVFaR1G5gLfTgNsNg5SVlDd9ZOcYXbI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D4F3F805D2; Thu, 30 Oct 2025 12:33:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71D63F805D4;
	Thu, 30 Oct 2025 12:33:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F242F80240; Thu, 30 Oct 2025 12:33:26 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10EC1F800C1
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2025 12:33:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10EC1F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IrjkNu1g
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 988F962041;
	Thu, 30 Oct 2025 11:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8177C4CEF1;
	Thu, 30 Oct 2025 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761824001;
	bh=A2EXzEfFIDj3kCbeKHlD4mRCBPWGMPgbKkBT9SNZlXU=;
	h=From:To:Cc:Subject:Date:From;
	b=IrjkNu1g1E6Bb/SUllOiU3zQbupn/vEwxoU4OCCjlNxaEdmeNNoTJfQQeNoTn67bk
	 rwjmjpFhIwhRpOOkpAWWsxiI/Dz5o77HErsJBUzrgg6ZNQTSYsOdAxNHp+M5ZQRmUP
	 lBoFKkGuBSv1Yf7g+Ma8Bq7KumJxGhwWlwhv3f3z+Zct7FXqJseZ3dLpguvvUMkT66
	 f63zl2BKGXAjAXRDnp112HE9uBQAbf73apfR1NxVhrAAEfI2iSKXP1ATkTE3N9tg/J
	 AN5C8BqNS+FYwTwAHRNE2BLJYsTVLKer5K5n2L7+QkQNRt6v7gDH9iohJH5zrknmrT
	 H8jM4NDEJYuLA==
Message-ID: <741e6973e073ce0ea4f6e17d7b1b080e@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.18-rc2
Date: Thu, 30 Oct 2025 11:33:11 +0000
Message-ID-Hash: 2TSHA4IMYK4CAZUGBQUTTHN66DWJ6C3U
X-Message-ID-Hash: 2TSHA4IMYK4CAZUGBQUTTHN66DWJ6C3U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2TSHA4IMYK4CAZUGBQUTTHN66DWJ6C3U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.18-rc2

for you to fetch changes up to 5e5c8aa73d99f1daa9f2ec1474b7fc1a6952764b:

  ASoC: dt-bindings: pm4125-sdw: correct number of soundwire ports (2025-10-29 14:54:47 +0000)

----------------------------------------------------------------
ASoC: Fixes for v6.18

A bigger batch of fixes than I'd like, things built up due to holidays
and some last minute issues which caused me to hold off on sending a pul
request.  None of these are super remarkable, and there's a few new
device IDs in here too including a relatively big block of AMD devices.

The Cirrus Logic CS530x support subject line is actually a fix that was
on the start of that series and got pulled in here, I forgot to fix the
subject up when merging.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: soc_sdw_utils: remove cs42l43 component_name

Cezary Rojewski (3):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs
      ASoC: Intel: avs: Disable periods-elapsed work when closing PCM
      ASoC: Intel: avs: Use snd_codec format when initializing probe

Claudiu Beznea (1):
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

Haotian Zhang (1):
      ASoC: mediatek: Fix double pm_runtime_disable in remove functions

Maarten Zanders (1):
      ASoC: fsl_sai: Fix sync error in consumer mode

Mark Brown (4):
      Add support for Cirrus Logic CS530x DAC and CODEC
      ASoC: Intel: avs: Set of streaming fixes
      ASoC: fsl: correct the bit order issue for DSD
      ASoC: Fix build for sdw_utils

Richard Fitzgerald (1):
      ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h

Sharique Mohammad (1):
      ASOC: max98090/91: fix for filter configuration: AHPF removed DMIC2_HPF added

Shengjiu Wang (2):
      ASoC: fsl_sai: fix bit order for DSD format
      ASoC: fsl_micfil: correct the endian format for DSD

Shuming Fan (2):
      ASoC: sdw_utils: add name_prefix for rt1321 part id
      ASoC: rt721: fix prepare clock stop failed

Simon Trimmer (3):
      ASoC: cs530x: Correct log message with expected variable
      ASoC: amd: acp: Add ACP7.0 match entries for cs35l56 and cs42l43
      ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43 match from sdw link3

Srinivas Kandagatla (2):
      ASoC: qdsp6: q6asm: do not sleep while atomic
      ASoC: dt-bindings: pm4125-sdw: correct number of soundwire ports

 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   4 +-
 sound/soc/amd/acp/amd-acp70-acpi-match.c           | 157 +++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib-test.c                 |   1 +
 sound/soc/codecs/cs530x.c                          |   2 +-
 sound/soc/codecs/max98090.c                        |   6 +-
 sound/soc/codecs/rt721-sdca.c                      |   4 +
 sound/soc/codecs/rt721-sdca.h                      |   1 +
 sound/soc/fsl/fsl_micfil.c                         |   4 +-
 sound/soc/fsl/fsl_sai.c                            |  11 +-
 sound/soc/intel/avs/pcm.c                          |   3 +
 sound/soc/intel/avs/probes.c                       |  18 +--
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  52 -------
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |   1 -
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |   1 -
 sound/soc/qcom/qdsp6/q6asm.c                       |   2 +-
 sound/soc/renesas/rz-ssi.c                         |  25 ++--
 sound/soc/sdw_utils/soc_sdw_utils.c                |   1 -
 17 files changed, 203 insertions(+), 90 deletions(-)
