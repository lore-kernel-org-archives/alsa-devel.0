Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:35:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A0F2078C
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AvLjrOxA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQN9bSQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A0F2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D7E715E4;
	Wed, 10 Jun 2020 15:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D7E715E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591796116;
	bh=bl5yzB7vi8WFQIVuecBwapmhsrlhlbNHxyMPs9md7Fo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AvLjrOxAEzP1b1RkgKDDxDZMY6JgV8DmLFkGNoAlmiWVZZci+s0qxxUKn8wLSXzfK
	 eifVO7TwsVC03Whzr0FzOKTdIVLyCIcrP3VKLhxDd0Ls6GD03omZqAdwfnMa74W3jM
	 HPhNx8kXo53iGdKnHHqNgWKvdAXsCPvF3bbidTPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFB1EF801F7;
	Wed, 10 Jun 2020 15:34:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65527F8021C; Wed, 10 Jun 2020 15:34:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE268F800E0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 15:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE268F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SQN9bSQ2"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 97D6E2067B;
 Wed, 10 Jun 2020 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591796053;
 bh=bl5yzB7vi8WFQIVuecBwapmhsrlhlbNHxyMPs9md7Fo=;
 h=From:To:Cc:Subject:Date:From;
 b=SQN9bSQ2Q1FL/f1p4Ie+mEgwhUKUan+ZBqGlUrQEM5CQIcIx+s3XapEi8m/nkTzjU
 AWyXdlRa3Bzjwkj6ZQaDQuLpQ2E8dhiQmN4guRi3bMvl/ACQd5oH/bZ2eCunOlO3fl
 JaanVzVbQPFB7AgvmUQsESc17S7txmbeM6jP2Z/o=
From: broonie@kernel.org
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.8
Date: Wed, 10 Jun 2020 14:34:09 +0100
Message-Id: <20200610133412.97D6E2067B@mail.kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The following changes since commit a6b675a89e51a1cdad0481b809b7840d3f86e4b5:

  ASoC: qcom: q6asm-dai: kCFI fix (2020-06-01 12:15:53 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.8

for you to fetch changes up to 44ce45f866c1606f03a411fb2d2c0db4626403a6:

  Merge series "ASoC: Fix dailink checks for DPCM" from Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>: (2020-06-09 15:46:20 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.8

A small pile of fixes that came in during the merge window, the DPCM
fixes from Pierre are the most notable thing here.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: core: only convert non DPCM link to DPCM link

Colin Ian King (1):
      ASoC: meson: fix memory leak of links if allocation of ldata fails

Dan Murphy (1):
      dt-bindings: ASoc: Fix tdm-slot documentation spelling error

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for Toshiba Encore WT10-A tablet
      ASoC: rt5645: Add platform-data for Asus T101HA

Mark Brown (1):
      Merge series "ASoC: Fix dailink checks for DPCM" from Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:

Oder Chiou (1):
      ASoC: rl6231: Modify the target DMIC clock rate

Pavel Machek (CIP) (1):
      ASoC: meson: add missing free_irq() in error path

Pierre-Louis Bossart (3):
      ASoC: soc-pcm: dpcm: fix playback/capture checks
      ASoC: Intel: boards: replace capture_only by dpcm_capture
      ASoC: SOF: nocodec: conditionally set dpcm_capture/dpcm_playback flags

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: Defer probe when fail to find codec device

Steve Lee (1):
      ASoC: max98390: Fix potential crash during param fw loading

Takashi Iwai (1):
      ASoC: max98390: Fix incorrect printf qualifier

 .../devicetree/bindings/sound/tdm-slot.txt         |  4 +-
 sound/soc/codecs/max98390.c                        | 26 ++++++++++---
 sound/soc/codecs/max98390.h                        |  3 +-
 sound/soc/codecs/rl6231.c                          |  4 +-
 sound/soc/codecs/rt5645.c                          | 14 +++++++
 sound/soc/fsl/fsl-asoc-card.c                      |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              | 12 ++++++
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |  2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c       |  4 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |  2 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  2 +-
 sound/soc/meson/axg-fifo.c                         | 10 ++++-
 sound/soc/meson/meson-card-utils.c                 | 17 ++++++---
 sound/soc/soc-core.c                               | 22 +++++++++--
 sound/soc/soc-pcm.c                                | 44 +++++++++++++++++-----
 sound/soc/sof/nocodec.c                            |  6 ++-
 16 files changed, 136 insertions(+), 38 deletions(-)
