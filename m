Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C831C55178
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:46:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3482071A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mOb+3s3U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz+QV/Ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3482071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DCE9167B;
	Thu,  5 Nov 2020 17:45:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DCE9167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604594790;
	bh=Vt+t2db5H6Eu07/CxyzNGF//JZ6BS+pvDId1rslEye0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mOb+3s3U6I8tSEfuYcwDr4ftkqK3lkrfEwjRW0fce/23DPbcjwGbLhXQcplaH2Lkf
	 Z1BS7GCP9peUpmBCOUpYsL8B3AkQ9DGsXkBp450kl4oAY7eDP4CQ6/x6Zg7yG/rg7Y
	 Wg2Z+4pOX7VKWn0VpbBoYQmxeH2G/Hd3CvTUWgaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ACD4F80150;
	Thu,  5 Nov 2020 17:45:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83364F80162; Thu,  5 Nov 2020 17:45:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDBBFF800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 17:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDBBFF800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Nz+QV/Ro"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8673D2080D;
 Thu,  5 Nov 2020 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604594727;
 bh=Vt+t2db5H6Eu07/CxyzNGF//JZ6BS+pvDId1rslEye0=;
 h=From:To:Cc:Subject:Date:From;
 b=Nz+QV/RoXXH/ZOjWxM7gzf//wiBJVOtUspfFpJEbfm0bMzyjLeZQiyWVKg34UMVIN
 9oOvIAL6Nu021Vv7xE6g3+Mh9gK6qOTB4pWAV8lludfa64/mM2bxTAPXxJyOW2Qy3/
 9yVyS0oFbk31WbLwgWryt9X7QbmVkqxkJ2xCB2II=
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.10-rc2
Date: Thu, 05 Nov 2020 16:45:06 +0000
Message-Id: <20201105164526.8673D2080D@mail.kernel.org>
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

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.10-rc2

for you to fetch changes up to f9d7c6eb23f7e55e7a0ca5451da06909bdfdd0e4:

  ASoC: mchp-spdiftx: Do not set Validity bit(s) (2020-11-04 17:50:22 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.10

A batch of driver specific fixes that have come up since the merge
window, nothing particularly major here but all good to have.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: SOF: loader: handle all SOF_IPC_EXT types

Cezary Rojewski (3):
      ASoC: Intel: atom: Remove duplicate kconfigs
      ASoC: Intel: catpt: Wake up device before configuring SSP port
      ASoC: Intel: catpt: Relax clock selection conditions

Codrin Ciubotariu (1):
      ASoC: mchp-spdiftx: Do not set Validity bit(s)

Mark Brown (1):
      Merge tag 'v5.10-rc1' into asoc-5.10

Olivier Moysan (1):
      ASoC: cs42l51: manage mclk shutdown delay

Srinivas Kandagatla (4):
      ASoC: codecs: wsa881x: add missing stream rates and format
      ASoC: qcom: sdm845: set driver name correctly
      ASoC: codecs: wcd934x: Set digital gain range correctly
      ASoC: codecs: wcd9335: Set digital gain range correctly

Tomasz Figa (1):
      ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup function

Tzung-Bi Shih (1):
      ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015

V Sujith Kumar Reddy (2):
      ASoC: qcom: lpass-sc7180: Fix MI2S bitwidth field bit positions
      ASoC: qcom: lpass-cpu: Fix clock disable failure

 sound/soc/atmel/mchp-spdiftx.c                     |  1 -
 sound/soc/codecs/cs42l51.c                         | 22 +++++++++++-
 sound/soc/codecs/wcd9335.c                         |  2 +-
 sound/soc/codecs/wcd934x.c                         |  2 +-
 sound/soc/codecs/wsa881x.c                         |  2 ++
 sound/soc/intel/Kconfig                            | 18 ----------
 sound/soc/intel/atom/Makefile                      |  2 +-
 sound/soc/intel/atom/sst/Makefile                  |  6 ++--
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 39 +++++++++++++++++-----
 sound/soc/intel/catpt/dsp.c                        |  9 +++--
 sound/soc/intel/catpt/pcm.c                        | 10 ++++++
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 31 +++++++++++++----
 sound/soc/qcom/lpass-cpu.c                         | 14 +++++---
 sound/soc/qcom/lpass-sc7180.c                      |  2 +-
 sound/soc/qcom/sdm845.c                            |  2 ++
 sound/soc/sof/loader.c                             |  5 +++
 16 files changed, 119 insertions(+), 48 deletions(-)
