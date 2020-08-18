Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD00C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:34:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809552075E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MV+rIJxx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="weF124pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809552075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB4D617C2;
	Tue, 18 Aug 2020 20:33:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB4D617C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597775659;
	bh=z3RJLskj/Jyq/CGo7os6PDRfuJ/oWmhezKP1hysn1YU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MV+rIJxx8QaWqTSk+hJRs8wf47i/c7K/FJWp2eD1CjTw7Av16Hb10Du5we0y/Oipx
	 /ZT8k1VpxODSsdE2kOwFeEP4GdBffXPhoTlKuI+D+7D40t+5RlJ8azSKFfKjSRIZ2s
	 aaJVLg8FCReYku+pj3jj7ECdrNr51lY9NkC/MQiI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52B64F80104;
	Tue, 18 Aug 2020 20:33:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17B01F8023F; Tue, 18 Aug 2020 20:33:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66006F80104
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 20:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66006F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="weF124pC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BF8A2075E;
 Tue, 18 Aug 2020 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597775592;
 bh=z3RJLskj/Jyq/CGo7os6PDRfuJ/oWmhezKP1hysn1YU=;
 h=From:To:Cc:Subject:Date:From;
 b=weF124pCBcj51HYirRUv8pnfeco0ahbR5vzV1/TyCZxkMLYYeuly856YhTLbaXAIo
 oCB5/0VApx357OMZAkqHXds69l9G+GwXZobKd7RJjD2Y+3+8Uvr07xvHAFg0BBb6Ce
 Jjxw+Z7kqqjEqZ5mcq50JIWa+AduWOX+ntSE6rcM=
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.9-rc1
Date: Tue, 18 Aug 2020 19:32:36 +0100
Message-Id: <20200818183312.3BF8A2075E@mail.kernel.org>
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

The following changes since commit 8e34f1e867b572f1e20b5250c2897fe5f041c99f:

  Merge series "ASoC: core: Two step component registration" from Cezary Rojewski <cezary.rojewski@intel.com>: (2020-07-31 19:36:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.9-rc1

for you to fetch changes up to 062fa09f44f4fb3776a23184d5d296b0c8872eb9:

  ASoC: intel: Fix memleak in sst_media_open (2020-08-17 12:28:57 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.9

A bunch of fixes that came in during the merge window, mostly for issues
that were uncovered by the changes to report errors on invalid register
access plus one important fix in that code itself.

----------------------------------------------------------------
Dinghao Liu (1):
      ASoC: intel: Fix memleak in sst_media_open

Fabio Estevam (1):
      ASoC: wm8962: Do not remove ADDITIONAL_CONTROL_4 from readable register list

Hui Wang (1):
      ASoC: amd: renoir: restore two more registers during resume

Mark Brown (1):
      Merge series "ASoC: tegra: Fix compile warning with CONFIG_PM=n" from Takashi Iwai <tiwai@suse.de>:

Ravulapati Vishnu vardhan rao (1):
      ASoC: amd: Replacing component->name with codec_dai->name.

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level function

Srinivas Kandagatla (3):
      ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
      ASoC: q6routing: add dummy register read/write function
      ASoC: msm8916-wcd-analog: fix register Interrupt offset

Sylwester Nawrocki (2):
      ASoC: wm8994: Prevent access to invalid VU register bits on WM1811
      ASoC: wm8994: Avoid attempts to read unreadable registers

Takashi Iwai (7):
      ASoC: tegra: tegra186_dspk: Fix compile warning with CONFIG_PM=n
      ASoC: tegra: tegra210_admaif: Fix compile warning with CONFIG_PM=n
      ASoC: tegra: tegra210_ahub: Fix compile warning with CONFIG_PM=n
      ASoC: tegra: tegra210_dmic: Fix compile warning with CONFIG_PM=n
      ASoC: tegra: tegra210_i2s: Fix compile warning with CONFIG_PM=n
      ASoC: fsl: Fix unused variable warning
      ASoC: Make soc_component_read() returning an error code again

 sound/soc/amd/acp3x-rt5682-max9836.c         |   2 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c         |  29 ++--
 sound/soc/codecs/msm8916-wcd-analog.c        |   4 +-
 sound/soc/codecs/wm8958-dsp2.c               |   4 +
 sound/soc/codecs/wm8962.c                    |   2 +-
 sound/soc/codecs/wm8994.c                    |  60 ++++++--
 sound/soc/fsl/fsl-asoc-card.c                | 154 +++++++++-----------
 sound/soc/fsl/mpc5200_dma.c                  |   1 -
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |   5 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c             | 210 +++++++++++++--------------
 sound/soc/qcom/qdsp6/q6routing.c             |  16 ++
 sound/soc/soc-component.c                    |   2 +-
 sound/soc/tegra/tegra186_dspk.c              |   4 +-
 sound/soc/tegra/tegra210_admaif.c            |   4 +-
 sound/soc/tegra/tegra210_ahub.c              |   4 +-
 sound/soc/tegra/tegra210_dmic.c              |   4 +-
 sound/soc/tegra/tegra210_i2s.c               |   4 +-
 17 files changed, 266 insertions(+), 243 deletions(-)
