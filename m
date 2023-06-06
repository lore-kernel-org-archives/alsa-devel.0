Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6416CC7EE2F
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 13:08:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2F57826;
	Tue,  6 Jun 2023 15:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2F57826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686056881;
	bh=we2pu8aUOHA8UubDuAkoGkbGSgYMZCI04YsgSiPDeMs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GOTVQUctcxyS2oAdiBO2kG1XtD9gNwf/xqbEufCt1z10Iu9VftnOnzyLeBN8xHEgm
	 2gZ3hzJFomyth1oilV58W7G5topP5p+Nuy7+zZCbHj5GkKPcu63de8OeQTlqlDlBVf
	 sksZGzplhAnloCOBPaoeucBOxndb1hDF+eSVJryw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1C00F804DA; Tue,  6 Jun 2023 15:06:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60EF9F80199;
	Tue,  6 Jun 2023 15:06:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F349F80199; Tue,  6 Jun 2023 15:06:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63E94F800C8
	for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2023 15:06:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63E94F800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bGXYD2Da
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 33A16632AA;
	Tue,  6 Jun 2023 13:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F30AC433EF;
	Tue,  6 Jun 2023 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686056782;
	bh=we2pu8aUOHA8UubDuAkoGkbGSgYMZCI04YsgSiPDeMs=;
	h=From:To:Cc:Subject:Date:From;
	b=bGXYD2Dao9zpHic6FWjuWRtoTkUAfyLDnbW1iVzwcasgh99c1nHIG9F8YSUKhfFQQ
	 Eam/RvzYM/ouDe1h5OjvuWNceKqMIFbiVEQMKxFT97VKZ5UMujsKglzTrkOhNN3KXa
	 6vlK1OUmi+6pi1I500BOaNTEG4tNsZtuvUI2pQvL8pomnhih/rLilY2IRKeYzcc/hW
	 NCb0SH49TbV4ikmRSLvClZBKhaUVVrQWiN/fR8tbWOX+YmCmbXEfCvYavi8LYczzKr
	 9AldIBYYUpGibsa0kAHj4973m1of6f6elGYIVgsISmSGrh82h1xDLlfkPEwP3FGigB
	 nmcJ94yRe7w/A==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.4-rc6
Date: Tue, 06 Jun 2023 14:06:10 +0100
Message-Id: <20230606130622.3F30AC433EF@smtp.kernel.org>
Message-ID-Hash: VVB7NKRSHHG3ABWNCEZMQQUQGDVZKTMV
X-Message-ID-Hash: VVB7NKRSHHG3ABWNCEZMQQUQGDVZKTMV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVB7NKRSHHG3ABWNCEZMQQUQGDVZKTMV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 011a8719d6105dcb48077ea7a6a88ac019d4aa50:

  ASoC: dwc: move DMA init to snd_soc_dai_driver probe() (2023-05-23 21:39:30 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.4-rc6

for you to fetch changes up to 32cf0046a652116d6a216d575f3049a9ff9dd80d:

  ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted (2023-06-02 12:54:07 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.4

A lot of routine driver specific fixes here, nothing in the core though
there are a couple of fixes for the generic cards.  There's also a few
new quirks for x86 platforms.

----------------------------------------------------------------
Chancel Liu (1):
      ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Herve Codina (1):
      ASoC: simple-card: Add missing of_node_put() in case of error

Mark Brown (1):
      ASoC: mediatek: fix use-after-free in driver remove

Richard Fitzgerald (1):
      ASoC: cs35l56: Remove NULL check from cs35l56_sdw_dai_set_stream()

Robert Hancock (1):
      ASoC: simple-card-utils: fix PCM constraint error check

Ryan Lee (2):
      ASoC: max98363: Removed 32bit support
      ASoC: max98363: limit the number of channel to 1

Sicong Jiang (1):
      ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x

Srinivas Kandagatla (3):
      ASoC: codecs: wsa883x: do not set can_multi_write flag
      ASoC: codecs: wsa881x: do not set can_multi_write flag
      ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag

Trevor Wu (2):
      ASoC: mediatek: mt8188: fix use-after-free in driver remove path
      ASoC: mediatek: mt8195: fix use-after-free in driver remove path

Vijendar Mukunda (1):
      ASoC: amd: ps: fix for acp_lock access in pdm driver

 sound/soc/amd/ps/pci-ps.c                     |  3 +-
 sound/soc/amd/ps/ps-pdm-dma.c                 | 10 +++---
 sound/soc/amd/yc/acp6x-mach.c                 |  7 ++++
 sound/soc/codecs/cs35l56.c                    |  3 --
 sound/soc/codecs/max98363.c                   |  4 +--
 sound/soc/codecs/nau8824.c                    | 24 ++++++++++++++
 sound/soc/codecs/wcd938x-sdw.c                |  1 -
 sound/soc/codecs/wsa881x.c                    |  1 -
 sound/soc/codecs/wsa883x.c                    |  1 -
 sound/soc/fsl/fsl_sai.c                       | 11 +++++--
 sound/soc/fsl/fsl_sai.h                       |  1 +
 sound/soc/generic/simple-card-utils.c         |  2 +-
 sound/soc/generic/simple-card.c               |  1 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    |  7 ----
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  1 -
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |  4 ---
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c | 47 ++++++++++++++-------------
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |  1 -
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c    |  5 ---
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h    |  1 -
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |  4 ---
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c | 47 ++++++++++++++-------------
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h |  1 -
 23 files changed, 99 insertions(+), 88 deletions(-)
