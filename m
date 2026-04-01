Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B128010F6FDC
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:25:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DD65601FE;
	Wed,  1 Apr 2026 19:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DD65601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775064303;
	bh=Q0jJ6V1m2qdr8A0gWUuXA1k19WwiAibMZ8fDfAGBVoA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GTImHZt1lChFYy33LaxK4i8WUMGiOYuSK06pwzXQ0n+Yjq7hrdB+clRhpxRMUWwNq
	 rOibzEWA+3wqp/mM4ZS0yU4m+/bhcPGRekz4ci3GdEZc+FCEJb9PH2p27f0eLRWrk+
	 Rliw9L2mkzak2+T74xt/hnS4EfeYpvh3xq4S9lDo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5600CF805F7; Wed,  1 Apr 2026 19:24:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DCA9DF805E5;
	Wed,  1 Apr 2026 19:24:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 410D6F80527; Wed,  1 Apr 2026 19:24:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F644F8047D
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 19:24:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F644F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MZhGIpxa
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 316E443468;
	Wed,  1 Apr 2026 17:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D03BC4CEF7;
	Wed,  1 Apr 2026 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775064254;
	bh=Q0jJ6V1m2qdr8A0gWUuXA1k19WwiAibMZ8fDfAGBVoA=;
	h=From:To:Cc:Subject:Date:From;
	b=MZhGIpxaFOOv65Q/3jwjxGMzdovNClX/giJqdPkv4PpPsfqgxqGBRCX7wIaFQc3b1
	 ie3f3jQZPcLbh2hMLUnaz3dBbzCptWWRk2dn6Efp9l01aaPF3SzqhIfwhXpPFw/Rfy
	 xDF0GfYNUxwdVgvkYPOvjClnKikNSDq7Ww3kl+6Ka9RD0AA9PsWc+HI/FLkCAcHvtP
	 z0ASXwflJjtMmVKqysRwhPKbMl9+da3C9GTIcAPscaVrKG+Elp9Kxc8TTJeUEzEAFp
	 jc5aY4AgfyCGdBWgbOrAf3cicmHGLDgKcjtOOlXAGjm2P1F7Bg5Fmu9PejWTW5ee6z
	 5Cl9avKg8s/zg==
Message-ID: <c736ee7c35c9676f3c71335e74d1d157@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.0-rc6
Date: Wed, 01 Apr 2026 18:24:06 +0100
Message-ID-Hash: 3WH6WJHRMC7QLK6YDXJQSR7QVS7A57P7
X-Message-ID-Hash: 3WH6WJHRMC7QLK6YDXJQSR7QVS7A57P7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3WH6WJHRMC7QLK6YDXJQSR7QVS7A57P7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc6

for you to fetch changes up to e74c38ef6f170179c0029b5744d6a14dfd543108:

  ASoC: amd: ps: Fix missing leading zeros in subsystem_device SSID log (2026-04-01 13:08:47 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.0

Another smallish batch of fixes and quirks, these days it's AMD that is
getting all the DMI entries added.  We've got one core fix for a missing
list initialisation with auxiliary devices, otherwise it's all fairly
small things.

----------------------------------------------------------------
Gilson Marquato Júnior (1):
      ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx

Jihed Chaibi (1):
      ASoC: ep93xx: Fix unchecked clk_prepare_enable() and add rollback on failure

Julian Braha (1):
      ASoC: Intel: boards: fix unmet dependency on PINCTRL

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Sachin Mokashi (1):
      ASoC: Intel: ehl_rt5660: Use the correct rtd->dev device in hw_params

Simon Trimmer (1):
      ASoC: amd: ps: Fix missing leading zeros in subsystem_device SSID log

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 16X OLED M7601RM

 sound/soc/amd/ps/pci-ps.c           |  2 +-
 sound/soc/amd/yc/acp6x-mach.c       | 14 ++++++++++++++
 sound/soc/cirrus/ep93xx-i2s.c       | 34 ++++++++++++++++++++++++----------
 sound/soc/intel/boards/Kconfig      |  2 --
 sound/soc/intel/boards/ehl_rt5660.c |  2 +-
 sound/soc/soc-core.c                |  1 +
 6 files changed, 41 insertions(+), 14 deletions(-)
