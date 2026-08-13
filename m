Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9DBC5CFCF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:17:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E43D60207;
	Thu, 13 Aug 2026 14:17:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E43D60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786623454;
	bh=k5zvfZsC+Cij2kUSiqT9eUQe/23ZE1Xn25VyZSDp3+I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PVW+wFwh/PT3Fr/o9C/aUliIXFAk7OkoQq69DRJImqo4A8WcwRcXfVSs0LMZnQF69
	 OZRJ41iQ5+F5yo65563EnGhKJI5k4xGYkpfhuDV5VaPIzW0FDG3g2Ki9BpglJsQcH6
	 JispzQt8aTFnpDnAEDEwiQir9Pv7OaDnOHkHCB9U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2985EF805FE; Thu, 13 Aug 2026 14:16:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE3E7F805FF;
	Thu, 13 Aug 2026 14:16:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D72EFF80553; Thu, 13 Aug 2026 14:16:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786623412;
	b=LseuZ0o7WNnZzAdWrQh7KI5+B96ozSxOdIdV20LbDwlKDQzFCOee3fcfmhd8oD6cAmnv
	 qgSF6H9nL8WpxMfWnwwdSi1lXpExgEZN4t9x6gW5vIopFLrnN8iGCNVKb4MIr2sB2VblO
	 VweLoIMKbnkrrjLvr/fiXWzETzYxA8wMCM6G8f3X/Uh2r54zC/nvQOp4xfrRmMB0p9Gs4
	 291ZyAxVR2oceq/bsJXl9Zr342jZGRvDRrjC7M2L/Uedx09gNz0Fyj6j3kOUjFDzJJBR0
	 89KIhPMM/5+98MNrnLBS/qebrt4GZrBO/4haC9O2FJMWZddhY2DyQFUTY/eSqtcC2Dw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786623412;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=k5zvfZsC+Cij2kUSiqT9eUQe/23ZE1Xn25VyZSDp3+I=;
	b=gcyyiZyWt54wrRvymanE+Sff0rOpM0Yw+wvG93RlxTdug1T2DiKgfHnvWs5R51Z1dJJD
	 BYZGYa3HOqXkAcFqgdUNgYmbqHrHUbsxgi3amW+3dIVS4SiZN8j4DBjl40oBL2/snex9U
	 pfyJxo/y0lX52LOCwCsCcL/h06AdsaDelFEXEXy9JfuhuL4+K34YmXlTgkC7MZI7FrKjN
	 eoUw0CHOoWIg/UmOiXpIutOa8SfmhFNhLt62sJuZaunGd3lWvLxqiRRDH/+fPQtGDFiHu
	 BX7/xJokuEWTs4nvl0gm2Msgl5ujZrqurkwOqlZIceYFDfcem7vmNUAusgu3aor3BsQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZPSG0YuH;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id E8437F80027
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 14:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8437F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZPSG0YuH
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 7EC61408C3;
	Thu, 13 Aug 2026 12:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DD2111F000E9;
	Thu, 13 Aug 2026 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786623407;
	bh=45kXvKtQQ5XTETNTNQNm84pGKH83GWFBXmxLHufnGKY=;
	h=From:To:Cc:Subject:Date;
	b=ZPSG0YuHCFUsfGp2KvKgoEPIAIRuced3Xf9x0+eq7qzZZDKaiMKEnlVgHhS0JB2lF
	 SQy9DBkqeNF/qzwEQHNJO2n6j1VPKBITq2HoZ+uE72+7xqzAFxirFyvDu0myTgp5yR
	 IvjYlB1jxjfR+4Be+IDl/gwxecV07vJF/o1y//PKJjCFWC9O02n1VjJH5TuMLnEcZm
	 98zmS+w1GD6DpRdQfq4v2F9zPfMP0pBRwmI66AqQyXrrEEQGpAyFTbXquPL4jrmDQ2
	 6zMcTG+/IW5dnw6eVae3Y70ejI2piIHLE0A2WVpcr3muYrpXiIK+rrWc2bfHpYA+by
	 reBH87fdD55/A==
Message-ID: <317e8543ff401f09ccc2e93c8cd70e71@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc7
Date: Thu, 13 Aug 2026 13:16:39 +0100
Message-ID-Hash: RH43CDVXC36ZUWDFOD5OSYSSBBKQFUJM
X-Message-ID-Hash: RH43CDVXC36ZUWDFOD5OSYSSBBKQFUJM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RH43CDVXC36ZUWDFOD5OSYSSBBKQFUJM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc7

for you to fetch changes up to 079e27f52b929b554b90514b081ea40b3d632a25:

  ASoC: Intel: NVL: Add entry for HDMI-In capture support to non-I2S codec boards. (2026-08-11 17:14:15 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

This set of fixes is bulked out quite a bit by the inclusion of a lot of
quirks for various x86 platforms, though there are a few driver specific
fixes in here too.  Nothing here is terribly critical, we should be fine
waiting for the merge window if it's too much.

----------------------------------------------------------------
Balamurugan C (3):
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in NVL match table
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for NVL.
      ASoC: Intel: NVL: Add entry for HDMI-In capture support to non-I2S codec boards.

Lin Xianglin (1):
      ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop 16-ap1xxx

Mark Brown (1):
      ASoC: Intel: Add HDMI-In capture match table for NVL

Niranjan H Y (1):
      ASoC: tac5xx2-sdw: select REGMAP_SOUNDWIRE_MBQ

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Rudi Heitbaum (1):
      ASoC: rt5645: Perform the initial jack detect at probe

Sergey Lebedev (1):
      ASoC: rt1320: run the initialisation preset on the first hardware init

Shenghao Ding (1):
      ASoC: tas2781: fix clang build error for goto bypassing cleanup variable

 sound/soc/amd/yc/acp6x-mach.c                     |  7 +++++++
 sound/soc/codecs/Kconfig                          |  1 +
 sound/soc/codecs/rt1320-sdw.c                     |  2 +-
 sound/soc/codecs/rt5645.c                         |  4 ++++
 sound/soc/codecs/tas2781-i2c.c                    | 18 ++++++++--------
 sound/soc/intel/boards/sof_es8336.c               | 10 +++++++++
 sound/soc/intel/boards/sof_rt5682.c               |  7 +++++++
 sound/soc/intel/boards/sof_ssp_amp.c              |  6 ++++++
 sound/soc/intel/common/soc-acpi-intel-nvl-match.c | 25 +++++++++++++++++++++++
 sound/soc/xilinx/xlnx_formatter_pcm.c             | 10 ++++-----
 10 files changed, 74 insertions(+), 16 deletions(-)
