Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62375C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 12:07:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B07911AC5;
	Wed, 30 Mar 2022 14:06:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B07911AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648642065;
	bh=QPwXx2AaC2FQDD/4//la61RxRaHJ5DohwLIQhvoQqTA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GFEZvsaI+IGawChsfXBI0M6mz3D0XJksudiW4l8At4ociJ4/Tz7m8XbuWK3uny97W
	 0luc9leK62HKFYGt2Eg3ZRofgcaUtDq5SPAef3EHgLQvtnY6sJLoMSwZb+f31GhsHh
	 SDxCjkKa4IFR+0J47FdND1KhyhWKRLFWM5Do9Mlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B540F80517;
	Wed, 30 Mar 2022 13:57:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A944BF80517; Wed, 30 Mar 2022 13:57:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 501E7F804B4
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 13:57:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 501E7F804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hUqFd10d"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DDC6461705;
 Wed, 30 Mar 2022 11:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9E3C34118;
 Wed, 30 Mar 2022 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648641435;
 bh=QPwXx2AaC2FQDD/4//la61RxRaHJ5DohwLIQhvoQqTA=;
 h=From:To:Cc:Subject:Date:From;
 b=hUqFd10draJQSCRhuKfj2julXT6ZVv+YVbcTdofTQpbULsx1aVBupaaIyBpjzipoQ
 3OfUl2eUFsE7IVGRvJj/csJMhoon1BSlRea7iQExvC433XAcuPDivg09Y2+4to1OWr
 xg0OCew1+lk7dp4VEIE0E9mqjO829gYjhLxAej1UaZedkC+Y3nZA5/GS+8t+ODIXAd
 3qHjh+tYOC/UOtq9gLQnHRkMPjIvEqIAElIoP1WbEKcfJZ+9K82B4TNWawZlbY7uFG
 RhHtva8f4SMoqBEkrNNWwQyoTvA0BLZ5u46fqYSrGgcbIyyPh/lsWCXtJ2SlwHgaH+
 r82G6KbTPvJzw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.18
Date: Wed, 30 Mar 2022 12:56:57 +0100
Message-Id: <20220330115714.7C9E3C34118@smtp.kernel.org>
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

The following changes since commit 49a24e9d9c740d3bd8b1200f225f67d45e3d68a5:

  Make the SOF control, PCM and PM code IPC agnostic (2022-03-18 20:11:08 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.18

for you to fetch changes up to 664d66dc0a64b32e60a5ad59a9aebb08676a612b:

  ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV (2022-03-25 16:09:28 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.18

A few fixes that came in during the merge window, all fairly routine.

----------------------------------------------------------------
Jiaxin Yu (1):
      ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs

Meng Tang (2):
      ASoC: fsl-asoc-card: Fix jack_event() always return 0
      ASoC: rockchip: i2s_tdm: Fixup config for SND_SOC_DAIFMT_DSP_A/B

Zheng Bin (1):
      ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV

 sound/soc/codecs/mt6358.c             |  4 ++++
 sound/soc/fsl/fsl-asoc-card.c         | 12 ++++--------
 sound/soc/rockchip/rockchip_i2s_tdm.c | 10 +++++-----
 sound/soc/sof/intel/Kconfig           |  1 +
 4 files changed, 14 insertions(+), 13 deletions(-)
