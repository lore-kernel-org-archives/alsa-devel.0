Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B5C44511
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:42:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63BD5601ED;
	Thu, 16 Jul 2026 18:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63BD5601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784220160;
	bh=DTkIEjiUfEkgYl0201yqKBtIgnvikvvVFHNI1YOQl4g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bX6A/WuW7xCDCaPG+92iLCmpnbRkQDstU1hyTUKLzxUGXcI8317qaXtUUgB90+Qhs
	 V+9Ml2Dd1HTnuxS1SU/mjl0RgFN1GuIhwSyfjeZhXJ6YsHWZggcMyX/nq+wyGI3xGL
	 cI3nXOkLC2HnhxB8/nz17LteKMI/ullL+OH9YUI4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3789CF805EC; Thu, 16 Jul 2026 18:42:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF544F805FF;
	Thu, 16 Jul 2026 18:42:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6032F80527; Thu, 16 Jul 2026 18:41:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784220118;
	b=huXNcF80eltkXH0Arr46wxvfMTn+mC16peHSuZSbahoP2cURO3qLpSJ7fzRJeA+dfXN4
	 FkRglG/675sYJzDYdsUnNs42n9HZCTGNXQ2cjGiodCySouC6xhzjaGk1p8dRqMBwYphgO
	 C/P70FQVt0swn1ZBCCh+CiCZdNKVux6Ro07TsDi3ov8JPILKb6iEvd92LLxVGY+Msr/ZA
	 YFsJChKAG/6/mK1BcDyRo6D4RUyNOVx2d/ls9ihwupKgLVIvsTrnL+SjHWq3C3KrPqU3j
	 0FxmUdseDJxmjHwEI6pJl3Wg980ibhozZeRL7A6M3OtfWZ6j/pszOBvlwmr2UawNYew==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784220118;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=DTkIEjiUfEkgYl0201yqKBtIgnvikvvVFHNI1YOQl4g=;
	b=RjgGpeQ8Q31Or6qxxzzafTkhmCR6j4QpQFYgUszHOhnZSom73C7szHCegEkRCGSoyvoA
	 WjbdGAYPYIQNHBVwU1Cq8qqZ+NPAgoX+Qkfa39cLJQVpkNUKcA4Me6CftM4r5ywf+dDu/
	 5wcbFRvmN1OEup/4+liOObidAEwPi+MyGODw/4tMlXwxasX2OTFRwy35nBlyDgR3H6/SJ
	 5Ucugx/u2M4INpRJxbbnc7bulqZwmQ3trPOv4ISPusfhmgNPaxxOHwPzr8qTjFOmHomSo
	 e1JPqZPECf/sPuMa5D9AiravKlRrAvWJUcPOQ1b48HfsbwxMzOMlsNA/R0IGlSuWe+g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=M5tUEWdA;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id BBF04F8051E
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 18:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBF04F8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=M5tUEWdA
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 8CA4941631;
	Thu, 16 Jul 2026 16:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E0BA21F000E9;
	Thu, 16 Jul 2026 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220113;
	bh=N/Ox/WPTfaE27r3f+TqEgWZcyo1ANjmeNtVC+0pBTF4=;
	h=From:To:Cc:Subject:Date;
	b=M5tUEWdASPEaeETvfpjV69Nt4ZhFa0oljGSzdxvAyVcOZ4VNInDpnBUEbu24uKmDY
	 EsAuwsfDpi/FU8pEMk0ufA6GVHB8SMTgtJ3cxXZmXCdVZ2WdWbuBFkNw4j240hCrg0
	 9pSiPgTXCKogO6r7sVtFJOqUjZxap6UISJtrqM5ZKM8ZKRL5cKWUBmPgBf7tOD2c41
	 //8IhKlpFF1ozCRtxIQFUSvtBReSnD1Nc8Fogax8sfGiqpDe9pXPgOiN4PBwkINZVn
	 FuTeQl1vepjGaaKGLIURuO3FaPOsw0yVHG+Gbgi3D3qnCNpeW1Bv1XMN/8zfyY8j3X
	 xcsXvzRusGElQ==
Message-ID: <e11aad798859896a3f0388f99de32bc0@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-rc3
Date: Thu, 16 Jul 2026 17:41:39 +0100
Message-ID-Hash: 3CFDD4YGFCU5NYGQOIUUNMCAWNDJTL2R
X-Message-ID-Hash: 3CFDD4YGFCU5NYGQOIUUNMCAWNDJTL2R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3CFDD4YGFCU5NYGQOIUUNMCAWNDJTL2R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 3238c634725afbb2a137fdda762208510828f71d:

  ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup (2026-07-09 00:33:20 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-rc3

for you to fetch changes up to efd80de2de9d06ddf0eee55ca11b04e39bfc7cd8:

  ASoC: Intel: sof_sdw: Add quirks for new Dell laptops (2026-07-16 17:18:08 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

A fairly standard collection of device specific fixes and quirks,
nothing particularly remarkable.

----------------------------------------------------------------
Antonio Ignacio Campos Ruiz (1):
      ASoC: amd: yc: Add DMI quirk for MSI Vector A16 HX A8WIG

Chancel Liu (2):
      ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
      ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown

Charles Keepax (1):
      ASoC: Intel: sof_sdw: Add quirks for new Dell laptops

Chen-Yu Tsai (1):
      ASoC: sun4i-codec: Set quirks.playback_only for H616 codec

Mark Brown (2):
      ASoC: fs210x: Make cache write through again during resume
      ASoC: cs35l56: Fixes for deadlock/hang during component_probe()

Pengpeng Hou (1):
      ASoC: tas2781: bound firmware description string parsing

Richard Fitzgerald (2):
      ASoC: cs35l56: Fix potential probe() deadlock
      ASoC: cs35l56: Use complete_all() to signal init_completion

Shengjiu Wang (1):
      ASoC: bt-sco: fix duplicate DAPM widget names for wideband DAI

Syed Saba Kareem (1):
      ASoC: amd: acp: add ACP70 DMI override for new ASUS TUF platforms

 sound/soc/amd/acp-config.c        | 12 ++++++++
 sound/soc/amd/yc/acp6x-mach.c     |  7 +++++
 sound/soc/codecs/bt-sco.c         | 10 +++++--
 sound/soc/codecs/cs35l56-i2c.c    |  4 +--
 sound/soc/codecs/cs35l56-spi.c    |  4 +--
 sound/soc/codecs/cs35l56.c        | 17 ++++++++++-
 sound/soc/codecs/fs210x.c         |  1 +
 sound/soc/codecs/tas2781-fmwlib.c | 63 +++++++++++++++++++++++++++++++++++----
 sound/soc/fsl/fsl_sai.c           | 29 +++++++++++++++---
 sound/soc/fsl/imx-card.c          | 12 +++++---
 sound/soc/intel/boards/sof_sdw.c  |  2 ++
 sound/soc/sunxi/sun4i-codec.c     |  1 +
 12 files changed, 139 insertions(+), 23 deletions(-)
