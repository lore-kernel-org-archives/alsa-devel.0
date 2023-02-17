Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE817C61DA4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Feb 2023 01:56:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1A94EF8;
	Fri, 17 Feb 2023 02:55:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1A94EF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676598988;
	bh=9mYAsN6b7GKU6N1COfBj1sVRbBaN/R6rMeAR8mgq6FI=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MZntD27Y0L1VacS5g0aCJ/z3DrYCNRCQOucRNZxSmJzOUvHri+xjFqzzAUiLxbnV+
	 5dK4WNLqXWu5QULxVtGv+pCwy1Yld2MdvCBpFpVWKA9BBFGZBmrWF1wJJVwQYazBXG
	 H1a8QqQTAdnaULt6kgk3WQvVkC3aYHMLVE/piHro=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ECBCF8047C;
	Fri, 17 Feb 2023 02:55:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14879F8047C; Fri, 17 Feb 2023 02:55:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2B210F80171
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2023 02:55:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B210F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a2hwSiim
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C60D9611FC;
	Fri, 17 Feb 2023 01:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA42CC433D2;
	Fri, 17 Feb 2023 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676598912;
	bh=9mYAsN6b7GKU6N1COfBj1sVRbBaN/R6rMeAR8mgq6FI=;
	h=From:To:Cc:Subject:Date:From;
	b=a2hwSiimCatvMFF16wdm5pSRa2r2JcH29OyPgw0mEXGGGgyCtt99oVBQrSclHquco
	 nwdhArIBNEvQgGjQa/3ZwZ63P2s2Vj/RO76O3lI3vxgySzUFgEgl7rpuVr5ZLSwEFn
	 nRacEtHJgsHp/DEeuHp3dS2YjxEcHuM66W2nepoVrfdHL1ZZ6vih+Ab6SpLVsS00CP
	 SEKOH/FXCvdO3U/O+ingGw3GclK69SU8y008V+lMONIBNVtTUD6jvjZBgHuiDrNC+T
	 LW48xgPwHV1w0D1cFyw0jc3GgGnreKMVgNENcYkKzW8+0SpVEM5lt73qbisab7Npv3
	 m37YFGp1zLuPw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v6.2-rc8-2
Date: Fri, 17 Feb 2023 01:55:04 +0000
Message-Id: <20230217015511.CA42CC433D2@smtp.kernel.org>
Message-ID-Hash: DEXVTRZD6EZKIR2EUF5XPN2E4A5TVTBM
X-Message-ID-Hash: DEXVTRZD6EZKIR2EUF5XPN2E4A5TVTBM
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DEXVTRZD6EZKIR2EUF5XPN2E4A5TVTBM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit c173ee5b2fa6195066674d66d1d7e191010fb1ff:

  ASoC: topology: Return -ENOMEM on memory allocation failure (2023-02-07 14:06:26 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.2-rc8-2

for you to fetch changes up to 1f810d2b6b2fbdc5279644d8b2c140b1f7c9d43d:

  ASoC: SOF: Intel: hda-dai: fix possible stream_tag leak (2023-02-16 16:31:15 +0000)

----------------------------------------------------------------
ASoC: One more fix for v6.2

One more fix from Peter which he'd very much like to get into
v6.2.

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: hda-dai: fix possible stream_tag leak

Rander Wang (1):
      ASoC: SOF: ops: refine parameters order in function snd_sof_dsp_update8

 sound/soc/sof/intel/hda-dai.c | 8 ++++----
 sound/soc/sof/ops.h           | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
