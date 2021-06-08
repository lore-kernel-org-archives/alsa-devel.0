Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF1C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:33:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3AE60E08
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3AE60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F80D18ED;
	Tue,  8 Jun 2021 16:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F80D18ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623162818;
	bh=ySJum2N1Bq5jIihataE82A9SoqKPSzngG4fBud3AYTs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XcgVf5OVuG1CQg2/rShfyFASsQCA5QF60iFpxzr2RA/4gbhA8Epm+1ATpVAv+ZMbO
	 D54jg9IrBR3ovzSAIRBfjURm0sV4pPfGNWauYerA82rLa2WBZwtNIpBxNrw/xalZPA
	 i5NBY6qjYbSLuH4ygTUz/Vd4/7eh4+hi69a1g5kI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3921F804B2;
	Tue,  8 Jun 2021 16:26:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C232F804BD; Tue,  8 Jun 2021 16:26:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CF82F801EC
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 16:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CF82F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A3NaUlcu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A1261003;
 Tue,  8 Jun 2021 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623162397;
 bh=ySJum2N1Bq5jIihataE82A9SoqKPSzngG4fBud3AYTs=;
 h=From:To:Cc:Subject:Date:From;
 b=A3NaUlcunrQevQ5H7CnNf+QovAzO1f6xB99CMZWaZZYuU85yx7RCbymdfKz6vjEG2
 Sw6YTR7Wo216y+YkHAOVtIztHA0XksusuO1K7L7e3Lil5bjk9vL6PEc1Kkj6ohYCGv
 EDl/mHJPwewYmU2asNL6IKKTREpvDcFsOpoPwk2rtQGw0+hQebWcYPEk9quCTod9ZE
 Cnz1V4JU7CC5tqmG5Np/r2iRG91yJCrsrq8zysrB+BSIV9JjHgh7VtWzpfE77kxGTJ
 CDu/O8WE2xx5uksLd3XddpdFYbHOOLH8AWos7UIIoX1KlbPAeWZoibCo2PIO9FTfze
 T37MADRSY1UOQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.13-rc4
Date: Tue, 08 Jun 2021 15:26:04 +0100
Message-Id: <20210608142636.97A1261003@mail.kernel.org>
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

The following changes since commit af2702549d68519ac78228e915d9b2c199056787:

  ASoC: qcom: lpass-cpu: Use optional clk APIs (2021-05-21 13:12:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.13-rc4

for you to fetch changes up to c8a4556d98510ca05bad8d02265a4918b03a8c0b:

  ASoC: qcom: lpass-cpu: Fix pop noise during audio capture begin (2021-06-07 15:54:08 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.13

A collection of fixes and device ID updates that have come up in the
past few -rcs, none of which stand out particularly.

----------------------------------------------------------------
Colin Ian King (1):
      ASoC: topology: Fix spelling mistake "vesion" -> "version"

Jack Yu (1):
      ASoC: rt5659: Fix the lost powers for the HDA header

Jerome Brunet (1):
      ASoC: meson: gx-card: fix sound-dai dt schema

Kai Vehmanen (1):
      ASoC: SOF: reset enabled_cores state at suspend

Kefeng Wang (1):
      ASoC: core: Fix Null-point-dereference in fmt_single_name()

Mark Pearson (2):
      ASoC: AMD Renoir - add DMI entry for Lenovo 2020 AMD platforms
      ASoC: AMD Renoir: Remove fix for DMI entry on Lenovo 2020 platforms

Nicolas Cavallari (1):
      ASoC: fsl-asoc-card: Set .owner attribute when registering card.

Oder Chiou (1):
      ASoC: rt5682: Fix the fast discharge for headset unplugging in soundwire mode

Richard Weinberger (1):
      ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-cpu: Fix pop noise during audio capture begin

 .../bindings/sound/amlogic,gx-sound-card.yaml      |  4 +-
 sound/soc/codecs/rt5659.c                          | 26 +++++--
 sound/soc/codecs/rt5682-sdw.c                      |  3 +-
 sound/soc/codecs/tas2562.h                         | 14 ++--
 sound/soc/fsl/fsl-asoc-card.c                      |  1 +
 sound/soc/qcom/lpass-cpu.c                         | 79 ++++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  4 ++
 sound/soc/soc-core.c                               |  2 +
 sound/soc/soc-topology.c                           |  6 +-
 sound/soc/sof/pm.c                                 |  1 +
 10 files changed, 122 insertions(+), 18 deletions(-)
