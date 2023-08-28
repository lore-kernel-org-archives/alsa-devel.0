Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF95FC71153
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Aug 2023 14:55:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEDBEDEB;
	Mon, 28 Aug 2023 16:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEDBEDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693234516;
	bh=R1KTSHNuGeL+vDraKgRI+gr5DXxU7FSRvjBBGimyR3c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vKFDwBMv/2XzU3oY3rFtXaqU2X00Lk1epIHshYKdlGwMxS67yqmgq85k40ljH1IU0
	 BScn/VkrNksemnayZaAaueshJ0txHatnIWPukOQr+Z3qD80c4SUTIqhUQCkvCkR/DT
	 CIFk+04PYo6yIqDz3B9EWyJyuWBR2EO9qwkupGhQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F9A2F8025F; Mon, 28 Aug 2023 16:54:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20828F8025F;
	Mon, 28 Aug 2023 16:54:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15425F80158; Mon, 28 Aug 2023 16:54:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14045F80094
	for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2023 16:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14045F80094
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=muHKUSKj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 564BF60FEC;
	Mon, 28 Aug 2023 14:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD01C433C7;
	Mon, 28 Aug 2023 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693234434;
	bh=R1KTSHNuGeL+vDraKgRI+gr5DXxU7FSRvjBBGimyR3c=;
	h=From:To:Cc:Subject:Date:From;
	b=muHKUSKjGwWsSDjVTdWa7Kcu2/yuD3DeL5JqMRgxtpL/HQE7TJKKUmoAqxUKWZfGZ
	 2qh24h6DYySgwN2tLL2kF/mPm4vbqd0/oe+8dxFBy8PCqNWNZh0ygLid2jC2f5XvYe
	 OB4F+lUpVSuXKAEyZ2qXXk5bjaooJkBjmu1dSe1xdt9RlTaQbReeoPk0qbfGyVLwZi
	 ApHr9+MtNvoa8hUUDr/ChFJVeTlbA+GCMoFAmo2YQR58VjoGwqNnki3vpM6P8eX7Bh
	 PPVUzN0XTsBPwijwq6wgYlHna/w13RqFq1ij9EX9j7TpLtMTQMIdkVSAszYu41wHk7
	 om2fsGw5RqWMA==
Message-ID: <fc0f3b34539c7a8778d59c52ec2092e1.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.5-merge-window
Date: Mon, 28 Aug 2023 15:53:35 +0100
Message-ID-Hash: JMTZSL7IRCZXRLF6FAME3ZPT72ZAQTYA
X-Message-ID-Hash: JMTZSL7IRCZXRLF6FAME3ZPT72ZAQTYA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JMTZSL7IRCZXRLF6FAME3ZPT72ZAQTYA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 1f1ef7e5bbe2de125da413e238915f6047ea4ba2:

  ASoC: intel: sof_sdw: Fixup typo in device link checking (2023-06-19 12:58:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.5-merge-window

for you to fetch changes up to d900d9a435ca95a386f49424f3689cd17ec201da:

  ASoC: tegra: Fix SFC conversion for few rates (2023-06-24 01:57:16 +0100)

----------------------------------------------------------------
ASoC: Fixes that got left after v6.4

These were some changes in my v6.4 branch that never got sent as fixes,
none of them super urgent thankfully.

----------------------------------------------------------------
Phil Elwell (1):
      ASoC: cs43130: Fix numerator/denominator mixup

Sheetal (1):
      ASoC: tegra: Fix SFC conversion for few rates

yixuanjiang (1):
      ASoC: soc-compress: Fix deadlock in soc_compr_open_fe

 sound/soc/codecs/cs43130.h     | 138 ++++++++++++++++++++---------------------
 sound/soc/soc-compress.c       |   1 +
 sound/soc/tegra/tegra210_sfc.c |  31 ++++++++-
 sound/soc/tegra/tegra210_sfc.h |   4 +-
 4 files changed, 102 insertions(+), 72 deletions(-)
