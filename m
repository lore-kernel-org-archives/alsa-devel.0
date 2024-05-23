Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6805C25B75
	for <alsa-devel@archiver.kernel.org>; Thu, 23 May 2024 11:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02AE1205;
	Thu, 23 May 2024 13:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02AE1205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716463698;
	bh=qHnqOQm+T3FYzT5KuGF3uLvCPQEfVanQr6BZcx8ARU4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ETEfmZ2fIBrf8b7Po6WDjwTVcVxYkHMvhoW67YvCIyj3uuOeR6wj10f2K1UyCkaYk
	 8l0inbGQROr2F6UTpLfsemRcpN6V/wlw3fg01RMihVw8mxR+qaB2AfxFuXgHEgbOPf
	 FGyg5f7mAMJAeHOhwjL0VGqKKLwmeHulekC041ag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E1FAF8051D; Thu, 23 May 2024 13:27:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1A7EF805AC;
	Thu, 23 May 2024 13:27:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66503F8026A; Thu, 23 May 2024 13:24:51 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 008DBF80051
	for <alsa-devel@alsa-project.org>; Thu, 23 May 2024 13:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 008DBF80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pHcw8kxt
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 31F21CE1322;
	Thu, 23 May 2024 11:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A61C2BD10;
	Thu, 23 May 2024 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716463476;
	bh=qHnqOQm+T3FYzT5KuGF3uLvCPQEfVanQr6BZcx8ARU4=;
	h=From:To:Cc:Subject:Date:From;
	b=pHcw8kxtxes6TQemSMrEe4uRUJFwFcGBUE06wecpZkZcLL42xpB9zmJCZtiGn384O
	 PbkT35L5TJsmiicDv5fsKViVWNDliHsWMSLSUAmIJ4w2gfRhiazrrKADcNCPyUL7vV
	 gfE7Y4sERIFx8WO7w4VK/FUHnBYGD26O607+SXqDwQYLZHtdfopYlca59llYRRiPPt
	 daIzrWPCV9Kh4DAgb7UcCRaBvx2vmRsv/x4+oKG2LR6pNIRqXpJMHvisJE71/nhMpt
	 WRg0RNd7cSrmQYOsWVIZrNoRIxfmkEf15v5wOaWQ7luOFPd97j6D1D6NPPTRpBB/8D
	 F0dDd0RLsw0cg==
Message-ID: <285471261b77e5d769b6bb55375edea3.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.10-merge-window
Date: Thu, 23 May 2024 12:24:23 +0100
Message-ID-Hash: 7WCMMJKIGOXN2O4IYPSSVKPB6V4HXBGG
X-Message-ID-Hash: 7WCMMJKIGOXN2O4IYPSSVKPB6V4HXBGG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WCMMJKIGOXN2O4IYPSSVKPB6V4HXBGG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit c3c5ac4bd7d7019f2e3ad1720572d53226fe656e:

  ASoC: Intel: updates for 6.10 - part7 (2024-05-10 12:30:12 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.10-merge-window

for you to fetch changes up to 737ce4fb96206f999ddea7530145fc0e8abd5d31:

  ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string (2024-05-21 12:35:12 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.10

A bunch of fixes that came in during the merge window, all driver
specific and none of them especially remarkable.

----------------------------------------------------------------
Jack Yu (1):
      ASoC: rt5645: mic-in detection threshold modification

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: Use name_prefix for `-sdca` detection

Rob Herring (Arm) (1):
      ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string

Shenghao Ding (2):
      ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      ASoC: tas2781: Fix wrong loading calibrated data sequence

Zhang Yi (1):
      ASoC: codecs: ES8326: solve hp and button detect issue

 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   2 +-
 include/sound/tas2781-dsp.h                        |   7 +-
 sound/soc/codecs/es8326.c                          |   6 +-
 sound/soc/codecs/rt5645.c                          |   1 +
 sound/soc/codecs/tas2552.c                         |  15 ++-
 sound/soc/codecs/tas2781-fmwlib.c                  | 103 ++++++---------------
 sound/soc/codecs/tas2781-i2c.c                     |   4 +-
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   2 +-
 8 files changed, 51 insertions(+), 89 deletions(-)
